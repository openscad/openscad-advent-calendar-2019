$fa=1;
$fs=0.4;

module CurveCyl(r, h) {
  rotate_extrude() hull() {
    square([0.001, h]);
    intersection() {
      square([r, h]);
      translate([r-h/2, h/2]) circle(d=h);
    }
  }
}


module LeftLeg() {
  translate([7, 0, 0]) {
    color("#353535")
      scale([0.9,1.5,0.3])
      translate([0, -2.5, 5])
      sphere(5);
    color("white")
      translate([0, 0, 5*0.3])
      CurveCyl(4, 6);
    color("red")
      translate([-2, 0, 10])
      scale([1, 1, 0.7])
      sphere(6);
    color("white")
      translate([-3, -2, 12.4])
      rotate([20, 0, 40])
      scale([1.4, 1, 1])
      CurveCyl(5, 2);
  }
}


module LeftArm() {
  translate([13, 0, 18]) {
    color("white")
      CurveCyl(3, 5);
    color("red")
      translate([-0.8, 0, -2])
      rotate([0, 30, 0])
      scale([0.7, 1, 1])
      sphere(3.5);
    color("red")
      translate([-3.8, 0, 7])
      rotate([0, -60, 0])
      scale([0.7, 1, 1.8])
      sphere(3.5);
  }
}


module CurveSquare(size, curve) {
  hull()
    for (i=[0:3])
      rotate(i*90)
      translate([size/2-curve, size/2-curve])
      circle(curve);
}

module Buckle() {
  rotate([90, 0, 0])
    linear_extrude(1)
      difference() {
        CurveSquare(6, 1.5);
        CurveSquare(4, 1.5);
      }
}


module LeftFace() {
  color("white")
    translate([2, -4.5, 32])
    rotate([50, 40, 0])
    scale([1.4, 1, 0.9])
    CurveCyl(3, 2);
  color("white")
    translate([2.4, -4.0, 38])
    rotate([-50, 25, 0])
    scale([1.4, 0.5, 0.9])
    CurveCyl(1, 0.5);
  color("black")
    translate([1.2, -4.7, 36])
    sphere(1.5);
}  

module Hat() {
  color("white")
    CurveCyl(8, 3);
  color("red") {
    translate([0, 0, 2])
      linear_extrude(12, scale=[0.1, 0.5])
      circle(7);
    translate([0, 0, 14]) {
      rotate([0, 130, 0])
        linear_extrude(5, scale=[1, 0.1])
          scale([0.1, 0.5])
          circle(7);
      scale([0.1, 0.5, 0.1])
        sphere(7);
    }
  }
  color("white")
    translate([5, 0, 10])
    sphere(2);
}


module Santa() {
  LeftLeg();
  mirror([1,0,0])
    LeftLeg();

  color("red")
    translate([0, 0, 20])
    scale([1.3, 1, 1])
    sphere(9);

  color("white")
    translate([0, 2, 12.2])
    scale([1.7, 1, 1])
    CurveCyl(6, 2);

  color("black")
    translate([0, 0, 18.5])
    scale([1.3/2, 1/2, 1])
    CurveCyl(19, 3);

  color("gold")
    translate([0, -8.5, 20])
    Buckle();

  LeftArm();
  mirror([1, 0, 0])
    LeftArm();

  color("white")
    translate([0, -3, 28])
    rotate([40, 0, 0])
    scale([1, 1, 0.5])
    sphere(8);

  color("#E0B8A8")
    translate([0, 0, 33]) {
      sphere(7);
      translate([0, -7, 0.5])
        scale([1, 0.7, 0.7])
        sphere(2.6);
    }

  LeftFace();
  mirror([1, 0, 0])
    LeftFace();

  color("white") {
    translate([1.5, -6.0, 36.8])
      rotate([-35, 0, 20])
      cube(0.3);
    translate([-1.4, -5.8, 36.6])
      rotate([55, 0, -10])
      cube(0.3);
  }

  translate([0, 1.5, 34.5])
    rotate([-45, 0, 0])
    Hat();
}

Santa();


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

