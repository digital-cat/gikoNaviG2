// �C�x���g�n���h���FonMouseover
// �O���ϐ��FanchorHead,dds
//======�摜�ǂݍ��݂̐ݒ�  �i���jWindowsXP SP2�ł͂����̐ݒ�͗L���ɋ@�\���܂���B
var onOpenLoad =1;  	// 0:�ǂݍ��܂Ȃ��A1:�V�����X�̂݁A2:�S��
var onMouseLoad=true;	// true:�J�[�\�������킹�������Afalse:LOAD�{�^�����N���b�N���Ă���
//==========�O���[�o���ϐ�
var lightmode=true; // Live,twin�̃W�����v�p����ŗp���Ă���̂ŕK�{
//==========�摜������
// �O���paddAnchor
function addAnchor2(inner,num){
 return('<a onclick="dialogArguments.document.getElementsByName(\''+anchorHead+num+'\')[0].scrollIntoView(true)" style="cursor:hand">'+num+'</a>')
}
// ���[�h�ؑցi30-3�̓��[�h�͈��j
function changeMode(){}
// �p�l���̓W�J
var thumbWindow=null;
function changePanel(){
 if(thumbWindow && !thumbWindow.closed){return}
 var skinPath=document.getElementsByName("SkinPath")[0].content;
 thumbWindow=showModelessDialog("",window,'dialogWidth:127px;dialogHeight:125px;dialogTop:0px;dialogLeft:0px;help:no;resizable:yes;status:no;unadorned:yes;');
 thumbWindow.document.write('<html><head><title>�摜�p�l��<\/title>');
 thumbWindow.document.write('<link rel="stylesheet" type="text\/css" href="'+skinPath+'chie_image2.css">');
 thumbWindow.document.write('<script type="text\/javascript" src="'+skinPath+'chie_thumbPanel.js"><\/script>');
 thumbWindow.document.write('<\/head>');
 thumbWindow.document.write('<body><div id="thumbPanel"><\/div><div id="viewPanel" onclick="changeView()"><\/div><\/body>');
 thumbWindow.document.write('<\/html>');
 window.focus();
}
// LOAD�{�^��
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
// HTML�̓Ǎ�
function loadDirect(mode,href){
  changePanel();
  var nHTML,buttons;
  if(mode=="swf"){nHTML='<embed src="'+href+'"></embed>'}
  else           {nHTML='<object data="'+href+'" onError="changeView()"></object>'}
  if(browser!="�z�b�g�]�k�Q"){buttons='<button onclick="window.open(\''+href+'\',\'_parent\');clearView()">OPEN</button><button onclick="clearView()">CLOSE</button>';}
  else                       {buttons='<button onclick="window.open(\''+href+'\',\'_blank\');clearView()">OPEN</button><button onclick="clearView()">CLOSE</button>';}
  thumbWindow.dialogWidth =screen.availWidth+"px";
  thumbWindow.dialogHeight=screen.availHeight+"px";
  thumbWindow.viewPanel.innerHTML=nHTML+buttons;
  thumbWindow.viewPanel.style.visibility="visible";
  thumbWindow.viewPanel.firstChild.style.posHeight=thumbWindow.document.body.clientHeight-20;
}

// �摜�Ǎ�
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
// �G���[�摜�̍폜
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
// LOAD�{�^���}���Ώۊg���q�i�ʏ�p�j
function imageExt(isu) {if(isu.search(/\.png$|\.jp(g|e|eg)$|\.gif$|\.bmp$|\.swf/i)!=-1){return true}else{return false}}
// LOAD�{�^���}���Ώۊg���q�i�ꊇ�Ǎ��p�j
function imageExt2(isu){if(isu.search(/\.png$|\.jp(g|e|eg)$|\.gif$|\.bmp$/i)!=-1){return true}else{return false}}

// �摜�ꊇ�ǂݍ���
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
  if(mode=="new"){var target="�V�����X��"}else{var target="�S�Ẵ��X��"}
  alert(target+"�摜�͂Ȃ���\ ")
 }
}
// ���U�C�N����
function imgOver(my,num) {my.style.filter="Alpha(opacity="+num+")"}
