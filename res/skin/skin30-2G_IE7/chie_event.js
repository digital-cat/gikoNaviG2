try{document.charset='Shift_JIS'}catch(e){}
//========新着ジャンプ設定
var buffer=1;     // 低速回線や低速マシンの場合にはbufferの数値を増やすとより正確にジャンプ（1増やすと0.1秒遅れる）
var newResJump=1; // 新着レスジャンプ（0:ブラウザ任せ、1:読了時のみ、2:常時）＊かちゅ、OpenJane、twintailのみの設定
//==========以下はスクリプト本文ですよ。
//イベントハンドラ定義
//外部関数：tohan
//外部変数：anchorHead,lightmode,getID,skinName,browser,dts
//=========外部ファイル共用のグローバル変数
var waited=false;//command表示後trueにし、選択後にfalseにする。
var viewed=false;//thumb読込み後trueにし、thumbPanelに乗降後falseにする。
var searched=false; //検索後に、trueにし、foundPanelに乗降後falseにする。
var cp,tp,vp,fp;
//========Click処理→search,他
	document.onclick = clickEvent;
function clickEvent(){
 if(clickCancel){return false}else{clearTimeout(clickTimer);if(document.getElementById("context")){document.getElementById("context").removeNode(true);}}
 var obj=window.event.srcElement;
 var tag=obj.tagName;
 if(tag=="B"||tag=="U"||tag=="SPAN"){searchPerson(obj)} //名前,トリップ,ID
 else if(tag=="DT")  {searchRef(obj)}
 else if(tag=="DD")  {defaultPopup()}
 else if(tag=="A"){
  if(obj.rel){obj.href=obj.rel;}
  //if(obj.parentElement.tagName!="DIV"){setHistory(obj);}
  //＃付きリンク
  if(browser=="Live2ch" || browser=="かちゅ～しゃ"){
   if(obj.href.match(/^http:.*#/)){window.open(obj.href,"_parent");return false}
  }
  //A Bone補正（非表示レスの表示）
  if((browser=="A Bone"||browser=="ギコナビ") && hiddenRes(obj)){showModelessDialog(document.getElementsByName("ThreadURL")[0].content.replace(/\/l50$/,"/")+tohan(obj.innerText.replace(/[>＞]/g,"")),window,"dialogWidth:"+document.body.clientWidth+"px;help:no;resizable:yes;status:no;unadorned:yes;");window.focus();}
  //Jane,Live,ギコナビ補正（skin30-2Normal及びギコナビ）＊レスジャンプがscrollIntoViewでないものに係る補正
  if(browser=="A Bone" || browser=="OpenJane" || browser=="Live2ch" || browser=="ギコナビ"){if(obj.href.match(/^about|jumpres/)){
   var h=tohan(obj.innerText.replace(/[>＞]/g,""));
   var anchor=document.anchors(anchorHead+h);
   if(anchor){anchor.scrollIntoView(true);return false}
  }}
  return true;
 }
 else{panelOver();return}
}

//=========MouseOver処理→image,popup
	document.onmouseover = mouseOverEvent;
function mouseOverEvent() {
 var e = window.event.srcElement;
 if(e.tagName=='B'){if(browser!="twintail2"){
  if(e.innerText.match(/^([^\d０-９]*)([\d０-９]+)([^\d０-９]*.*)/)){namePopup(e,RegExp.$1,RegExp.$2,RegExp.$3);}
  else if(e.innerText.match(/^あぼ～ん$/))                          {abonePopup(e);}
 }}
 if(e.tagName=='A'){
  if(!e.innerText.match(/%/)){ // URLエンコードでありがちな%がなければ
   //e.href=e.href.replace(/>/g,"");
   //e.href=e.href.replace(/\/ime.\w+/g,"");
  }else{
   try{
    e.title=decodeURI(e.innerText);
   }catch(err){
     // ShiftJIS,EUC-JPのデコードは面倒だからつけない。
   }
  }
  try{e.href}catch(err){return} // IE7だと何故かe.hrefが取得出来ないA要素がある
  if     (checkAnchor(e.href)==2){insButton(e);return;}
  else if(checkAnchor(e.href)==1){  // 多段ポップアップ
   if(event.shiftKey){if(e.rel){e.href=e.rel}return}
   var parent=e.parentElement;
   var aNum= (parent.tagName!="DD") ? parent.firstChild.sourceIndex : parent.previousSibling.firstChild.innerText;
   if(!document.getElementById("p"+aNum)){
    var obj=e;var onPopup;
    while(obj.tagName!="BODY"){if(obj.id.match(/p\d+/)){onPopup=true;break}else{obj=obj.parentElement}}
    if(!onPopup){removePopup()}
    makePopContent(e);return;
   }
  }else if(checkAnchor(e.href)==0){ // 逆参照ポップアップ
   if(e.href.match(/menu:/) && event.shiftKey){searchPopup(e)}
  }
 }else if(e.tagName=="SPAN"||e.tagName=="TT"){
  var obj=e;var onPopup;
  while(obj.tagName!="BODY"){if(obj.id.match(/p\d+/)){onPopup=true;break}else{obj=obj.parentElement}}
  if(e.tagName=="SPAN"){
   if(!onPopup && event.shiftKey){searchPopup(e)}
  }else{searchPopup(e)}
 }else{ // 多段ポップアップ消去
  var obj=e;var onPopup;
  if(obj.sourceIndex<0){obj=document.body;if(document.getElementById("popupBase")){onPopup=true;}} // namePopupとの競合でノードが外れる瞬間の回避
  while(obj.tagName!="BODY"){if(obj.id.match(/(p\d+)/)){onPopup=true;break}else{obj=obj.parentElement;}}
  if(onPopup){while(obj.id!=obj.parentElement.lastChild.id){obj.parentElement.lastChild.removeNode(true)}}
  else       {removePopup()}
 }
}
//=========MouseMove処理→panelOver()
	document.onmousemove=mouseMoveEvent;
function mouseMoveEvent() {
 if(!cp){
  var nHTML ='<div id="controlPanel"><input type="button" value="TOP" onclick="scroll_Top();blur()"><input type="button" value="END" onclick="scroll_End();blur()"><input type="button" value="IMG" onmouseup="imgCommand();blur()"><input type="button" value="FND" onclick="fndCommand();blur();"></div><div id="foundPanel" onmouseout="searched=false"></div>';
  if(skinName.match(/30-2/)){nHTML+='<div id="thumbPanel" onmouseout="viewed=false"></div><div id="viewPanel"></div>';}
  document.body.insertAdjacentHTML("afterBegin",nHTML);
  cp=document.getElementById("controlPanel");fp=document.getElementById("foundPanel");
  if(skinName.match(/30-2/)){tp=document.getElementById("thumbPanel");vp=document.getElementById("viewPanel");}else{tp=vp=new Object()}
  cp.condition="waited";tp.condition="vp.firstChild || viewed || !lightmode";fp.condition=resultView ? "fp.hasChildNodes()" : "searched";
  cp.territory="<25";   tp.territory=">20";                                  fp.territory="<(30+fp.clientHeight) && fp.hasChildNodes()";
 }
 if(event){panelOver();}
 if(!idHash.length){setHash();searchColoring();}
}
// 各パネル
function panelOver(){
 var territoryW=document.body.clientWidth-120;var territoryH=25;
 var panels=new Array("cp","tp","fp");
 for(var i in panels){
  if(skinName.match(/30-3/)&&panels[i]=="tp"){continue}
  var panel=eval(panels[i]); var territoryY=eval("event.y"+panel.territory); var territoryX=eval(event.x>document.body.clientWidth-panel.offsetWidth-15);
  if(eval(panel.condition)){panel.style.visibility="visible";return}
  if(territoryY && territoryX){panel.style.visibility="visible";}else{panel.style.visibility="hidden";}
 }
}
// TOP,END
function scroll_Top(){document.getElementsByTagName("DL")[0].firstChild.scrollIntoView(true);}
function scroll_End(){document.getElementsByTagName("DL")[0].lastChild.scrollIntoView(true);}
// IMG
function imgCommand(mode,s){
 if(!waited){
  var nHTML='<div id="command" onclick="clearCommand()"><input type="button" onclick="allImageLoad(\'all\')" value="全レス一括読込"><br><input type="button" onclick="allImageLoad(\'new\')" value="新レス一括読込"><br><input type="button" onclick="removeError()" value="Error画像削除"><br></div>';
  event.srcElement.parentElement.insertAdjacentHTML('beforeEnd',nHTML);
  if(skinName.match(/30-2/)){
   //if(!lightmode){document.getElementById("command").insertAdjacentHTML('afterBegin','<input type="button" onclick="changePanel()" value="パネル切替"><br>')}
   document.getElementById("command").insertAdjacentHTML('beforeEnd','<input type="button" onclick="changeMode()" value="モード切替">')
  }
  waited=true;
 }else{
  clearCommand();
 }
}
function fndCommand(mode,s){
 if(!waited){
  findIt(document.selection.createRange().text);
  event.cancelBubble=true;
 }else{
  clearCommand();
 }
}
function clearCommand(){
 waited=false;
 document.getElementById("command").removeNode(true);
}
//=========左長押処理→copyMenu()
	document.onmousedown=mousedownEvent;
var clickCancel,e,ex,ey,clickTimer;
function mousedownEvent(){
 var obj=e=event.srcElement;ex=event.x;ey=event.y;
 if(document.getElementById("context") && obj.innerText==document.getElementById("context").name){return}
 clickCancel=false;
 if(obj.nextSibling && obj.nextSibling.tagName=="U" && event.button==1){
  clickTimer=setTimeout("copyMenu()",500);
 }
}

//コピーメニュー→colorChange(),search::copyText()
function copyMenu(){
 clickCancel=true; clearTimeout(clickTimer);
 if(document.getElementById("context")){document.getElementById("context").removeNode(true);}
 var nHTML='<div id="context" name="'+e.innerText+'"><div onclick="copyText(\'res\')" onmouseover="colorChange()" onmouseout="colorChange()">レスをコピー</div><div onclick="copyText(\'name\')" onmouseover="colorChange()" onmouseout="colorChange()">名前をコピー</div><div onclick="copyText(\'id\')" onmouseover="colorChange()" onmouseout="colorChange()">IDをコピー</div></div>';
 document.body.insertAdjacentHTML("afterBegin",nHTML);
 var context=document.getElementById("context");
 context.style.pixelLeft=document.body.scrollLeft+ex
 context.style.pixelTop =document.body.scrollTop+ey;
 context.style.visibility="visible";
}
function colorChange(){
 var style=event.srcElement.style;
 if(event.type=="mouseout"){style.backgroundColor="Menu";     style.color="MenuText";}
 else                      {style.backgroundColor="Highlight";style.color="HighlightText";}
}

//=========キーボード入力（skin30-2でのキー無効の回避＋α）
	document.onkeydown=key;
function key(){
 var dl=document.getElementsByTagName("DL").item(0);
 var code=event.keyCode;
 if     (code=="32" && !event.shiftKey || code=="34"){dl.scrollTop+=dl.offsetHeight;}
 else if(code=="32" && event.shiftKey  || code=="33"){dl.scrollTop-=dl.offsetHeight;}
// else if(code=="37" && event.altKey  || code=="8"){jumpHis.back();if(code=="8"){return false}}
// else if(code=="39" && event.altKey){jumpHis.forward();return false;}
 else if(code=="40"){dl.scrollTop+=36;}
 else if(code=="38"){dl.scrollTop-=36;return true;}
 else if(code=="36"){scroll_Top()}
 else if(code=="35"){scroll_End()}
 else if(code=="73" && event.shiftKey){changePanel();return false;} // shift+I
 else if(code=="70" && event.shiftKey){findIt(document.selection.createRange().text);return false;} // shift+F
 else if(code=="78" && event.shiftKey && firstNew){firstNew.scrollIntoView(true)} // shift+N
 else if(code=="82" && event.shiftKey && event.ctrlKey){ // ctrl+shift+R
  //かちゅ～しゃ補正（板更新のショートカットキー）
  if(browser=="かちゅ～しゃ"){
   if(!t_url){threadurl();}
   window.open("http://"+t_domain+"/"+t_bbs+"/","_blank");
   return false;
  }
 }
}

//=========新着レス取得後処理（標準スキン未対応ブラウザ用）←Timer又はFooterから呼び出し
//=========かちゅ、ABone、ゾヌ２
var newResNum=parseInt(document.getElementsByName("GetRescount")[0].content)+1;
var k=0;
function loadEvent(num){
 //====新着レスジャンプ
 if(newResJump==0){clearInterval(timerID);return} //「ブラウザ任せ」なら終了
 //新着レスの開始番号を取得
 if     (browser=="かちゅ～しゃ"){if(isNaN(newResNum)){while(dts[k]){if(dts[k].className=="new"){newResNum=parseInt(dts[k].firstChild.innerText);break;} k++;}}}
 else if(browser=="ホットゾヌ２"){newResNum=num+1;}
 var anc=document.anchors(anchorHead+newResNum);
 if(!anc || !anc.parentElement){return} // 透明あぼ～んされてたら終了
 //新着レスジャンプ
 scr=lightmode ? document.body : document.getElementById("dl");
 viewPos=scr.scrollTop+scr.clientHeight;// スクロール後の画面下部位置
 endPos =anc.offsetTop+20;				// 新レスアンカー位置
 //最後まで読了 or 「常に新着ジャンプ」ならジャンプ
 if(viewPos>endPos || newResJump==2){clearInterval(timerID);setTimeout("moveToNew("+newResNum+")",buffer*100)}
 else{firstNew=document.anchors(anchorHead+newResNum).parentElement.nextSibling;}
}
//=========新着レス取得後処理（標準スキン対応ブラウザ用）←NewMarkから呼び出し
//=========OpenJ、twin
var scr,viewPos,endPos=0;
function reloadEvent(){
 //====既読化
 var lastDt=dts[dts.length-2];if(!lastDt){return}// 全部新着なら終了
 while(lastDt && lastDt.className=="new"){lastDt.className="";lastDt=lastDt.previousSibling.previousSibling;}
 //====新着レスジャンプ
 if(newResJump==0){return} //「ブラウザ任せ」なら終了
 var ancs=document.anchors;
 var newResNum=parseInt(ancs[ancs.length-1].name)+1;
 scr=lightmode ? document.body : document.getElementById("dl");
 viewPos=scr.scrollTop;
 endPos =scr.scrollHeight-scr.clientHeight-20;
 //最後まで読了 or 「常に新着ジャンプ」ならジャンプ
 if(viewPos>endPos || newResJump==2){setTimeout("moveToNew("+newResNum+")",buffer*100);}
}

// 新着レス移動＋新着レスの位置を記憶
var firstNew;
function moveToNew(num){
 firstNew=getDTfromAnc(num);
 while(!firstNew){num--;firstNew=getDTfromAnc(num);} //対象が透明あぼ～んなら数を減らす
 firstNew.scrollIntoView(true);
}

//=========DoubleClick処理→defaultPopup()
	document.ondblclick=defaultPopup;
function defaultPopup(){
 var num=document.selection.createRange().text.replace(/\s$/,"");
 var hnum=tohan(num);
 if(!isNaN(hnum) && hnum<=1000){
  var obj=document.createElement("a");
  obj.innerText=num;
  obj.href="#"+hnum;
  makePopContent(obj);
 }else if(num.match(/\w{8,9}/)){ //\w{8}ではだめぽ？
  var obj=document.createElement("DT");
  obj.innerHTML="<span>date time ID:"+num+"</span>";
  searchPerson(obj.firstChild);
 }
}

//=========Copy処理
//headから読むとbodyは見えないので、専用ブラウザの特質を利用してbodyの後ろに書き出す
//本来どおりheadに書き出すSkinManager対策で判定を一つ入れる
	if(document.body) document.write('<script type="text/javascript">document.body.oncopy=copyEvent</script>\n');
function copyEvent(){
 var textarea=document.createElement("TEXTAREA");
 textarea.value=document.selection.createRange().text.replace(/\s(\r\n|$)/g,"\n");
 var copyText=textarea.createTextRange();
 copyText.execCommand("Copy");
 return false; 
}
//=========onScroll処理
//window.onscroll=function(){clearInterval(beforeScrollTimer);onLoadEvent()}
window.onscroll=function(){onLoadEvent()}
if(document.getElementById("dl")){
 document.getElementById("dl").onscroll=function(){onLoadEvent()}
}
//=========onLoad処理
window.onload=onLoadEvent;
function onLoadEvent(){mouseMoveEvent();setHash();searchColoring();}
setTimeout("onLoadEvent()",1000); // 一回だけ着色

