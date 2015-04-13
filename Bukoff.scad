//BukOff by Moritz Keller

//Variables
$fn=50;
profileSize = 20;
printerX = 300; //tbd
printerY = 200; //tbd
profileRadius = 2.5;
distanceFrame = 40;
angleLength = 60;
mdf = 5;
motorSide = 43;

//Modules
//Platform
module platform_bottom() {
	difference() {
		square([230,140],center=true);
		for(i=[1,-1]) {
			translate([-70,i*50])tr_xy(x=12,y=9)circle(r=2);
			translate([5,i*65])circle(r=1.5);
		}
		translate([70,0])	tr_xy(x=12,y=9)circle(r=2);
		for(i=[-1,1])for(j=[1,-1])translate([i*212.2/2,j*60])circle(r=2);
		tr_xy(x=50)circle(r=1.5);
	}
}
module platform_top() {
	difference() {
		square([200,200],center=true);
		for(i=[-1,1])for(j=[1,-1])translate([i*212.2/2,j*60])circle(r=9);
		tr_xy(x=50)circle(r=1.5);
	}
}

//Helper Modules
module tr_xy(x,y=0) {
	if(y==0) {
		for(i=[-1,1])for(j=[-1,1])translate([x*i,x*j])children();
	} else {
		for(i=[-1,1])for(j=[-1,1])translate([x*i,y*j])children();
	}
}
//Render
//Platform
platform_top(); //1
platform_bottom(); //1