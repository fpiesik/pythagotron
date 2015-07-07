module pulleymount(){
stepperwidth=35.5;
stepperdepth=28;
width=roddistance+roddia;
steppersupport=width;
centerhole=8.3;
height=centerhole*2;
depth=roddia*2;
screwdia=4;
screwdistance=26;
offset=0;


rotate([0,0,0]){
difference(){
union(){

//--------------------------
cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}

}
translate([offset,(stepperdepth/2)-depth/2+steppersupport,0]){
cube([stepperwidth,stepperdepth,stepperwidth+1],center=true);}

translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}

translate([roddistance/2,roddia,0]){
cube([roddia,depth,height+1],center=true);}
translate([-roddistance/2,roddia,0]){
cube([roddia,depth,height+1],center=true);}

translate([offset,0,0]){
rotate([90,0,0]){
cylinder(d=centerhole,h=depth*2,center=true);
}
}
}

}
}