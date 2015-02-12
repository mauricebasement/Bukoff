//Bukoff

//Variable
module z_motor_hold() {

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

