try{document.charset='Shift_JIS'}catch(e){}
//========�V���W�����v�ݒ�
var buffer=1;     // �ᑬ�����ᑬ�}�V���̏ꍇ�ɂ�buffer�̐��l�𑝂₷�Ƃ�萳�m�ɃW�����v�i1���₷��0.1�b�x���j
var newResJump=1; // �V�����X�W�����v�i0:�u���E�U�C���A1:�Ǘ����̂݁A2:�펞�j��������AOpenJane�Atwintail�݂̂̐ݒ�
//==========�ȉ��̓X�N���v�g�{���ł���B
//�C�x���g�n���h����`
//�O���֐��Ftohan
//�O���ϐ��FanchorHead,lightmode,getID,skinName,browser,dts
//=========�O���t�@�C�����p�̃O���[�o���ϐ�
var waited=false;//command�\����true�ɂ��A�I�����false�ɂ���B
var viewed=false;//thumb�Ǎ��݌�true�ɂ��AthumbPanel�ɏ�~��false�ɂ���B
var searched=false; //������ɁAtrue�ɂ��AfoundPanel�ɏ�~��false�ɂ���B
var cp,tp,vp,fp;
//========Click������search,��
	document.onclick = clickEvent;
function clickEvent(){
 if(clickCancel){return false}else{clearTimeout(clickTimer);if(document.getElementById("context")){document.getElementById("context").removeNode(true);}}
 var obj=window.event.srcElement;
 var tag=obj.tagName;
 if(tag=="B"||tag=="U"||tag=="SPAN"){searchPerson(obj)} //���O,�g���b�v,ID
 else if(tag=="DT")  {searchRef(obj)}
 else if(tag=="DD")  {defaultPopup()}
 else if(tag=="A"){
  if(obj.rel){obj.href=obj.rel;}
  //if(obj.parentElement.tagName!="DIV"){setHistory(obj);}
  //���t�������N
  if(browser=="Live2ch" || browser=="������`����"){
   if(obj.href.match(/^http:.*#/)){window.open(obj.href,"_parent");return false}
  }
  //A Bone�␳�i��\�����X�̕\���j
  if((browser=="A Bone"||browser=="�M�R�i�r") && hiddenRes(obj)){showModelessDialog(document.getElementsByName("ThreadURL")[0].content.replace(/\/l50$/,"/")+tohan(obj.innerText.replace(/[>��]/g,"")),window,"dialogWidth:"+document.body.clientWidth+"px;help:no;resizable:yes;status:no;unadorned:yes;");window.focus();}
  //Jane,Live,�M�R�i�r�␳�iskin30-2Normal�y�уM�R�i�r�j�����X�W�����v��scrollIntoView�łȂ����̂ɌW��␳
  if(browser=="A Bone" || browser=="OpenJane" || browser=="Live2ch" || browser=="�M�R�i�r"){if(obj.href.match(/^about|jumpres/)){
   var h=tohan(obj.innerText.replace(/[>��]/g,""));
   var anchor=document.anchors(anchorHead+h);
   if(anchor){anchor.scrollIntoView(true);return false}
  }}
  return true;
 }
 else{panelOver();return}
}

//=========MouseOver������image,popup
	document.onmouseover = mouseOverEvent;
function mouseOverEvent() {
 var e = window.event.srcElement;
 if(e.tagName=='B'){if(browser!="twintail2"){
  if(e.innerText.match(/^([^\d�O-�X]*)([\d�O-�X]+)([^\d�O-�X]*.*)/)){namePopup(e,RegExp.$1,RegExp.$2,RegExp.$3);}
  else if(e.innerText.match(/^���ځ`��$/))                          {abonePopup(e);}
 }}
 if(e.tagName=='A'){
  if(!e.innerText.match(/%/)){ // URL�G���R�[�h�ł��肪����%���Ȃ����
   //e.href=e.href.replace(/>/g,"");
   //e.href=e.href.replace(/\/ime.\w+/g,"");
  }else{
   try{
    e.title=decodeURI(e.innerText);
   }catch(err){
     // ShiftJIS,EUC-JP�̃f�R�[�h�͖ʓ|��������Ȃ��B
   }
  }
  try{e.href}catch(err){return} // IE7���Ɖ��̂�e.href���擾�o���Ȃ�A�v�f������
  if     (checkAnchor(e.href)==2){insButton(e);return;}
  else if(checkAnchor(e.href)==1){  // ���i�|�b�v�A�b�v
   if(event.shiftKey){if(e.rel){e.href=e.rel}return}
   var parent=e.parentElement;
   var aNum= (parent.tagName!="DD") ? parent.firstChild.sourceIndex : parent.previousSibling.firstChild.innerText;
   if(!document.getElementById("p"+aNum)){
    var obj=e;var onPopup;
    while(obj.tagName!="BODY"){if(obj.id.match(/p\d+/)){onPopup=true;break}else{obj=obj.parentElement}}
    if(!onPopup){removePopup()}
    makePopContent(e);return;
   }
  }else if(checkAnchor(e.href)==0){ // �t�Q�ƃ|�b�v�A�b�v
   if(e.href.match(/menu:/) && event.shiftKey){searchPopup(e)}
  }
 }else if(e.tagName=="SPAN"||e.tagName=="TT"){
  var obj=e;var onPopup;
  while(obj.tagName!="BODY"){if(obj.id.match(/p\d+/)){onPopup=true;break}else{obj=obj.parentElement}}
  if(e.tagName=="SPAN"){
   if(!onPopup && event.shiftKey){searchPopup(e)}
  }else{searchPopup(e)}
 }else{ // ���i�|�b�v�A�b�v����
  var obj=e;var onPopup;
  if(obj.sourceIndex<0){obj=document.body;if(document.getElementById("popupBase")){onPopup=true;}} // namePopup�Ƃ̋����Ńm�[�h���O���u�Ԃ̉��
  while(obj.tagName!="BODY"){if(obj.id.match(/(p\d+)/)){onPopup=true;break}else{obj=obj.parentElement;}}
  if(onPopup){while(obj.id!=obj.parentElement.lastChild.id){obj.parentElement.lastChild.removeNode(true)}}
  else       {removePopup()}
 }
}
//=========MouseMove������panelOver()
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
// �e�p�l��
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
  var nHTML='<div id="command" onclick="clearCommand()"><input type="button" onclick="allImageLoad(\'all\')" value="�S���X�ꊇ�Ǎ�"><br><input type="button" onclick="allImageLoad(\'new\')" value="�V���X�ꊇ�Ǎ�"><br><input type="button" onclick="removeError()" value="Error�摜�폜"><br></div>';
  event.srcElement.parentElement.insertAdjacentHTML('beforeEnd',nHTML);
  if(skinName.match(/30-2/)){
   //if(!lightmode){document.getElementById("command").insertAdjacentHTML('afterBegin','<input type="button" onclick="changePanel()" value="�p�l���ؑ�"><br>')}
   document.getElementById("command").insertAdjacentHTML('beforeEnd','<input type="button" onclick="changeMode()" value="���[�h�ؑ�">')
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
//=========������������copyMenu()
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

//�R�s�[���j���[��colorChange(),search::copyText()
function copyMenu(){
 clickCancel=true; clearTimeout(clickTimer);
 if(document.getElementById("context")){document.getElementById("context").removeNode(true);}
 var nHTML='<div id="context" name="'+e.innerText+'"><div onclick="copyText(\'res\')" onmouseover="colorChange()" onmouseout="colorChange()">���X���R�s�[</div><div onclick="copyText(\'name\')" onmouseover="colorChange()" onmouseout="colorChange()">���O���R�s�[</div><div onclick="copyText(\'id\')" onmouseover="colorChange()" onmouseout="colorChange()">ID���R�s�[</div></div>';
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

//=========�L�[�{�[�h���́iskin30-2�ł̃L�[�����̉���{���j
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
  //������`����␳�i�X�V�̃V���[�g�J�b�g�L�[�j
  if(browser=="������`����"){
   if(!t_url){threadurl();}
   window.open("http://"+t_domain+"/"+t_bbs+"/","_blank");
   return false;
  }
 }
}

//=========�V�����X�擾�㏈���i�W���X�L�����Ή��u���E�U�p�j��Timer����Footer����Ăяo��
//=========������AABone�A�]�k�Q
var newResNum=parseInt(document.getElementsByName("GetRescount")[0].content)+1;
var k=0;
function loadEvent(num){
 //====�V�����X�W�����v
 if(newResJump==0){clearInterval(timerID);return} //�u�u���E�U�C���v�Ȃ�I��
 //�V�����X�̊J�n�ԍ����擾
 if     (browser=="������`����"){if(isNaN(newResNum)){while(dts[k]){if(dts[k].className=="new"){newResNum=parseInt(dts[k].firstChild.innerText);break;} k++;}}}
 else if(browser=="�z�b�g�]�k�Q"){newResNum=num+1;}
 var anc=document.anchors(anchorHead+newResNum);
 if(!anc || !anc.parentElement){return} // �������ځ`�񂳂�Ă���I��
 //�V�����X�W�����v
 scr=lightmode ? document.body : document.getElementById("dl");
 viewPos=scr.scrollTop+scr.clientHeight;// �X�N���[����̉�ʉ����ʒu
 endPos =anc.offsetTop+20;				// �V���X�A���J�[�ʒu
 //�Ō�܂œǗ� or �u��ɐV���W�����v�v�Ȃ�W�����v
 if(viewPos>endPos || newResJump==2){clearInterval(timerID);setTimeout("moveToNew("+newResNum+")",buffer*100)}
 else{firstNew=document.anchors(anchorHead+newResNum).parentElement.nextSibling;}
}
//=========�V�����X�擾�㏈���i�W���X�L���Ή��u���E�U�p�j��NewMark����Ăяo��
//=========OpenJ�Atwin
var scr,viewPos,endPos=0;
function reloadEvent(){
 //====���ǉ�
 var lastDt=dts[dts.length-2];if(!lastDt){return}// �S���V���Ȃ�I��
 while(lastDt && lastDt.className=="new"){lastDt.className="";lastDt=lastDt.previousSibling.previousSibling;}
 //====�V�����X�W�����v
 if(newResJump==0){return} //�u�u���E�U�C���v�Ȃ�I��
 var ancs=document.anchors;
 var newResNum=parseInt(ancs[ancs.length-1].name)+1;
 scr=lightmode ? document.body : document.getElementById("dl");
 viewPos=scr.scrollTop;
 endPos =scr.scrollHeight-scr.clientHeight-20;
 //�Ō�܂œǗ� or �u��ɐV���W�����v�v�Ȃ�W�����v
 if(viewPos>endPos || newResJump==2){setTimeout("moveToNew("+newResNum+")",buffer*100);}
}

// �V�����X�ړ��{�V�����X�̈ʒu���L��
var firstNew;
function moveToNew(num){
 firstNew=getDTfromAnc(num);
 while(!firstNew){num--;firstNew=getDTfromAnc(num);} //�Ώۂ��������ځ`��Ȃ琔�����炷
 firstNew.scrollIntoView(true);
}

//=========DoubleClick������defaultPopup()
	document.ondblclick=defaultPopup;
function defaultPopup(){
 var num=document.selection.createRange().text.replace(/\s$/,"");
 var hnum=tohan(num);
 if(!isNaN(hnum) && hnum<=1000){
  var obj=document.createElement("a");
  obj.innerText=num;
  obj.href="#"+hnum;
  makePopContent(obj);
 }else if(num.match(/\w{8,9}/)){ //\w{8}�ł͂��߂ہH
  var obj=document.createElement("DT");
  obj.innerHTML="<span>date time ID:"+num+"</span>";
  searchPerson(obj.firstChild);
 }
}

//=========Copy����
//head����ǂނ�body�͌����Ȃ��̂ŁA��p�u���E�U�̓����𗘗p����body�̌��ɏ����o��
//�{���ǂ���head�ɏ����o��SkinManager�΍�Ŕ����������
	if(document.body) document.write('<script type="text/javascript">document.body.oncopy=copyEvent</script>\n');
function copyEvent(){
 var textarea=document.createElement("TEXTAREA");
 textarea.value=document.selection.createRange().text.replace(/\s(\r\n|$)/g,"\n");
 var copyText=textarea.createTextRange();
 copyText.execCommand("Copy");
 return false; 
}
//=========onScroll����
//window.onscroll=function(){clearInterval(beforeScrollTimer);onLoadEvent()}
window.onscroll=function(){onLoadEvent()}
if(document.getElementById("dl")){
 document.getElementById("dl").onscroll=function(){onLoadEvent()}
}
//=========onLoad����
window.onload=onLoadEvent;
function onLoadEvent(){mouseMoveEvent();setHash();searchColoring();}
setTimeout("onLoadEvent()",1000); // ��񂾂����F

