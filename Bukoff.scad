//Bukoff

//Variable
module z_motor_hold() {
	difference() {
		square([55,80],center=true);
		translate([0,-20])profile();
		translate([0,11.5])motor(screw_i=true,face=true);
	}
}
module y_connector(l=140) {
	difference() {
		union() {
			square([l,20],center=true);
			for(i=[-1,1])translate([i*40,0])square([20,100],center=true);
		}
		for(i=[-1,1])translate([i*60,0])circle(r=2.5);
		for(j=[-1,1])for(i=[-1,1])translate([i*40,j*40])circle(r=2.5);
	}
}

//Modules

//Helper Modules
module motor(face,cable,screw_e,screw_i,hole,screw_d,screws,rod,rod_hole) {	
	if (face==true) square(42.8,center=true);
	if (cable==true) translate([21+5,0])square(10,center=true);
	if (screw_e==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([26,26])circle(r=1.5);
	if (screw_i==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([15.5,15.5])circle(r=1.5);
	if (hole==true) circle(r=11);
	if (rod==true) circle(r=4);
	if (screws==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([screw_d,screw_d])circle(r=1.5);
}

module profile() {
	import("profile.dxf");
	circle(r=2.2);
}


z_motor_hold();
y_connector();
y_connector(l=100); //necessary?