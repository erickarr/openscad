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

module french_cleat (length) {
    ply = 3/4*25.4;         // 3/4" plywood thickness
    rabbet = 3/8*25.4;      // Rabbet depth
    cleat = 2.5*25.4;         // Cleat mininimum height
    sixteenth = 1/16*25.4;  // 1/16" for tolerance

    // French cleat polygon
    p0 = [0,0];
    p1 = [rabbet-sixteenth,0];
    p2 = [p1[0],rabbet];
    p3 = [p2[0]+rabbet,rabbet];
    p4 = [p3[0],-cleat];
    p5 = [p4[0]+rabbet,-cleat];
    p6 = [p5[0], ply];
    p7 = [0, ply];
    
    points = [
        p0,
        p1, 
        p2,
        p3,
        p4,
        p5,
        p6,
        p7
    ];

    difference () {
        translate([length,-ply,-p6[0]]) {
            rotate([0,-90,0]) {
                linear_extrude(length) {
                    difference () {
                        polygon(points);
                        
                        chamfer_corners = [
                            p0,
                            p1,
                            p4,
                            p5,
                            p6
                        ];
                    
                        // For each corner, apply a chamfer
                        for(corner = chamfer_corners) {
                            translate([corner[0], corner[1], 0])
                                rotate([0,0,45])
                                square(1.5, center=true);
                        }
                    }
                }
            }
        }
        
        num_mount_holes = floor(length/50);
        hole_spacing = length/num_mount_holes;
            
        // Mounting hole(s)
        for (i = [1:num_mount_holes]) {
            translate([i*hole_spacing - hole_spacing/2,-1.25*25.4,-3/8/2*25.4-1.5])  
                embedded_m4_nut(10, recessed=5); 
        }
    }
}

/**
 * @brief Not intended to be called directly.
 * Creates through hole with nut and clearance
 */
module create_recessed_nut (length, recessed=0, bolt_diameter, nut_diameter, nut_height) {
    union () {
        // Bolt
        cylinder(h=length, d=bolt_diameter, $fn=50);
        
        // Nut
        translate([0,0,length])
            cylinder(h=nut_height, d=nut_diameter, $fn=6);
        
        // Optional clearance
        if (recessed > 0) {
            translate([0,0,length+nut_height])
                cylinder(h=recessed,d=nut_diameter+2, $fn=50);
        }
    }
}

// Measurements taken from M4 nuts and bolts
module embedded_m4_nut (length, recessed=0) {
    bolt_diameter = 4 + 0.2;
    
    nut_diameter = 7.8 + 0.3;
    nut_height = 3 + 0.2;
    
    translate([0,0,-length])
        create_recessed_nut(length, recessed, bolt_diameter, nut_diameter, nut_height);
}

/**
 * @brief Module for creating 6x mm magnet hole with a teardrop for 3D printing.
 */
module magnet_hole_teardrop () {
    // Required:
    //use <MCAD/teardrop.scad>

    translate([0,-2.75*25.4,-3/8/2*25.4-2])
        rotate([180,90,90])
        teardrop(radius=3+0.2, length=3/8*25.4, angle=90);
}

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
