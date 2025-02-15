use <lib/french_cleat.scad>
use <lib/hardware.scad>

// Wrench sizes
wrenches = [17,19,21,22];

// Half of each radius, plus a fudge factor
//function calc_offset (a,b) = a/2 + b/2 + 10;
//wo = [ for (i = [0:len(wrenches)-2]) calc_offset(wrenches[i], wrenches[i+1])];

// Start offset
so = 5;

// Wrench offsets
wo = [42+so, 47, 50];

// Calculate absolute x-offsets
x_offsets = [
    so,
    wo[0],
    wo[0] + wo[1],
    wo[0] + wo[1] + wo[2],
];

echo(x_offsets);

cleat_width = 175;

// Group wrenches onto french cleat holder
union () {
    french_cleat(width=cleat_width);

    for (i = [0:len(wrenches)-1]) {
        translate([x_offsets[i]+10, -wrenches[i]/2, -2])
            hex_chamfer(length=wrenches[i]*1.5,size=wrenches[i],size_tol_minus=0.5);
    }
}
