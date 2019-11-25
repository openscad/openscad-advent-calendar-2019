$fa=1;
$fs=0.4;

function r(s) = rands(-s,s,1)[0];
function rp(s) = rands(0,s,1)[0];


module BowLoop(width, ang, offset) {
  rotate([0, 0, ang])
    translate([offset, 0, 0])
    rotate([90, 0, 0])
    rotate_extrude()
      hull() {
        translate([width/5, width/8])
          circle(width/36);
        translate([width/5, -width/8])
          circle(width/36);
      }
}


module Bow(width) {
  color("red") {
    scale([1, 1, 0.2]) {
      BowLoop(width, 30, width/3);
      BowLoop(width, 30, -width/3);
      BowLoop(width, -30, width/3);
      BowLoop(width, -30, -width/3);
      sphere(width/4);
    }
    scale([1, 1, 0.1]) {
      rotate([90, 0, 15])
        cylinder(d=width/3, h=width);
      rotate([90, 0, -15])
        cylinder(d=width/3, h=width);
    }
  }
}


module Needle(needle_len, needle_thick, y, ang) {
  needle_fluff = 15;
  rnd_len = needle_len/4;
  translate([0, y, 0])
  rotate([0, r(needle_fluff), ang])
    cube([needle_len-rp(rnd_len), needle_thick, needle_thick]);
}



module Leaf(length, width) {
  needle_ang = 45;
  needle_len = (width/2)/cos(needle_ang);
  needle_thick = needle_len/24;
  needle_count = round(length/(3*needle_thick));
  needle_step = (length)/needle_count;
  rnd_fact = needle_thick/2;
  color("green") {
    for(i=[0:needle_count-1]) {
      py=needle_step*i + needle_thick;
      Needle(needle_len, needle_thick, py+r(rnd_fact), needle_ang+r(5));
      Needle(needle_len, needle_thick, py+r(rnd_fact), 180-needle_ang+r(5));
    }

    Needle(needle_len, needle_thick, length, 90-(90-needle_ang)/2 + r(5));
    Needle(needle_len, needle_thick, length, 90+needle_ang/2 + r(5));
  }

  color("brown")
    rotate([0, 0, 90])
    translate([0, 0, 0.01])
    cube([length, needle_thick, needle_thick-0.02]);
}


module WreathLayer(thick, leaf_len, leaf_wid, a, leaf_ang) {
  rotate([0, r(40), 180+a+leaf_ang+r(10)])
    translate([0, -leaf_len, thick/4])
    Leaf(leaf_len, leaf_wid);
  rotate([0, r(40), 180+a-leaf_ang+r(10)])
    translate([0, 0, 0])
    Leaf(leaf_len, leaf_wid);
}


module Wreath(diam, thick=0) {
  thick = thick<=0 ? diam*2/9 : thick;
  leaf_ang = 45;
  for (a=[0:10:359.99]) {
    leaf_len = thick/cos(leaf_ang);
    leaf_wid = thick/(2*cos(leaf_ang));
    translate([diam/2*cos(a), diam/2*sin(a), 0]) {
      WreathLayer(thick, leaf_len, leaf_wid, a, leaf_ang);
      translate([0, 0, thick/4])
        WreathLayer(thick, leaf_len, leaf_wid, a, leaf_ang);
    }
  }
  
  translate([0, (diam-thick)/2, thick*0.7])
    Bow(1.5*thick);

  colors = ["gold", "red", "blue", "silver"];
  ball_cnt = floor(rp(3.999)+3);
  for (i=[60:300/ball_cnt:359.99]) {
    a = rp(240/ball_cnt)+i+60;
    br = diam/2 - rp(thick/2);
    color(colors[rp(len(colors))])
      translate([br*cos(a), br*sin(a), thick*3/4])
      sphere(r=thick/4);
  }
}


Wreath(90);


// Written in 2019 by Ryan A. Colyer
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

