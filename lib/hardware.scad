/**
 * @brief Modules related to creating mounting hardware. 
 * @author Eric Karr
 * @date Christmas 2024
 */

/**
 * @brief Creates through hole with nut and clearance.
 * Not intended to be called directly. Additional tolerances are not being added here.
 *
 * @param[in] length Length of the through hole portion for a fastener, joined to the nut.
 * @param[in] recessed Optional, creates a cylinder on the opposite side of the nut for clearance.
 * @param[in] bolt_diameter Diameter of the bolt. i.e. M4 = 4mm.
 * @param[in] nut_diameter Diameter of the nut from face to face.
 * @param[in] nut_height Thickness, or height of the nut.
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

/**
 * @brief Creates an M4 nut with through hole, and an optional recession.
 * Used to create a negative in a 3D print. Measurements taken from M4 nuts
 * and bolts, tolerances learned from printing a sample on X1C.
 *
 */
module embedded_m4_nut (length, recessed=0) {
    bolt_diameter = 4 + 0.2;
    
    nut_diameter = 7.8 + 0.3;
    nut_height = 3 + 0.2;
    
    translate([0,0,-length])
        create_recessed_nut(length, recessed, bolt_diameter, nut_diameter, nut_height);
}

/**
 * @brief Module for creating 6x mm magnet hole with a teardrop for 3D printing.
 *
 */
module magnet_hole_teardrop () {
    // Required:
    //use <MCAD/teardrop.scad>

    translate([0,-2.75*25.4,-3/8/2*25.4-2])
        rotate([180,90,90])
        teardrop(radius=3+0.2, length=3/8*25.4, angle=90);
}
