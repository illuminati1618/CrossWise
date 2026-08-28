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
// Mounting: ONE flat plate carrying ONE T-shaped key, running the
// full plate_len (default 70mm) along the rail. The key slides
// into the rail's channel from the end of the extrusion and is
// trapped by that channel's back wall and both side lips; the
// plate bears flat against the rail face. Tapered lead-ins at
// both ends of the key let it start from either direction and
// back straight off the way it went on.
//
// Note on "the longer side": with the drives side by side the
// comb's mounting face is its 39.2mm one — the 70mm faces are the
// ends of the stack, and mounting there is what puts the drives
// back in a front-to-back line. So the plate is instead EXTENDED
// to 70mm along the rail, overhanging the comb ~15mm at each end.
// That's the longest rail engagement available without going back
// to front-to-back drives. Set plate_len = comb_width for a flush
// plate if the overhang is in the way.
//
// Optional M3 set screws (set_screw = true) run through the
// plate's two overhanging ends, where nothing is behind them so a
// driver reaches with the drives still in. Driving them against
// the rail face pushes the bracket out and pulls the key's head
// up against the slot lips, taking the play out of the slide fit.
// Without them the bracket still holds but can rock slightly on
// its clearances.
//
// The rail is assumed HORIZONTAL, drives standing vertically
// (open top up) perpendicular to it. The rail's bottom sits flush
// with the bottom of the holder.
//
// Default key dims (6.2mm mouth / 9.4mm channel) match common
// 20-series T-slot/V-slot extrusion; measure your actual rail and
// adjust slot_mouth/channel_w/lip_thickness/head_depth below if
// it differs — a wrong fit either won't slide in or will be loose.
//
// Print settings: 3-4 walls, 20%+ infill, NO SUPPORTS — the comb
// floor and the mounting plate both sit flat on the bed, and the
// key's 3.2mm horizontal protrusion is short enough to print
// clean. PETG or ABS recommended since drives run warm; PLA is
// fine for a desk build.
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

// ---- Rail mount: one flat plate, one key ----
rail_size     = 20;    // T-slot extrusion cross-section (square)
plate_t       = 3;     // mounting plate thickness
plate_len     = 70;    // how far the plate runs ALONG the rail (engagement length)
plate_h       = 20;    // plate height - matches the rail face it bears against
slot_mouth    = 6.2;   // width of the narrow opening on the rail face
channel_w     = 9.4;   // internal width of the T-slot channel
lip_thickness = 1.6;   // depth of the narrow mouth before it opens into the channel
head_depth    = 1.6;   // how far the wide part of the key sits inside the channel
key_clearance = 0.3;   // per-side clearance so the key slides freely
key_lead_in   = 2.5;   // taper at each end of the key, so it starts into the slot
set_screw     = true;  // M3 set-screw holes through the plate to take up slide play
set_screw_d   = 2.9;   // pilot diameter for an M3 screw self-tapping into plastic
set_screw_inset = 7;   // how far each screw sits in from the plate's ends
set_screw_z   = 3.5;   // screw height on the plate - below the key, on solid rail face

key_neck_w = slot_mouth - 2 * key_clearance;
key_head_w = channel_w - 2 * key_clearance;

// ---- Derived ----
comb_width   = (n_bays + 1) * wall_t + n_bays * slot_gap; // span along the rail
total_height = floor_t + wall_height;
plate_x0     = (comb_width - plate_len) / 2;  // plate centered on the comb
key_z        = rail_size / 2;                 // key on the rail's slot centerline

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

module mount_plate() {
    translate([plate_x0, -plate_t, 0])
        cube([plate_len, plate_t, plate_h]);
}

// One segment of the key: a bar running along the rail (X), w tall
// in Z, protruding depth into -Y from y0, tapered at both ends so
// it can start into the slot from either direction.
module key_bar(w, y0, depth) {
    inner_w = max(w - 2 * key_lead_in, 0.1);
    hull() {
        translate([plate_x0 + key_lead_in, y0 - depth, key_z - w / 2])
            cube([plate_len - 2 * key_lead_in, depth, w]);
        translate([plate_x0, y0 - depth, key_z - inner_w / 2])
            cube([plate_len, depth, inner_w]);
    }
}

module t_slot_key() {
    key_bar(key_neck_w, -plate_t, lip_thickness);                 // through the slot mouth
    key_bar(key_head_w, -plate_t - lip_thickness, head_depth);    // inside the channel
}

// Two set screws, placed in the plate's overhanging ends where
// nothing is behind them, so a driver reaches from the back with
// the drives still in. Kept low on the plate, clear of the key:
// pushing the bracket's bottom edge off the rail face both takes
// up the slide play and leans against the way the loaded holder
// wants to tip.
module set_screw_holes() {
    for (x = [plate_x0 + set_screw_inset,
              plate_x0 + plate_len - set_screw_inset])
        translate([x, 1, set_screw_z])
            rotate([90, 0, 0])
                cylinder(d = set_screw_d, h = plate_t + 2);
}

module ssd_holder() {
    difference() {
        union() {
            base_body();
            mount_plate();
            t_slot_key();
        }
        if (set_screw) set_screw_holes();
    }
}

ssd_holder();
