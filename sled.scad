$fa = 4; $fs = 0.4;

n = 20;

// calculate single bezier point in 2D
function bezierp(from, to, c1, c2, a) =
    from * pow(1 - a, 3)
    + c1 * 3 * pow(1 - a, 2) * a
    + c2 * 3 * pow(1 - a, 1) * pow(a, 2)
    + to * pow(a, 3);

// calculate points of cubic bezier
function bezier(p) = [
    for (i = [0:n])
       let(a =  i * 1 / n)
           bezierp(p[0], p[1], p[2], p[3], a)
];

beziers = [
    [ [140,  0], [130, 10], [150,  0], [140, 10] ],
    [ [ 90, 10], [-20, 10], [ 90, 10], [-20, 10] ],
    [ [-20, 10], [-40, 30], [-30, 10], [-40, 20] ],
    [ [-40, 30], [-37, 40], [-40, 35], [-39, 37] ],
    [ [-37, 40], [-30, 30], [-37, 40], [-34, 31] ],
    [ [-30, 30], [-10, 45], [-20, 23], [-10, 36] ],
    [ [-10, 45], [-30, 60], [-10, 56], [-20, 60] ],
    [ [-30, 60], [-50, 30], [-51, 57], [-50, 30] ],
    [ [-50, 30], [-43, 10], [-51, 20], [-47, 15] ],
    [ [-43, 10], [-24,  0], [-37,  5], [-33,  1] ],
];

bezier_points = [
    [0, 0],
    [100, 0],
    each for (a = [0 : len(beziers) - 1]) bezier(beziers[a])
];

module skid() {
    rotate([90, 0, 0])
        linear_extrude(10, center = true)
            polygon(bezier_points);
}

module sled() {
    color("SaddleBrown") {
        translate([0, 35, 0])
            skid();
        translate([0, -35, 0])
            skid();
        translate([-25, 0, 44])
            rotate([90, 0, 0])
                cylinder(r = 4, h = 70, center = true);
        translate([40, 0, 27]) cube([7, 80, 40], center = true);
        translate([105, 0, 27]) cube([7, 80, 40], center = true);
        translate([70, 0, 50])
            for (a = [-2 : 2])
                translate([0, a * 18, 0])
                    cube([120, 15, 7], center = true);
    }
}

sled();

/*

debug_bezier(beziers[9]);

module debug_bezierl(p, i) {
    color("black") hull() {
        translate(p[i]) cube(0.1, center = true);
        translate(p[i + 2]) cube(0.1, center = true);
    }
}

module debug_bezier(p) {
    color("blue") translate(p[0]) circle(0.5);
    color("red") translate(p[1]) circle(0.5);
    color("yellow") {
        translate(p[2]) circle(0.3);
        translate(p[3]) circle(0.3);
    }
    debug_bezierl(p, 0);
    debug_bezierl(p, 1);
}

*/

// Written in 2019 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
