rop =isOpen("ROI Manager");
if (rop==1){
	selectWindow("ROI Manager");
	run("Close");
}
rop =isOpen("Results");
if (rop==1){
	selectWindow("Results");
	run("Close");
}


Dialog.create("Choose start coordinates:");
i=newArray(4);
i[0]="x = 0   ; y = 0";
i[1]="x = 0   ; y = 1/2";
i[2]="x = 1/2 ; y = 0";
i[3]="x = 1/2 ; y = 1/2";

Dialog.addRadioButtonGroup("Set option:", i, 2, 2, i[0]);
Dialog.show(); 

dig=Dialog.getRadioButton();



expath = getDirectory("Choose the experiment folder to be anaylzed");
expathor= expath+"\\SingleCell\\Original\\";
expathorex= expath+"\\SingleCell\\OriginalExecuted\\";
expathorsi= expath+"\\SingleCell\\Sink\\";
expathroi= expath+"\\SingleCell\\ROI\\";
File.makeDirectory(expathroi);
File.makeDirectory(expathorex);
File.makeDirectory(expathorsi);

alis=getFileList(expathor);
colo=1414;
colo2=1039;
//zellzahl=1;
aleg=(alis.length);
xx=0;
//print("------------------------------Aller Anfang---------------------");
do{
//print("------------------------------Do1---------------------");
do{
//print("------------------------------Do2---------------------");
aslis =expathor+alis[xx];
//print(as);
open(aslis);
run("Enhance Contrast", "saturated=0.35");
Stack.setPosition(2, 1, 1);
run("Enhance Contrast", "saturated=0.35");
Stack.setPosition(3, 1, 1);
run("Enhance Contrast", "saturated=0.35");
Stack.setPosition(4, 1, 1);
run("Enhance Contrast", "saturated=0.35");
Stack.setPosition(1, 1, 1);



getRawStatistics(nPixels, mean, min, max, std, histogram);
getHistogram(v,c,max);
ac=Array.rankPositions(c);
ah=Array.rankPositions(histogram);
//Array.show(ac);
//Array.show(ah);

acl=ac.length;
zrd=ah[acl];
//print(zrd);
if (zrd==0){
zrd=ah[acl-1];
	
}
colo=zrd;

titl=getTitle();
di=0;
saveAs("tiff",expathorsi+"\\"+titl);
xx=xx+1;
////morpho turn
getDimensions(width, height, channels, slices, frames);


if (dig == "x = 0   ; y = 0"){
	tx = 0;   
	ty = 0;
}

if (dig == "x = 0   ; y = 1/2"){
	tx = 0;   
	ty = floor(height/2);
}

if (dig == "x = 1/2 ; y = 0"){
	tx = floor(width/2);   
	ty = 0;
}

if (dig == "x = 1/2 ; y = 1/2"){
	tx=floor(width/2);
   ty=floor(height/2);
}

x=tx;
y=ty;

do{


do{
x=x+1;
col=getPixel(x,y);
//print(x,"xy",y,"Colc",col);
if(col==colo){
	if (di == 0){
	doWand(x,y);
	roiManager("add");
	di=1;
	}
}
}while(x<width);
x=0;
y=y+10	;

}while(y<height);
roiManager("select",0);
getDimensions(width, height, channels, slices, frames);
x=-1;
y=-1;
do{
y=y+1	;

do{
x=x+1;
col=Roi.contains(x,y);
//print(x,y,col);
if(col==1){
	setPixel(x,y,colo);
//colo2=getPixel(x,y);
//print("§§§§§§§§§§§§§COLO2§§§§§§§§§§",colo2);
}
if(col==0){
	setPixel(x,y,0);

//colo2=getPixel(x,y);
//print("§§§§§§§§§§§§§COLO2§§§§§§§§§§",colo2);
}
}while(x<width);
x=0;
}while(y<height);

Overlay.addSelection;
//print("w",width);
//print("h",height);
setForegroundColor(colo2);
x=5;
y=5;
//wait(5000);
cu=0;
cr=0;
gs=0;
icod=0;

xit=0;
roiManager("deselect");
run("To ROI Manager");
rocoul= roiManager("count");
  indco = newArray(rocoul);
//print("roimaco",rocoul);
/// nur eine zelle auf bild

//print ("ro;",rocoul);
if (rocoul==1){
d32=0;
	do{
do{
roiManager("select", 0);
//makePoint(x,y);
c= selectionContains(x, y);
//print ("c: ",c);
//print(d32);
if (c == 1){
if(d32==0){
//floodFill(x, y);
d32=1;
}
}






y=y+5;
//wait(10);
makePoint(x,y);
}while (y<height) ;
y=0;
x=x+5;
}while (x<width) ;
}


///zusätzlich artefakte auf bild

if (rocoul>1){

//do{
 	
 for (l=0; l<(rocoul); l++){
  roiManager("select", l);
  Roi.getCoordinates(xpoints, ypoints);
  //print (xpoints.length);
    for (i=0; i<(xpoints.length); i++){
  //  wait(500);
     deb= xpoints[i];
	 dec= ypoints[i];
	if(deb<0) {
	//roiManager("Delete");
	indco[icod]=roiManager("index");
	i= xpoints.length+1;
	xit=23;
	icod=icod+1;
		//print ("kikx",indco[icod]);
		//exit for
	}
   if (xit<22){
	if(dec<0){
	indco[icod]=roiManager("index");
	i= xpoints.length+1;
	icod=icod+1;
		//print ("kiky",indco[icod] );
	}
		}
//	 print ("xpo: ",deb," ypo: ",dec);
	}
 //print("stop");

 } 

//Array.show(indco); 
//print(indco[0],indco[1],indco[2]);

locx=0;
do{
	  roiManager("select", locx);
	roiManager("Delete");
locx=locx+1;
}while (locx< icod);

roiManager("select", 0);
setForegroundColor(colo);
do{
do{
roiManager("select", 0);
//makePoint(x,y);
c= selectionContains(x, y);
//print ("c: ",c);

if (c == 1){

floodFill(x, y);
}
//wait(5000);






y=y+5;
//wait(10);
makePoint(x,y);
}while (y<height) ;
y=0;
x=x+5;
}while (x<width) ;
}
roiManager("select", 0);
//wait (5000);
//run("Interpolate", "interval=1 smooth adjust");

Roi.getCoordinates(xpoints, ypoints);
roileng=xpoints.length;

Roi.getCoordinates(xpoints, ypoints);
makePoint(xpoints[0],ypoints[0]);
//do{
//print ("xp, yp  ",xpoints[cu]," ",ypoints[cu]);
cu=cu+1;

ia= xpoints.length;
	//print("------------------------------Längebp1 ---------------------");
//L�nge �ber Pythagoras
lw= ia*ia;
lena= newArray(lw);
hanna= newArray(lw);
swe= newArray(lw);
hanna1= newArray(lw);
swe1= newArray(lw);
ig=0;
gi=0;
igg= 0;
do{
do{
leax=xpoints[gi]-xpoints[ig];
leay=ypoints[gi]-ypoints[ig];
leax=leax*leax;
leay=leay*leay;
solo= leax+leay;
luke=sqrt(solo);
lena[igg]= luke;
swe[igg] = xpoints[gi];
hanna[igg]= ypoints[gi];
swe1[igg] = xpoints[ig];
hanna1[igg]= ypoints[ig];
igg= igg +1;
ig=ig+1;
}while (ig <= (ia-1));
ig=0;
gi=gi+1;
}while (gi <= (ia-1));

sortedValues = Array.copy(lena);
Array.sort(sortedValues);
rankPosArr = Array.rankPositions(lena);
ranks = Array.rankPositions(rankPosArr);

	
vo=(rankPosArr[(igg-1)]);
//print(rankPosArr[(igg-1)]);
//print(lena[vo]);
gig=swe[vo];
igi=hanna[vo];
gig1=swe1[vo];
igi1=hanna1[vo];


makeLine(gig,igi,gig1,igi1,25);
roiManager("add");
roiManager("select",1);
roiManager("measure");
//	print("------------------------------makeline ---------------------");
a= getResultString("Angle",0);
if (a>-90){
xxx = 90 - a;
}

if (a<-90){
xxx = -90 + a;
}
run("Select None");
dada= "angle="+xxx+" grid=1 interpolation=None enlarge stack";
roiManager("Select", 0);
roiManager("Delete");
roiManager("Select", 0);
roiManager("Delete");
//print (xxx, " ", dada);
run("Select None");

run("Rotate... ", dada);
getDimensions(width, height, channels, slices, frames);
//print("w",width);
//print("h",height);


getRawStatistics(nPixels, mean, min, max, std, histogram);
 getHistogram(v,c,max);
ac=Array.rankPositions(c);
//Array.show(ac);
acl=ac.length;
colo2=ac[acl-2];
//prnit(colo2);
x=5;
y=5;
cd=0;
cu=0;
cr=0;
gs=0;
do{
do{

c= getPixel (x,y);
if (gs==0){

if (c == colo){
doWand(x,y);
run("Interpolate", "interval=2 smooth adjust");
run("Interpolate", "interval=2 smooth adjust");
Roi.getCoordinates(xpoints, ypoints);
roiManager("add");
cr=cr+1;
gs=2;



cd=cd+1;
}
}
y=y+5;
//wait(10);
makePoint(x,y);
}while (y<height) ;
y=0;
x=x+5;
}while (x<width) ;
roiManager("select", 0);
run("Interpolate", "interval=1 smooth adjust");
selectWindow("Results");
run("Close");
///morphoturn end

Roi.getCoordinates(xpoints, ypoints);
makePoint(xpoints[0],ypoints[0]);
//print ("xp, yp  ",xpoints[cu]," ",ypoints[cu]);
cu=cu+1;

ia= xpoints.length;
	//print("ia ",ia);
//	print("------------------------------Längebp2 ---------------------");

//Länge �ber Pythagoras
lw= ia*ia;
lena= newArray(lw);
hanna= newArray(lw);
swe= newArray(lw);
hanna1= newArray(lw);
swe1= newArray(lw);
ig=0;
gi=0;
igg= 0;
do{
do{
leax=xpoints[gi]-xpoints[ig];
leay=ypoints[gi]-ypoints[ig];
leax=leax*leax;
leay=leay*leay;
solo= leax+leay;
luke=sqrt(solo);
lena[igg]= luke;
swe[igg] = xpoints[gi];
hanna[igg]= ypoints[gi];
swe1[igg] = xpoints[ig];
hanna1[igg]= ypoints[ig];
igg= igg +1;
ig=ig+1;
}while (ig <= (ia-1));
ig=0;
gi=gi+1;
}while (gi <= (ia-1));

sortedValues = Array.copy(lena);
Array.sort(sortedValues);
rankPosArr = Array.rankPositions(lena);
ranks = Array.rankPositions(rankPosArr);

	
vo=(rankPosArr[(igg-1)]);
//print(rankPosArr[(igg-1)]);
//print(lena[vo]);
gig=swe[vo];
igi=hanna[vo];
gig1=swe1[vo];
igi1=hanna1[vo];


makeLine(gig,igi,gig1,igi1,25);
roiManager("add");
roiManager("select",1);
roiManager("measure");

/////midlinerend

	
	
	
	
//print("------------------------------Längebp2end ->scanner ---------------------");



///scanner///scanner
	clu=0;
		co=0;
		/////////////////////////////////////////////////////////////////////////////////////////////////
		lenax= newArray(500);
		hjaa=ia%2;
if (hjaa > 0) { 
	hjaa = 1;
}
if (hjaa == 0) { 
	hjaa = 2;
}

s=0;
a=0;
b=0;
statrx= 0;
    statry=0;
aix=newArray(4000);
aiy=newArray(4000);
do {
	
	a=xpoints[s];
	b=ypoints[s];
if (a == gig){
if (b==igi){
    statrx= a;
    statry=b;
    djflip=s;
}
}
s=s+1;

}while(s<=ia-1) ;

aix[0]= xpoints[djflip];
aiy[0]=ypoints[djflip];
//print("djflip1 ",djflip);
lemaza=0;
remaza=0;
//print("lemaza1 ",lemaza);
//print("remaza1 ",remaza);
//	print("------------------------------QT---------------------");
//quantumtrace


if (hjaa==1){
	maza= djflip;
lemaza = djflip;
	remaza = djflip-2;
}
if (hjaa==2){//gleich null
	maza= djflip;
lemaza = djflip;
	remaza = djflip-1;
}
	frw=ia-1;
//print("lemaza1 ",lemaza);
//print("remaza1 ",remaza);
//print("fre ",frw);

	
	if (remaza > frw){
//	print("frw3 lemaza",lemaza);
	remaza = frw;
	
		}
	if (remaza == 0){
	remaza =frw;
//	print("frw2 remaza ",remaza);
	}
//	print("frw1 ",frw);
	lemaza = lemaza+5;
	remaza = remaza-5;

	if (lemaza > frw){
//	print("frw3 lemaza",lemaza);
	lemaza = frw;
	}
		if (remaza > frw){
//	print("frw4 lemaza",lemaza);
	remaza = frw;
		}
	legrugurx = xpoints[lemaza];
	legrugury = ypoints[lemaza];
	regrugurx = xpoints[remaza];
	regrugury = ypoints[remaza];

migrugurx2 = (legrugurx+regrugurx)/2;
	migrugury2 = (legrugury+regrugury)/2;
	
aix[1]= migrugurx2;
aiy[1]=migrugury2;
 //moveTo(aix[1],aiy[1]);
//	print("djflip2 ",djflip);
//	print("lemaza2 ",lemaza);
//	print("remaza2 ",remaza);

//	print ("huhuh1aiy[1]",aiy[1]);
aixyc= 1 ;

///quantumtraceend
	//	print("------------------------------QTend ---------------------");
weit=0;
do{
oc=0;
zellzahl= 1;
makeLine (aix[aixyc-1],aiy[aixyc-1],aix[aixyc],aiy[aixyc]);

em= (aiy[aixyc-1]-aiy[aixyc])/(aix[aixyc-1]-aix[aixyc]);
//	print("em",em);
tee= aiy[aixyc]-(em*aix[aixyc]);
ixi=1;
do{

ypsi=aiy[aixyc]+ixi;
ixs=(ypsi-tee)/em;
roiManager("select",0);
roc23 = Roi.contains(ixs,ypsi);

if (ixi==10){
	roc23=0;
}

//	print ("rocco",roc23);
ixi=ixi+1;
}while(roc23>0);
//wait(200);

ixi=1;

//	print("new xy0",ixs,ypsi);
ixs1= ixs;
ypsi1=ypsi;
em1=-1/em;
tee2= ypsi1-(em1*ixs1);


do{
	
ixs1=ixs1+0.1;
	
ypsi1= (em1*ixs1)+tee2;

roiManager("select",0);
roc = Roi.contains(ixs1,ypsi1);
//makePoint(ixs1,ypsi1);


}while (roc > 0) ;

Diapo1x=ixs1;
Diapo1y=ypsi1;

ixs1= ixs;
ypsi1=ypsi;

do{
	ixs1=ixs1-0.1;
ypsi1= (em1*ixs1)+tee2;
roiManager("select",0);
//wait (3000);
roc = Roi.contains(ixs1,ypsi1);
}while (roc> 0) ;

Diapo2x=ixs1;
Diapo2y=ypsi1;

diamit1=(Diapo2x+Diapo1x)/2;
diamit2=(Diapo2y+Diapo1y)/2;
makeLine (Diapo1x,Diapo1y,Diapo2x,Diapo2y);


//roiManager("add");
//	print ("y  mx+t:" , diamit2 , " ",em," ",diamit1," ", tee );


//roiManager("add");
//	print("aix y",aix[aixyc]," ",aiy[aixyc]," ",aixyc);
aixyc=aixyc +1; 
xss=xss+1;
aix[aixyc]= diamit1;
aiy[aixyc]=diamit2;
roiManager("select",0);
//makePoint(ixs1,ypsi1);
//wait (3000);
roc2 = Roi.contains(diamit1,diamit2);
//	print ("huhuh3 ",aix[0]," ",aiy[0]," ",aix[1]," ",aiy[1]," ",aix[2]," ",aiy[2]," ",aix[3]," ",aiy[3]);
//	print("xss; ",xss);

} while (roc2> 0) ;



aix=Array.trim(aix,xss+2);
//moveTo(aix[0],aiy[0]);
aiy=Array.trim(aiy,xss+2);
axl=aix.length-1;


//Array.show(aix);
//Array.show(aiy);
//print("axl ",axl);

roiManager("select",0);
roc44 = Roi.contains(aix[axl],aiy[axl]);

xss=0;

//reverser
aixyc= 1 ;
axl= aix.length -1;
aix2=newArray(4000);
aiy2=newArray(4000);
aix2[0]=aix[axl];
aiy2[0]=aiy[axl];
aix2[1]=aix[axl-1];
aiy2[1]=aiy[axl-1];
//Array.show(aix2);
//Array.show(aiy2);
weit=0;
do{
		oc=0;
		zellzahl= 1;
		//	print ("huhuh2zellzahl",zellzahl);
makeLine (aix2[aixyc-1],aiy2[aixyc-1],aix2[aixyc],aiy2[aixyc]);
	//roiManager("add");

em= (aiy2[aixyc-1]-aiy2[aixyc])/(aix2[aixyc-1]-aix2[aixyc]);
//	print("em2",em);
tee= aiy2[aixyc]-(em*aix2[aixyc]);
ixi=1;
do{

ypsi=aiy2[aixyc]-ixi;
ixs=(ypsi-tee)/em;
roiManager("select",0);
roc23 = Roi.contains(ixs,ypsi);


if (ixi==10){
	roc23=0;
}

//	print ("rocco",roc23);
ixi=ixi+1;
}while(roc23>0);
//wait(200);

ixi=1;

//	print("new xy0",ixs,ypsi);
ixs1= ixs;
ypsi1=ypsi;
em1=-1/em;
tee2= ypsi1-(em1*ixs1);


do{
	
	ixs1=ixs1+0.1;
	
ypsi1= (em1*ixs1)+tee2;

roiManager("select",0);
roc = Roi.contains(ixs1,ypsi1);
//makePoint(ixs1,ypsi1);


}while (roc > 0) ;

Diapo1x=ixs1;
Diapo1y=ypsi1;

ixs1= ixs;
ypsi1=ypsi;

do{
	ixs1=ixs1-0.1;
ypsi1= (em1*ixs1)+tee2;
roiManager("select",0);
//makePoint(ixs1,ypsi1);
//wait (3000);
roc = Roi.contains(ixs1,ypsi1);
}while (roc> 0) ;

Diapo2x=ixs1;
Diapo2y=ypsi1;

diamit1=(Diapo2x+Diapo1x)/2;
diamit2=(Diapo2y+Diapo1y)/2;
makeLine (Diapo1x,Diapo1y,Diapo2x,Diapo2y);


//roiManager("add");
//	print ("y  mx+t:" , diamit2 , " ",em," ",diamit1," ", tee );


//roiManager("add");
//	print("aix y",aix[aixyc]," ",aiy[aixyc]," ",aixyc);
aixyc=aixyc +1; 
xss=xss+1;
aix2[aixyc]= diamit1;
aiy2[aixyc]=diamit2;
roiManager("select",0);
//makePoint(ixs1,ypsi1);
//wait (3000);
roc2 = Roi.contains(diamit1,diamit2);
//	print ("huhuh3 ",aix[0]," ",aiy[0]," ",aix[1]," ",aiy[1]," ",aix[2]," ",aiy[2]," ",aix[3]," ",aiy[3]);
//	print("xss; ",xss);
weit=weit+1;
} while (roc2> 0) ;


aix2=Array.trim(aix2,xss+2);
//moveTo(aix[0],aiy[0]);
aiy2=Array.trim(aiy2,xss+2);
//do{
axlo=aiy2.length-1;
axlo2=axlo-2;
roiManager("select",0);
roc44 = Roi.contains(aix2[axlo],aiy2[axlo]);
if (roc44==0){
//	print("ROCCO!44");

///////////////////////////////////ROI SCHNITT
roiManager("select", 0);
getSelectionCoordinates(xar,yar);
axlo=aiy2.length-1;
axlo2=axlo-2;
m=(aiy2[axlo]-aiy2[axlo2])/(aix2[axlo]-aix2[axlo2]);
t=aiy2[axlo]-(m*aix2[axlo]);
l=abs(aiy2[axlo2]-aiy2[axlo]);
//print(aiy2[axlo]);
//print(aiy2[axlo2]);
//print("axlo: ",axlo);
//print("t: ",t);
//print("m: ",m);
yy=newArray(l+1);
xx2=newArray(l+1);
xarl=xar.length;
arl=xarl*(l+1);
ryy=newArray(arl+1);
rxx=newArray(arl+1);
raa=newArray(arl+1);
sumar=newArray(arl+1);
y=aiy2[axlo];
ll=0;
do{
x=(y-t)/m;
//print("x: ",x);
//print("y: ",y);
yy[ll]=y;
xx2[ll]=x;
ll=ll+1;	
//print("ll: ",ll);
y=y+1;
}while(y<=aiy2[axlo2]);
//Array.show(xx2);
//Array.show(yy);
a=0;
c=0;
do{
b=0;
do{
dx=abs(xar[a]-xx2[b]);
dy=abs(yar[a]-yy[b]);
rxx[c]=dx;
ryy[c]=dy;
raa[c]=a;
b=b+1;
c=c+1;
//print("dx dy: ",dx," ",dy," ", a);
}while(b<l);
a=a+1;
}while (a<xarl);
ryy=Array.trim(ryy, c) ;
rxx=Array.trim(rxx, c) ;
raa=Array.trim(raa, c) ;
rpy=Array.rankPositions(ryy);
rpx=Array.rankPositions(rxx);
//Array.show(rpy);
//Array.show(rpx);
//Array.show(ryy);
//Array.show(raa);
//Array.show(rxx);
aa=0;
do{
sumar[aa]=rxx[aa]+ryy[aa];
aa=aa+1;
}while (aa<c);
sumar=Array.trim(sumar, c) ;
rsumar=Array.rankPositions(sumar);
//Array.show(sumar);
//Array.show(rsumar);
shot=rsumar[0];
goal=raa[shot];
makePoint(xar[goal],yar[goal]);
aix2[axlo]=xar[goal];
aiy2[axlo]=yar[goal];
makeSelection ( 7,aix2,aiy2);
///////////////////////////////////ROI SCHNITT END


}


aix2=Array.reverse(aix2);
//moveTo(aix[0],aiy[0]);
aiy2=Array.reverse(aiy2);

aix=aix2;
aiy=aiy2;
///reversend
xss=0;
makeSelection ( 7,aix,aiy);

	run("Interpolate", "interval=0.5 smooth adjust");
	Roi.setStrokeWidth(15);
	
	roiManager("add");
	getSelectionCoordinates(xar,yar);
	//	print(xar[0],xar[1],xar[2]);
Roi.setStrokeWidth(1);
xac=1;
d=0;
//	print(xar.length);

//////////////////////////septum 
roiManager("select",2)

Stack.setPosition(4, 1, 1)

arrr=getProfile();
//Roi.getCoordinates(xpoints, ypoints);
alr=arrr.length;
edg=abs(10-alr);
//print("arl",alr,"egd ",edg);
//	print("alr: ",alr);
//Array.show(a);
//Array.show(xpoints, ypoints);
//xl=a.length;
//print(xl);

maxmo=Array.findMaxima(arrr, 25,1);
maxmo= Array.sort(maxmo);
//print(area, mean, min, max];//, std)//, histogram);
//Array.show(maxmo);
slex = maxmo.length;
//print("arl",alr);
if (slex==0){
	sep=0;
	}

	
if (slex==1){
seps=maxmo[0];
sps=abs(alr-seps);

	sep=maxmo[0];



if(sps<=15){
	sep= 0;
}


if(sps>=edg){
	sep= 0;
}

}



if (slex==2){

sep=maxmo[0];
seps=maxmo[0];
ssps=maxmo[1];
sps=abs(alr-seps);
spss=abs(alr-ssps);
//	print("sps: ",sps);
if(seps<=15){
	sep= maxmo[1];
if(spss<=15){
	sep= 0;
}
}

if(sps>=edg){
	sep= maxmo[1];
if(spss<=10){
	sep= 0;
}
}


}


if (slex==3){

sep=maxmo[1];




}
//	print("s: ",slex);
sepl =sep/alr;
	//print("sps: ",sps);
	//print("sepl: ",sepl);
	//print("spss: ",spss);
Stack.setPosition(1, 1, 1)



do{
	//	print("xar y:",d," ",xar[d],"",yar[d]);
	d=d+1;
}while(d<xar.length);

do{
ypsi1=yar[xac];
ixs1=xar[xac];
roiManager("select",0);
//makePoint(ixs1,ypsi1);
//wait (3000);
roc23 = Roi.contains(ixs1,ypsi1);
yac=xar.length;
yac=yac-1;
if (xac<yac){
		em= (yar[xac-1]-yar[xac+1])/(xar[xac-1]-xar[xac+1]);
}
if (xac==yac){
	em= (yar[xac-1]-yar[xac])/(xar[xac-1]-xar[xac]);
}
	em1=-1/em;
tee2= ypsi1-(em1*ixs1);


do{
	
	ixs1=ixs1+0.2;
	
ypsi1= (em1*ixs1)+tee2;

roiManager("select",0);
roc = Roi.contains(ixs1,ypsi1);
//makePoint(ixs1,ypsi1);


}while (roc > 0) ;

Diapo1x=ixs1;
Diapo1y=ypsi1;

ypsi1=yar[xac];
ixs1=xar[xac];

do{
	ixs1=ixs1-0.1;
ypsi1= (em1*ixs1)+tee2;
roiManager("select",0);
//makePoint(ixs1,ypsi1);
//wait (3000);
roc = Roi.contains(ixs1,ypsi1);
}while (roc> 0) ;
roiManager("select",0);
roiManager("Measure");
roiManager("measure");
are= getResultString("Area",0);
run ("Clear Results");
//	print ("AA:", are);
Diapo2x=ixs1;
Diapo2y=ypsi1;
	setLineWidth(1);
makeLine (Diapo1x,Diapo1y,Diapo2x,Diapo2y);
	roiManager("add");
	xac=xac+1;
 moveTo(aix[1],aiy[1]);
}while (roc23>0);

////////////////
ert=roiManager("count");

co=co+1;
//print("co; ",co);
lenax[zellzahl]=co;
//print("lex:", lenax[zellzahl]);
//print("zellzahl; ",zellzahl);
//print("zellzahlr; ",zellzahlr);
//print("ert; ",ert);

makeSelection("freeline",aix ,aiy); 
setLineWidth(15); 
roiManager("add");
roiManager("select",ert)
roiManager("measure");
//a = getResultString("Length",zellzahl-1);
setLineWidth(1); 
//print ("A: ",a);




//////XXXXXXXXXXXXXXXXXXX
c=2;
title = getTitle();
//zellzahl= 0;
zellzahlr = 1;
//Dimensionen erfassen

//		print("------------------------------Open 00101---------------------");

d=0;
cellx=newArray(1500000);
celly=newArray(1500000);
chann = channels - 1;
chan = newArray(chann);
cha = 2;

for (i =0; i<chann;i++){
chan[i] = cha;
cha =cha+1;
}
expac=expath+"\\Channel ";
expasc=expath+"\\SingleCell\\Channel ";
cha = 2;
for (i =0;i<chann;i++){
File.makeDirectory(expasc+cha);
	
//		print("------------------------------Channeladd ---------------------");
cha =cha+1;
}
zellzahlr = 1;

do{
//		print("------------------------------xxxxcell1 ---------------------");
cha = 2;
for (i =0;i<chann;i++){
//		print("------------------------------xxxxcell2 ---------------------");
File.makeDirectory(expasc+cha+"\\"+title+" xxxxx");
cha =cha+1;
}



f3 =expac+c;




//print(f,"");
//print(f,"Channel "+c);
cx=0;
cxx=0.000;
do{

lop3=roiManager("count");
lopop=lop3-3;
loppo=lop3-lopop;
lop=loppo+zellzahlr;
//	print ("Lop ",lop3, lopop, loppo, lop);
roiManager("select", (lop));
//print ("co: ",co);
Stack.setPosition(c,1,1);
profile = getProfile();
for (i=0; i<profile.length; i++)
setResult("Value", i, profile[i]);
//updateResults;
cellc= newArray(profile.length);
for (i=0; i<(profile.length); i++){
b= getResultString("Value", (i));
cellc[i]=b;
//print (f,b);
}



roiManager("Measure");
roiManager("measure");
a = getResultString("Length",0);
run ("Clear Results");


roiManager("select",2)
run ("Clear Results");
roiManager("Measure");
roiManager("measure");
av = getResultString("Length",0);
run ("Clear Results");


if (a==0){
	a="0.000";
	}

cxx=toString(cxx,3);

f3 =expasc+c+"\\"+title+" xxxxx";
//		print("------------------------------xxxxcelltext ---------------------");

f4 = f3+"\\Slice "+cxx+" "+title+" Channel "+c+" Length "+a+".txt";
  alp=av;
////////////////////




f = File.open(f4);
for (i=0; i<(cellc.length); i++){
	print (f,cellc[i]);
//print ("cci: ",cellc[i],"i: ",i);
}
	//	print("------------------------------file IO ---------------------");
File.close(f);

cx=cx+1;
cxx= parseFloat(cxx);
cxx=cxx+0.001;
zellzahlr = zellzahlr +1;
//	print(zellzahlr);
}while(zellzahlr <= (lop3-4));


//zellzahl= 0;
zellzahlr = 1;

c=c+1;
co=0;
}while (c<= channels);
/// ///////

///////////////////

Stack.setPosition(1,1,1);
roiManager("select", (ert-1));
zellzahl = zellzahl+1;
clu=clu+1;
		}while(clu<1)

///scannerend






////exporter
roiManager("show none");
titl=lengthOf(title);
titl=titl-4;
titla=substring(title,0,titl);

saveAs("tiff",expathorex+"\\"+titla+"T");

title=getTitle();
chax=1;
expase=expath+"\\SingleCell\\Export\\";
File.makeDirectory(expase);
File.makeDirectory(expase+"Overlay 1\\");
File.makeDirectory(expase+"Overlay 2\\");
File.makeDirectory(expase+"Overlay 3\\");
File.makeDirectory(expase+"Overlay 4\\");

fna=File.name;
do{
File.makeDirectory(expase+"Channel "+chax);

if (chax ==1){
Stack.setDisplayMode("composite");
Stack.setActiveChannels("1000");
}
if (chax ==2){
Stack.setDisplayMode("composite");
Stack.setActiveChannels("0100");
}
if (chax ==3){
Stack.setDisplayMode("composite");
Stack.setActiveChannels("0010");
}
if (chax ==4){
Stack.setDisplayMode("composite");
Stack.setActiveChannels("0001");
}
romoc=roiManager("count");

run("Enhance Contrast", "saturated=0.35");
//	print (fna," ", alp); 
roiManager("select", 0);
run("Add Selection...");
roiManager("select", romoc-1);
run("Add Selection...");
run("Show Overlay");
saveAs("Jpeg",expase+"Channel "+chax+"/"+alp+" Area "+are+" Sep "+sepl+" "+fna);
//wait(200);

chax=chax+1;
}while (chax<=channels);
Stack.setDisplayMode("composite");
Stack.setActiveChannels("0110");
saveAs("Jpeg",expase+"Overlay 1\\"+alp+" "+fna);
Stack.setActiveChannels("0101");
saveAs("Jpeg",expase+"Overlay 2\\"+alp+" "+fna);
Stack.setActiveChannels("0011");
saveAs("Jpeg",expase+"Overlay 3\\"+alp+" "+fna);
Stack.setActiveChannels("0111");
saveAs("Jpeg",expase+"Overlay 4\\"+alp+" "+fna);

///exporterend

roiManager("select", 2);
roiManager("Save", expathroi+"\\"+title+".zip");



selectWindow(title);
run("Close");
selectWindow("ROI Manager");
run("Close");
path2=expathor+"\\"+fna;
path1=expathorsi+"\\"+fna;

//File.copy(path1, path2) ;
File.delete(path2);
}while(xx<aleg)

///generate info.txt

fa =expath+"\\info.txt";

swi=File.exists(fa);
if (swi==0){
	

chann = channels - 1;
chan = newArray(chann);
//print (chann);
cha = 2;
//open info
f6=File.open(fa);

chanx = getString("Experiment name: ", cha);
print (f6,chanx);


for (i =0; i<chann;i++){
chan[i] = getString("Channel: ", cha);
	print (f6,chan[i]);
cha =cha+1;
}

File.close(f6);
}
/// end
waitForUser("Single Cell Analysis","Done");