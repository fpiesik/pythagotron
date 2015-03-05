pivotdia=20;
width=35;
roddia=10.5;
roddistance=60;

screedlength=120;
type=2;
screedheight=18;

screedholelength=15;

tuneroddia=8.3;
tunerodholelength=pivotdia;
tunerodPosY=-screedlength/2+pivotdia/2;

stiffroddia=6.5;

pivotoffset=0;



stringholedia1=2;
stringholedia2=3.5;
stringholedia3=3.5;
stringholenumber=6;
stringholespread=5;



$fn=64;

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



module screed(){
difference(){
//base
union(){
if (type==1){
translate([0,-screedlength/2+pivotdia/2,screedheight]){
rotate([0,90,0]){
cylinder(d=pivotdia,h=width,center=true);}}}
translate([0,pivotoffset,screedheight/2]){
cube([roddistance,screedholelength+roddia*2,screedheight],center=true);
translate([roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2,h=screedheight,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2,h=screedheight,center=true);}
}


translate([0,0,screedheight/2]){
cube([width,screedlength+tunerodholelength,screedheight],center=true);}

}
translate([width/2-stiffroddia,0,screedheight/2]){
rotate([90,0,0]){
cylinder(d=stiffroddia,h=screedlength+tunerodholelength+1,center=true);
}}

translate([-width/2+stiffroddia,0,screedheight/2]){
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
//stringhole

for(y=[0:stringholenumber-1]){
scale([1,1,1]){
translate([0,screedlength/2-stringholespread*y,screedheight/2]){{
cylinder(d1=stringholedia1,d2=stringholedia2,h=screedheight+1,center=true,$fn=16);
cylinder(d=stringholedia3,h=screedheight+1,center=true,$fn=16);}}}}



//tunerodhole
translate([0,-screedlength/2+pivotdia/2,0]){

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
//stringhole
for(y=[0:stringholenumber-1]){
scale([1,1,1]){
translate([0,screedlength/2-stringholespread*y,screedheight/2]){{
cylinder(d1=stringholedia1,d2=stringholedia2,h=screedheight+1,center=true,$fn=16);
cylinder(d=stringholedia3,h=screedheight+1,center=true,$fn=16);}}}}

}

}


//tunerodfix--------------------------------------------------------------------------
module tunerodfix(){
rotate([180,0,0]){
difference(){
translate([0,0,pivotdia/4]){
cube([width,pivotdia+2,pivotdia/2],center=true);}
translate([0,0,-pivotdia/4]){
rotate([0,90,0]){
cylinder(d=pivotdia,h=width+1,center=true);}}
//translate([0,0,pivotdia-2.5])cylinder(d=tuneroddia*2,h=5,center=true,$fn=6);
cylinder(d=tuneroddia,h=pivotdia*2,center=true);

}}}

//spacer--------------------------------------------------------------------------
module spacer(){
height=6;

difference(){
union(){
linear_extrude(height = height, center = true, convexity = 0){
polygon(points=[[-tuneroddia,tunerodPosY-tuneroddia],
				[tuneroddia,tunerodPosY-tuneroddia],
				
				[roddistance/2+roddia,-roddia],				
				[roddistance/2+roddia,0],
				
				[roddistance/2-roddia,0],				
				[roddistance/2-roddia,-roddia],

				[tuneroddia,tunerodPosY+tuneroddia*1.5],
				[-tuneroddia,tunerodPosY+tuneroddia*1.5],

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
translate([0,tunerodPosY,0]){
cylinder(d=tuneroddia,h=screedheight+pivotdia,center=true);
translate([0,-tuneroddia*2,0]){
cube([tuneroddia,tuneroddia*4,height],center=true);}}
}
}


//------------------------coil----------------------------------
coilheight=17;
coilwidth=20;
upperidlerheight=2;
loweridlerheight=5;
magdia=5.5;
wallthick=0.5;
cableholedia=2;
coilthreadwidth=4;
threaddepth=5;

module coil(){
difference(){
union(){
cylinder(d=magdia+wallthick*2,h=coilheight,center=true);
translate([0,0,coilheight/2-upperidlerheight/2]){
cylinder(d=coilwidth,h=upperidlerheight,center=true);}
translate([0,0,-(coilheight/2-loweridlerheight/2)]){
cylinder(d=coilwidth,h=loweridlerheight,center=true);}
}
translate([0,0,loweridlerheight]){
cylinder(d=magdia,h=coilheight,center=true);}
cylinder(d=coilthreadwidth,h=coilheight+1,center=true);
translate([coilwidth/2-cableholedia,0,-(coilheight/2-loweridlerheight/2)]){
cylinder(d=cableholedia,h=loweridlerheight+1,center=true);}
}}

//--------------------coilmount--------------------------------
module coilmount(){

height=9;
depth=roddia*2;
width=roddistance+roddia;
screwdia=4;
jackmountheight=3;
jackmountwidth=25;
jackmountlength=20;
jackmountoffset=width/2-jackmountwidth/2;
jackdia=10;
rotate([0,0,0]){
difference(){
union(){

//jackmount

difference(){
union(){
translate([jackmountoffset,-jackmountlength/2-depth/2,jackmountheight/2-height/2]){
cube([jackmountwidth,jackmountlength,jackmountheight],center=true);
translate([0,-jackmountlength/2,0]){
cylinder(d=jackmountwidth,h=jackmountheight,center=true);}}}
translate([jackmountoffset,-jackmountlength/2-depth/2,jackmountheight/2-height/2]){
translate([0,-jackmountwidth/2,0]){
cylinder(d=jackdia,h=jackmountheight+1,center=true);}}}

//--------------------------
cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
}
translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
rotate([90,0,0]){
cylinder(d=screwdia,h=depth+1,center=true);}

translate([0,depth/2,0]){
cube([coilwidth+2,depth,roddia],center=true);}

translate([roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}


}

}
}
//servomount----------------------------------------------------------------
module servomount(){

height=9;
depth=roddia*3;
width=roddistance+roddia;
screwdia=3;
screwnumber=2; //one or two screws
screwdistance=10; //if two screws
servowidth=40.5;
servodepth=20.5;
servosupportX=8;
servosupportY=8;


offsetY=-15;

rotate([0,0,0]){
difference(){
union(){


cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([0,offsetY,0]){
cube([servodepth+servosupportX*2,servowidth+servosupportY*2,height],center=true);
}}
translate([0,offsetY,0]){
cube([servodepth,servowidth,height+1],center=true);

if (screwnumber==1){
translate([0,servowidth/2+servosupportY/2,0]){
cylinder(d=screwdia,h=height+1,center=true);}
translate([0,-(servowidth/2+servosupportY/2),0]){
cylinder(d=screwdia,h=height+1,center=true);}
}

if (screwnumber==2){
translate([screwdistance/2,0,0]){
translate([0,servowidth/2+servosupportY/2,0]){
cylinder(d=screwdia,h=height+1,center=true);}
translate([0,-(servowidth/2+servosupportY/2),0]){
cylinder(d=screwdia,h=height+1,center=true);}
}
translate([-screwdistance/2,0,0]){
translate([0,servowidth/2+servosupportY/2,0]){
cylinder(d=screwdia,h=height+1,center=true);}
translate([0,-(servowidth/2+servosupportY/2),0]){
cylinder(d=screwdia,h=height+1,center=true);}
}
}

}

translate([0,-depth/2+roddia,0]){
translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}

translate([roddistance/2,depth/2,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,depth/2,0]){
cube([roddia,depth,roddia],center=true);}
}

}

}
}


//pcbmount-------------------------------------------------------------
module pcbmount(){

pcbX=93.5;
pcbY=49.5;
pcbZ=4;

height=pcbY;
depth=roddia*1;
width=roddistance+roddia*2;
screwdia=4;

support=3;


rotate([0,0,0]){
difference(){
union(){


cube([width,depth,height],center=true);


translate([0,-depth/2-(pcbZ+support*2)/2,0]){
cube([pcbX+support*2,pcbZ+support*2,height],center=true);}



}

translate([0,-depth/2-(pcbZ+support*2),0]){
cube([pcbX-support*2,(pcbZ+support*2),height],center=true);}

translate([0,-depth/2-pcbZ/2-support,0]){
cube([pcbX,pcbZ,height],center=true);}

translate([0,0,0]){
cube([width-roddia*4,depth,height],center=true);}

translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}

translate([roddistance/2,depth/2,0]){
cube([roddia,depth,height+1],center=true);}
translate([-roddistance/2,depth/2,0]){
cube([roddia,depth,height+1],center=true);}


}

}

}

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

//------------pulleymount-----------------

module pulleymount(){
stepperwidth=35.5;
stepperdepth=28;
steppersupport=5;
centerhole=8.3;
height=centerhole*2;
depth=roddia*2;
width=roddistance+roddia;
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

//---------------railmount-------------------
module railmount(){

height=9;
depth=roddia*2;
width=roddistance+roddia;
raildia=10.3;

raildistance=30;


supportX=12;
supportY=8;

cutoutX=45;
cutoutY=13.5;


offsetY=0;

rotate([0,0,0]){
difference(){
union(){

//--------------------------
cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}

translate([0,-raildistance/2,0]){
cube([cutoutX+supportX*2,raildistance+supportY,height],center=true);
translate([0,-raildistance/2,0]){
cylinder(d=raildia*2,h=height,center=true);}
}}
translate([0,-raildistance,height/2]){
cylinder(d=raildia,h=height,center=true);}


translate([0,0,height/2]){
cylinder(d=raildia,h=height,center=true);}

translate([0,-cutoutY/2-depth/2,0]){
cube([cutoutX,cutoutY,height+1],center=true);}

translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}

translate([roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}


}

}
}

//-------------carriage----------
module carriage(){
raildistance=30;
bearingdia=19;
height=29;
bearingsupportX=4;
bearingsupportY=2;
offset=3;
ziptiedimZ=5;
ziptiedimY=2.5;
zipdistance=8;
zipdistanceZ=19;
mountdimY=10;
mountdimX=6;
screwdia=4.2;
screwdistance=15;
nutdepth=2.5;
nutdia=8.3;




difference(){
union(){
cube([bearingdia+bearingsupportX*2,raildistance+bearingdia+bearingsupportY,height],center=true);
translate([(bearingdia+bearingsupportX*2)/2-mountdimX/2,(raildistance+bearingdia+bearingsupportY)/2+mountdimY/2,0]){
cube([mountdimX,mountdimY,height],center=true);}
}
translate([-(bearingdia+bearingsupportX*2)/2+offset,0,0])
cube([bearingdia+bearingsupportX*2,raildistance+bearingdia+bearingsupportY,height],center=true);
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
cylinder(d=nutdia,h=bearingdia+bearingsupportX*2,center=true,$fn=6);
}}}
translate([0,(raildistance+bearingdia+bearingsupportY)/2+mountdimY/2,-screwdistance/2]){
rotate([0,90,0]){
cylinder(d=screwdia,h=bearingdia+bearingsupportX*2+1,center=true);
translate([0,0,-mountdimX+nutdepth]){
cylinder(d=nutdia,h=bearingdia+bearingsupportX*2,center=true,$fn=6);
}}}

}
}

module bottleneck(){
height=29;
mountX=6;
mountY=30;
screwdia=4.2;
screwdistance=15;
adjustlength=20;
ziptiedim=6;
ziptiedepth=3;

neckdia=19.5;
neckholderX=15;
neckholderY=25;

rotate([0,90,0]){
translate([-mountX/2,0,0]){
difference(){
cube([mountX,mountY,height],center=true);


translate([0,0,screwdistance/2]){
translate([0,adjustlength/2,0]){
rotate([0,90,0]){
cylinder(d=screwdia,h=mountX+1,center=true);}} 
translate([0,-adjustlength/2,0]){
rotate([0,90,0]){
cylinder(d=screwdia,h=mountX+1,center=true);}}
cube([mountX+1,adjustlength,screwdia],center=true);
}

translate([0,0,-screwdistance/2]){
translate([0,adjustlength/2,0]){
rotate([0,90,0]){
cylinder(d=screwdia,h=mountX+1,center=true);}} 
translate([0,-adjustlength/2,0]){
rotate([0,90,0]){
cylinder(d=screwdia,h=mountX+1,center=true);}}
cube([mountX+1,adjustlength,screwdia],center=true);
}

translate([ziptiedepth/2,mountY/2-adjustlength/2,0]){
cube([ziptiedepth,mountY,ziptiedim],center=true);}
}
}

translate([-neckholderX/2,-mountY/2-neckholderY/2,0]){
difference(){
cube([neckholderX,neckholderY,height],center=true);
rotate([0,90,0]){
cylinder(d=neckdia,h=neckholderX+1,center=true);}}
}
}
}

module stringshorter(){
height=29;
mountX=8;
mountY=45;
screwdia=4.2;
screwdistance=15;
adjustlength=35;
adjustoffset=5;
ziptiedim=6;
ziptiedepth=mountX/2;

neckdia=8.4;


rotate([0,-90,0]){
translate([-mountX/2,0,0]){
difference(){
cube([mountX,mountY,height],center=true);


translate([0,0,screwdistance/2]){
translate([0,adjustlength/2,0]){
rotate([0,90,0]){
cylinder(d=screwdia,h=mountX+1,center=true);}} 
translate([0,-adjustlength/2,0]){
rotate([0,90,0]){
cylinder(d=screwdia,h=mountX+1,center=true);}}
cube([mountX+1,adjustlength,screwdia],center=true);
}

translate([0,0,-screwdistance/2]){
translate([0,adjustlength/2,0]){
rotate([0,90,0]){
cylinder(d=screwdia,h=mountX+1,center=true);}} 
translate([0,-adjustlength/2,0]){
rotate([0,90,0]){
cylinder(d=screwdia,h=mountX+1,center=true);}}
cube([mountX+1,adjustlength,screwdia],center=true);
}

translate([ziptiedepth/2,mountY/2-adjustlength/2,0]){
cube([ziptiedepth,mountY,ziptiedim],center=true);}
}
}

translate([-mountX/2,-mountY/2-height/2,0]){
difference(){
union(){
rotate([0,90,0])cylinder(d=height,h=mountX,center=true);
translate([0,height/4,0]){
cube([mountX,height/2,height],center=true);}}
rotate([0,90,0]){
cylinder(d=neckdia,h=mountX+1,center=true);}}
}
}
}

module endstopmount(){
height=6;
depth=roddia*2;
width=roddistance+roddia;
screwdia=3;
screwdistance=9.5;
screwoffset=3;
rotate([0,0,0]){
difference(){
union(){

//jackmount



//--------------------------
cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
}
translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
rotate([90,0,0]){
translate([screwdistance/2+screwoffset,0,0]){
cylinder(d=screwdia,h=depth+1,center=true);}
translate([-screwdistance/2+screwoffset,0,0]){
cylinder(d=screwdia,h=depth+1,center=true);}
}




translate([roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}


}

}

}

module piezoplate(){
piezodia=27.5;
piezosupport=2;
piezosink=2;
height=15;
screwdia=4.5;
screwsink=8;

difference(){
cylinder(d2=piezodia+piezosupport*2,d1=piezodia/2,h=height);
translate([0,0,height-piezosink]){
cylinder(d=piezodia,h=height);}
translate([0,0,-height+screwsink]){
cylinder(d=screwdia,h=height);}
}
}

module piezoramp(){
piezodia=20;
piezosupport=2;
piezosink=2;
height=15;
screwdia=4.5;
screwsink=5;
width=10;
spread=6;


translate([0,spread/2,0]){
difference(){
sphere(d=piezodia);
translate([0,0,-piezodia/2]){
cube([piezodia*2,piezodia*2,piezodia],center=true);}
translate([piezodia/2+width/2,0,0]){
cube([piezodia,piezodia,piezodia],center=true);}
translate([-piezodia/2-width/2,0,0]){
cube([piezodia,piezodia,piezodia],center=true);}
}}
translate([0,-spread/2,0]){
difference(){
sphere(d=piezodia);
translate([0,0,-piezodia/2]){
cube([piezodia*2,piezodia*2,piezodia],center=true);}
translate([piezodia/2+width/2,0,0]){
cube([piezodia,piezodia,piezodia],center=true);}
translate([-piezodia/2-width/2,0,0]){
cube([piezodia,piezodia,piezodia],center=true);}
}}

}

module piezomount(){

height=10;
depth=roddia*3;
width=roddistance+roddia;
screwdia=4;
nutdia=8.3;
nutsink=3;
piezowidth=15;
offset=7.5;
jackmountheight=3;
jackmountwidth=25;
jackmountlength=20;
jackmountoffset=width/2-jackmountwidth/2;
jackdia=10;
rotate([0,0,0]){
difference(){
union(){

//jackmount

difference(){
union(){
translate([jackmountoffset,-jackmountlength/2-depth/2,jackmountheight/2-height/2]){
cube([jackmountwidth,jackmountlength,jackmountheight],center=true);
translate([0,-jackmountlength/2,0]){
cylinder(d=jackmountwidth,h=jackmountheight,center=true);}}}
translate([jackmountoffset,-jackmountlength/2-depth/2,jackmountheight/2-height/2]){
translate([0,-jackmountwidth/2,0]){
cylinder(d=jackdia,h=jackmountheight+1,center=true);}}}

//--------------------------
cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
}
translate([roddistance/2,-roddia/2,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,-roddia/2,0]){
cylinder(d=roddia,h=height+1,center=true);}
rotate([90,0,0]){
cylinder(d=screwdia,h=depth+1,center=true);
translate([0,0,-depth+nutsink]){
cylinder(d=nutdia,h=depth,center=true,$fn=6);}}

translate([0,-depth/2+offset,0]){
cube([piezowidth+2,depth,roddia],center=true);}

translate([roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}


}

}
}

module pick(){
$fn=16;
outerdia=12;
innerdia=5.5;
height=5;
length=31;
thickness=0.5;
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
translate([cutradius/2+thickness/2,length,0]){
cylinder(d=cutradius,h=height,$fn=64);}
translate([-cutradius/2-thickness/2,length,0]){
cylinder(d=cutradius,h=height,$fn=64);}
}
}


!screed();
spacer();
pivot();
tunerodfix();
coil();
coilmount();
servomount();
pcbmount();
steppermountB();
pulleymount();
railmount();
carriage();
bottleneck();
stringshorter();
endstopmount();
piezomount();
piezoramp();
piezoplate();
pick();


