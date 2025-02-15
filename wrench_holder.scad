use <lib/french_cleat.scad>
use <lib/hardware.scad>

// Wrench sizes
wrenches = [8,9,10,11,12,13,14,15];

// Half of each radius, plus a fudge factor
//function calc_offset (a,b) = a/2 + b/2 + 10;
//wo = [ for (i = [0:len(wrenches)-2]) calc_offset(wrenches[i], wrenches[i+1])];

// Wrench offsets
wo = [ for (i = [0:len(wrenches)-2]) wrenches[i+1]*2 + 5 ];

// Calculate absolute x-offsets
x_offsets = [
    0,
    wo[0],
    wo[0] + wo[1],
    wo[0] + wo[1] + wo[2],
    wo[0] + wo[1] + wo[2] + wo[3],
    wo[0] + wo[1] + wo[2] + wo[3] + wo[4],
    wo[0] + wo[1] + wo[2] + wo[3] + wo[4] + wo[5],
    wo[0] + wo[1] + wo[2] + wo[3] + wo[4] + wo[5] + wo[6],
];

cleat_width = 230;

// Group wrenches onto french cleat holder
union () {
    french_cleat(cleat_width);

    for (i = [0:len(wrenches)-1]) {
        translate([x_offsets[i]+10, -wrenches[i]/2, -2])
            hex_chamfer(length=wrenches[i]*1.5,size=wrenches[i]);
    }
}
