$fa = 4; $fs = 0.4;

module star() {
     color("gold") translate([0, 0, 50]) rotate([90, 0, 0]) for (a = [0:5]) {
        rotate(72 * a) hull() {
            linear_extrude(1, center = true) {
                polygon([[0, 0], for (i = [-1:1])
                    let(angle = 36 * i, dia = 40 - 20 * (abs(i) % 2))
                        dia * [-sin(angle), cos(angle)] ]);
            }
            cylinder(r = 0.1, h = 20, center = true);
        }
    }
    color("silver") {
        cylinder(r = 2, h = 50);
        cylinder(r = 20, h = 2);
    }
}

star();

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