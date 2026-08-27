// ============================================================
// Fit check for ssd_holder.scad
// ============================================================
// Drops the holder into a modeled 20x20 T-slot rail and three
// modeled 2.5" drives, so the fit can be checked before printing.
//
//   show = "assembly"    holder + rail + drives, rendered together
//   show = "rail_clash"  ONLY where the holder intersects the rail
//   show = "drive_clash" ONLY where the holder intersects a drive
//
// Both clash modes must come out EMPTY. Render one and read the
// reported volume: "Top level object is a 3D object" with a real
// volume means parts are trying to occupy the same space.
//
//   openscad -o clash.stl -D 'show="rail_clash"' fit_check.scad
//
// The rail profile here is a nominal 20-series extrusion (6.2mm
// slot mouth, 9.4mm channel, 6mm deep, 4.2mm center bore). It is
// a stand-in for checking geometry — it is not a substitute for
// measuring your own rail.
// ============================================================

include <ssd_holder.scad>
render_holder = false; // we place the holder ourselves below

show = "assembly";

rail_len   = 120;  // length of rail to model
rail_x0    = -40;  // where that length starts
rail_bore  = 4.2;  // center bore diameter
slot_depth = 6.0;  // how deep the channel runs from the rail face

// The rail bears flat against the mounting plate's outer face.
rail_y_face   = -plate_t;
rail_y_center = rail_y_face - rail_size / 2;
rail_z_center = rail_size / 2;

module rail_slot_2d() {
    translate([-slot_mouth / 2, rail_size / 2 - lip_thickness])
        square([slot_mouth, lip_thickness]);
    translate([-channel_w / 2, rail_size / 2 - slot_depth])
        square([channel_w, slot_depth - lip_thickness]);
}

module rail_profile_2d() {
    difference() {
        square([rail_size, rail_size], center = true);
        for (a = [0 : 90 : 270]) rotate(a) rail_slot_2d();
        circle(d = rail_bore);
    }
}

module rail() {
    translate([rail_x0, rail_y_center, rail_z_center])
        rotate([0, 90, 0])
            linear_extrude(rail_len)
                rail_profile_2d();
}

// A drive sitting in bay i, centered in its slot, resting on the floor.
module drive(i) {
    x = wall_t + i * (wall_t + slot_gap) + (slot_gap - drive_t) / 2;
    translate([x, (bay_depth - drive_w) / 2, floor_t])
        cube([drive_t, drive_w, drive_h]);
}

module drives() {
    for (i = [0 : n_bays - 1]) drive(i);
}

if (show == "assembly") {
    color("SteelBlue")           ssd_holder();
    color("DimGray",   0.55)     rail();
    color("DarkOrange", 0.45)    drives();
} else if (show == "rail_clash") {
    intersection() { ssd_holder(); rail(); }
} else if (show == "drive_clash") {
    intersection() { ssd_holder(); drives(); }
}
