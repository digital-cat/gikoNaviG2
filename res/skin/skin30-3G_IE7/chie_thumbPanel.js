var orgDialogW=dialogWidth;var orgDialogH=dialogWidth;
// 画像読込判定\
function imgResult(img){
 var btn=img.parentElement.children.item(2);
 if(event.type=="load"){btn.innerText="___"; img.style.display="block";}
 else{btn.innerText="NONE";btn.style.color="#C00";}
 var y=27+Math.max(document.getElementById("thumbPanel").clientHeight,document.getElementById("thumbPanel").scrollHeight);
 if(y>screen.availHeight){y=screen.availHeight};
 window.self.dialogHeight=y+"px";
 orgDialogH=dialogHeight;
}
// サイズの切替
function changeSize(btn){
 var div=document.getElementById("viewPanel");
 var img=div.firstChild;
 if(!img){return}
 if(btn.innerText.match(/100%|_+/)){
  var hRatio=div.style.pixelWidth /img.offsetWidth;
  var vRatio=div.style.pixelHeight/img.offsetHeight;
  var ratio =(hRatio>vRatio) ? vRatio : hRatio;
  if(ratio>1){ratio=1}else{img.style.zoom=ratio*100+'%';}
  btn.innerText=Math.round(ratio*100-0.5)+"%";
 }else{
  img.style.zoom="100%";
  btn.innerText="100%";
 }
}
// サムネイルの削除
function removeThumb(btn){
 btn.parentElement.removeNode(true);
 if(!thumbPanel.innerHTML&&!viewPanel.innerHTML){self.window.close();return;}
 var y=27+Math.min(document.body.clientHeight,document.body.scrollHeight);
 window.self.dialogHeight=y+"px";
 orgDialogH=dialogHeight;
}
// 画像表示の切替
function changeView(mode,href){
 if(!href){href=event.srcElement.src}
 var div = document.getElementById("viewPanel");
 var thumbs=document.getElementById("thumbPanel");
 if(thumbs){
  var l=thumbs.childNodes.length;
  for(var i=l;i--;){
   var stateBtn=thumbs.childNodes[i].childNodes[2];
   if(stateBtn.tagName=="BUTTON" && stateBtn.innerText!="NONE"){stateBtn.innerText="___"} //embedはchildNodesに入らない?
  }
 }
 if(!div.hasChildNodes() || div.firstChild.src!=href){
  if     (mode=="img") {var nHTML='<img src="'+href+'" ondragstart="imageMoveStart(this)" ondrag="imageMove(this)" oncontextmenu="addObject()">'}
  else if(mode=="swf") {var nHTML='<embed src="'+href+'"></embed><button onclick="window.open(\''+href+'\',\'_parent\')">OPEN</button><button onclick="clearView()">CLOSE</button>'}
  div.innerHTML=nHTML;
  div.style.posWidth =screen.availWidth-127;
  div.style.posHeight=screen.availHeight-20;
  if(mode=="img"){changeSize(event.srcElement.parentElement.childNodes[2])}
  else{div.firstChild.style.posHeight=div.style.posHeight-25}
  //ウィンドウのサイズ
  var x,y;
  if     (mode=="img"){x=div.childNodes[0].offsetWidth+145; y=Math.max(div.childNodes[0].offsetHeight+30,parseInt(orgDialogH));}
  else if(mode=="swf"){x=screen.availWidth;y=screen.availHeight;orgDialogH=dialogHeight;}
  window.self.dialogWidth =x+"px";
  window.self.dialogHeight=y+"px";
 }else{clearView()}
}
//Viewパネルクリア
function clearView(){
 var div=document.getElementById("viewPanel");
 while(div.firstChild){div.removeChild(div.firstChild)};
 if(!thumbPanel.innerHTML){self.window.close();return;}
 //ウィンドウのサイズ
 window.self.dialogWidth =orgDialogW+"px";
 window.self.dialogHeight=orgDialogH+"px";
 dialogArguments.focus();
}
var imageMoveX,imageMoveY;
function imageMoveStart(obj){
 imageMoveX=obj.parentElement.scrollLeft+event.clientX;
 imageMoveY=obj.parentElement.scrollTop +event.clientY
}
function imageMove(obj)     {
 obj.parentElement.scrollLeft=imageMoveX-event.clientX;
 obj.parentElement.scrollTop=imageMoveY -event.clientY
}
// モザイク処理
function imgOver(my,num) {my.style.filter="Alpha(opacity="+num+")"}

// Object追加
function addObject(){
 var div = document.getElementById("viewPanel");
 if(div.firstChild.tagName!="IMG"){return}
 div.insertAdjacentHTML("beforeEnd",'<object data="'+event.srcElement.href+'" ondragstart="imageMoveStart(this)" ondrag="imageMove(this)"></object>');
 div.childNodes[1].style.pixelWidth =div.childNodes[0].offsetWidth+16;
 div.childNodes[1].style.pixelHeight=div.childNodes[0].offsetHeight;
 div.src=div.data;
 div.childNodes[0].removeNode(true);
}
