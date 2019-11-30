// Max iterations
i = 6;
// Initial length per "arm"
l = 100;
// Arm width
w = 10;
// Random seed (-1 to generate new each preview)
seed = 0;
// Choose 2D or 3D version
view3D = true;
// Optionally Preview many consecutive seed values at once, starting with seed set above.
cols = 5;
rows = 5;

seed0 = seed == -1 ? ceil(rands(0,1,1)[0]*10000) : seed;
echo();
echo(seed0=seed0);
echo();

h = w/2*tan(30);
for(x=[0:1:cols-1],y=[0:1:rows-1]) {
  seed1 = y*cols+x+seed0;
  translate(3.2*l*[x+0.5,y+0.5]) 
    if (view3D) snowflake3D(i,l,w,seed1);
    else snowflake(i,l,w,seed1); 
}

module snowflake(i,l,w,seed) {
  union() for(a=[0:60:300]) rotate(a) 
    branch(i,l,w,seed);
}

module snowflake3D(i,l,w,seed) {
  union() for(a=[0:60:300]) rotate(a) 
    branch3D(i,l,w,seed);
}

module branch(i,l,w,seed) {
  if (l>w && i>0) {
    rnds = rands(1,6,3,seed);
    polygon([[0,l],[w/2,l-h],[w/2,0],[-w/2,0],[-w/2,l-h]]);
    for(a=[-60,60])
      translate([0,l*rnds[0]/7]) rotate(a)
        branch(i-1,l*(1-rnds[1]/7),w,rnds[2]);
  }
}

module branch3D(i,l,w,seed) {
  if (l>w && i>0) {
    rnds = rands(1,6,3,seed);
    eps = 1/1024;
    polyhedron(points=[
        [0,l,0],[-w/2,l-h,0],[w/2,l-h,0],// tip
        [-w/2,-w/2,0],[w/2,-w/2,0],      // base
        [0,0,h],[0,l-2*h,h]              // top points
      ],            
      faces=[
        [0,1,2],[1,3,4,2],      // bottom
        [0,6,1],[0,2,6],[5,4,3],// ends
        [3,1,6,5],[2,4,5,6]     // sides
      ]
    );  
    translate([0,l*rnds[0]/7]) 
      for(a=[-60,60]) rotate(a)
        branch3D(i-1,l*(1-rnds[1]/7),w,rnds[2]);
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
