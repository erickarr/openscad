include <BOSL2/std.scad>

in_to_mm = 25.4;

/**
 * Controller dimensions, without tolerances.
 */
cont_width = 2.5 * in_to_mm;
cont_height = 6 * in_to_mm;
cont_depth = 1 * in_to_mm;

up(cont_depth/2)
    cube([cont_width, cont_height, cont_depth], center = true);

/**
 * Buttons, on the face of the controller.
 */
butt_width = 1.5 * in_to_mm;
butt_height = 4 * in_to_mm;
butt_depth = 0.5 * in_to_mm;

up(cont_depth)
    cube([butt_width, butt_height, butt_depth], center = true);
