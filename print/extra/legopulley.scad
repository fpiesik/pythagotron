module legopulley(){
// tuneable constants

motor_shaft = 5.3;	// NEMA17 motor shaft exact diameter = 5
m3_dia = 3.2;		// 3mm hole diameter
m3_nut_hex = 1;		// 1 for hex, 0 for square nut
m3_nut_flats = 5.7;	// normal M3 hex nut exact width = 5.5
m3_nut_depth = 2.7;	// normal M3 hex nut exact depth = 2.4, nyloc = 4

pulley_b_ht = 8;		// pulley base height, standard = 8. 

pulley_b_dia = 20;	// pulley base diameter, standard = 20
no_of_nuts = 1;		// number of captive nuts required, standard = 1
nut_angle = 180;		// angle between nuts, standard = 90
nut_shaft_distance = 1.2;	// distance between inner face of nut and shaft, can be negative.


// calculated constants

nut_elevation = pulley_b_ht/2;
m3_nut_points = 2*((m3_nut_flats/2)/cos(30)); // This is needed for the nut trap


gearHeight = 15;





// Main Module

module pulley()
	{
	difference()
	 {	 
		union()
		{
			//base
	
			
				rotate_extrude($fn=pulley_b_dia*2)
				{
						square([pulley_b_dia/2-1,pulley_b_ht]);
						square([pulley_b_dia/2,pulley_b_ht-1]);
						translate([pulley_b_dia/2-1,pulley_b_ht-1]) circle(1);
				}
			
	
		
	
	
		}
	   
	
				
		
        //captive nut and grub screw holes
			for(j=[1:no_of_nuts]) rotate([0,0,j*nut_angle])
			translate([0,0,nut_elevation])rotate([90,0,0])
	
			union()
			{
				//entrance
				translate([0,-pulley_b_ht/4-0.5,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance]) cube([m3_nut_flats,pulley_b_ht/2+1,m3_nut_depth],center=true);
	
				//nut
				
						// hex nut
						translate([0,0.25,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance]) rotate([0,0,30]) cylinder(r=m3_nut_points/2,h=m3_nut_depth,center=true,$fn=6);
					
	
				//grub screw hole
				rotate([0,0,22.5])cylinder(r=m3_dia/2,h=pulley_b_dia/2+1,$fn=8);
			}
		}
	 
	   
	}






    
    

    
  
    
    
    
    

    
    
    
    

   
    
module myGear(n_teeth) {
  if (n_teeth >= 56) {
    myGearParamed(n_teeth, 6, 4, 5, 5);
  } else if (n_teeth >= 48) {
    myGearParamed(n_teeth, 4, 4, 5, 3);
  } else if (n_teeth >= 40) {
    myGearParamed(n_teeth, 4, 2, 3, 3);
  } else if (n_teeth >= 32) {
    myGearParamed(n_teeth, 2, 2, 3, 3);
  } else if (n_teeth >= 26) {
    myGearParamed(n_teeth, 2, 2, 3, 1);
  } else if (n_teeth >= 21) {
    myGearParamed(n_teeth, 2, 2, 1, 1);
  } else {
    myGearParamed(n_teeth, 0, 0, 1, 1);
  }
}

module myGearParamed(num_teeth, holes_row, holes_col, plus_row, plus_col)
{

 

 
  difference() {
    linear_extrude(height = gearHeight, center = false, convexity = 10, twist = 0) {
      gear(number_of_teeth=num_teeth,
        diametral_pitch=1, 
        pressure_angle=88, 
        clearance = 0);
    }

   

  }
}



module gear(number_of_teeth,
    circular_pitch=false, diametral_pitch=false,
    pressure_angle=20, clearance = 0)
{
  if (circular_pitch==false && diametral_pitch==false) echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");
  
  //Convert diametrial pitch to our native circular pitch
  circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);
  
  // Pitch diameter: Diameter of pitch circle.
  pitch_diameter  =  number_of_teeth * circular_pitch / 180;
  pitch_radius = pitch_diameter/2;
  
  // Base Circle
  base_diameter = pitch_diameter*cos(pressure_angle);
  base_radius = base_diameter/2;

  // Diametrial pitch: Number of teeth per unit length.
  pitch_diametrial = number_of_teeth / pitch_diameter;

  // Addendum: Radial distance from pitch circle to outside circle.
  addendum = 1/pitch_diametrial;
  
  //Outer Circle
  outer_radius = pitch_radius+addendum;
  outer_diameter = outer_radius*2;
  
  // Dedendum: Radial distance from pitch circle to root diameter
  dedendum = addendum + clearance;

  // Root diameter: Diameter of bottom of tooth spaces.
  root_radius = pitch_radius-dedendum;
  root_diameter = root_radius * 2;
  
  half_thick_angle = 360 / (4 * number_of_teeth);
  
  union() {
    rotate(half_thick_angle)
      circle($fn=number_of_teeth*2, r=root_radius*1.001);
    
    for (i= [1:number_of_teeth]) {  //for (i = [0])
      rotate([0,0,i*360/number_of_teeth]) {
        involute_gear_tooth(
          pitch_radius = pitch_radius,
          root_radius = root_radius,
          base_radius = base_radius,
          outer_radius = outer_radius,
          half_thick_angle = half_thick_angle);
      } // end of rotate(){}
    } // end of for(){}
  } // end of union(){}
} // end of module gear

module involute_gear_tooth(
          pitch_radius,
          root_radius,
          base_radius,
          outer_radius,
          half_thick_angle
          )
{
  pitch_to_base_angle  = involute_intersect_angle( base_radius, pitch_radius );
  
  outer_to_base_angle = involute_intersect_angle( base_radius, outer_radius );
  
  base1 = 0 - pitch_to_base_angle - half_thick_angle;
  pitch1 = 0 - half_thick_angle;
  outer1 = outer_to_base_angle - pitch_to_base_angle - half_thick_angle;
  
  b1 = polar_to_cartesian([ base1, base_radius ]);
  p1 = polar_to_cartesian([ pitch1, pitch_radius ]);
  o1 = polar_to_cartesian([ outer1, outer_radius ]);
  
  b2 = polar_to_cartesian([ -base1, base_radius ]);
  p2 = polar_to_cartesian([ -pitch1, pitch_radius ]);
  o2 = polar_to_cartesian([ -outer1, outer_radius ]);
  
  // set up values for ( root_radius > base_radius ) case
    pitch_to_root_angle = pitch_to_base_angle - involute_intersect_angle(base_radius, root_radius );
    root1 = pitch1 - pitch_to_root_angle;
    root2 = -pitch1 + pitch_to_root_angle;
    r1_t =  polar_to_cartesian([ root1, root_radius ]);
    r2_t =  polar_to_cartesian([ -root1, root_radius ]);
  
  // set up values for ( else ) case
    r1_f =  polar_to_cartesian([ base1, root_radius ]);
    r2_f =  polar_to_cartesian([ -base1, root_radius ]);
  
  if (root_radius > base_radius) {
    polygon( points = [
      b1, r1_t,p1,o1,o2,p2,r2_t, b2
    ], convexity = 3);
  } else {
    polygon( points = [
      r1_f, b1,p1,o1,o2,p2,b2,r2_f
    ], convexity = 3);
  }
  
}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from its center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle(base_radius, radius) = sqrt( pow(radius/base_radius,2) - 1);



// Polar coord [angle, radius] to cartesian coord [x,y]

function polar_to_cartesian(polar) = [
  polar[1]*cos(polar[0]),
  polar[1]*sin(polar[0])
];

difference(){
union(){
pulley ();
translate([0,0,pulley_b_ht])myGear(15);
}


//hole for motor shaft
		translate([0,0,-1])cylinder(r=motor_shaft/2,h=pulley_b_ht + gearHeight + 2,$fn=motor_shaft*4);
}
}
//legopulley();