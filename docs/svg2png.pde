PShape sh = loadShape("shape.svg");
background(255);
size(512, 512);
shape(sh, 0, 0, 512, 512);
save("shape.png");
