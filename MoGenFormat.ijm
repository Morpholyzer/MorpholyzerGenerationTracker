a=newArray(2);
a[1]="automatic numbering";
a[0]="take ROI names";
Dialog.create("Add ID# to image");
Dialog.addRadioButtonGroup("Choose style:", a, 2, 1, a[1]);  
Dialog.addNumber("automatic starting at: ", 1);
Dialog.addCheckbox("Preform scale-up 2.5x", 1);
Dialog.show(); 
b= Dialog.getRadioButton();
d=Dialog.getNumber(); 
dig=Dialog.getCheckbox();
getDimensions(width, height, channels, slices, frames);

title = getTitle();
titl=lengthOf(title);
titl=titl-4;
titla=substring(title,0,titl)
pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\";
File.makeDirectory(pna);


print(pna);
pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\";
File.makeDirectory(pna);

pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\ROIs\\";
File.makeDirectory(pna);

pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\Originals\\";
pnax=pna;
File.makeDirectory(pna);

print(pna);
pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\SingleCell\\";
File.makeDirectory(pna);
print(pna);
pna="C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\SingleCell\\Original\\";
File.makeDirectory(pna);



frs= toString(frames);
dbl = "duplicate frames=1-"+frs ;
run("Duplicate...", dbl);
//selectWindow("170628_dmc_01_13_A3D-1.tif");
Stack.getPosition(channel, slice, frame);
run("Add Slice", "add=channel");
run("Add Slice", "add=channel");
x=1;
do{
Stack.setChannel(1);
Stack.setFrame(x);
run("Copy");
//run("Add Slice", "add=channel");
Stack.setChannel(3);
run("Paste");
Stack.setChannel(2);
run("Paste");
run("Auto Threshold", "method=Mean");
//run("Enhance Contrast...", "saturated=20");
run("Remove Outliers...", "radius=5 threshold=1 which=Dark slice");
x=x+1;
}while(x<=frs)
titl=getTitle();
getDimensions(width, height, channels, slices, frames);
scaq = "n";

ac = roiManager("Count");
x=0;


setFont("SansSerif", 10);//, "bold");
if (b=="take ROI names"){


do{
roiManager("Select", x);
nem=call("ij.plugin.frame.RoiManager.getName", x); 
print(nem); 
getSelectionCoordinates(xpoints, ypoints);
a=x+1;
drawString(nem, xpoints[0],ypoints[0]);
//print
x=x+1;
}while(x<ac)
}


if (b=="automatic numbering"){


do{
roiManager("Select", x);
getSelectionCoordinates(xpoints, ypoints);
ff=d+x;
f=toString(ff);
los= lengthOf(f);
if (los==1){
	f="00"+f;
}
if (los==2){
	f="0"+f;
}

drawString(f, xpoints[0],ypoints[0]);
//print
roiManager("rename", f);
x=x+1;
}while(x<ac)
}

selectWindow("ROI Manager");
run("Select All");
roiManager("Save", "C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\"+titla+"\\Originals\\Cell-ID#_"+titla+".zip");
suf="_INI";
if (dig == 1){
	suf= "_PRE";
	}


selectWindow(title);
save(pnax+titla+"_ORI"+".tif");
close();

save(pnax+titla+suf+".tif");

if (dig == 1){
titlef = getTitle();
	wi= width*2.5;
	hi= height*2.5;
titi= titlef;
scstr="x=2.5 y=2.5 z=1.0 width="+hi+" height="+hi+" depth="+frs+" interpolation=Bilinear average create title="+titi;
run("Scale...", scstr);
save(pnax+titla+"_INI"+".tif");
close();
}
open(pnax+titla+"_INI"+".tif");
selectWindow(titl);
close();