// V0
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

/**
* Controller dimensions, without tolerances.
*/
cont_width = 2.5*INCH;
cont_height = 6*INCH;
cont_depth = 1*INCH;

cont_dims = [cont_width, cont_height, cont_depth];

/**
 * Holder dimensions, based off controller
 */
holder_thickness = 0.25*INCH;
holder_height = cont_height-2*INCH;

/**
* Buttons, on the face of the controller.
*/
butt_width = 1.5 * INCH;
butt_height = cont_height;
butt_depth = 0.5 * INCH;

button_dims = [butt_width, cont_height, butt_depth];

diff()
cuboid([cont_width + holder_thickness*2, holder_height, cont_depth + holder_thickness*2],
    rounding=4, anchor=BOTTOM) {
        // Controller and button bodies
        tag("remove") 
            back(holder_thickness) 
                position(FRONT) cube(cont_dims, anchor=FRONT) 
                position(TOP) back(0.5*INCH) cube(button_dims, anchor=BOTTOM);
        // Text
        tag("remove") back(7/16*INCH) position(FRONT+TOP) text3d("KVR", h=3, font="Times New Roman", center=true);
        // Mounting screw holes
        tag("remove") back(1*INCH) up(holder_thickness) position(BOTTOM) screw_hole("#8-32,1/2",head="flat",counterbore=0,anchor=TOP,$slop=0.1);
        tag("remove") fwd(1*INCH) up(holder_thickness) position(BOTTOM) screw_hole("#8-32,1/2",head="flat",counterbore=0,anchor=TOP,$slop=0.1);
}
