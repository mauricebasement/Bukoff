//BukOff

//Variables
$fn=50;
zMotorHoldX = 62;

//Modules
module platform1() {
	difference() {
		square([230,205],center=true);
		for(i=[1,-1])translate([-50,i*50])xy_holes(x=9,y=12,r=1.5);
		translate([50,0])xy_holes(x=9,y=12,r=1.5);
		for(i=[-1,1])for(j=[1,-1])translate([i*212.2/2,j*60])circle(r=2);
	}
}
module platform2() {
	difference() {
		square([230,205],center=true);
		for(i=[1,-1])translate([106,i*95])circle(r=1.5);
		translate([-106,0])circle(r=1.5);
		for(i=[-1,1])for(j=[1,-1])translate([i*212.2/2,j*60])circle(r=8.5);
	}
}
module z_motor_hold_top() {
	difference() {
		translate([0,5])square([zMotorHoldX,69],center=true);
		translate([0,-20])square(20,center=true);
		translate([0,11])motor(screw_i=true,a=1.5,hole=true);
		for(i=[-1,1]){
			translate([i*26,-25])squares(x=10,o=0);
			translate([i*17.5,-30])t_slot();
		}
	}
	for(i=[-1,1]) {
		for(j=[12.5,42.5])translate([i*26,j-25])square_hole();
		translate([i*26,-32])square([5,6],center=true);
	}
}
module z_motor_hold_back() {
	difference() {
		square([zMotorHoldX,50],center=true);
		for(i=[-1,1]) {
			translate([i*26,-25])squares(x=10,o=1);
			translate([i*17.5,22.5])circle(r=1.5);
			translate([0,i*15])circle(r=2.5);
		}
	}
	for(i=[-1,1])for(j=[17.5,37.5])translate([i*26,j-25])square_hole();
}
module z_motor_hold_side() {
	difference() {
		translate([5,0])square([40,69]);
		for(i=[20,50])translate([5,i-2.5])rotate(a=[0,0,-90])t_slot();	
		for(i=[15,35])translate([i-2.5,0])rotate(a=[0,0,00])t_slot();	
	}
	for(j=[-1,1])for(i=[10,30,40,60])translate([0,i-5])square(5);
	for(j=[-1,1])for(i=[25,45])translate([i-5,-5])square(5);

}
module y_rod_hold() {
	difference() {
		y_rod_hold_hull();
		y_rod_hold_cut();
	}
}
module y_rod_hold_cover() {
	difference() {
		circle(r=12);
		x_holes(r=1.5,x=5);
	}
}

module angle(profileSize=20,length=60,holeRadius=2.5,number=3) {
i=profileSize/2;
j=length-profileSize/2;
	difference() {
		union() {
			square([profileSize,length]);
			square([length,profileSize]);
		}
		for(k=[i:((j-i)/number):(j+((j-i)/number))]) {
			translate([k,i])circle(r=holeRadius);
			translate([i,k])circle(r=holeRadius);
		}
	}
}
module y_axis_connector() {
	difference() {
		union() {
			square([100,20],center=true);
			square([40,60],center=true);
		}
		xy_holes(r=2.5,y=20,x=10);
		for(i=[-1,1])translate([i*40,0])circle(r=2.5);
	}
}
module thread_hold() {
	difference() {
		square([80,20],center=true);
		translate([-21,0])for(i=[0:3])rotate(a=[0,0,i*90])translate([9,9])rotate(a=[0,0,90])slot_hole(r=1.5,d=1.5);
		
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
	if (hole==true) circle(r=14);
	if (rod==true) circle(r=4);
	if (screws==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([screw_d,screw_d])circle(r=1.5);
}
module profile() {
	import("profile.dxf");
	circle(r=2.2);
}
module xy_holes(x,y,r) {
	for(i=[1,0])for(j=[0,1])mirror([0,j,0])mirror([i,0,0])translate([x,y])circle(r=r);
}
module x_holes(x,r) {
	for(i=[0:3])rotate(a=[0,0,i*90])translate([x,x])circle(r=r);
}
module y_rod_hold_cut() {
	for(i=[-1,1]) {
		translate([i*10,-10])	circle(r=2.5);
		translate([i*50,8]) {
			circle(r=4);
			x_holes(r=1.5,x=6);
		}
	}
}
module y_rod_hold_hull() {
	hull()for(i=[-1,1]) {
		translate([i*50,8])circle(r=12);
		translate([i*50,8])circle(r=12);
		translate([i*20,-11])circle(r=9);
	}
}
module squares(x,o) {
	for(i=[o:2:x])translate([0,i*5+2.5])square(5,center=true);
}
module square_hole() {
	difference() {
		square(5,center=true);
		circle(r=1.5);
	}
}
module t_slot() {
	translate([0,3.25])square([2.8,6.5],center=true);
	translate([0,3.5])square([2.5+2.8,1.65],center=true);
}

//Render
platform1(); //1
platform2(); //1
z_motor_hold_top();  //2
z_motor_hold_back(); //2
z_motor_hold_side(); //4
y_rod_hold(); //2
y_rod_hold_cover(); //4
angle();
y_axis_connector(); //1
thread_hold(); //2
