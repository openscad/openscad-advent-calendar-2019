// 6205

seed = ceil(rands(0,1,1)[0]*10000);
echo(seed=seed);
snowflake(6,30,2,seed);

module branch(i,l,w,seed) {
  if (l>w && i>0) {
    rnds = rands(1,6,4,seed);
    for(m=[0,1]) mirror([m,0]) {
      polygon([[0,0],[w/2,w/2*tan(30)],[w/2,l-w/2*tan(30)],[0,l]]);
      translate([0,l*rnds[0]/7]) rotate(60)
        branch(i-1,l*(1-rnds[1]/7),w,rnds[2]);
    }
  }
}

module snowflake(i,l,w,seed) {
  color("White") for(a=[0:60:300]) rotate(a) branch(i,l,w,seed);
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