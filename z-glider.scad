$fn=50;
//Bukoff
module profile(h=50) {
	import("profile.dxf");
}

//Option: FDM Printed Glider
module glider(x=20,y=10,ex=10,b=5) {
	translate([0,-2.5])square([x,y],center=true);
	translate([0,ex/2])square([b,ex],center=true);
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


 
module z_glider(h=40,screw_dx=5,screw_dy=7,screw_r=1.5) {
    difference() {
        linear_extrude(height=h)offset(r=-.1)glider1(b=5);
        for(i=[screw_dx,screw_dx*2,screw_dx*3,h/2,h-screw_dx,h-screw_dx*2,h-screw_dx*3])translate([0,-5,i])rotate(a=[0,90,0])cylinder(r=screw_r,center=true,h=30);
        for(i=[screw_dy,screw_dy/2,0,-screw_dy,-screw_dy/2])translate([i,-5,0])rotate(a=[0,0,0])cylinder(r=screw_r,h=h);
    }
}
z_glider();
