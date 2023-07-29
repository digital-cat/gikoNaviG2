// イベントハンドラ：onMouseover
// 外部変数：anchorHead,dds
//======画像読み込みの設定  （注）WindowsXP SP2ではこれらの設定は有効に機能しません。
var onOpenLoad =1;  	// 0:読み込まない、1:新着レスのみ、2:全部
var onMouseLoad=true;	// true:カーソルを合わせただけ、false:LOADボタンをクリックしてから
//==========グローバル変数
var lightmode=true; // Live,twinのジャンプ用判定で用いているので必須
//==========画像処理等
// 外部用addAnchor
function addAnchor2(inner,num){
 return('<a onclick="dialogArguments.document.getElementsByName(\''+anchorHead+num+'\')[0].scrollIntoView(true)" style="cursor:hand">'+num+'</a>')
}
// モード切替（30-3はモードは一定）
function changeMode(){}
// パネルの展開
var thumbWindow=null;
function changePanel(){
 if(thumbWindow && !thumbWindow.closed){return}
 var skinPath=document.getElementsByName("SkinPath")[0].content;
 thumbWindow=showModelessDialog("",window,'dialogWidth:127px;dialogHeight:125px;dialogTop:0px;dialogLeft:0px;help:no;resizable:yes;status:no;unadorned:yes;');
 thumbWindow.document.write('<html><head><title>画像パネル<\/title>');
 thumbWindow.document.write('<link rel="stylesheet" type="text\/css" href="'+skinPath+'chie_image2.css">');
 thumbWindow.document.write('<script type="text\/javascript" src="'+skinPath+'chie_thumbPanel.js"><\/script>');
 thumbWindow.document.write('<\/head>');
 thumbWindow.document.write('<body><div id="thumbPanel"><\/div><div id="viewPanel" onclick="changeView()"><\/div><\/body>');
 thumbWindow.document.write('<\/html>');
 window.focus();
}
// LOADボタン
function insButton(a,hRH) {
 if(a.className!='replaced' && a.parentElement.tagName!='DIV'){
  if(imageExt2(a.href)){
   var nHTML='<input type="button" value="LOAD" onClick=\'loadImage(this,"'+a.href+'");blur()\'>';
  }else if(imageExt(a.href)){
   var nHTML='<input type="button" value="LOAD" onClick=\'loadImage(this,"'+a.href+'");blur()\'>'
            +'<input type="button" value="VIEW" onClick=\'loadDirect("swf","'+a.href+'");blur()\'>';
  }else{
   if(hRH){var ahref=hRH}else{var ahref=a.href}
   var nHTML='<input type="button" value="VIEW" onClick=\'loadDirect("html","'+ahref+'");blur()\'>'
            +'<input type="button" value="CHECK" onClick=\'loadDirect("html","http://www.tekijuku.com/URL/?url='+ahref+'");blur()\'>';
  }
  a.insertAdjacentHTML('AfterEnd',nHTML);
  a.className = 'replaced';
  if(onMouseLoad && imageExt2(a.href)){loadImage(a.nextSibling,a.href)}
  return;
 }
}
// HTMLの読込
function loadDirect(mode,href){
  changePanel();
  var nHTML,buttons;
  if(mode=="swf"){nHTML='<embed src="'+href+'"></embed>'}
  else           {nHTML='<object data="'+href+'" onError="changeView()"></object>'}
  if(browser!="ホットゾヌ２"){buttons='<button onclick="window.open(\''+href+'\',\'_parent\');clearView()">OPEN</button><button onclick="clearView()">CLOSE</button>';}
  else                       {buttons='<button onclick="window.open(\''+href+'\',\'_blank\');clearView()">OPEN</button><button onclick="clearView()">CLOSE</button>';}
  thumbWindow.dialogWidth =screen.availWidth+"px";
  thumbWindow.dialogHeight=screen.availHeight+"px";
  thumbWindow.viewPanel.innerHTML=nHTML+buttons;
  thumbWindow.viewPanel.style.visibility="visible";
  thumbWindow.viewPanel.firstChild.style.posHeight=thumbWindow.document.body.clientHeight-20;
}

// 画像読込
function loadImage(btn,href){
 changePanel();
 var tp = thumbWindow.document.getElementById("thumbPanel");
 if(btn.tagName!="A"){
  var thumbs = thumbWindow.document.images;
  var l=thumbs.length;
  for(i=l;i--;){if(thumbs[i].src==href){imgOver(tp,100);imgOver(thumbs[i],100);return true;}}
 }
 if(btn.parentElement.tagName=="DD"){var dt = btn.parentElement.previousSibling;}
 else                               {var dt = btn.parentElement;}
 var num = dt.firstChild.innerText;
 if(href.search(/\.swf/i)==-1){
  var nHTML = '<div><img src="'+href+'" onLoad="imgResult(this)" onError="imgResult(this)" onClick="changeView(\'img\')" onmouseover="imgOver(this,100)" onmouseout="imgOver(this,30)">'
            +addAnchor2(num,num)+' '
            +'<button onClick="changeSize(this);blur()">...</button>'
            +'<button onClick="removeThumb(this)">DEL</button>'
            +'</div>';
 }else{
  var nHTML = '<div><embed src="'+href+'" onFocus="changeView(\'swf\')"></embed>'
            +addAnchor2(num,num)+' '
            +'<button onClick="blur()">___</button>'
            +'<button onClick="removeThumb(this)">DEL</button>'
            +'</div>';
  var h=(tp.childNodes.length+1)*98+27;
  if(h < screen.availHeight){thumbWindow.dialogHeight=h+"px"}
 }
 if(btn.tagName=="INPUT"){btn.value = 'LOADED';}
 tp.insertAdjacentHTML('BeforeEnd',nHTML);
}
// エラー画像の削除
function removeError(){
 if(thumbWindow){
  var thumbs = thumbWindow.document;
  var l=thumbs.images.length;
  for(var i=l;i--;){
   var stateBtn=thumbs.getElementById("thumbPanel").childNodes[i].childNodes[2];
   if(stateBtn.tagName=="BUTTON" && stateBtn.innerText=="NONE"){stateBtn.parentElement.removeNode(true);}
  }
 }
}
// LOADボタン挿入対象拡張子（通常用）
function imageExt(isu) {if(isu.search(/\.png$|\.jp(g|e|eg)$|\.gif$|\.bmp$|\.swf/i)!=-1){return true}else{return false}}
// LOADボタン挿入対象拡張子（一括読込用）
function imageExt2(isu){if(isu.search(/\.png$|\.jp(g|e|eg)$|\.gif$|\.bmp$/i)!=-1){return true}else{return false}}

// 画像一括読み込み
function allImageLoad(mode){
 var ddl=dds.length;var exist;
 for(i=0;i<ddl;i++){
  if(mode=="new"){if(dds[i].previousSibling.className!="new"){continue}}
  cl=dds[i].childNodes.length;
  for(j=0;j<cl;j++){
   cn=dds[i].childNodes[j];
   if(cn.tagName == "A"){
    if(imageExt2(cn.href)){loadImage(cn,cn.href);exist=true}
   }
  }
 }
 if(!exist){
  if(mode=="new"){var target="新着レスに"}else{var target="全てのレスに"}
  alert(target+"画像はないよ\ ")
 }
}
// モザイク処理
function imgOver(my,num) {my.style.filter="Alpha(opacity="+num+")"}
