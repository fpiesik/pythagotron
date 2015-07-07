module steppermountA(){
stepperwidth=43; //nema14=35.5 
stepperdepth=200;
steppersupport=5;
height=stepperwidth;
depth=roddia*2;
width=roddistance+roddia;
centerhole=24;
screwdia=4;
screwdistance=31; //nema14=26
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
translate([screwdistance/2,screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
translate([-screwdistance/2,screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
translate([screwdistance/2,-screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
translate([-screwdistance/2,-screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
cylinder(d=centerhole,h=depth*2,center=true);
}
}
}

}
}

module steppermountB(){
stepperwidth=43; //nema14=35.5 
stepperdepth=0;
steppersupport=3;
height=10;
depth=roddia*3;
width=roddistance+roddia;
centerhole=24;
screwdia=4;
screwdistance=31; //nema14=26
offset=-24;


rotate([0,0,0]){

difference(){
union(){

//--------------------------
cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}

translate([0,offset,0]){
cube([stepperwidth+steppersupport*2,stepperwidth,height],center=true);}

}

translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}




translate([roddistance/2,depth/2,0]){
cube([roddia,depth,height+1],center=true);}
translate([-roddistance/2,depth/2,0]){
cube([roddia,depth,height+1],center=true);}

rotate([-90,0,0]){
translate([0,-height/2,offset]){
cube([stepperwidth,height,stepperwidth+1],center=true);}


translate([0,0,offset]){
rotate([90,0,0]){
translate([screwdistance/2,screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
translate([-screwdistance/2,screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
translate([screwdistance/2,-screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
translate([-screwdistance/2,-screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
cylinder(d=centerhole,h=depth*2,center=true);
}
}
}
}
}
}