//BukOff by Moritz Keller

//Variables
$fn=50;
profileSize = 20;
profileRadius = 2.5;
mdf = 5;
zipX = 2; //Zip ties for carriages to hold linear beraings
zipY = 4;
lbrX = 15;
lbrY = 24;
lbrSub = 3; //how much to subtract from linear beraing in carriage hole
lbrOff = 1;
rodDistance = 140;

//Modules
//Platform
module platform_bottom() {
	difference() {
		square([230,140],center=true);
		for(i=[1,-1]) {
			translate([-rodDistance/2,i*50])bearing_cut();
			translate([5,i*65])circle(r=1.5);
		}
		translate([rodDistance/2,0])bearing_cut();
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

module bearing_cut(holes=false) {
    if(holes==true)tr_xy(x=12,y=9)circle(r=2);
    if(holes==false) {
        square([lbrX-lbrSub,lbrY],center=true);
        tr_xy(x=(lbrX-lbrSub)/2+zipX+lbrOff,y=lbrY/2-zipY)square([zipX,zipY],center=true);
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
!platform_bottom(); //1