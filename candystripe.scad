// "A Pile of Peppermint"
d = 6;
l = 120;
turns = 4;
sticks = 50;

$fn=60;

if (sticks == 1) {
  translate([0,0,-l/2]) peppermint_stick();  
} else {
  rs = rands(-90,+90,sticks*4,0);
  for(i=[0:1:sticks-1]) 
    translate([rs[i*4+0],rs[i*4+1],d/2]) 
      rotate([90+rs[i*4+2]/10,0,2*rs[i*4+3]]) 
        peppermint_stick();
}

module peppermint_stick() {
  //translate([d*2,0,0]) 
  color([1,0,0]) render() intersection() {
    stripes();
    squished_ends(d=d,l=l);
  }
  color([1,1,1]) render() difference() {
    squished_ends(d=d,l=l);
    stripes();
  }
}

module stripes() {
  linear_extrude(height=l, twist=360*turns, slices=180, convexity=10)
    union() {
      for(a_w = [[0,70],[150,10],[180,30],[210,10]])
        rotate(a_w[0]) {
          x = cos(a_w[1]/2);
          y = sin(a_w[1]/2);
          polygon([d/20*[x,y],d/2*[x,y],[d,0],d/2*[x,-y],d/20*[x,-y]]); 
        }
    }
}

module squished_ends(d,l,squish=0.5) {
  hull() {
    translate([0,0,l-squish*d/2]) scale([1,1,squish]) sphere(d=d); 
    scale([1,1,squish]) translate([0,0,d/2]) sphere(d=d);
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