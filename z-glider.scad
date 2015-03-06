//Bukoff
module profile(h=50) {
	linear_extrude(height=h)import("profile.dxf");
}








//Option: FDM Printed Glider
module glider(x=20,y=5,z=50,ex=8.5,b=5) {
	translate([0,0,z/2])cube([x,y,z],center=true);
	translate([0,ex/2,z/2])cube([b,ex,z],center=true);
}

module glider_cut(b=b) {
	intersection() {
		translate([0,10])profile();
		translate([0,-2.5])glider(b=b);
	}
}
module glider1(b) {
	difference() {
		translate([0,-2.5])glider(b=b);
		glider_cut(b=b);
	}
}
glider1(b=10);
//Option: Laser Cut Glider
module flat() {
	difference(){
		square([20,50],center=true);
		for(i=[-1,1])translate([0,i*22.5])square(5,center=true);
	}
}
module stick_out() {
		square([8,50],center=true);
		for(i=[-1,1])translate([-6.5,i*22.5])square(5,center=true);
}
module cut_glider() {
	flat();
	stick_out();
}