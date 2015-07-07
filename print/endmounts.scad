module pivot(){
difference(){

rotate([0,90,0]){
cylinder(d=pivotdia,h=roddistance+roddia*2-1,center=true);}

translate([roddistance/2,0,0]){
cylinder(d=roddia,h=pivotdia*2,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=pivotdia*2,center=true);}

translate([0,0,-pivotdia/2]){
cube([roddistance+roddia*2+1,pivotdia,pivotdia],center=true);
}

}

}



module screed(type){
    tunerodholelength=pivotdia;
    screedholelength=15;
difference(){
//base
union(){
if (type==1){
translate([0,-stringroddist/2,screedheight]){
rotate([0,90,0]){
cylinder(d=pivotdia,h=screedwidth,center=true);}}}
translate([0,pivotoffset,screedheight/2]){
cube([roddistance,screedholelength+roddia*2,screedheight],center=true);
translate([roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2,h=screedheight,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2,h=screedheight,center=true);}
}


translate([0,0,screedheight/2]){
cube([screedwidth,screedlength,screedheight],center=true);}

}
translate([screedwidth/2-stiffroddia,0,screedheight/2]){
rotate([90,0,0]){
cylinder(d=stiffroddia,h=screedlength+tunerodholelength+1,center=true);
}}

translate([-screedwidth/2+stiffroddia,0,screedheight/2]){
rotate([90,0,0]){
cylinder(d=stiffroddia,h=screedlength+tunerodholelength+1,center=true);
}}


//pivotholes
translate([roddistance/2,pivotoffset,0]){

if (type==1){

translate([0,screedholelength/2,screedheight/2]){
cylinder(d=roddia,h=screedheight+1,center=true);
}
translate([0,-screedholelength/2,screedheight/2]){
cylinder(d=roddia,h=screedheight+1,center=true);
}
translate([0,0,screedheight/2]){
cube([roddia,screedholelength,screedheight+1],center=true);}
}
if (type==2){
translate([0,0,screedheight/2]){
cylinder(d=roddia,h=screedheight+1,center=true);}
}
}

translate([-roddistance/2,pivotoffset,0]){

if (type==1){



translate([0,screedholelength/2,screedheight/2]){
cylinder(d=roddia,h=screedheight+1,center=true);
}
translate([0,-screedholelength/2,screedheight/2]){
cylinder(d=roddia,h=screedheight+1,center=true);
}
translate([0,0,screedheight/2]){
cube([roddia,screedholelength,screedheight+1],center=true);}
}
if (type==2){
translate([0,0,screedheight/2]){
cylinder(d=roddia,h=screedheight+1,center=true);}
}
}



//pivot cylinder
if (type==1){
translate([0,pivotoffset,-pivotdia/4]){
rotate([0,90,0]){
cylinder(d=pivotdia,h=roddistance+roddia*2,center=true);}}
}


//tunerodhole
translate([0,-stringroddist/2,0]){

if (type==1){
translate([0,tunerodholelength/2,screedheight/2]){
cylinder(d=tuneroddia,h=screedheight+pivotdia,center=true);
}
translate([0,-tunerodholelength/2,screedheight/2]){
cylinder(d=tuneroddia,h=screedheight+pivotdia,center=true);
}
translate([0,0,screedheight/2]){
cube([tuneroddia,tunerodholelength,screedheight+pivotdia],center=true);}
}

if (type==2){
translate([0,0,screedheight/2]){
cylinder(d=tuneroddia,h=screedheight+pivotdia,center=true);}
}

}
//stringholes
for(y=[0:stringholenumber-1]){
scale([1,1,1]){
translate([0,stringroddist/2-stringholespread*y,screedheight/2]){{
cylinder(d=stringdia,h=screedheight+1,center=true,$fn=16);
cylinder(d=stringdia,h=screedheight+1,center=true,$fn=16);}}}}

}

}


module tunerodfix(){
rotate([180,0,0]){
difference(){
translate([0,0,pivotdia/4]){
cube([screedwidth,pivotdia+2,pivotdia/2],center=true);}
translate([0,0,-pivotdia/4]){
rotate([0,90,0]){
cylinder(d=pivotdia,h=screedwidth+1,center=true);}}
//translate([0,0,pivotdia-2.5])cylinder(d=tuneroddia*2,h=5,center=true,$fn=6);
cylinder(d=tuneroddia,h=pivotdia*2,center=true);

}}}

module spacer(){
height=6;

difference(){
union(){
linear_extrude(height = height, center = true, convexity = 0){
polygon(points=[[-tuneroddia,-stringroddist/2-tuneroddia],
				[tuneroddia,-stringroddist/2-tuneroddia],
				
				[roddistance/2+roddia,-roddia],				
				[roddistance/2+roddia,0],
				
				[roddistance/2-roddia,0],				
				[roddistance/2-roddia,-roddia],

				[tuneroddia,-stringroddist/2+tuneroddia*1.5],
				[-tuneroddia,-stringroddist/2+tuneroddia*1.5],

				[-roddistance/2+roddia,-roddia], 
				[-roddistance/2+roddia,0], 

				[-roddistance/2-roddia,0],
				[-roddistance/2-roddia,-roddia]],
				


					
				
				

				paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]);
}


translate([roddistance/2,pivotoffset,0]){
cylinder(d=roddia*2,h=height,center=true);}
translate([-roddistance/2,pivotoffset,0]){
cylinder(d=roddia*2,h=height,center=true);}

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
