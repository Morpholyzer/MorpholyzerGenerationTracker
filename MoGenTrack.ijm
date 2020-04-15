

title = getTitle();
ind=getString("Set ID # (three digits)", "");
titl=lengthOf(title);
titl=titl-8;
titla=substring(title,0,titl)
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
roiManager("rename", "Ti"+ind+"Tf"+f+"T");
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
save(pnax+titla+"_"+ind+".tif");
roiManager("sort");
roiManager("Save", "C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\ROIs\\RoiSet_"+titla+"_"+ind+".zip");
run("Select None");
rop =isOpen("ROI Manager");
waitForUser("Close ROImanager and proceed.");
if (rop==1){
	selectWindow("ROI Manager");
	run("Close");
}