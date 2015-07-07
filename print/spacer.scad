include <configuration.scad>;

module spacer(){
height=6;

difference(){
union(){
//linear_extrude(height = height, center = true, convexity = 0){
//polygon(points=[
//                [-roddistance/2-roddia,-stringroddist/2-tuneroddia],
//				[roddistance/2+roddia,-stringroddist/2-tuneroddia],
//				
//				[roddistance/2+roddia,-roddia],				
//				[roddistance/2+roddia,0],
//				
//				[roddistance/2-roddia,0],				
//				[roddistance/2-roddia,-roddia],
//
//				[roddistance/2-roddia,-stringroddist/2+tuneroddia*1],
//				[-roddistance/2+roddia,-stringroddist/2+tuneroddia*1],
//
//				[-roddistance/2+roddia,-roddia], 
//				[-roddistance/2+roddia,0], 
//
//				[-roddistance/2-roddia,0],
//				[-roddistance/2-roddia,-roddia]],
//				
//
//
//					
//				
//				
//
//				paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]);
//}

hull(){
translate([roddistance/2,0,0]){
cylinder(d=roddia*2,h=height,center=true);}
translate([roddistance/2,-stringroddist/2+roddia-tuneroddia,0])cylinder(d=roddia*2,h=height,center=true);
}

hull(){
translate([-roddistance/2,0,0]){
cylinder(d=roddia*2,h=height,center=true);}
translate([-roddistance/2,-stringroddist/2+roddia-tuneroddia,0])cylinder(d=roddia*2,h=height,center=true);
}

hull(){
translate([roddistance/2,-stringroddist/2,0])cylinder(d=tuneroddia*2,h=height,center=true);
translate([-roddistance/2,-stringroddist/2,0])cylinder(d=tuneroddia*2,h=height,center=true);
}
}

translate([roddistance/2,pivotoffset,0]){
cylinder(d=roddia,h=screedheight+1,center=true);
translate([0,roddia*2,0]){
cube([roddia,roddia*4,height],center=true);}}
translate([-roddistance/2,pivotoffset,0]){
cylinder(d=roddia,h=screedheight+1,center=true);
translate([0,roddia*2,0]){
cube([roddia,roddia*4,height],center=true);}}

translate([0,roddia*1.5,0]){
cube([roddistance*2,roddia*2,height],center=true);}

//tunerodhole
translate([0,-stringroddist/2,0]){
cylinder(d=tuneroddia,h=screedheight+pivotdia,center=true);
translate([0,-tuneroddia*2,0]){
cube([tuneroddia,tuneroddia*4,height],center=true);}}
}
}

//spacer();