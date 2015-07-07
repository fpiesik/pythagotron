module pick(){
    
    
   
 
$fn=16;
outerdia=12;
innerdia=5.5;
height=4;
length=30;
thickness=1;
skrewdia=3.5;
skrewsupport=2.5;
cutradius=180;

rotate([0,180,0])
difference(){
union(){
cylinder(d=outerdia,h=height);
translate([-outerdia/2,0,0]){
cube([outerdia,length,height]);}
}
cylinder(d=innerdia,h=height-skrewsupport);
cylinder(d=skrewdia,h=height);
translate([cutradius/2+thickness/2,length,-0.5]){
cylinder(d=cutradius,h=height+1,$fn=64);}
translate([-cutradius/2-thickness/2,length,-0.5]){
cylinder(d=cutradius,h=height+1,$fn=64);}
}
}
