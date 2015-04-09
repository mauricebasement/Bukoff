//BukOff by Moritz Keller

//Variables
$fn=50;
profileSize = 20;
printerX = 300; //tbd
printerY = 200; //tbd
profileRadius = 2.5;
distanceFrame = 40;
angleLength = 60;

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
module frame_top (r=profileRadius,d=distanceFrame,bottom=true) {
    difference() {
        union() {
            square([printerX+2*profileSize,profileSize],center=true);
            if(bottom==true)for(i=[1,-1])translate([i*(printerX/2+profileSize/2),0])square(profileSize*1.5,center=true);
            }
        for(i=[1,0,-1])translate([i*(printerX/2+profileSize/2),0])circle(r=r);
        for(i=[1,-1])translate([i*(printerX/2+profileSize/2-d),0])circle(r=r);
        if(bottom==true)for(i=[1,-1])translate([i*(printerX/2+profileSize/2),0])profile();
     }
        
}
module frame_top_side() {
    difference() {
        square([profileSize*2+printerX,angleLength],center=true);
        tr_xy(x=printerX/2+profileSize/2,y=angleLength/2-profileSize/2)circle(r=profileRadius);
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

//Render
//Platform
platform_top(); //1
platform_bottom(); //1

//Frame
frame_top();
!frame_top_side();
