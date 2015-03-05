//variables (mm)
bearingOD = 16;// bearing diameter
bearingwidth = 5;
beltwidth= 6;

slopfactor = .6; // it printed a bit tight on my printer so i added this slop factor to make the hole slightly looser.. you may not need it

thickness = 2;

	idlerID = bearingOD + slopfactor; 

	idlerOD = idlerID+thickness;
	$fn=30; //faceting

//these are the lips that hold the belt on
	lipheight = 2.5;
	lipthickness = 2;
	topangle = 60; //the angle the top lip overhang makes. You can increase this to lower the idler profile.

//construction
	difference(){
	union(){
	cylinder(r=lipheight+idlerOD/2, h=lipthickness);
		cylinder(r=idlerOD/2, h = lipthickness*2+beltwidth+lipheight*cos(topangle));
		translate([0,0,lipthickness+beltwidth+lipheight*cos(topangle)])cylinder(r=lipheight+idlerOD/2, h=lipthickness);
		translate([0,0,beltwidth+lipthickness])cylinder(r1=idlerOD/2, r2=lipheight+idlerOD/2, h=lipheight*cos(topangle));
		}
		translate([0,0,-.1+lipthickness+(beltwidth-bearingwidth)/2])cylinder(r=idlerID/2, h=lipthickness+beltwidth+lipheight*2-(beltwidth-bearingwidth)/2);
            // inner lip to hold bearing
		translate([0,0,-1])cylinder(r=idlerID/2-1, h=lipthickness+1+(beltwidth-bearingwidth)/2);
}