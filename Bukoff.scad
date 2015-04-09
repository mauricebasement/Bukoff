//BukOff by Moritz Keller

//Variables
$fn=50;
zMotorHoldX = 62;
xRodDistance = 18;

//Modules
//1. Platform
module platform1() {
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
module platform2() {
	difference() {
		square([200,200],center=true);
		for(i=[-1,1])for(j=[1,-1])translate([i*212.2/2,j*60])circle(r=9);
		tr_xy(x=50)circle(r=1.5);
	}
}
//Render
//1. Platform
platform1(); //1
platform2(); //1

