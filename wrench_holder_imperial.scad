use <lib/french_cleat.scad>
use <lib/hardware.scad>

// Wrench sizes
wrenches_imp = [1/4,5/16,3/8,7/16,1/2,9/16,5/8,11/16];
wrenches = [for (w = wrenches_imp) w * 25.4];

wrench_txt = ["1/4", "5/16", "3/8", "7/16", "1/2", "9/16", "5/8", "11/16"];

echo(wrenches);

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
        translate([x_offsets[i]+5, -wrenches[i]/2, -2])
            hex_chamfer(
                length=wrenches[i]*1.3,
                size=wrenches[i],
                size_tol_minus=0.5,
                size_txt=wrench_txt[i],
                font_size_mult=0.25);
    }
}
