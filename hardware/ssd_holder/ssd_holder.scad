// ============================================================
// 3-Bay Vertical 2.5" SSD Holder w/ T-Slot Rail Mount
// ============================================================
// Holds three 2.5" drives (70 x 100 x 9 mm) upright. Each bay is
// a fully enclosed tub (floor + left/right dividers + front/back
// walls) with ONLY the top open, so the connector end of each
// drive stays reachable for cables while the drive itself is
// boxed in on every side.
//
// Mounting: the comb's LONG side wall — the 75.8 x 43mm face at
// x = 0 — is itself the mount. It is thickened to mount_wall_t
// and a single T-key is molded straight onto its outer surface,
// running the full 75.8mm along the rail. There is no separate
// plate or block bolted onto the holder: the wall that closes the
// end bay is the same wall that grips the rail.
//
// The key slides into the rail's channel from the end of the
// extrusion and is trapped by that channel's back wall and both
// side lips, while the wall face bears flat against the rail.
// Tapered lead-ins at both ends let it start from either
// direction and back straight off the way it went on.
//
// The rail runs HORIZONTALLY along the holder's 75.8mm depth,
// with its bottom flush to the bottom of the holder. Because the
// mount is on the end face, the three drives sit in a line
// running away from the rail rather than spread along it — that
// is what mounting on the long face means geometrically.
//
// Default key dims (6.2mm mouth / 9.4mm channel) match common
// 20-series T-slot/V-slot extrusion; measure your actual rail and
// adjust slot_mouth/channel_w/lip_thickness/head_depth below if
// it differs — a wrong fit either won't slide in or will be loose.
//
// Print settings: 3-4 walls, 20%+ infill, NO SUPPORTS — the comb
// floor sits flat on the bed and the key's 3.2mm horizontal
// protrusion is short enough to print clean. PETG or ABS
// recommended since drives run warm; PLA is fine for a desk build.
// ============================================================

$fn = 48;

// ---- Drive dimensions ----
drive_w = 70;             // drive width (mm) - horizontal, along the rail
drive_h = 100;             // drive height (mm) - reference only, top is open
drive_t = 9;               // drive thickness (mm) - stacking direction
drive_t_clearance = 0.6;   // total slack added to slot thickness for easy insertion
drive_y_clearance = 0.6;   // total slack added along the drive's width

// ---- Holder geometry ----
n_bays      = 3;
wall_t      = 2.6;   // divider / front-wall / back-wall thickness
wall_height = 40;    // how far up the walls enclose the drive (rest is open, at top)
floor_t     = 3;     // base plate thickness
slot_gap    = drive_t + drive_t_clearance;
bay_depth   = drive_w + drive_y_clearance; // bay depth, along the rail

// ---- Rail mount: the long end wall IS the mount ----
mount_wall_t  = 4;     // thickness of the long wall that carries the key
rail_size     = 20;    // T-slot extrusion cross-section (square)
slot_mouth    = 6.2;   // width of the narrow opening on the rail face
channel_w     = 9.4;   // internal width of the T-slot channel
lip_thickness = 1.6;   // depth of the narrow mouth before it opens into the channel
head_depth    = 1.6;   // how far the wide part of the key sits inside the channel
key_clearance = 0.3;   // per-side clearance so the key slides freely
key_lead_in   = 2.5;   // taper at each end of the key, so it starts into the slot

key_neck_w = slot_mouth - 2 * key_clearance;
key_head_w = channel_w - 2 * key_clearance;

// ---- Derived ----
comb_width   = mount_wall_t + n_bays * (slot_gap + wall_t);
total_height = floor_t + wall_height;
comb_y0      = -wall_t;                  // outer face of the front wall
comb_depth   = bay_depth + 2 * wall_t;   // full depth, and the key's length
key_z        = rail_size / 2;            // key on the rail's slot centerline

// Interior dividers, one after each bay. The mount wall closes the
// first bay, so these start after it.
module divider(i) {
    translate([mount_wall_t + i * slot_gap + (i - 1) * wall_t, 0, floor_t])
        cube([wall_t, bay_depth, wall_height]);
}

module base_body() {
    union() {
        // floor spans the full footprint, including under every wall
        translate([0, comb_y0, 0])
            cube([comb_width, comb_depth, floor_t]);
        // the long mount wall - closes the first bay AND grips the rail
        translate([0, comb_y0, 0])
            cube([mount_wall_t, comb_depth, total_height]);
        // interior dividers
        for (i = [1 : n_bays]) divider(i);
        // front/back walls - close the near/far side of every bay
        translate([0, comb_y0, floor_t])
            cube([comb_width, wall_t, wall_height]);
        translate([0, bay_depth, floor_t])
            cube([comb_width, wall_t, wall_height]);
    }
}

// One segment of the key: a bar running the length of the mount
// wall (along Y), w tall in Z, protruding depth into -X from x0,
// tapered at both ends so it can start into the slot either way.
module key_bar(w, x0, depth) {
    inner_w = max(w - 2 * key_lead_in, 0.1);
    hull() {
        translate([x0 - depth, comb_y0 + key_lead_in, key_z - w / 2])
            cube([depth, comb_depth - 2 * key_lead_in, w]);
        translate([x0 - depth, comb_y0, key_z - inner_w / 2])
            cube([depth, comb_depth, inner_w]);
    }
}

module t_slot_key() {
    key_bar(key_neck_w, 0, lip_thickness);                // through the slot mouth
    key_bar(key_head_w, -lip_thickness, head_depth);      // inside the channel
}

module ssd_holder() {
    union() {
        base_body();
        t_slot_key();
    }
}

ssd_holder();
