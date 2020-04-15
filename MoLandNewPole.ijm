rop =isOpen("ROI Manager");
if (rop==1){
	selectWindow("ROI Manager");
	run("Close");
}


Dialog.create("Placing landmark for new pole");

Dialog.addCheckbox("Clear 2nd channel and draw cell-silhouette (first time only)", 0);
Dialog.show(); 

dig=Dialog.getCheckbox();

setTool("Paintbrush Tool");
run("Paintbrush Tool Options...", "brush=20");
if (dig==1){
getDimensions(width, height, channels, slices, frames);
x=1;
setBackgroundColor(0,0,0);
do{
	Stack.setPosition(2, 1, x);
	run("Select All");
	run("Clear", "slice");
	x=x+1;
}while (x<=frames)
}

title = getTitle();
titl=lengthOf(title);
titl=titl-8;
titla=substring(title,0,titl);
expath ="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\ROIs\\";

fiell=getFileList(expath);
a=fiell.length;
z=0;

do{
roiManager("Open", expath+fiell[z]);

titl=lengthOf(title);
titl=titl-8;
titla=substring(title,0,titl);

deew=lengthOf(fiell[z]);

ade=deew-7;
adb=deew-4;
ind=substring(fiell[z],ade,adb);




pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\";
File.makeDirectory(pna);


print(pna);
pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\";
File.makeDirectory(pna);

pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\ROIs\\";
File.makeDirectory(pna);
run("Select All");

pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\Originals\\";
pnax=pna;
File.makeDirectory(pna);

print(pna);
pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\SingleCell\\";
File.makeDirectory(pna);
print(pna);
pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\SingleCell\\Original\\";
File.makeDirectory(pna);

print(pna);


fr=0;
c=roiManager("count");
do{
run("Remove Overlay");
roiManager("select",fr);
Stack.getPosition(channel, slice, frame);

setBackgroundColor(255,255,255);
Stack.setPosition(2, 1, frame);
if (dig==1){
run("Clear", "slice");
}
ff= frame;
print (ff);
f=toString(ff);
los= lengthOf(f);
if (los==1){
	f="00"+f;
}
if (los==2){
	f="0"+f;
}
run("Interpolate", "interval=2 smooth");
run("Interpolate", "interval=1 smooth");

Roi.setStrokeColor("white");
Roi.setStrokeWidth(2);
Stack.setPosition(1, 1, frame);
setForegroundColor(255,255,255);

run("Draw", "slice");


Roi.getBounds(x,y,w,h);
makeRectangle (x-5,y-5,w+10,h+10);

run("Duplicate...", "duplicate frames=" + ff);


dde= ".tiff";



fd= "save="+pna+"Ti"+ind+"Tf"+f+"T"+dde;
print("fd",fd);
run("Save", fd);
run ("Close");
selectWindow(title);
roiManager("select",fr);

run("Interpolate", "interval=2 smooth");
run("Interpolate", "interval=1 smooth");
roiManager("update");
Roi.setStrokeColor("black");
Roi.setStrokeWidth(2);
Stack.setPosition(1, 1, frame);
setForegroundColor(0,0,0);

run("Draw", "slice");


fr=fr+1;
}while(fr<c)
selectWindow(title);
selectWindow("ROI Manager");
run("Close");
z=z+1;
}while(z<a)
save(pnax+titla+"_POL"+".tif");
run("Select None");