
Stack.setPosition(3, 1, 1);
run("Select All");
run("Copy");
Stack.setPosition(1, 1, 1);
run("Paste");
run("Select None");
setTool("brush");
waitForUser("Rearrange outliners", "Set new outline and press OK");
roiManager("add");
Roi.setStrokeColor("white");
Roi.setStrokeWidth(2);
Stack.setPosition(1, 1, 1);
setForegroundColor(255,255,255);

run("Draw", "slice");
run("Select None");
run("Save");