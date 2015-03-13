//Bukoff
module profile(h=50) {
	scale(1.0)linear_extrude(height=h)import("profile.dxf");
}

//Option: FDM Printed Glider
module glider(x=20,y=5,z=20,ex=8.6,b=5) {
	translate([0,0,z/2])cube([x,y,z],center=true);
	translate([0,ex/2,z/2])cube([b,ex,z],center=true);
}

module glider_cut(b) {
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
	translate([19.01,0])stick_out();
}

//Render

glider1(b=10);
glider1(b=7);
!scale(0.95)glider1(b=5);
cut_glider();