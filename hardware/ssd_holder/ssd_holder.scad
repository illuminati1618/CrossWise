// ============================================================
// 3-Bay Vertical 2.5" SSD Holder w/ T-Slot Rail Mount
// ============================================================
// Holds three 2.5" drives (70 x 100 x 9 mm) upright, side by
// side. Each bay is a fully enclosed tub (floor + left/right +
// front/back walls) with ONLY the top open, so the connector
// end of each drive stays reachable for cables while the drive
// itself is boxed in on every other side.
//
// Mounting: the front wall doubles as a T-slot bracket. A T-
// shaped key is molded onto its outer face, sized to slide in
// from the end of a 20x20mm T-slot extrusion and lock into the
// channel — trapped by the channel's back wall and both side
// lips (3 sides), so it resists being pulled straight off the
// rail. The default key dims (6.2mm mouth / 9.4mm channel) match
// common 20-series T-slot/V-slot extrusion; measure your actual
// rail and adjust slot_mouth/channel_w/lip_thickness/head_depth
// below if it differs.
//
// Print settings: 3-4 walls, 20%+ infill, no supports needed
// (nothing overhangs more than 90 deg). PETG or ABS recommended
// since drives can run warm; PLA is fine for a desk build.
// Print the key with clean first layers — it's the load-bearing
// interface with the rail.
// ============================================================

$fn = 48;

// ---- Drive dimensions ----
drive_w = 70;          // drive width (mm)
drive_h = 100;          // drive height (mm) - reference only, top is open
drive_t = 9;            // drive thickness (mm)
drive_t_clearance = 0.6; // total slack added to slot width (left/right) for easy insertion
drive_y_clearance = 0.6; // total slack added front-to-back so the drive still drops in/out

// ---- Holder geometry ----
n_bays        = 3;
wall_t        = 2.6;   // divider / back-wall thickness
wall_height   = 40;    // how far up the walls enclose the drive (rest is open, at top)
floor_t       = 3;     // base plate thickness
slot_gap      = drive_t + drive_t_clearance;
box_depth     = drive_w + drive_y_clearance; // front-to-back interior depth of each bay

// ---- Rail mount: front wall doubles as the T-slot bracket ----
bracket_t       = 4;    // front wall / bracket plate thickness
slot_mouth      = 6.2;  // width of the narrow opening on the rail face
channel_w       = 9.4;  // internal width of the T-slot channel
lip_thickness   = 1.6;  // depth of the narrow mouth before it opens into the channel
head_depth      = 1.6;  // how far the wide part of the key sits inside the channel
key_len         = 24;   // key length along the rail's running direction
key_clearance   = 0.3;  // per-side clearance so the key slides freely

key_neck_w = slot_mouth - 2 * key_clearance;
key_head_w = channel_w - 2 * key_clearance;

// ---- Derived ----
total_width  = (n_bays + 1) * wall_t + n_bays * slot_gap;
total_height = floor_t + wall_height;

module divider(x) {
    translate([x, 0, floor_t])
        cube([wall_t, box_depth, wall_height]);
}

module base_body() {
    union() {
        // floor spans the full footprint, including under the front/back walls
        translate([0, -bracket_t, 0])
            cube([total_width, bracket_t + box_depth + wall_t, floor_t]);
        // dividers (comb) - close the left/right side of every bay
        for (i = [0 : n_bays])
            divider(i * (wall_t + slot_gap));
        // back wall - closes the far side of every bay
        translate([0, box_depth, floor_t])
            cube([total_width, wall_t, wall_height]);
        // front wall - closes the near side of every bay AND is the rail bracket
        translate([0, -bracket_t, 0])
            cube([total_width, bracket_t, total_height]);
    }
}

module t_slot_key() {
    key_x = total_width / 2 - key_head_w / 2;
    neck_x = total_width / 2 - key_neck_w / 2;
    z0 = total_height / 2 - key_len / 2;
    // neck: passes through the rail's narrow slot mouth
    translate([neck_x, -bracket_t - lip_thickness, z0])
        cube([key_neck_w, lip_thickness, key_len]);
    // head: sits inside the wider channel, trapped by the side lips + channel back
    translate([key_x, -bracket_t - lip_thickness - head_depth, z0])
        cube([key_head_w, head_depth, key_len]);
}

module ssd_holder() {
    union() {
        base_body();
        t_slot_key();
    }
}

ssd_holder();
