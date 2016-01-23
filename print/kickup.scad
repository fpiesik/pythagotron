include <configuration.scad>;
include <extra/configuration.scad>;
include <extra/bolt_nut.scad>;

module kickup(orientation){

 
hub=4;

top=4;

magdia=5.7;
magZ=20;
magscrewdia=4.8;
magthreadZ=5;

bottom=magZ-hub+1;


coildia=14;
upperidlerZ=2;
loweridlerZ=2;
threaddepth=4;
coilZ=18; //magZ-bottom+threaddepth;
echo(coilZ);
magholedia=magdia;
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
jackY=3.5;
jackZ=10;
jacksupport=2;
jackpindia=1.5;
jackpindist=2.54;
jackpinsupport=1.5;

mountdepth=roddia*3;
mountsupportY=2;

$fn=32;

module solenoid(){


module Ccube( size, align = [ 0, 0, 0 ] ){
 translate(size/2*[[align[0],0,0],[0,align[1],0],[0,0,align[2]]])
  cube( size, center = true );
}

module base(){
difference(){
Ccube([baseX,baseY,magthreadZ],[0,0,1]);
cylinder(d=magscrewdia,h=baseZ+1);
}
translate([0,0,magthreadZ]){
difference(){
Ccube([baseX,baseY,baseZ],[0,0,1]);
translate([0,0,bottom])Ccube([innerX,innerY,innerZ],[0,0,1]);
cylinder(d=magdia,h=baseZ+1);
}}

translate([0,-(baseY/2+(jackY+jacksupport)/2),0]){
difference(){
translate([0,0,0])Ccube([jackX+jacksupport*2,jackY+jacksupport,jackZ],[0,0,1]);
translate([0,jacksupport/2,0])Ccube([jackX,jackY,jackZ-jackpinsupport],[0,0,1]);
translate([jackpindist/2,jacksupport/2,0])cylinder(d=jackpindia,h=jackZ);
translate([-jackpindist/2,jacksupport/2,0])cylinder(d=jackpindia,h=jackZ);
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
translate([0,0,bottom+threaddepth])rotate([0,0,0])coil();
}

if(orientation==2){
base();
//translate([25,0,0])rotate([0,0,0])coil();
}

}

module kickupmount(){

height=6;
depth=mountdepth;
width=roddistance+roddia;
servowidth=33;
servodepth=15.5;
supportX=8;
supportY=mountsupportY;



ziptieX=3;
ziptieY=6;

offsetY=10;

rotate([0,0,0]){
difference(){
union(){


cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([0,offsetY,0]){
cube([servodepth+supportX*2,depth,height],center=true);
}}
translate([0,baseZ-depth/2+supportY,height/2]){
cube([servodepth,baseZ*2,height],center=true);



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
translate([0,0,0]){
translate([servodepth/2+supportX/2,0,0]){
cube([ziptieX,ziptieY,height+1],center=true);}
translate([-(servodepth/2+supportX/2),0,0]){
cube([ziptieX,ziptieY,height+1],center=true);}
}
}
}
}

if(orientation==1){
color(actcolor)translate([0,-mountdepth/2+mountsupportY,baseX/2])rotate([-90,90,0])solenoid();
color(basecolor)kickupmount();
color(boltcolor)translate([0,baseZ/2+-mountdepth/2+mountsupportY,baseX/2])rotate([-90,0,0])bolt(4,30);
}
if(orientation==2){
//color(actcolor)translate([0,-40,0])rotate([-90,0,0])solenoid();
color(basecolor)kickupmount();

}
}

//kickup(2);

module cap(){
i_dia=10;
o_dia=14;
//headZ=4;
difference(){
union(){
difference(){
sphere(d=o_dia);
translate([0,0,-o_dia/2])cube([o_dia,o_dia,o_dia],center=true);}
translate([0,0,-i_dia/2])cylinder(d=o_dia,h=i_dia/2);
}
translate([0,0,-i_dia/2])cylinder(d=i_dia,h=i_dia/2);
}
}
//cap();