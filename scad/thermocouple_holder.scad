body = 25;          // X,Y size of the body
tc_len = 23;        // Thermocouple length
tc_dia = 10;        // Thermocouple diameter
id_tol = 0.20/2;    // Inner diameter tolerance

difference () {
    // Make a core body that will hold the probe
    cube([body,body,tc_len], center=true);
    
    // Cutout the diameter of the probe
    cylinder(h=tc_len+10, r=tc_dia/2+id_tol, center=true, $fn=30);    
    
    // Make a cutout to slide over the wire
    translate([10,0,0])
        cube([body/2,4,tc_len+10], center=true);
}
