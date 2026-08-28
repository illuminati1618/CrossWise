// ============================================================
// 3-Bay Vertical 2.5" SSD Holder w/ T-Slot Rail Mount
// ============================================================
// Holds three 2.5" drives (70 x 100 x 9 mm) upright, SIDE BY SIDE
// ALONG THE RAIL — all three sit the same distance out from the
// rail rather than receding front-to-back, so no drive hangs off
// the end of a long lever arm. Each bay is a fully enclosed tub
// (floor + left/right dividers + front/back walls) with ONLY the
// top open, so the connector end of each drive stays reachable
// for cables while the drive itself is boxed in on every side.
//
// Mounting: a U-shaped cradle wraps three faces of a 20x20mm
// T-slot rail — top, bottom, and back — leaving the outward face
// open. T-shaped keys are molded into all three wrapped faces and
// engage the rail's top, bottom, and back channels, each trapped
// by its own channel's back wall and side lips. Three keyed faces
// resist pull-off, twist, AND rock. The cradle runs cradle_len
// along the rail (default 70mm, wider than the 39.2mm comb) to
// keep a long engagement even though the drives now stack
// side-by-side.
//
// Removal: the cradle slides on and off from the END of the rail.
// Every key runs straight along the rail's axis with a tapered
// lead-in at both ends, so it slides either direction and can be
// backed straight off the way it went on. Nothing needs to be
// unbolted. (If your rail's ends are blocked and you need to lift
// the holder off in place instead, the top arm has to become a
// removable cap — say so and it's a small change.)
//
// The rail is assumed HORIZONTAL, drives standing vertically
// (open top up) perpendicular to it.
//
// IMPORTANT: add_back_key assumes your rail is slotted on all 4
// faces (standard for 20-series T-slot/V-slot extrusion). If the
// face that ends up against the cradle's back wall is solid in
// your rail, set add_back_key = false so the cradle clamps that
// face flat instead of jamming a key into solid aluminum.
//
// Default key dims (6.2mm mouth / 9.4mm channel) match common
// 20-series T-slot/V-slot extrusion; measure your actual rail and
// adjust slot_mouth/channel_w/lip_thickness/head_depth below if
// it differs — a wrong fit either won't slide in or will be loose.
//
// Print settings: 3-4 walls, 20%+ infill. Print as oriented (comb
// floor and cradle bottom arm both flat on the bed) — the only
// overhang is the cradle's top arm reaching over the rail pocket,
// which wants light support under it. PETG or ABS recommended
// since drives run warm; PLA is fine for a desk build.
// ============================================================

$fn = 48;

// ---- Drive dimensions ----
drive_w = 70;             // drive width (mm) - horizontal, pointing away from the rail
drive_h = 100;             // drive height (mm) - reference only, top is open
drive_t = 9;               // drive thickness (mm) - stacking direction, along the rail
drive_t_clearance = 0.6;   // total slack added to slot thickness for easy insertion
drive_y_clearance = 0.6;   // total slack added along the drive's width

// ---- Holder geometry ----
n_bays      = 3;
wall_t      = 2.6;   // divider / front-wall / back-wall thickness
wall_height = 40;    // how far up the walls enclose the drive (rest is open, at top)
floor_t     = 3;     // base plate thickness
slot_gap    = drive_t + drive_t_clearance;
bay_depth   = drive_w + drive_y_clearance; // how far each bay reaches away from the rail

// ---- Rail mount: cradle wraps top/bottom/back of the rail ----
rail_size         = 20;   // T-slot extrusion cross-section (square)
rail_pocket_clear = 0.6;  // total clearance around the rail inside the cradle pocket
mount_wall_t      = 3;    // thickness of the cradle's back wall and top/bottom arms
cradle_len        = 70;   // how far the cradle runs ALONG the rail (engagement length)
slot_mouth        = 6.2;  // width of the narrow opening on the rail face
channel_w         = 9.4;  // internal width of the T-slot channel
lip_thickness     = 1.6;  // depth of the narrow mouth before it opens into the channel
head_depth        = 1.6;  // how far the wide part of a key sits inside its channel
key_clearance     = 0.3;  // per-side clearance so each key slides freely
key_lead_in       = 2.5;  // taper at each end of every key, so it starts into the slot
add_back_key      = true; // set false if the rail's back face is unslotted

key_neck_w = slot_mouth - 2 * key_clearance;
key_head_w = channel_w - 2 * key_clearance;

// ---- Derived ----
comb_width    = (n_bays + 1) * wall_t + n_bays * slot_gap; // span along the rail
total_height  = floor_t + wall_height;
pocket_span   = rail_size + rail_pocket_clear;  // space the rail + clearance occupies
pocket_z_lo   = mount_wall_t;                   // bottom arm sits flat on the bed
pocket_z_hi   = pocket_z_lo + pocket_span;
rail_z_center = pocket_z_lo + pocket_span / 2;
mount_y_lo    = -(mount_wall_t + pocket_span);  // outer (open) face of the cradle
pocket_y_mid  = -mount_wall_t - pocket_span / 2;
cradle_x0     = (comb_width - cradle_len) / 2;  // cradle centered on the comb

// Bar running along the rail (X) with a tapered lead-in at both
// ends, so a key can start into the slot from either direction.
// w is measured across the slot, h is the protrusion depth.
module lead_in_bar(w, h) {
    inner_w = max(w - 2 * key_lead_in, 0.1);
    hull() {
        translate([cradle_x0 + key_lead_in, -w / 2, 0])
            cube([cradle_len - 2 * key_lead_in, w, h]);
        translate([cradle_x0, -inner_w / 2, 0])
            cube([cradle_len, inner_w, h]);
    }
}

module divider(x) {
    translate([x, 0, floor_t])
        cube([wall_t, bay_depth, wall_height]);
}

module base_body() {
    union() {
        // floor spans the full footprint, including under the front/back walls
        translate([0, -wall_t, 0])
            cube([comb_width, bay_depth + 2 * wall_t, floor_t]);
        // dividers - close the sides of every bay, stacked along the rail
        for (i = [0 : n_bays])
            divider(i * (wall_t + slot_gap));
        // front/back walls - close the near/far side of every bay
        translate([0, -wall_t, floor_t])
            cube([comb_width, wall_t, wall_height]);
        translate([0, bay_depth, floor_t])
            cube([comb_width, wall_t, wall_height]);
    }
}

module rail_cradle() {
    union() {
        // back wall, bonded to the comb's front wall
        translate([cradle_x0, -mount_wall_t, 0])
            cube([cradle_len, mount_wall_t, pocket_z_hi + mount_wall_t]);
        // bottom arm - flat on the bed
        translate([cradle_x0, mount_y_lo, 0])
            cube([cradle_len, mount_wall_t + pocket_span, mount_wall_t]);
        // top arm - reaches back over the rail pocket
        translate([cradle_x0, mount_y_lo, pocket_z_hi])
            cube([cradle_len, mount_wall_t + pocket_span, mount_wall_t]);
    }
}

// Key on the top or bottom arm: protrudes vertically into the
// rail's top/bottom channel. dir = -1 hangs down from the top arm,
// dir = +1 rises up from the bottom arm.
module t_slot_key_arm(z0, dir) {
    neck_z = dir > 0 ? z0 : z0 - lip_thickness;
    head_z = dir > 0 ? z0 + lip_thickness : z0 - lip_thickness - head_depth;
    translate([0, pocket_y_mid, neck_z]) lead_in_bar(key_neck_w, lip_thickness);
    translate([0, pocket_y_mid, head_z]) lead_in_bar(key_head_w, head_depth);
}

// Key on the cradle's back wall: protrudes horizontally into the
// rail's back channel, the 3rd wrapped face.
module t_slot_key_back() {
    rotate([90, 0, 0]) {
        translate([0, rail_z_center, mount_wall_t])
            lead_in_bar(key_neck_w, lip_thickness);
        translate([0, rail_z_center, mount_wall_t + lip_thickness])
            lead_in_bar(key_head_w, head_depth);
    }
}

module ssd_holder() {
    union() {
        base_body();
        rail_cradle();
        t_slot_key_arm(pocket_z_hi, -1); // hangs down into the rail's top channel
        t_slot_key_arm(pocket_z_lo, 1);  // rises up into the rail's bottom channel
        if (add_back_key) t_slot_key_back();
    }
}

ssd_holder();
