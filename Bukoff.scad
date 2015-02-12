//BukOff

//Variable
$fn=50;

//Modules
module z_motor_hold_top() {
	difference() {
		translate([0,5])square([62,69],center=true);
		translate([0,-20])square(20,center=true);
		translate([0,11])motor(screw_i=true,a=1.5,hole=true,face=true);
		for(i=[-1,1])translate([i*26,-25])squares(x=10,o=0);
	}
}
module z_motor_hold_back() {
}
module z_motor_hold_side() {
}
module y_rod_hold() {
	difference() {
		y_rod_hold_hull();
		y_rod_hold_cut();
	}
}

//Helper Modules
module slot_hole(r,d) {
	hull() {
		for(i=[-1,1])translate([0,i*d])circle(r=r);
	}
}
module motor(face,cable,screw_e,screw_i,hole,screw_d,screws,rod,rod_hole,a) {	
	if (face==true) square(42,center=true);
	if (cable==true) translate([21+5,0])square(10,center=true);
	if (screw_e==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([26,26])circle(r=1.5);
	if (screw_i==true) for(x=[15.5,-15.5])for(y=[-15.5,15.5])translate([x,y])slot_hole(r=1.5,d=a);
	if (hole==true) circle(r=12);
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
	hull()for(i=[-1,1]) {
		translate([i*50,8])circle(r=8);
		translate([i*20,-11])circle(r=8);
	}
}
module squares(x,o) {
	for(i=[o:2:x])translate([0,i*5+2.5])square(5,center=true);
}

linear_bearing(x=20,y=10,r=2.5);
!z_motor_hold_top();
y_rod_hold(); //2