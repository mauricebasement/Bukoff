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
//Frame
module frame_top1(r=profileRadius,d=distanceFrame) {
    difference() {
        square([printerX+2.5*profileSize,profileSize*2],center=true);
        for(i=[1,-1])translate([i*(printerX/2+profileSize/2),0])profile();
        for(i=[-0.99999,1])translate([0,i*(profileSize+mdf)/2])frame_top_side_joints();
     }
        
}
module frame_top2 (r=profileRadius,d=distanceFrame) {
    difference() {
        union() {
            square([printerX+2.5*profileSize,profileSize*2],center=true);
        }
        for(i=[1,-1])translate([i*(printerX/2+profileSize/2),0])circle(r=r);
        for(i=[-0.99999,1])translate([0,i*(profileSize+mdf)/2])frame_top_side_joints();
     }       
}
module frame_top_side() {
    difference() {
        square([profileSize*2+printerX,angleLength],center=true);
        tr_xy(x=printerX/2+profileSize/2,y=angleLength/2-profileSize/2)circle(r=profileRadius);
    }
    for(i=[-0.99999,1])translate([0,i*(angleLength+mdf)/2])frame_top_side_joints();
    translate([0,(angleLength+mdf)/2+mdf])frame_top_side_joints();
}
module frame_bottom(r=profileRadius,d=distanceFrame) {
    difference() {
        union() {
            square([printerX+2*profileSize+2*motorSide,profileSize*2],center=true);
        }
        for(i=[1,-1]) {
            translate([i*(printerX/2+profileSize/2),0])profile();
            translate([i*(printerX/2+profileSize+motorSide/2),0])motor(hole=true,screw_i=true);
        }        
        for(i=[-0.99999,1])translate([0,i*(profileSize+mdf)/2])frame_top_side_joints();
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
module profile() {
    import("dxf/profile.dxf");
    circle(r=2.5);
}
module joints(size=5,length=30,o1=0,o2=-1) {
    for(j=[-1,1])for(i=[0+o1:length/size/4+o2])translate([j*(i*size*2+size),0])square([size,mdf],center=true);
}

module frame_top_side_joints() {
    joints(size=20,length=profileSize*2+printerX,o1=0);
}
module motor(face,cable,screw_e,screw_i,hole,screw_d,screws,rod,rod_hole,a) {	
	if (face==true) square(motorSide,center=true);
	if (cable==true) translate([21+5,0])square(10,center=true);
	if (screw_e==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([26,26])circle(r=1.5);
	if (screw_i==true) for(x=[15.5,-15.5])for(y=[-15.5,15.5])translate([x,y])slot_hole(r=1.5,d=a);
	if (hole==true) circle(r=14);
	if (rod==true) circle(r=4);
	if (screws==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([screw_d,screw_d])circle(r=1.5);
}
module slot_hole(r,d) {
	hull() {
		for(i=[-1,1])translate([0,i*d])circle(r=r);
	}
}
//Render
//Platform
platform_top(); //1
platform_bottom(); //1

//Frame
frame_top1();
frame_top2();
frame_top_side();
frame_bottom();