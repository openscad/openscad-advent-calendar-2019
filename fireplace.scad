// View -> Animate | 10 fps, 40 steps
// convert -delay 2 -loop 0 frame0*.png -scale 240x240 fireplace.gif

$fn = 20;

w=2;
h=3;
d=2;
a=0.3;

flames = 32;
seed = 9;

function points(toff) = [
  for(i=[0:1:$fn-1]) let(t=i/($fn-1)) [t*w/2+(1-t)*a*sin(360*(toff+$t+2*t)),(1-t)*h],
  for(i=[$fn-1:-1:0]) let(t=i/($fn-1)) [-t*w/2+(1-t)*a*sin(360*(toff+$t+2*t)),(1-t)*h]
];

colsg = rands(0, 1, flames, seed);
posxs = rands(-2*w, +2*w, flames, colsg[0]);
scales = rands(0.75,1.5, flames, posxs[0]);
rots = rands(-10,10,flames,scales[0]);
ts = rands(0, 1, flames, rots[0]);

module log() {
  color([0.4,0.2,0.07]) rotate([0,90]) {
    cylinder(d=d, h=10.5, center=true, $fn=30);
  }
}

module fire() {
  for (i=[0:1:flames-1]) {
    sweep=60;
    y=sweep-sweep*2*i/(flames-1);
    translate([posxs[i],d/2*sin(y),d/2*cos(y)-d/10]) 
      color([1,colsg[i]*colsg[i],0,0.25]) 
        rotate([90,0,rots[i]]) linear_extrude(0.1) 
            scale(scales[i]) polygon(points(ts[i]));
  }
}

module bricks() {
  brick_color = [0.4,0.1,0.1];
  difference() {
    color(brick_color) translate([-10,-5,0]) cube([20,10,16]);
    color(0.2*brick_color) translate([-6,-6,-0.1]) cube([12,9,10]);  
  }
}

module holder_profile(size) {
  scale([1.5,1]) rotate(45) square(size, center=true);
}

module bent_profile(width, l_bent, a_bent, r_bent, profile_size) {
  union() {
    // main length
    rotate([90,0,0]) linear_extrude(width,center=true) 
      holder_profile(profile_size);
    // bent length
    for(i=[0,1]) mirror([0,i]) {
      translate([0,width/2,r_bent])
        rotate([-90+a_bent,0,0]) translate([0,r_bent,0])
        linear_extrude(l_bent) 
          holder_profile(profile_size);
      translate([0,width/2,r_bent])
        rotate([0,90]) rotate_extrude(angle=a_bent) translate([r_bent,0,0]) rotate(90) 
          holder_profile(profile_size);
    }
  }
}

module log_holder(width,depth,height,s) {
  holder_color = [0.4,0.4,0.4];
  leg_height = height-1*s;
  leg_angle = 75;
  leg_length = leg_height/s*sin(leg_angle);
  color(holder_color) { 
    for(i=[-0.5,-0.3,-0.1,0.1,0.3,0.5]) translate([i*width*0.8,0,height])
      scale(s) bent_profile(20, 7, 30, 1.5, 1);
    for(y=[-depth/2,depth/2]) 
    translate([0,y,leg_height]) rotate([0,180,90]) scale(s) 
      bent_profile(40,leg_length,leg_angle,1.5,1);
 }
}

module fireplace() {
    log_holder(10,4,1.9,0.2);

    translate([0,1,0]) bricks();
    rotate(-2) translate([0,0,3]) {
      log();
      fire();
    }
}

fireplace();

// Written in 2019 by Hans Loeblich <thehans@gmail.com>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
