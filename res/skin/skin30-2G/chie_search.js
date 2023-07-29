beID=false; // beにログイン出来る場合は、true
//==========検索設定
var expression="multiAND";	// 検索方法　　default:標準、regExp:正規表現、multiAnd:AND検索、multiOR:OR検索
var searchView="resList";	// 検索結果表示　　resList:該当レス番号表示、resPopup:該当レスポップアップ、
var resultView=false;		// 検索結果の常時表示　　true:常時表示、false:マウスで近づけたときのみ表示
var listLimit =10;  		// searchViewがresPopupでない場合の、レス番号の表示制限
//==========レス番号、日付文字列の着色設定
coloring=1;               // 着色する:1　着色しない:0
threshold1=[2,"#0000ff"]; // 書き込みが複数あるID のしきい値と色
threshold2=[5,"#aaaa00"]; // 書き込みが多数あるID のしきい値と色
threshold3=[8,"#ff0000"]; // 書き込みが多数あるID のしきい値と色
threshold4=[1,"#0000FF"]; // 書き込みがある    レス のしきい値とレス番号の色
threshold5=[4,"#aaaa00"]; // 書き込みが多数あるレス のしきい値とレス番号の色
threshold6=[7,"#ff0000"]; // 書き込みが多数あるレス のしきい値とレス番号の色
//==========名前・ID検索によるレスの帯の色指定（16進数又はWeb形式の色名で指定。いくつでも可。アルファベットは小文字でお願い）
var foundResColor =new Array("#ffdfee","#eeffdf","#ffeedf","#dfffee","#eedfff","#ffffe1");
//==========単語検索によるハイライト色指定（同上）
var highlightColor=new Array("#ffff66","#a0ffff","#99ff99","#ff9999","#ff66ff","#880000","#00aa00","#886800","#004699","#990099");
//==========以下はスクリプト本文ですよ。
// イベントハンドラ：onClick,onScroll,onMousemove
// 外部関数：addAnchor,checkAnchor,tohan,searchPopup
// 外部変数：anchorHead,browser,fp
// 逆参照の特徴：イベント発生DTに対応するDD下に、DL-DT-DD構造を作成する。
//==========CSSの出力
var nCSS='';
nCSS+='#foundPanel {position:absolute;top:expression(body.scrollTop+25);right:18px;padding:2px 5px;z-index:6;background-color:white;border:1px solid #999;visibility:hidden}';
nCSS+='#foundPanel div{padding-left:5px;text-align:right;font-size:100%;}';
nCSS+='.refResult{margin:0.5em 0.3em; border:1px solid #666;padding-right:0px}';
nCSS+='.refResult{border-top:none}';
nCSS+='.refResult dt{margin-right:0px;}';
nCSS+='.refResult dd{margin-left:0.8em;}';
document.write('<style type="text/css">'+nCSS+'</style>\n');
var nCSS='';
for(var css in foundResColor){
 var c=foundResColor[css].replace(/#/,"");
 nCSS+='#COLOR'+c+" a{border-color:"+foundResColor[css]+"}\n";
 nCSS+='#COLOR'+c+" a:hover{border-color:red}\n";
}
document.write('<style type="text/css">'+nCSS+'</style>\n');
//=========外部ファイル共用のグローバル変数
var dts=document.getElementsByTagName('DT');
var dds=document.getElementsByTagName('DD');
var idHash=new Array(); var refHash=new Array();
var foundRes,highlight;
//==========IDと参照をハッシュに格納
// 配列のハッシュより軽いっぽいので、空白区切りの値による単純なハッシュにしてみるテスト。
// setEndIdx:本文の同レスを重複処理しないように、Hash化位置としてのdtsの最終indexを記憶
// setEndNum:本文以外レスを重複処理しないように、最終レス番号を記憶
var setEndIdx=setEndNum=0;
function setHash(){
 //var t0=new Date();
 var l=Math.min(dts.length,dds.length);
 var lastNum=l ? parseInt(dts[l-1].firstChild.innerText) : 0;
 if(isNaN(lastNum)&&l>1){lastNum=parseInt(dts[l-2].firstChild.innerText)} //Footerありなら一つ前
 if(l==0 || lastNum<=setEndNum){return} // 最後まで調査済みなら回避
 for(var i=setEndIdx;i<l;i++){
  if(dds[i].parentElement.className=="refResult"){continue} // 逆参照内のDDなら回避
  var num=dts[i].firstChild.innerText; var span=dts[i].lastChild;
  // ID
  var t=getID(span); if(t&&t.length>3){idHash[t] = idHash[t] ? idHash[t]+" "+num : num;} // ???やID:0,ID:#(@ゾヌ)はスルー。
  // 画像板
  var imgURL=getIMG(span);
  if(imgURL){
   var dd=dts[i].nextSibling;
   if(tp && imgURL && !dd.getElementsByTagName("IMG").length){
    var aObj=(dd.innerText)?'<br><a href="'+imgURL+'">'+imgURL+'</a>':'<a href="'+imgURL+'">'+imgURL+'</a>';
    if(!beID && imgURL.match(/kako/)){/*dd.insertAdjacentHTML("beforeEnd","<br>Beにログインしてないと取得できません");*/}else{dd.insertAdjacentHTML("beforeEnd",aObj)}
   }
  }
  // ref,IMG
  var ddAnc=dds[i].getElementsByTagName("A");
  for(var j=0;j<ddAnc.length;j++){
   if      (checkAnchor(ddAnc[j].href)==0){
    continue;
   }else if(checkAnchor(ddAnc[j].href)==1){
    var anc=tohan(ddAnc[j].innerText.replace(/[>＞]/g,""));var start,end;
    if(anc.match(/(\d*)\D+(\d*)/)){
     start=parseInt(RegExp.$1); end=parseInt(RegExp.$2);
     if( (end-start>100) || (num-end<4 && start==1) ){continue} // >>1-1000とか>>1-n(直前レス)とかは華麗にスルー
    }else{
     start=end=parseInt(anc);
    }
    var k=start-1;do{k++;
     if((!refHash[k] || refHash[k].indexOf(num)==-1) && num>k){refHash[k]=refHash[k] ? refHash[k]+" "+num : num;} // 重複や未来へのアンカーはスルー
    }while(k<end);
   }else if(imageExt2(ddAnc[j].href) && onOpenLoad!=0){
    if(onOpenLoad==1){if(dds[i].previousSibling.className!="new"){continue}}
    insButton(ddAnc[j],ddAnc[j].href);
   }
  }
 }
 setEndIdx=l;setEndNum=lastNum;
 //var t1=new Date(); var t=(t1-t0)/1000; if(t){alert(t+"秒");}
}
// スレッドウィンドウ中心に前後5レスを着色
var resUnit=new Array();
function searchColoring(){
 if(!coloring){return;} // 着色不要なら終了
 if(!scr){scr=lightmode ? document.body : document.getElementById("dl");}
 var nowScrollPos=scr.scrollTop+document.body.clientHeight/2;
 var l=Math.min(dts.length,dds.length);var st,ed;
 // dtのoffsetTopを格納（25レス単位）
 if(resUnit.length<=Math.floor(dts.length/25)){resUnit[0]=0;
  for(var i=25;i<l;i+=25){resUnit[i/25]=dts[i].offsetTop;}
 }
 // 現在どのあたりまでスクロールしてるか調査
 var rul=resUnit.length-1;
 if     (rul==0)                   {st=0;ed=l-1;} //25未満
 else if(resUnit[0]>nowScrollPos)  {st=0;ed=24;}  //0-24
 else if(resUnit[rul]<nowScrollPos){st=l-26;ed=l-1;} // 最終25レス
 else{
  for(var i=rul;i--;){
   if(resUnit[i+1]>nowScrollPos&&resUnit[i]<=nowScrollPos){st=i*25;ed=st+25;break}
  }
 }
 // 現在の範囲内からウィンドウの真ん中あたりに表示してるレスを取得（ここで着色すると、25レス単位の切替時に数レスが着色されない）
 var dtIdx=0; //if(cp){cp.childNodes[1].value=(st+1)+"-"+(ed+1);cp.style.visibility="visible";}
 for(var i=st;i<=ed;i++){if(!dts[i+1]){dtIdx=ed;break;}
  if(dts[i+1].offsetTop>nowScrollPos && dts[i].offsetTop<=nowScrollPos){dtIdx=i;break;}
 }
 // dtIdxからその周辺を特定
 var start=dtIdx-5;var end=dtIdx+5;//
 for(var i=start;i<=end;i++){
  if(dts[i]){setSearchColor(dts[i])}
 }
}
// IDHash、refHashを元に着色
function setSearchColor(dt){
 if(!dt.innerText){return}
 // ID
 var span=dt.lastChild; var t=getID(span);//alert(t +"&&"+ idHash[t] +"&&"+ span);
 if     (browser=="ホットゾヌ２"){span=span.lastChild}
 else if(browser=="A Bone")      {span=span.childNodes[1]}
 if(t && idHash[t] && span){
  var idResult=idHash[t].split(" "); if(t.match(/\?\?\?/)){idResult="";idHash[t]="";}
  if     (idResult.length>=threshold3[0]){span.style.color=threshold3[1];span.title="同一ID ("+idResult.length+"回)\n"+idHash[t]}
  else if(idResult.length>=threshold2[0]){span.style.color=threshold2[1];span.title="同一ID ("+idResult.length+"回)\n"+idHash[t]}
  else if(idResult.length>=threshold1[0]){span.style.color=threshold1[1];span.title="同一ID ("+idResult.length+"回)\n"+idHash[t]}
  else if(idResult.length==1){span.title="同一IDは\nありません"}
 }
 // ref
 var numA=dt.firstChild; var num=numA.innerText; 
 if(refHash[num]){
  var refResult=refHash[num].split(" ");
  if     (refResult.length>=threshold6[0]){numA.style.color=threshold6[1];dt.title="これへのレス ("+refResult.length+"個)\n"+refHash[num];}
  else if(refResult.length>=threshold5[0]){numA.style.color=threshold5[1];dt.title="これへのレス ("+refResult.length+"個)\n"+refHash[num];}
  else if(refResult.length>=threshold4[0]){numA.style.color=threshold4[1];dt.title="これへのレス ("+refResult.length+"個)\n"+refHash[num];}
  else{numA.title="これへのレスはない模様"}
 }
}
//==========名前・ID検索等
function searchPerson(obj){
 var by,thisDT,reg;
 if     (obj.tagName=="DT")  {by="ID";  thisDT=obj;              reg=getID(obj)}
 else if(obj.tagName=="SPAN"){by="ID";  thisDT=obj.parentElement;reg=getID(obj)}
 else if(obj.tagName=="U")   {by="NAME";thisDT=obj.parentElement;              reg=obj.innerHTML.replace(/<B>(.*?)<\/B>/ig,"");if(!reg){reg=RegExp.$1.replace(/<.*?A.*?>/ig,"")}/*名前が数字*/}
 else if(obj.tagName=="B")   {by="NAME";thisDT=obj.parentElement.parentElement;reg=obj.innerText}
 else{return}
 if(!thisDT.rel){
  var c=selectColor("res"); if(!c){return} var color=new Array(c); // カラー選択
  if(by=="ID"){
   if(!reg || !idHash[reg]){return} // IDなし、ID:???、本文中の他スレのコピペID
   // 検索ハッシュに値を設定して、それに基づきレス着色
   foundRes[c]=idHash[reg].split(" "); foundRes[c].word="ID:"+reg;
   for(i in foundRes[c]){var dt=getDTfromAnc(foundRes[c][i]);toggleResColor(dt,c);}
  }else{
   var us=document.getElementsByTagName("U"); var l=us.length;
   var regName=new RegExp();regName.compile(reg);
   // ループ中にレス着色・値の設定を同時実行
   for(var i=l;i--;){var dt=us[i].parentElement;
    if(dt.parentElement.className=="refResult"){continue} // 逆参照内のDTなら回避
    if(regName.test(us[i].innerText)){toggleResColor(dt,c);foundRes[c].unshift(dt.firstChild.innerText);}
   }
   foundRes[c].word=reg;
  }
  returnFound("res",color);
 }else{
  clearColor("res",thisDT.style.backgroundColor);
 }
}
// ID文字列の抽出
var regID=new RegExp(); // HOSTも可能にしてみる
regID.compile(".*?\\s.*?\\s.*:(.*?)(\\s|$)"); // 1000resで0.02秒ほど高速
function getID(span){
 if(regID.test(span.innerText)){return(RegExp.$1)}else{return(false)}
}
//==========色設定解除
// オブジェクトの初期化
function createHash(name,key,arr,word){
 name[key]=arr?arr:new Array();
 name[key].word=word?word:"";
 name[key].justMovedRes=undefined;
}
// 色選択(該当レス番号配列を持たないキーを返す)
function selectColor(type){
 if(!foundRes) {foundRes =new Array();for(var i in foundResColor) {createHash(foundRes,foundResColor[i]);}}   // Hash foundRes  ={色:該当レス番号配列}
 if(!highlight){highlight=new Array();for(var i in highlightColor){createHash(highlight,highlightColor[i]);}} // Hash hightLight={色:該当レス番号配列}
 var cHash,cArray,cMess;
 if(type=="res"){cHash=foundRes; cArray=foundResColor; cMess="今までのレス着色を解除しますか？";}
 else           {cHash=highlight;cArray=highlightColor;cMess="今までのハイライトを解除しますか？";}
 var i=0; while(cHash[cArray[i]].word){
  i++; if(i==cArray.length){if(confirm(cMess)){clearColor(type);i=0;break}else{i=null;break}}
 }
 return(cArray[i]);
}
// 色解除（ハッシュ、対象、foundPanel）
function clearColor(type,color){
 var cHash=(type=="res")?foundRes:highlight;
 if(event && event.altKey){color=""}
 for(var i in cHash){
  if(type=="res"){
   if(color && i!=color){continue} // 指定色でなければスルー
   for(var j in cHash[i]){
    if(event.srcElement.value=="DEL"){removeRes(getDTfromAnc(cHash[i][j]))}else{toggleResColor(getDTfromAnc(cHash[i][j]))}
   }
   cHash[i]=new Array();
   document.getElementById("c"+i).removeNode(true);
  }else{
   var strongs=document.getElementsByTagName("STRONG");
   var reg=new RegExp(i);
   if(!color.match(i)){continue}  // 指定色でなければスルー
   for(var j=0;j<strongs.length;j++){
    if(strongs[j].style.backgroundColor==i){
     if(event.srcElement.value=="DEL"){removeRes(strongs[j].parentElement.previousSibling);j--}else{strongs[j].removeNode(false);j--}
    }
   }
   cHash[i]=new Array();
   if(document.getElementById("c"+i)){document.getElementById("c"+i).removeNode(true);} // and,or検索で１色目のみ
  }
 }
 if(!fp.hasChildNodes()){fp.style.visibility="hidden";searched=false;}
}
// レス色トグル
function toggleResColor(dt,c){
 if(!dt){return} // for-inで送られる番号以外のobjなら終了
 if(c){
  dt.rev=dt.style.backgroundColor;
  dt.rel="colored";
  dt.id ="COLOR"+c.replace(/#/,"");
  dt.style.backgroundColor=c;
 }else{
  dt.style.backgroundColor=dt.rev;
  if(dt.id.match(/COLOR/)){dt.removeAttribute("id")}//else{alert("dtにCOLOR***以外のid（"+dt.id+"）が設定されています")}
  dt.removeAttribute("rev");
  dt.removeAttribute("rel");
 }
}
// 検索結果に基づき消去
function removeRes(dt){if(!dt){return} // cHash[i][j]=ID:xxxxxxxxのとき
 if(browser=="Live2ch"){location.href='func:ABONECLEAR?'+dt.firstChild.innerText;} // Liveのみ-透明あぼ～ん
 dt.nextSibling.removeNode(true);dt.removeNode(true);
}
//==========結果表示
// レス番号リスト（ポップアップアンカーを含む）
function returnFound(type,color){
 var cHash=(type=="res")?foundRes:highlight;
 var nDIV="";var numArray=cHash[color[0]]; var display=new Array(["none","POP"],["inline","LST"]);
 if(searchView=="resPopup" || numArray.length>=listLimit){display=display.reverse();}
 // ポップアップ
 var nTT="";for(var i=0;i<color.length;i++){nTT+='<tt style="background-color:'+color[i]+'"> '+cHash[color[i]].word+'</tt>';}
 nDIV+='<span rel="'+type+'" style="display:'+display[0][0]+'">'+nTT+'</span>';
 // リスト
 var nA="";for(var i=0;i<numArray.length;i++){nA+=addAnchor(numArray[i],numArray[i])+" "}
 nDIV+='<tt style="background-color:'+color[0]+'" style="display:'+display[1][0]+'"> '+nA+'</tt>';
 // 個数
 nDIV+='&nbsp;'+numArray.length+' ';
 var buttons='<input type="button" value="'+display[0][1]+'" onclick="changeSearchView();blur()"><input type="button" value="∨" onclick="moveToSearchRes(\''+type+'\',\''+color+'\')" title="下へ検索"><input type="button" value="∧" onclick="moveToSearchRes(\''+type+'\',\''+color+'\')" title="上へ検索"><input type="button" value="CLR" onclick="clearColor(\''+type+'\',\''+color+'\')" title="Alt押下時\n着色レス全て"><input type="button" value="DEL" onclick="clearColor(\''+type+'\',\''+color+'\')" title="Alt押下時\n着色レス全て">';
 fp.innerHTML+='<div id="c'+color[0]+'">'+nDIV+buttons+'</div>';
 fp.style.visibility="visible";searched=true;
}
// 対象レスにジャンプ
var markedDT;
function moveToSearchRes(type,color){
 if(color.match(/(.*?),/)){color=RegExp.$1}
 var scope   = (event && event.srcElement.value=="∧") ? false : true ;
 var numArray= (type=="res") ? foundRes[color] : highlight[color];
 if(isNaN(numArray.justMovedRes)){numArray.justMovedRes=0}
 else{
  markedDT.style.borderColor="#999";
  if(scope){numArray.justMovedRes++;if(numArray.justMovedRes>=numArray.length){numArray.justMovedRes--;alert("これより下にはありません")}}
  else     {numArray.justMovedRes--;if(numArray.justMovedRes<0){numArray.justMovedRes++;alert("これより上にはありません")}}
 }
 markedDT=getDTfromAnc(numArray[numArray.justMovedRes]);   markedDT.style.borderColor="red";
 markedDT.scrollIntoView(true);
 setTimeout('markedDT.style.borderColor="#999"',5000);
}
// ポップアップとリスト表示切り替え
function changeSearchView(){
 var e=event.srcElement;
 if(e.value=="POP"){
  e.value="LST";
  e.parentElement.childNodes[0].style.display="inline";
  e.parentElement.childNodes[1].style.display="none";
 }else{
  e.value="POP";
  e.parentElement.childNodes[0].style.display="none";
  e.parentElement.childNodes[1].style.display="inline";
 }
}

//==========単語検索
function findIt(arg){createSearchPanel(arg);}
var searchWindow=null;
// 検索ウィンドウの表示
function createSearchPanel(arg){ // 専用ブラウザでのmodelessDialogへの外部読み込みでは、dialogArgumentsが送れないので直接書き出す
 if(arg){word=arg}
 if(searchWindow && !searchWindow.closed){return}
 var skinPath=document.getElementsByName("SkinPath")[0].content;
 searchWindow=showModelessDialog("",window,'dialogWidth:500px;dialogHeight:200px;dialogTop:0px;dialogLeft:0px;help:no;resizable:yes;status:no;unadorned:yes;');
 var nWin='<html><head><title>単語の検索<\/title>'
         +'<script type="text/javascript">function submitEvent(){var fo=document.forms[0]; dialogArguments.word=fo.word.value; var i=-1;do{i++;dialogArguments.expression  =fo.expression[i].value;}while(!fo.expression[i].checked); var i=0; while(fo.searchTarget[i]){dialogArguments.searchTarget[fo.searchTarget[i].value]=fo.searchTarget[i].checked;i++;} var i=-1;do{i++;dialogArguments.searchView  =fo.searchView[i].value;}while(!fo.searchView[i].checked); dialogArguments.searchWord();}</script>'
         +'<style type="text/css">body{background:ThreeDFace;padding:0.5em;overflow:auto} fieldset{padding:0.5em;margin-top:0.5em;} legend,label,input{font:message-box;}</style>'
         +'<\/head><body onunload="unloadEvent()"><form onsubmit="submitEvent();return false;"><table width="100%"><tr><td valign="top" colspan="3">'
         +'<label for="word">検索文字列：</label><input type="text" name="word" id="word" size="50" value="'+word+'" tabindex="0"><br>'
         +'</td><td align="right" valign="top" rowspan="2">'
         +'<input type="submit" name="submit" value="　検　索　" tabindex="7"><br><br><input type="button" name="cancel" value="キャンセル" onclick="window.close()" tabindex="8">'
         +'</td></tr><tr valign="top">'
         +'<td><fieldset><legend>検索方法</legend><input type="radio"    name="expression"   value="default" id="tDef" tabindex="1"> <label for="tDef">通常検索</label><br><input type="radio" name="expression" value="regExp" id="tReg"> <label for="tReg">正規表現</label><br><input type="radio" name="expression" value="multiAND" id="tAND"> <label for="tAND">AND検索</label><br><input type="radio" name="expression" value="multiOR" id="tOR"> <label for="tOR">OR検索</label></fieldset></td>'
         +'<td><fieldset><legend>検索対象</legend><input type="checkbox" name="searchTarget" value="name" id="tName" tabindex="2" checked> <label for="tName">名前</label><br><input type="checkbox" name="searchTarget" value="mail" id="tMail" tabindex="3" checked> <label for="tMail">メール</label><br><input type="checkbox" name="searchTarget" value="id" id="tID" tabindex="4" checked> <label for="tID">日付とID</label><br><input type="checkbox" name="searchTarget" value="mess" id="tMess" tabindex="5" checked> <label for="tMess">本文</label></fieldset></td>'
         +'<td><fieldset><legend>結果表示</legend><input type="radio"    name="searchView"   value="resList" id="rList" tabindex="6"> <label for="rList">レス番号を表示</label><br><input type="radio" name="searchView" value="resPopup" id="rPop"> <label for="rPop">レスをポップアップ</label><br><input type="radio" name="searchView" value="resJump" id="rJump"> <label for="rJump">レスへジャンプ</label></fieldset></td>'
         +'</tr></table></form><\/body><\/html>';
 searchWindow.document.write(nWin);
 sdf=searchWindow.document.forms[0]; sdf.elements[0].select();
 var ex=sdf.expression;for(var i=0;i<ex.length;i++){if(ex[i].value==expression){ex[i].checked=true}}
 var sv=sdf.searchView;for(var i=0;i<sv.length;i++){if(sv[i].value==searchView){sv[i].checked=true}}
 range=document.body.createTextRange();
}
// 検索処理メイン
var word="";var range;var searchTarget={"word":true};
function searchWord(){
 if(!word){return}
 var matchs=new Array(); var color=new Array();
 // 検索方法
 if(expression=="regExp" || expression=="default" || (expression.match(/multi/) && !word.match(/\s/))){ // AND/ORで一単語ならdefaultで検索
  // 検索語指定（重複排除で高速化？）
  if(expression=="regExp"){
   var regWord=word.replace(/[\^\$]/g,"");
   var reg=new RegExp(regWord,"g"); var tmpArr=range.text.match(reg); var tmp;
   if(!tmpArr || !tmpArr.length){tmpArr=new Array(tmpArr)} // 検索結果0or1なら、配列作成
   tmpArr.sort();for(var i=0;i<tmpArr.length;i++){if(tmp!=tmpArr[i]){matchs.push(tmpArr[i])}tmp=tmpArr[i]}
   if(!matchs || !matchs.length){matchs[0]=word} // 検索結果0or1なら、配列作成
  }else{matchs[0]=word}
  // ハイライト
  for(var i=0;i<matchs.length;i++){color.push(setHighlight(matchs[i]));}
  highlight[color[0]].word=word;
 }else{
  // 検索語指定
  var matchs=word.split(" "); var tmpArr=new Array(); var tmp;
  // ハイライト→重複処理
  for(var i=0;i<matchs.length;i++){
   color.unshift(setHighlight(matchs[i]));
   highlight[color[0]].word=matchs[i];
   tmpArr=tmpArr.concat(highlight[color[0]])
  }
  color.reverse();tmpArr.sort();createHash(highlight,color[0],"",matchs[0]); // 一旦初期化
  var judge = (expression=="multiAND") ? "tmp==tmpArr[i]" : "tmp!=tmpArr[i]";
  for(var i=0;i<tmpArr.length;i++){if(eval(judge)){highlight[color[0]].push(tmpArr[i])}tmp=tmpArr[i]} // 検索結果はhighlight[color[0]]に入れる
 }
 // 結果表示
 if     (searchView=="resList") {returnFound("search",color);searchWindow.close();}
 else if(searchView=="resPopup"){returnFound("search",color);searchWindow.close();}
 else if(searchView=="resJump") {returnFound("search",color);searchWindow.close();if(highlight[color[0]].length){moveToSearchRes("search",color.join(","))}}
}
// ハイライト検索
function setHighlight(reg){
 // カラー選択
 var c=selectColor("highlight"); if(!c){return}
 // 検索
 while(range.findText(reg)){
  var dt=range.parentElement();var tag=dt.tagName; var thisRange;
  // 検索対象で絞り込み
  if(tag=="B"||tag=="U"){thisRange="name"}
  else if(tag=="DT")    {thisRange="mail"}
  else if(tag=="SPAN")  {thisRange="id"}
  else if(tag=="DD" || tag=="A" && dt.parentElement.tagName=="DD"){thisRange="mess"}
  else if(tag=="STRONG"){thisRange="word"}
  else{/*alert("tag："+tag+"\ndt:"+dt.outerHTML);*/range.collapse(false);continue;} // レス番号(A)や検索結果自体(TT)
  if(!searchTarget[thisRange]){range.collapse(false);continue;}
  // 正規表現の位置指定子がある場合、包含要素内部で再検索
  if(expression=="regExp" && word.match(/[\^|\$]/)){
   var thisReg=new RegExp(word); var targetText=(tag=="STRONG") ? dt.parentElement.innerText : dt.innerText;
   if(!targetText.match(thisReg)){range.collapse(false);continue}
  }
  // dt取得→レス番号取得→ハイライト
  if(dt.tagName!="DT"){
   while(dt.tagName!="DT" && dt.tagName!="DD"){dt=dt.parentElement}
   if(dt.tagName=="DD"){dt=dt.previousSibling}
  }
  var num=dt.firstChild.innerText;
  if(dt.parentElement.className!="refResult" && num!=highlight[c][highlight[c].length-1]){highlight[c].push(num)} // 逆参照内のDT,同一番号なら回避
  range.pasteHTML('<strong style="background-color:'+c+'">'+range.text+'</strong>');
  range.collapse(false);
 }
 range=document.body.createTextRange(); // レンジを元に戻しておく
 return(c);
}
//==========逆参照
function searchRef(obj){
 if(obj.name!='referred'){
  var num=obj.firstChild.innerText;
  if(refHash[num]){
   var refArr=refHash[num].split(/\s/); var refs="";
   for(var i=0;i<refArr.length;i++){refs+=returnString(refArr[i]);}
   obj.nextSibling.insertAdjacentHTML("beforeEnd",'<dl class="refResult">'+refs+'</dl>')
   obj.name="referred";
  }
 }else{
  obj.nextSibling.lastChild.removeNode(true);
  obj.name='';
 }
}
//==========クリップボードにコピー
function copyText(target){
 var num=event.srcElement.parentElement.name;
 var obj=getDTfromAnc(num);
 var textarea=document.createElement("TEXTAREA");
 var message=obj.nextSibling.innerText.replace(/\s(\r\n|$)/g,"\n");
 if     (target=="res") {textarea.value=obj.firstChild.innerText+" ："+obj.childNodes[1].innerText+" ："+obj.lastChild.innerText+"\n"+message;}
 else if(target=="name"){textarea.value=obj.childNodes[1].innerText+"\n";}
 else if(target=="id")  {textarea.value="ID:"+(obj.lastChild.innerText.split(/ID:/))[1]+"\n";}
 var copyText=textarea.createTextRange();
 copyText.execCommand("Copy")
 event.srcElement.parentElement.removeNode(true);
}
//==========アンカーからDTを特定
var ancs=document.anchors;
function getDTfromAnc(num){
 var anc=ancs(anchorHead+num);
 if(!anc){return("")} //LABELNUMBER対応のあぼ～ん若しくは未出番号なら終了
 var obj=anc.parentElement; //LABELNUMBER対応のもの
 if(!obj || !obj.tagName){return false;}
 if(obj.tagName!="DT"){ //LABELNUMBER非対応のもの
  if(num==1){if(anc){obj=anc.nextSibling}                           else{return("")}}
  else      {if(!anc.nextSibling){obj=anc.parentElement.nextSibling}else{return("")}}
 }
 return(obj);
}

// 画像板関連
var regIMG=new RegExp(".*?\\s.*?\\s.*:.*?\\sIMG:(.*?)(\\s|$)"); // 画像も可能にしてみる
function getIMG(obj){
 if(regIMG.test(obj.innerText)){
  var filename=RegExp.$1;
  var tmp=filename.match(/(\d\d\d\d)(\d\d\d\d)(\d\d)/);
  var today=new Date();var last=new Date(today-7*24*60*60*1000);var date="";
  date+=last.getMonth()<9 ? "0"+(last.getMonth()+1) : last.getMonth()+1;
  date+=last.getDate()<10 ? "0"+last.getDate()      : last.getDate();
  var log= (RegExp.$1+""+RegExp.$2 < last.getYear()+""+date) ? "_kako/" : "_img/";
  var fileurl="http://up01.2ch.io/"+log+RegExp.$1+"/"+RegExp.$1+RegExp.$2+"/"+RegExp.$3+"/"+filename;
  return(fileurl)
 }else{return(false)}
}

