// View, Animate, FPS: 10, Steps: 300

$fa = 1;
$fs = 0.4;

numflakes = 5000;

seeda = 0;
seedu1 = 1;
seedu2 = 2;
seedz = 3;
xyrange = 50;
maxh = 100;
maxz = 500;
flake_size = 0.2;
platform_size = 10*xyrange;
avals = rands(0, 360, numflakes, seed=seeda);
u1vals = rands(0, 1, numflakes, seed=seedu1);
u2vals = rands(0, 1, numflakes, seed=seedu2);
rvals = [for (i=[0:numflakes-1]) xyrange*(u1vals[i]+u2vals[i] > 1 ?
          2 - (u1vals[i]+u2vals[i]) : u1vals[i]+u2vals[i])];
xvals = [for (i=[0:numflakes-1]) rvals[i]*cos(avals[i])];
yvals = [for (i=[0:numflakes-1]) rvals[i]*sin(avals[i])];
zvals = rands(0, maxz, numflakes, seed=seedz);

color("white")
  for (f=[0:numflakes-1]) {
    hwrap = (zvals[f] + maxz*(1-$t)) % maxz;
    h = hwrap > maxh ? 0 : hwrap;
    translate([xvals[f] - flake_size/2, yvals[f] - flake_size/2, h])
      cube(flake_size);
  }

color("black")
  cube([platform_size, platform_size, 0.1], center=true);

color("silver") {
  translate([-xyrange, 0, 0]) {
    cylinder(r=2, h=1.2*maxh);
    translate([4, 0, 1.2*maxh-1])
      difference() {
        scale([2, 1, 1])
          sphere(3.5);
        translate([-5, -5, -14])
          cube(14);
      }
  }
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

