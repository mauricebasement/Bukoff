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
module z_glider(h=40,screw_d=5,screw_dy=6.5,screw_r=1.5,rot=30) {
    
    difference() {
        linear_extrude(height=h)offset(r=-.1)glider1(b=5); 
        translate([0,0,1])resize([0,0,38])linear_extrude(height=h)offset(r=-1.1)glider1(b=5);
        screw(h,screw_d,screw_dy,screw_r,11,0);
        for(i=[screw_d,h-screw_d])for(j=[screw_dy,-screw_dy])translate([j,0.1,i])rotate(a=[90,rot,0])cylinder(h=3,r=3,$fn=6);
        for(i=[-5,3])translate([0,i,0])cylinder(h=h,r=0.5);
    }
    difference(){
        screw(h,screw_d,screw_dy,screw_r+1.5,9.8,-.1);
        screw(h,screw_d,screw_dy,screw_r,11,0);
        for(i=[screw_d,h-screw_d])for(j=[screw_dy,-screw_dy])translate([j,0.1,i])rotate(a=[90,rot,0])cylinder(h=3,r=3,$fn=6);
    }
}
module screw(h,screw_d,screw_dy,screw_r,h2,o) {
    for(i=[screw_d,h-screw_d])for(j=[screw_dy,-screw_dy])translate([j,o,i])rotate(a=[90,0,0])cylinder(h=h2,r=screw_r);
    }
z_glider();