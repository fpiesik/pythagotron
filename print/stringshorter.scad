include <configuration.scad>
include <extra/linear_bearing.scad>;

module stringshorter(orientation){

bearingdia=19;
height=29;
bearingsupportX=4;
bearingsupportY=2;
offset=3;

ziptiedimZ=5;
ziptiedimY=2.5;
zipdistance=8;
zipdistanceZ=19;

mountdimY=14;
mountdimX=6;
screwdia=4.2;
screwdistance=15;
nutdepth=2.5;
M4_nutdia=8.3;
M8_nutdia=15.5;    
adjust=40;

armA_mountX=8;    
armA_mountY=20;

armB_mountX=5;
armB_mountY=40;

//orientation=1; //1=model orientation, 2=print orientation
    
    
module carriage(){


difference(){
union(){
cube([bearingdia+bearingsupportX*2,raildistance+bearingdia+bearingsupportY,height],center=true);
translate([(bearingdia+bearingsupportX*2)/2-mountdimX/2,(raildistance+bearingdia+bearingsupportY)/2+mountdimY/2,0]){
cube([mountdimX,mountdimY,height],center=true);}
}
translate([-(bearingdia+bearingsupportX*2)/2+offset,0,0])
cube([bearingdia+bearingsupportX*2,raildistance+bearingdia+bearingsupportY+1,height+1],center=true);
translate([0,raildistance/2,0]){
cylinder(d=bearingdia,h=height+1,center=true);}
translate([0,-raildistance/2,0]){
cylinder(d=bearingdia,h=height+1,center=true);}

translate([0,zipdistance/2,0]){
cube([bearingdia+bearingsupportX*2+1,ziptiedimY,ziptiedimZ],center=true);}
translate([0,-zipdistance/2,0]){
cube([bearingdia+bearingsupportX*2+1,ziptiedimY,ziptiedimZ],center=true);}

translate([0,0,zipdistanceZ/2]){
translate([0,zipdistance/2,0]){
cube([bearingdia+bearingsupportX*2+1,ziptiedimY,ziptiedimZ],center=true);}
translate([0,-zipdistance/2,0]){
cube([bearingdia+bearingsupportX*2+1,ziptiedimY,ziptiedimZ],center=true);}
}

translate([0,0,-zipdistanceZ/2]){
translate([0,zipdistance/2,0]){
cube([bearingdia+bearingsupportX*2+1,ziptiedimY,ziptiedimZ],center=true);}
translate([0,-zipdistance/2,0]){
cube([bearingdia+bearingsupportX*2+1,ziptiedimY,ziptiedimZ],center=true);}
}

translate([0,(raildistance+bearingdia+bearingsupportY)/2+ziptiedimY/2,0]){
cube([bearingdia+bearingsupportX*2+1,ziptiedimY,ziptiedimZ],center=true);}

translate([0,(raildistance+bearingdia+bearingsupportY)/2+mountdimY/2,screwdistance/2]){
rotate([0,90,0]){
cylinder(d=screwdia,h=bearingdia+bearingsupportX*2+1,center=true);
translate([0,0,-mountdimX+nutdepth]){
cylinder(d=M4_nutdia,h=bearingdia+bearingsupportX*2,center=true,$fn=6);
}}}
translate([0,(raildistance+bearingdia+bearingsupportY)/2+mountdimY/2,-screwdistance/2]){
rotate([0,90,0]){
cylinder(d=screwdia,h=bearingdia+bearingsupportX*2+1,center=true);
translate([0,0,-mountdimX+nutdepth]){
cylinder(d=M4_nutdia,h=bearingdia+bearingsupportX*2,center=true,$fn=6);
}}}

}
}





module stringshorterA(){
mountX=armA_mountX;
mountY=armA_mountY;
screwdia=4.2;
screwdistance=15;
adjustlength=10;
adjustsupport=2;
ziptiedim=6;
ziptiedepth=mountX/2;

neckdia=8.4;




difference(){
hull(){
cube([mountX,mountY,height],center=true);
translate([0,mountY/2+height/2,0])rotate([0,90,0])cylinder(d=height,h=mountX,center=true);
}
//screwholes
translate([0,screwdia/2+(adjustlength-mountY)/2+adjustsupport,0]){
hull(){
translate([0,0,screwdistance/2]){
translate([0,adjustlength/2,0])rotate([0,90,0])cylinder(d=screwdia,h=mountX+1,center=true); 
translate([0,-adjustlength/2,0])rotate([0,90,0])cylinder(d=screwdia,h=mountX+1,center=true);
}}
hull(){
translate([0,0,-screwdistance/2]){
translate([0,adjustlength/2,0])rotate([0,90,0])cylinder(d=screwdia,h=mountX+1,center=true); 
translate([0,-adjustlength/2,0])rotate([0,90,0])cylinder(d=screwdia,h=mountX+1,center=true);
}}
}

//ziptie cutout
translate([-ziptiedepth/2,-mountY/2+adjustlength/2,0]){
cube([ziptiedepth,mountY,ziptiedim],center=true);}

translate([0,mountY/2+height/2,0])rotate([0,90,0]){
cylinder(d=neckdia,h=mountX+1,center=true);
translate([0,0,mountX/2])cylinder(d=M8_nutdia,h=mountX,center=true,$fn=6);
}
}
}



module stringshorterB(){

mountX=armB_mountX;
mountY=armB_mountY;
screwdia=4.2;
screwdistance=15;

ziptiedim=6;
ziptiedepth=mountX/2;

boltdia=8.4;


difference(){
union(){
translate([0,mountY/2,0])cube([mountX,mountY,height],center=true);
translate([0,0,0])rotate([0,90,0])cylinder(d=height,h=mountX,center=true);
translate([0,mountY,0])rotate([0,90,0])cylinder(d=height,h=mountX,center=true);
}
translate([0,0,0])rotate([0,90,0])cylinder(d=boltdia,h=mountX+1,center=true);
translate([0,mountY,0])rotate([0,90,0])cylinder(d=boltdia,h=mountX+1,center=true);


}
}

//model orientation
if(orientation==1){
color(actcolor)carriage();

translate([bearingdia/2+bearingsupportX+armA_mountX/2,adjust,0])color(actcolor)stringshorterA();
translate([bearingdia/2+bearingsupportX-armB_mountX/2,armA_mountY/2+height/2+adjust,0]){
rotate([120,0,0]){
color(actcolor)stringshorterB();
}}
color(basecolor){
translate([0,raildistance/2,-height/2])linear_bearing();
translate([0,-raildistance/2,-height/2])linear_bearing();
}
}
//print orientation
if(orientation==2){
    
 //   translate([0,0,0])rotate([0,90,0])color(actcolor)carriage();
    translate([0,0,0])rotate([0,90,0])color(actcolor)stringshorterA();
   // translate([80,0,0])rotate([0,90,0])color(actcolor)stringshorterB();
    
}
}

//stringshorter(2);