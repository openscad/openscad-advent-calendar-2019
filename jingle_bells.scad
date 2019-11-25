$fs = 0.5;
$fa = 1;

d = 30;
th = 1;
lipH = 2;
ringR = 2.5;// major radius
ringD = 1;  // minor diameter
slotW = 3;
slotAngle = 120;
slotEndD = 6;
numBells = 3;

silver = [0.84,0.87,0.95];

if (numBells == 1) {
  jingle_bell();
} else {
  rs = rands(-20,20,3*numBells);
  for(i=[0:1:numBells-1]) 
    translate([(i+1/2)*d*1.5,0]) rotate([rs[i*3+0],rs[i*3+1],rs[i*3+2]]) 
      translate([0,0,-d/2-2*ringR+ringD]) jingle_bell();
}

module hemisphere(d,th,lipH) {
  difference() {
    sphere(d=d);    
    translate([0,0,-(d+2)/2]) cube(d+2, center=true);
    sphere(d=d-2*th);
  }
}

module jingle_bell() {
  bellTop(d,th);
  rotate([180,0,0]) translate([0,0,lipH]) 
    bellBottom(d-th*2-0.1,th,slotW,slotAngle,slotEndD);
}

module bellTop(d,th) {
  color(silver) {
    union() {
      hemisphere(d,th);
      // bead / lip
      rotate_extrude() translate([d/2-th,-lipH/2,0]) intersection() {
        ratio = 0.75;
        translate([0,-lipH/2]) square([lipH,lipH*2]);
        difference() {
          offset(r=th) scale([ratio,1]) circle(d=lipH);
          scale([ratio,1]) circle(d=lipH);
        }
      }
      translate([0,0,d/2-th/2]) { 
        cylinder(d=ringD*1.5,h=th/2+ringD*1.5, $fn=20);      // ring base
        translate([0,0,ringR+ringD/4+th/2]) rotate([90,0,90]) // top ring
          rotate_extrude() 
            translate([ringR-ringD/2,0,0]) circle(d=ringD,$fn=20);
      }
    }
  }
}

module bellBottom(d, th, slotW, slotAngle, slotEndD) {
  color(silver) {
    difference() {
      union() {
        hemisphere(d,th);
        rotate_extrude() translate([d/2,0,0]) {
          ratio = 0.75;
          translate([-th,-lipH]) square([th,lipH]);
          translate([0,-lipH/2]) {
            scale([ratio,1]) circle(d=lipH);
          }
        }
      }
      cube([slotW,d*sin(slotAngle/2),d], center=true);    // slots
      rotate(90) cube([slotW,d*sin(slotAngle/2),d], center=true);
      for(a=[0:90:270]) // circular slot ends
        rotate([slotAngle/2,0,a]) 
          cylinder(d=slotEndD,h=d);
    }
  }
}

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