use <lib/french_cleat.scad>
use <lib/hardware.scad>

// Wrench sizes (19.05mm, 20.64mm, 22.23mm, 23.81mm)
wrenches = [3/4,13/16,7/8,15/16];

wrench_txt = ["3/4", "13/16", "7/8", "15/16"];

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

cleat_width = 175;

// Group wrenches onto french cleat holder
union () {
    french_cleat(width=cleat_width);

    for (i = [0:len(wrenches)-1]) {
        wrench_mm = wrenches[i]*25.4;
        translate([x_offsets[i]+10, -wrench_mm/2, -2])
            hex_chamfer(
                length=wrench_mm*1.5,
                size=wrench_mm,
                size_tol_minus=0.5,
                size_txt=wrench_txt[i],
                font_size_mult=0.25);
    }
}
