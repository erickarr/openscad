//Source: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
function circumscribed_diameter(diameter, fn) = (diameter * 1/cos(180/fn));

module wrench (length, size, is_metric=true, size_txt=undef) {    
    // Convert diameter if imperial, 25.4mm == 1"
    diameter_conv = (is_metric) ? size : (size * 25.4);
    
    // Circumscribed diameter
    circum_diameter = circumscribed_diameter(diameter_conv, 6);
    
    difference () {
        // Create cylinder object with chamfer to hold wrench
        union () {
            linear_extrude(length)
                circle(d=circum_diameter,$fn=6);
            
            translate([0,0,length])
                cylinder(h=2,
                    d1=circum_diameter, 
                    d2=circum_diameter*0.8, 
                    $fn=6);
        }
        
        custom_txt = is_undef(size_txt) ? str(size) : size_txt;
        
        // Subtract text
        translate([0,0,length+1])
            linear_extrude(2)
            text(custom_txt, size=diameter_conv*0.4, halign="center", valign="center");
    }
}

use <lib/french_cleat.scad>

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
            wrench(length=wrenches[i]*1.5,size=wrenches[i]);
    }
}
