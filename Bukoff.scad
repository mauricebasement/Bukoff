//BukOff by Moritz Keller

//Variables
$fn=50;
zMotorHoldX = 62;
xRodDistance = 18;

//Modules
//1. Platform
module platform1() {
	difference() {
		square([230,140],center=true);
		for(i=[1,-1]) {
			translate([-70,i*50])tr_xy(x=9,y=12)circle(r=2);
			translate([5,i*65])circle(r=1.5);
		}
		translate([70,0])	tr_xy(x=9,y=12)circle(r=2);
		for(i=[-1,1])for(j=[1,-1])translate([i*212.2/2,j*60])circle(r=2);
		tr_xy(x=50)circle(r=1.5);
	}
}
module platform2() {
	difference() {
		square([200,200],center=true);
		for(i=[-1,1])for(j=[1,-1])translate([i*212.2/2,j*60])circle(r=9);
		tr_xy(x=50)circle(r=1.5);
	}
}
//2. Z Motor Hold
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
//3. Y Rod Hold
module y_rod_hold(wide) {
	difference() {
		y_rod_hold_hull();
		y_rod_hold_cut(wide=wide);
	}
}
module y_rod_hold_cover() {
	difference() {
		circle(r=12);
		x_holes(r=1.5,x=5);
	}
}
module motor_hold(y,face) {
	profile_square();
    translate([0,25])square([y,10],center=true);
	translate([0,50])difference() {
		square([y,y],center=true);
		motor(screw_i=true,hole=true,face=face);
	}
    holds();
}
module motor_hold_bottom() {
	profile_square();
	translate([0,40])difference() {
		square(40,center=true);
		motor(screw_i=true,hole=true);
	}
    holds();
}

module belt_hold() {
    profile_square();
    holds();
    difference() {
        translate([0,30])square([40,35],center=true);
        translate([0,35])circle(r=7);
    }
}
//Helper Modules
module holds() {
    for(i=[0,1])mirror([i,0,0])polygon(points=[[20,0],[60,20],[20,20]]);
}
module profile_square(y=40) {
	difference() {
		square([40,y],center=true);
		tr_xy(x=10)circle(r=2.5);
	}
}
//4. Frame
module angle(profileSize=20,length=60,holeRadius=2.5,number=1) {
i=profileSize/2;
j=length-profileSize/2;
	difference() {
		union() {
			square([profileSize,length]);
			square([length,profileSize]);
		}
		for(k=[i:((j-i)/number):(j+((j-i)/number))])translate([k,i])circle(r=holeRadius);
		for(k=[i:((j-i)/(number+1)):(j+((j-i)/(number+1)))])translate([i,k])circle(r=holeRadius);
	}
}
module profile_top() {
	translate([-21,0])thread_hold();
	translate([25,0])profile_connector();
}
module bearing_hold() {
	difference() {
		square(32,center=true);
		tr_xy(x=10)circle(r=1.5);
		circle(r=8);
	}
}
module y_axis_connector() {
	difference() {
		hull()union() {
			square([100,20],center=true);
			square([50,110],center=true);
		}
		tr_xy(x=10,y=40)circle(r=2.5);
        tr_xy(x=22.5,y=47.5)square(5,center=true);
        tr_xy(x=22.5,y=12.5)square(5,center=true);
		for(i=[-1,1])translate([i*40,0])circle(r=2.5);
	}
}
module y_axis_connector_side() {
    difference() {
        square([40,100],center=true);
        translate([10,0])square([20,20],center=true);
        translate([-7.5,0])square([5,20],center=true);
    }
    translate([22.5,0])tr_xy(x=0,y=47.5)square(5,center=true);
    translate([22.5,0])tr_xy(x=0,y=12.5)square(5,center=true);
}
module y_axis_connector_bottom() {
    difference() {
        union() {
            square([20,90],center=true);
            square([25,40],center=true);
        }
        tr_xy(x=0,y=35)circle(r=2.5);
        circle(r=2.5);
    }
}
module y_axis_connector_square() {
    difference() {
        square(20,center=true);
        circle(r=2.5);
    }
}
module y_axis_connector_middle_square() {
    difference() {
        square([20,40],center=true);
        circle(r=2.5);
    }
}


//5. Z Guide
module z_glider() {
    import("z-glider.stl");
}
module z_glider_cut(negativ) {
    if (negativ==true) {
    negativ_sq()import("z-glider_cut.dxf");
    }else{
    import("z-glider_cut.dxf");
    }
}
module z_guide_side_one() {
    difference() {
        z_guide_side(40);
        translate([33,0])motor(screw_i=true,a=0,hole=true);
    }
}
module z_guide_side_two() {
    difference() {
        z_guide_side(50);
        translate([33,0])motor(face=true);
    }    
}
module z_guide_side(x) {
    difference() {
        translate([10,0])square([100,x],center=true);
        z_glider_cut(negativ=true);
    }
}
*z_guide_side_one();
*z_guide_side_two();
//6. X_Carriage
module x_carriage() {
	difference() {
		square([30,60],center=true);
		translate([0,xRodDistance])lbr_cut();
		for(i=[-1,1])translate([0,i*xRodDistance])lbr_cut();
	}
}
//Helper Modules
module tr_xy(x,y=0) {
	if(y==0) {
		for(i=[-1,1])for(j=[-1,1])translate([x*i,x*j])children();
	} else {
		for(i=[-1,1])for(j=[-1,1])translate([x*i,y*j])children();
	}
}
module lbr_cut() {
	square([24,8],center=true);
	for(i=[-1,1])for(j=[-1,1])translate([i*10,j*7.5])square([3,1.5],center=true);
}
module z_holder() {
	difference() {
		translate([2.5,0])square([37,35],center=true);
		xy_slotholes(x=10,y=10,r=1.5,d=1.5,o=90);
		circle(r=6);

	}
}
module brass_cut() {
	circle(r=5);
	for(i=[0:3])rotate(a=[0,0,90*i])translate([8,0])circle(r=1.5);
}
module thread_hold(r=6) {
	difference() {
		square(32,center=true);
		xy_slotholes(x=10,y=10,r=1.5,d=1.5,o=90);
		circle(r=r);
	}
}
module profile_connector() {
	difference() {
		square([60,20],center=true);
		for(i=[-15,20])translate([i,0])circle(r=2.5);
	}
}
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
module xy_squares(x,y,s) {
	for(i=[1,0])for(j=[0,1])mirror([0,j,0])mirror([i,0,0])translate([x,y])square(s,center=true);
}
module x_holes(x,r) {
	for(i=[0:3])rotate(a=[0,0,i*90])translate([x,x])circle(r=r);
}
module y_rod_hold_cut(wide=40) {
	for(i=[-1,1]) {
		translate([i*10,0])	circle(r=2.5);
		translate([i*70,8]) {
			circle(r=4);
			x_holes(r=1.5,x=6);
		}
	}
	translate([0,12.5])square([40,5],center=true);
	translate([0,-12.5])square([wide,5],center=true);
}
module y_rod_hold_hull() {
	hull()for(i=[-1,1]) {
		translate([i*70,8])circle(r=13);
		translate([i*20,-5])circle(r=10);
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
module xy_slotholes(x,y,r,d,o=0) {
	for(xt=[x,-x])for(yt=[-y,y])translate([xt,yt])rotate(a=[0,0,o])slot_hole(r=r,d=d);
}
module negativ_sq() {
    difference() {
        hull()children();
        children();
    }
}
//Render
//1. Platform
platform1(); //1
platform2(); //1
//2. Z Motor Hold
z_motor_hold_top();  //2
z_motor_hold_back(); //2
z_motor_hold_side(); //4
//3. Y Rod Hold
y_rod_hold(wide=40); //1
y_rod_hold(wide=50); //1
y_rod_hold_cover(); //4
belt_hold(); //2
motor_hold(y=60,face=true); //1
motor_hold(y=40); //1
//4. Frame
angle(); //8 /4 ?
y_axis_connector(); //1
y_axis_connector_side(); //2
y_axis_connector_bottom(); //1
y_axis_connector_square(); //2
y_axis_connector_middle_square(); //1
profile_top(); //2
bearing_hold(); //2
//5. Z Guide
z_glider(); //4 SLA

//6. X_Carriage
x_carriage();


