// ============================================================
// 3-Bay Vertical 2.5" SSD Holder w/ T-Slot Rail Mount
// ============================================================
// Holds three 2.5" drives (70 x 100 x 9 mm) upright, side by
// side, in open-top comb slots so SATA/power cables stay
// accessible at the top. A bracket on the back bolts straight
// to a 20x20mm T-slot extrusion using two T-nuts (no printed
// threads, no hardware beyond M5 bolts + T-nuts).
//
// Print settings: 3-4 walls, 20%+ infill, no supports needed
// (nothing overhangs more than 90 deg). PETG or ABS recommended
// since drives can run warm; PLA is fine for a desk build.
// ============================================================

$fn = 48;

// ---- Drive dimensions ----
drive_w = 70;      // drive width (mm)
drive_h = 100;      // drive height (mm) - reference only, top is open
drive_t = 9;        // drive thickness (mm)
drive_clearance = 0.6; // total slack added to slot width for easy insertion

// ---- Holder geometry ----
n_bays        = 3;
wall_t        = 2.6;   // divider thickness
wall_height   = 40;    // how far up the dividers grip the drive (rest is open)
floor_t       = 3;     // base plate thickness
slot_gap      = drive_t + drive_clearance;

// ---- Rail mount ----
rail_size     = 20;    // T-slot extrusion is 20 x 20 mm
bracket_t     = 4;     // thickness of the mounting plate
bolt_dia      = 5.5;   // M5 clearance hole
bolt_head_dia = 9.5;   // clearance for bolt head / washer, counterbored from the back
bolt_head_depth = 2.2;
bolt_spacing_z  = 26;  // vertical spacing between the two mounting bolts

// ---- Derived ----
total_width = (n_bays + 1) * wall_t + n_bays * slot_gap;
total_height = floor_t + wall_height;

module divider(x) {
    translate([x, 0, floor_t])
        cube([wall_t, drive_w, wall_height]);
}

module base_body() {
    union() {
        // floor
        cube([total_width, drive_w, floor_t]);
        // dividers (comb)
        for (i = [0 : n_bays])
            divider(i * (wall_t + slot_gap));
        // rear mounting bracket, flush with back edge (y=0),
        // full height so it's bonded to both floor and dividers
        translate([0, -bracket_t, 0])
            cube([total_width, bracket_t, total_height]);
    }
}

module mount_holes() {
    hole_x = total_width / 2;
    z0 = total_height / 2 - bolt_spacing_z / 2;
    z1 = total_height / 2 + bolt_spacing_z / 2;
    for (z = [z0, z1]) {
        // through hole for the bolt shank
        translate([hole_x, -bracket_t - 1, z])
            rotate([-90, 0, 0])
                cylinder(d = bolt_dia, h = bracket_t + drive_w + 2);
        // counterbore from the rail side so the bolt head sits flush
        translate([hole_x, -bracket_t - 0.1, z])
            rotate([-90, 0, 0])
                cylinder(d = bolt_head_dia, h = bolt_head_depth + 0.1);
    }
}

module ssd_holder() {
    difference() {
        base_body();
        mount_holes();
    }
}

ssd_holder();

// ---- Reference geometry (uncomment to visualize fit) ----
// color("SteelBlue", 0.3)
//   for (i = [0 : n_bays - 1])
//     translate([wall_t + i * (wall_t + slot_gap) + slot_gap/2 - drive_t/2, 0, floor_t])
//       cube([drive_t, drive_w, drive_h]);
//
// color("DimGray", 0.4)
//   translate([total_width/2 - rail_size/2, -bracket_t - rail_size, 0])
//     cube([rail_size, rail_size, total_height]);
