//==========以下はスクリプト本文ですよ。
// イベントハンドラ：onMouseover
// 外部変数：idHash,refHash,foudRes,highlight
// 外部関数：addAnchor,getDTfromAnc
// 特徴：DIV#popupBase下に「フラットでリニア」にDL#p\dを作成する。
//==========CSSの出力
var nCSS=''
nCSS+='#popupBase{font-size:90%;}'; //フォントサイズの指定
nCSS+='#popupBase{position:absolute;width:100%;height:100%;z-index:7}';
nCSS+='#popupBase dl{position:absolute; background-color:window; border:outset 1px infobackground; overflow-y:auto; z-index:5; border-top:none}';
nCSS+='#popupBase dt span{float:none; margin-left:1em;}';
nCSS+='#popupBase dd{margin:auto 1em}';
document.write('<style type="text/css">'+nCSS+'</style>\n');
//=========外部ファイル共用のグローバル変数
//=========ナンバーな名前のポップアップ
function namePopup(e,before,num,after){
 var hnum=tohan(num);
 if(hnum==774 || hnum==21 || hnum==1 || hnum==30){return} // Socket774、774KB、21禁、[1-30]、などは無視
 if(before && before.match(/名無/)){return} //名無しっぽいのは無視
 if(after) {if(after=="周年"){return}} // デフォルトな"ｎ周年"は無視
 var nB = before ? "<b>"+before+"</b><b>":"<b>"; nB+=addAnchor(hnum,num); nB+=after ? "</b><b>"+after+"</b>":"</b>";
 e.outerHTML=nB;
}
//=========弱あぼ～んのポップアップ
function abonePopup(e){e.outerHTML = "<b>"+addAnchor(e.parentElement.previousSibling.innerText,'あぼ～ん')+"</b>";}
//=========検索したレスのポップアップ
function searchPopup(obj){
 var reg,cArray;var tag=obj.tagName;
 /*ref Popup*/if     (tag=="A")   {if(refHash[obj.innerText]){cArray=refHash[obj.innerText].split(" ")}else{return}}
 /*ID Popup*/ else if(tag=="SPAN"){reg=getID(obj);if(reg&&reg.length>3){cArray=idHash[reg].split(" ");}else{return} if(cArray.length==1){return}}
 /*検索Popup*/else if(tag=="TT")  {var cHash=(obj.parentElement.rel=="res")?foundRes:highlight;cArray=cHash[obj.parentElement.firstChild.style.backgroundColor];if(!cArray){return}}
 var targetString=""; for(var i=0;i<cArray.length;i++){targetString+=returnString(cArray[i]);} //中身の切り出し
 if(targetString){popup(targetString);} //対象が存在したらポップアップ
}
//=========多段ポップアップ
//・ポップアップの作成
function makePopContent(obj){
 //事前準備
 var num=obj.innerText.replace(/[>＞]/g,""); var number=tohan(num);
 if(!obj.rel){obj.rel=obj.href;} obj.href="decoy:"; // ブラウザ本体のポップアップ回避
 //番号調査
 if(number.match(/(\d*)\D+(\d*)/)){var start=parseInt(RegExp.$1); var end=parseInt(RegExp.$2);}
 else                             {var start=end=parseInt(number);}
 if(end-start>100){end=start+100} // 100以上表示しない
 //中身の切り出し
 var targetString=""; for(var i=0;i<=end-start;i++){targetString+=returnString(start+i)}
 //対象が存在したらrelに退避してポップアップ
 if(targetString){popup(targetString);}else{obj.href=obj.rel;}
}
//・中身の切り出し
function returnString(num){
 var obj=getDTfromAnc(num);
 setSearchColor(obj);//ポップアップ先の着色
 if(!obj){return("")} //対象が透明あぼ～んなら終了
 var dt=obj.cloneNode(true);
  var dtOuter=dt.outerHTML.replace(/name=.*?>/,">"); // LABELNUMBER対応のものに係るリンクアンカーの除去
 var dd=obj.nextSibling.cloneNode(true);
  if(dd.hasChildNodes()){
   while(dd.lastChild.name){dd.lastChild.removeNode(true)} // LABELNUMBER非対応のものに係るリンクアンカーの除去
   if(dd.lastChild.tagName=="DL"){dd.lastChild.removeNode(true)} // 逆参照の除去
  }
  var ddOuter=dd.outerHTML;
 return(dtOuter+ddOuter);
}
//・ポップアップ
var pb;
function popup(inner){
 if(!pb){document.body.insertAdjacentHTML('afterBegin','<div id="popupBase"></div>');pb=document.getElementById("popupBase")}
 //要素の作成
 var parent=event.srcElement.parentElement;
 //var aNum= (parent.tagName!="DD") ? parent.firstChild.sourceIndex : parent.previousSibling.firstChild.innerText; // DD以外＝名前欄、画像、ID検索
 var aNum=event.srcElement.sourceIndex;if(!aNum){alert("aNum取得エラー")}
 if(document.getElementById('p'+aNum)){return} // ポップアップしてたら終了
 pb.insertAdjacentHTML("beforeEnd",'<dl id="p'+aNum+'">'+inner+'</dl>');
 //要素の配置
 var p=document.getElementById('p'+aNum);
 // y軸調整
 var pos=Math.min(event.y,document.body.clientHeight-event.y);
 var scTop=document.body.scrollTop+event.y;
 if(pos==event.y){var y=scTop-30;}  // カーソルの下へ表示
 else            {var y=scTop+10-p.clientHeight;}  // カーソルの上へ表示
 if(y<0){y=0}
 if(event.srcElement.parentElement.tagName=="TT"){y+=35;}
 p.style.pixelTop=y;
 // x軸調整
 var pos=Math.min(event.x,document.body.clientWidth-event.x);
 var scLeft=document.body.scrollLeft+event.x;
 if(pos==event.x){var x=scLeft-2}  // カーソルの右へ表示
 else            {var x=scLeft-4-p.clientWidth;}  // カーソルの左へ表示
 if(x<0){x=0}
 p.style.pixelLeft=x;
 // 高さ調整（scrollBarを要す場合と要しない場合がある）→y軸調整
 if(p.clientHeight>Math.max(event.y,document.body.clientHeight-event.y)){
  if(p.clientHeight>document.body.clientHeight){p.style.pixelHeight=document.body.clientHeight-2;}
  p.style.pixelTop=document.body.scrollTop;
 }
}
//・ポップアップ消去
function removePopup(popid){
 if(pb){while(pb.lastChild){pb.lastChild.removeNode(true)}}
}
//数値変換（to半角）
function tohan(num){
 var zen="０１２３４５６７８９";
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
