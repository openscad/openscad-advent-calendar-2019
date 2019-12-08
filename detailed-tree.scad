$fa=1;
$fs=0.4;

anim = false;
leaf_width = 3;
ball_density = 0.3;
ball_rad = 2;
height = 70;
diam = 30;

seed = -1;  // Random
//seed = 10;  // Selected
if (seed >= 0) {
  _ = rands(0,1,0,seed);
}

function r(s) = rands(-s,s,1)[0];
function rp(s) = rands(0,s,1)[0];

function MakeSparkles() = [for (i=[0:rp(10)+20])
  [asin(r(1)), rp(360), rp(0.2*diam)+0.1*diam]];
$staron = true;
$sparkles = MakeSparkles();


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
    for (i=[0:needle_count-1]) {
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


module Branch(length) {
  color("brown")
    cylinder(r1=0.01*length, r2=0.005*length, h=length);
  leaf_count = length * 1.3;
  for (i=[0:leaf_count-1]) {
    leaf_len = length / 8 + (1-i/leaf_count) * length / 8;
    translate([0, 0, length*(i+1-rp(1))/leaf_count])
      rotate([0, 0, rp(360)])
      rotate([r(15)+55, 0, 0])
      rotate([0, rp(360), 0])
      Leaf(leaf_len, leaf_width);
  }
}


module Star(rad) {
  star_color = $staron ? "yellow" : "white";
  color(star_color)
  for (a=[0:360/5:359.99]) {
    rotate([0, a, 0])
      translate([0, 0, -0.001])
      linear_extrude(height=rad, scale=0)
      scale([1, 0.4])
      rotate(45)
      square(3/5*rad, center=true);
  }

  if ($staron) {
    for (s=$sparkles) {
      color(star_color)
        rotate([0, s[0], s[1]])
        translate([rad, 0, 0])
        cube([s[2], 0.1, 0.1]);
    }
  }
}


module Ball(rad) {
  colors = ["gold", "red", "blue", "silver"];
  color(colors[rp(len(colors))])
    sphere(r=rad);
}


module Tree(height, diam) {
  color("brown")
    cylinder(r1=0.05*diam, r2=0.01*diam, h=height);
  branch_count = height * 1.4;
  trunk_base = round(height / 10);
  ball_skip = round(1/ball_density);
  ball_prob = ball_density*ball_skip;
  for (i=[trunk_base:branch_count-1]) {
    branch_h = diam*(1-0.5*i/branch_count);
    branch_a = asin(i/(branch_count-1)) + rp(15);
    translate([0, 0, height*(i+1-rp(1))/branch_count])
      rotate([90-branch_a, 0, (i%4)*90+rp(90)]) {
        Branch(branch_h);
        if ((i%ball_skip == 0) && (rp(1) < ball_prob)) {
          translate([r(branch_h/8), -ball_rad, branch_h*sqrt(rp(1))])
            Ball(ball_rad);
        }
      }
  }

  translate([0, 0, height+(1/2+1/8)*diam])
    Star(0.2*diam);
}


module RotateTree(height, diam) {
  _sparkles = rands(0,1,1,$t);
  $staron = round($t*10)%2 == 0;
  $sparkles = MakeSparkles();

  seed = seed < 0 ? 10 : seed;
  _ = rands(0,1,0,seed);

  rotate([0, 0, $t*360])
    Tree(height, diam);
}

if (anim) {
  RotateTree(height, diam);
} else {
  Tree(height, diam);
}

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

