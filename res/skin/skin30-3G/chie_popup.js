//==========�ȉ��̓X�N���v�g�{���ł���B
// �C�x���g�n���h���FonMouseover
// �O���ϐ��FidHash,refHash,foudRes,highlight
// �O���֐��FaddAnchor,getDTfromAnc
// �����FDIV#popupBase���Ɂu�t���b�g�Ń��j�A�v��DL#p\d���쐬����B
//==========CSS�̏o��
var nCSS=''
nCSS+='#popupBase{font-size:90%;}'; //�t�H���g�T�C�Y�̎w��
nCSS+='#popupBase{position:absolute;width:100%;height:100%;z-index:7}';
nCSS+='#popupBase dl{position:absolute; background-color:window; border:outset 1px infobackground; overflow-y:auto; z-index:5; border-top:none}';
nCSS+='#popupBase dt span{float:none; margin-left:1em;}';
nCSS+='#popupBase dd{margin:auto 1em}';
document.write('<style type="text/css">'+nCSS+'</style>\n');
//=========�O���t�@�C�����p�̃O���[�o���ϐ�
//=========�i���o�[�Ȗ��O�̃|�b�v�A�b�v
function namePopup(e,before,num,after){
 var hnum=tohan(num);
 if(hnum==774 || hnum==21 || hnum==1 || hnum==30){return} // Socket774�A774KB�A21�ցA[1-30]�A�Ȃǂ͖���
 if(before && before.match(/����/)){return} //���������ۂ��͖̂���
 if(after) {if(after=="���N"){return}} // �f�t�H���g��"�����N"�͖���
 var nB = before ? "<b>"+before+"</b><b>":"<b>"; nB+=addAnchor(hnum,num); nB+=after ? "</b><b>"+after+"</b>":"</b>";
 e.outerHTML=nB;
}
//=========�゠�ځ`��̃|�b�v�A�b�v
function abonePopup(e){e.outerHTML = "<b>"+addAnchor(e.parentElement.previousSibling.innerText,'���ځ`��')+"</b>";}
//=========�����������X�̃|�b�v�A�b�v
function searchPopup(obj){
 var reg,cArray;var tag=obj.tagName;
 /*ref Popup*/if     (tag=="A")   {if(refHash[obj.innerText]){cArray=refHash[obj.innerText].split(" ")}else{return}}
 /*ID Popup*/ else if(tag=="SPAN"){reg=getID(obj);if(reg&&reg.length>3){cArray=idHash[reg].split(" ");}else{return} if(cArray.length==1){return}}
 /*����Popup*/else if(tag=="TT")  {var cHash=(obj.parentElement.rel=="res")?foundRes:highlight;cArray=cHash[obj.parentElement.firstChild.style.backgroundColor];if(!cArray){return}}
 var targetString=""; for(var i=0;i<cArray.length;i++){targetString+=returnString(cArray[i]);} //���g�̐؂�o��
 if(targetString){popup(targetString);} //�Ώۂ����݂�����|�b�v�A�b�v
}
//=========���i�|�b�v�A�b�v
//�E�|�b�v�A�b�v�̍쐬
function makePopContent(obj){
 //���O����
 var num=obj.innerText.replace(/[>��]/g,""); var number=tohan(num);
 if(!obj.rel){obj.rel=obj.href;} obj.href="decoy:"; // �u���E�U�{�̂̃|�b�v�A�b�v���
 //�ԍ�����
 if(number.match(/(\d*)\D+(\d*)/)){var start=parseInt(RegExp.$1); var end=parseInt(RegExp.$2);}
 else                             {var start=end=parseInt(number);}
 if(end-start>100){end=start+100} // 100�ȏ�\�����Ȃ�
 //���g�̐؂�o��
 var targetString=""; for(var i=0;i<=end-start;i++){targetString+=returnString(start+i)}
 //�Ώۂ����݂�����rel�ɑޔ����ă|�b�v�A�b�v
 if(targetString){popup(targetString);}else{obj.href=obj.rel;}
}
//�E���g�̐؂�o��
function returnString(num){
 var obj=getDTfromAnc(num);
 setSearchColor(obj);//�|�b�v�A�b�v��̒��F
 if(!obj){return("")} //�Ώۂ��������ځ`��Ȃ�I��
 var dt=obj.cloneNode(true);
  var dtOuter=dt.outerHTML.replace(/name=.*?>/,">"); // LABELNUMBER�Ή��̂��̂ɌW�郊���N�A���J�[�̏���
 var dd=obj.nextSibling.cloneNode(true);
  if(dd.hasChildNodes()){
   while(dd.lastChild.name){dd.lastChild.removeNode(true)} // LABELNUMBER��Ή��̂��̂ɌW�郊���N�A���J�[�̏���
   if(dd.lastChild.tagName=="DL"){dd.lastChild.removeNode(true)} // �t�Q�Ƃ̏���
  }
  var ddOuter=dd.outerHTML;
 return(dtOuter+ddOuter);
}
//�E�|�b�v�A�b�v
var pb;
function popup(inner){
 if(!pb){document.body.insertAdjacentHTML('afterBegin','<div id="popupBase"></div>');pb=document.getElementById("popupBase")}
 //�v�f�̍쐬
 var parent=event.srcElement.parentElement;
 //var aNum= (parent.tagName!="DD") ? parent.firstChild.sourceIndex : parent.previousSibling.firstChild.innerText; // DD�ȊO�����O���A�摜�AID����
 var aNum=event.srcElement.sourceIndex;if(!aNum){alert("aNum�擾�G���[")}
 if(document.getElementById('p'+aNum)){return} // �|�b�v�A�b�v���Ă���I��
 pb.insertAdjacentHTML("beforeEnd",'<dl id="p'+aNum+'">'+inner+'</dl>');
 //�v�f�̔z�u
 var p=document.getElementById('p'+aNum);
 // y������
 var pos=Math.min(event.y,document.body.clientHeight-event.y);
 var scTop=document.body.scrollTop+event.y;
 if(pos==event.y){var y=scTop-30;}  // �J�[�\���̉��֕\��
 else            {var y=scTop+10-p.clientHeight;}  // �J�[�\���̏�֕\��
 if(y<0){y=0}
 if(event.srcElement.parentElement.tagName=="TT"){y+=35;}
 p.style.pixelTop=y;
 // x������
 var pos=Math.min(event.x,document.body.clientWidth-event.x);
 var scLeft=document.body.scrollLeft+event.x;
 if(pos==event.x){var x=scLeft-2}  // �J�[�\���̉E�֕\��
 else            {var x=scLeft-4-p.clientWidth;}  // �J�[�\���̍��֕\��
 if(x<0){x=0}
 p.style.pixelLeft=x;
 // ���������iscrollBar��v���ꍇ�Ɨv���Ȃ��ꍇ������j��y������
 if(p.clientHeight>Math.max(event.y,document.body.clientHeight-event.y)){
  if(p.clientHeight>document.body.clientHeight){p.style.pixelHeight=document.body.clientHeight-2;}
  p.style.pixelTop=document.body.scrollTop;
 }
}
//�E�|�b�v�A�b�v����
function removePopup(popid){
 if(pb){while(pb.lastChild){pb.lastChild.removeNode(true)}}
}
//���l�ϊ��ito���p�j
function tohan(num){
 var zen="�O�P�Q�R�S�T�U�V�W�X";
 var han="0123456789";
 var hnum="";
 if(zen.indexOf(num.charAt(0))!=-1){
  for(var i=0;i<num.length;i++){
   var at=zen.indexOf(num.charAt(i));
   hnum+=han.charAt(at);
  }
 }else{hnum=num}
 return hnum;
}
