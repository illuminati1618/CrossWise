// ============================================================
// 3-Bay Vertical 2.5" SSD Holder w/ T-Slot Rail Mount
// ============================================================
// Holds three 2.5" drives (70 x 100 x 9 mm) upright, side by
// side. Each bay is a fully enclosed tub (floor + left/right +
// front/back walls) with ONLY the top open, so the connector
// end of each drive stays reachable for cables while the drive
// itself is boxed in on every other side.
//
// Mounting: a cradle on the LEFT end of the comb (the 70mm-long
// side, for maximum engagement length) wraps around three faces
// of a 20x20mm T-slot rail — top, bottom, and back — leaving only
// the outward face open. T-shaped keys molded into the top and
// bottom arms slide into the rail's top and bottom channels from
// the end of the extrusion, each trapped by its channel's back
// wall and side lips. Gripping two opposing channels plus the
// flat back contact resists both being pulled straight off AND
// twisting/rocking, which a single flat key can't do on its own.
// The rail is assumed HORIZONTAL — drives stand vertically (open
// top up) perpendicular to it, and the cradle slides on from the
// rail's open end.
//
// Default key dims (6.2mm mouth / 9.4mm channel) match common
// 20-series T-slot/V-slot extrusion; measure your actual rail and
// adjust slot_mouth/channel_w/lip_thickness/head_depth below if
// it differs — a wrong fit either won't slide in or will be loose.
//
// Print settings: 3-4 walls, 20%+ infill, no supports needed
// (nothing overhangs more than 90 deg). PETG or ABS recommended
// since drives can run warm; PLA is fine for a desk build.
// Print the cradle/keys with clean first layers — it's the
// load-bearing interface with the rail.
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
wall_t        = 2.6;   // divider / front-wall / back-wall thickness
wall_height   = 40;    // how far up the walls enclose the drive (rest is open, at top)
floor_t       = 3;     // base plate thickness
slot_gap      = drive_t + drive_t_clearance;
box_depth     = drive_w + drive_y_clearance; // front-to-back interior depth of each bay - the "longer side"

// ---- Rail mount: cradle wraps top/bottom/back of the rail ----
rail_size        = 20;   // T-slot extrusion cross-section (square)
rail_pocket_clear = 0.6; // total clearance around the rail inside the cradle pocket
mount_wall_t      = 3;   // thickness of the cradle's back wall and top/bottom arms
slot_mouth        = 6.2; // width of the narrow opening on the rail face
channel_w         = 9.4; // internal width of the T-slot channel
lip_thickness     = 1.6; // depth of the narrow mouth before it opens into the channel
head_depth        = 1.6; // how far the wide part of the key sits inside the channel
key_clearance     = 0.3; // per-side clearance so each key slides freely

key_neck_w = slot_mouth - 2 * key_clearance;
key_head_w = channel_w - 2 * key_clearance;

// ---- Derived ----
total_width   = (n_bays + 1) * wall_t + n_bays * slot_gap;
total_height  = floor_t + wall_height;
rail_z_center = total_height / 2;
pocket_span   = rail_size + rail_pocket_clear;      // Z space the rail + clearance occupies
pocket_z_lo   = rail_z_center - pocket_span / 2;
pocket_z_hi   = rail_z_center + pocket_span / 2;
mount_x_lo    = -(mount_wall_t + pocket_span);      // outer (open) face of the cradle

module divider(x) {
    translate([x, 0, floor_t])
        cube([wall_t, box_depth, wall_height]);
}

module base_body() {
    union() {
        // floor spans the full footprint, including under the front/back walls
        translate([0, -wall_t, 0])
            cube([total_width, box_depth + 2 * wall_t, floor_t]);
        // dividers (comb) - close the left/right side of every bay
        for (i = [0 : n_bays])
            divider(i * (wall_t + slot_gap));
        // front/back walls - close the near/far side of every bay
        translate([0, -wall_t, floor_t])
            cube([total_width, wall_t, wall_height]);
        translate([0, box_depth, floor_t])
            cube([total_width, wall_t, wall_height]);
    }
}

module rail_cradle() {
    union() {
        // back wall of the cradle, flush against the comb's left end
        translate([-mount_wall_t, 0, pocket_z_lo - mount_wall_t])
            cube([mount_wall_t, box_depth, pocket_span + 2 * mount_wall_t]);
        // top arm
        translate([mount_x_lo, 0, pocket_z_hi])
            cube([mount_wall_t + pocket_span, box_depth, mount_wall_t]);
        // bottom arm
        translate([mount_x_lo, 0, pocket_z_lo - mount_wall_t])
            cube([mount_wall_t + pocket_span, box_depth, mount_wall_t]);
    }
}

module t_slot_key(z0, dir) {
    // dir = +1 for a key protruding downward (mounted on the top arm)
    // dir = -1 for a key protruding upward (mounted on the bottom arm)
    key_x = -mount_wall_t - pocket_span / 2;
    neck_x = key_x - key_neck_w / 2;
    head_x = key_x - key_head_w / 2;
    neck_z = dir > 0 ? z0 - lip_thickness : z0;
    head_z = dir > 0 ? z0 - lip_thickness - head_depth : z0 + lip_thickness;
    translate([neck_x, 0, neck_z])
        cube([key_neck_w, box_depth, lip_thickness]);
    translate([head_x, 0, head_z])
        cube([key_head_w, box_depth, head_depth]);
}

module ssd_holder() {
    union() {
        base_body();
        rail_cradle();
        t_slot_key(pocket_z_hi, 1);  // hangs down into the rail's top channel
        t_slot_key(pocket_z_lo, -1); // rises up into the rail's bottom channel
    }
}

ssd_holder();
