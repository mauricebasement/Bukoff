//Bukoff
module profile(h=50) {
	import("profile.dxf");
}

//Option: FDM Printed Glider
module glider(x=23,y=10,ex=10,b=5) {
	translate([0,-1])square([x,y],center=true);
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


//Render
glider1(b=5);
    
