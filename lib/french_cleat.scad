/**
 * @brief Modules related to creating french cleat holders.
 * @author Eric Karr
 * @date Christmas 2024
 */

use <hardware.scad>

/**
 * @brief Creates a french cleat base, with a 3/8" rabbet, designed to attach 
 * to 3/4" plywood.
 *
 * @param[in] width Width, in the x-axis of the french cleat.
 * @param[in] (optional) height_in Height of the cleat, specified in inches
 * that overlaps with the wall mounted cleat. Enter a custom height if desired.
 * Set to 3 7/8" by default to land in the middle of the cleat.
 */
module french_cleat (width,height_in=3.875) {
    ply = 3/4*25.4;                     // 3/4" plywood thickness
    rabbet = 3/8*25.4;                  // Rabbet depth
    cleat = height_in*25.4 - ply;       // Cleat height (default 3 7/8")
    sixteenth = 1/16*25.4;              // 1/16" for tolerance

    /**
     * French cleat polygon
     * 
     * Imagine a cross section of the cleat, with the long piece on the right.
     * Points are drawn starting at the bottom left, working counter clockwise.
     */
    p0 = [0,0];
    p1 = [rabbet-sixteenth,0];
    p2 = [p1[0],rabbet];
    p3 = [p2[0]+rabbet,rabbet];
    p4 = [p3[0],-cleat];
    p5 = [p4[0]+rabbet,-cleat];
    p6 = [p5[0],ply];
    p7 = [0,ply];
    
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
        translate([width,-ply,-p6[0]]) {
            rotate([0,-90,0]) {
                linear_extrude(width) {
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
        
        num_mount_holes = floor(width/50);
        hole_spacing = width/num_mount_holes;
            
        // Mounting hole(s)
        for (i = [1:num_mount_holes]) {
            translate([i*hole_spacing - hole_spacing/2,-1.25*25.4,-3/8/2*25.4-1.5])  
                embedded_m4_nut(10, recessed=5); 
        }
    }
}
