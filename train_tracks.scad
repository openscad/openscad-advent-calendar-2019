use <tree.scad>   // For demo only.  Advent calendar 06.scad
use <train.scad>  // For demo only.  Advent calendar 07.scad

$fa = 1; $fs = 0.4;

default_segment_len = 120;
default_curve_rad = 150;
wheel_width = 7;
wheel_wall = 3;
wheel_spacing = 25.4;
wheel_inset = 3;
base_thick = 5;
bar_spacing = 14;
bar_width = 6;
latch_tol = 0.30;
rail_half = wheel_width/2 + wheel_wall;
inter_rail = wheel_spacing - 2*rail_half;

module Rail() {
    translate([-rail_half, 0])
      square([wheel_wall, base_thick + wheel_inset]);
    translate([+(1/2)*wheel_width, 0])
      square([wheel_wall, base_thick + wheel_inset]);
    translate([-(1/2)*wheel_width, 0])
      square([wheel_width, base_thick]);
}


module Latch() {
  cube([rail_half+0.4*inter_rail-latch_tol, bar_width, base_thick]);
  translate([rail_half+0.10*inter_rail, -bar_width-latch_tol, 0]) {
    cube([0.50*inter_rail, bar_width, base_thick]);
    cube([0.30*inter_rail-latch_tol, 1.5*bar_width, base_thick]);
  }
  translate([wheel_spacing-rail_half-0.10*inter_rail+latch_tol, 0, 0])
    cube([0.10*inter_rail+rail_half, bar_width, base_thick]);
}

module CurvedTrack(arc=45, curve_rad=default_curve_rad) {
  rotate_extrude(angle=arc) translate([curve_rad, 0]) {
    translate([-wheel_spacing/2, 0])
      Rail();
    translate([+wheel_spacing/2, 0])
      Rail();
  }

  inner_circ = (curve_rad-wheel_spacing/2+rail_half)*2*PI;
  inner_len = inner_circ*arc/360;
  inner_bars = round((inner_len-bar_width)/bar_spacing);
  inner_bar_step = (360/inner_circ)*(inner_len-bar_width)/inner_bars;

  translate([curve_rad-wheel_spacing/2, 0, 0])
    Latch();
  rotate([0, 0, arc])
    translate([2*curve_rad, 0, 0])
    rotate([0, 0, 180])
    translate([curve_rad-wheel_spacing/2, 0, 0])
    Latch();

  for (b=[1:inner_bars-1]) {
    rotate([0, 0, b*inner_bar_step])
      translate([curve_rad-wheel_spacing/2, 0, 0])
      cube([wheel_spacing, bar_width, base_thick]);
  }
}


module StraightTrack(len=default_segment_len) {
  translate([0, len, 0])
    rotate([90, 0, 0])
    linear_extrude(len) {
      translate([-wheel_spacing/2, 0])
        Rail();
      translate([+wheel_spacing/2, 0])
        Rail();
    }

  inner_bars = round((len-bar_width)/bar_spacing);
  inner_bar_step = (len-bar_width)/inner_bars;

  translate([-wheel_spacing/2, 0, 0])
    Latch();
  translate([wheel_spacing/2, len, 0])
    rotate([0, 0, 180])
    Latch();

  for (b=[1:inner_bars-1]) {
    translate([-wheel_spacing/2, b*inner_bar_step, 0])
      cube([wheel_spacing, bar_width, base_thick]);
  }
}


module TrackDemo() {
  scale(6) tree();
  rotate([0, 0, -115]) translate([-default_curve_rad+3, 0, 13]) scale(0.38)
    train();

  atol = latch_tol*360 / (default_curve_rad*2*PI);

  CurvedTrack();
  rotate([0, 0, 45+atol]) CurvedTrack();
  rotate([0, 0, 90+2*atol]) CurvedTrack();
  rotate([0, 0, 135+3*atol]) CurvedTrack();
  rotate([0, 0, 180+4*atol]) CurvedTrack();
  translate([2*default_curve_rad, -latch_tol, 0])
    rotate([0, 0, 180]) CurvedTrack();

  rotate([0, 0, 225+4*atol])
    translate([default_curve_rad, latch_tol, 0])
    StraightTrack();

  translate([1.6*default_curve_rad, -0.2*default_curve_rad, 0])
    rotate([0, 0, 180])
    CurvedTrack();

  translate([0.3*default_curve_rad, -1.4*default_segment_len, 0])
    StraightTrack();
}

//CurvedTrack();
//StraightTrack();
TrackDemo();

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

