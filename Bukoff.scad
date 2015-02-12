//Bukoff

//Variable
//Modules
module z_motor_hold() {
	difference() {
		square([55,80],center=true);
		translate([0,-20])profile();
		translate([0,11.5])motor(screw_i=true,face=true);
	}
}
module y_rod_hold() {
	difference() {
		!y_rod_hold_hull();
		y_rod_hold_cut();
	}
}

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
module linear_bearing() {
	for(i=[0:3])rotate(a=[0,0,i*90])translate([x,y])circle(r=r);
}
module y_rod_hold_cut() {
	for(i=[-1,1]) {
		translate([i*10,-10])circle(r=2.5);
		translate([i*50,8])circle(r=4);
	}
}
module y_rod_hold_hull() {
	for(i=[-1,1]) { hull() {
		translate([i*50,8])circle(r=8);
		translate([i*20,-11])circle(r=8);
	} }
}


linear_bearing(x=20,y=10,r=2.5);
z_motor_hold();
y_connector();
y_connector(l=100); //necessary?
y_rod_hold();