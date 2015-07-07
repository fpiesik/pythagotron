include <configuration.scad>;
include <extra/configuration.scad>;
include <extra/bolt_nut.scad>;

module kickup(orientation){

 
hub=4;
bottom=6;
top=6;

magdia=5.2;
magZ=20;
magscrewdia=3;

coildia=14;
upperidlerZ=2;
loweridlerZ=2;
threaddepth=4;
coilZ=magZ-bottom+threaddepth;
magholedia=5.7;
wallthick=1;
coilthreaddia=4.9;

rampZ=3;
rampdia=coildia;


innerX=15;
innerY=16;
innerZ=coilZ+hub;

baseX=22;
baseY=15;
baseZ=innerZ+bottom+top;
echo(baseZ);


jackX=6.5;
jackY=3;
jacksupport=2;
jackpindia=1.5;
jackpindist=2.54;
jackpinsupport=1.5;


$fn=32;

module solenoid(){


module Ccube( size, align = [ 0, 0, 0 ] ){
 translate(size/2*[[align[0],0,0],[0,align[1],0],[0,0,align[2]]])
  cube( size, center = true );
}

module base(){
difference(){
Ccube([baseX,baseY,baseZ],[0,0,1]);
translate([0,0,bottom])Ccube([innerX,innerY,innerZ],[0,0,1]);
cylinder(d=magdia,h=baseZ+1);
translate([0,0,bottom/2]){
rotate([0,90,0])cylinder(d=magscrewdia,h=baseX+1,center=true);}
}

translate([0,-(baseY/2+(jackY+jacksupport)/2),0]){
difference(){
translate([0,0,0])Ccube([jackX+jacksupport*2,jackY+jacksupport,bottom],[0,0,1]);
translate([0,jacksupport/2,0])Ccube([jackX,jackY,bottom-jackpinsupport],[0,0,1]);
translate([jackpindist/2,jacksupport/2,0])cylinder(d=jackpindia,h=bottom);
translate([-jackpindist/2,jacksupport/2,0])cylinder(d=jackpindia,h=bottom);
}}


}



module coil(){
difference(){
union(){
cylinder(d=magholedia+wallthick*2,h=coilZ);
translate([0,0,loweridlerZ])cylinder(d1=rampdia,d2=magholedia+wallthick*2,h=rampZ);
translate([0,0,coilZ-upperidlerZ-rampZ])cylinder(d2=rampdia,d1=magholedia+wallthick*2,h=rampZ);
translate([0,0,coilZ-upperidlerZ])cylinder(d=coildia,h=upperidlerZ);
//Ccube([coildia,coildia,upperidlerZ],[0,0,1]);
translate([0,0,0]){
Ccube([coildia,coildia,loweridlerZ],[0,0,1]);

}
}
translate([0,0,threaddepth]){
cylinder(d=magholedia,h=coilZ);}
cylinder(d=coilthreaddia,h=coilZ+1);
}}

if(orientation==1){
base();
translate([0,0,bottom])rotate([0,0,0])coil();
}

if(orientation==2){
base();
translate([25,0,0])rotate([0,0,0])coil();
}

}

module kickupmount(){

height=6;
depth=roddia*3;
width=roddistance+roddia;
screwdia=3;
screwnumber=2; //one or two screws
screwdistance=10; //if two screws
servowidth=33;
servodepth=15.5;
servosupportX=8;
servosupportY=8;
sink=2;

ziptieX=3;
ziptieY=6;

offsetY=15;

rotate([0,0,0]){
difference(){
union(){


cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([0,offsetY,0]){
cube([servodepth+servosupportX*2,servowidth,height],center=true);
}}
translate([0,baseZ/2,height/2]){
cube([servodepth,baseZ,height],center=true);



}


translate([0,depth/2-roddia,0]){

translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}

translate([roddistance/2,-depth/2,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,-depth/2,0]){
cube([roddia,depth,roddia],center=true);}

}
translate([0,offsetY,0]){
translate([servodepth/2+servosupportX/2,0,0]){
cube([ziptieX,ziptieY,height+1],center=true);}
translate([-(servodepth/2+servosupportX/2),0,0]){
cube([ziptieX,ziptieY,height+1],center=true);}
}
}
}
}

if(orientation==1){
color(actcolor)translate([0,0,baseX/2])rotate([-90,90,0])solenoid();
color(basecolor)kickupmount();
color(boltcolor)translate([0,baseZ/2,baseX/2])rotate([-90,0,0])bolt(4,30);
}
if(orientation==2){
color(actcolor)translate([0,-40,0])rotate([0,0,0])solenoid();
color(basecolor)kickupmount();

}
}

//kickup(2);

