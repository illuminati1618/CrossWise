# 3-Bay Vertical 2.5" SSD Holder (T-Slot Mount)

Parametric OpenSCAD design for a bracket that holds three 2.5" drives
(70 x 100 x 9 mm) upright and mounts to a 20x20mm T-slot aluminum
extrusion.

![preview](preview_iso.png)

## Design

- **The long wall is the mount** — the comb's 75.8 x 43mm end face is
  thickened to 4mm and a single T-key is molded straight onto its outer
  surface, running the full 75.8mm. There is no separate plate or block
  bolted onto the holder: the wall that closes the end bay is the same
  wall that grips the rail. The whole mount adds just **3.2mm** to the
  holder's footprint.
- **Fully enclosed bays, open top only** — each drive drops into a boxed-in
  tub: floor + left/right dividers + front/back walls, all 40mm tall. Only
  the top (where the SATA/power connectors are, on a 100mm-tall drive) is
  open, for cable routing.
- **One key, one channel** — it slides into the rail's channel from the end
  of the extrusion and is trapped by that channel's back wall and both side
  lips, while the wall face bears flat against the rail. Tapered lead-ins
  at both ends let it start from either direction and back straight off the
  way it went on.

![section](preview_section.png)

*Cross-section through the mount wall: the T-key is part of the wall, not
an attached plate.*

## Drive arrangement

Mounting on the long face means the rail runs along the holder's 75.8mm
depth, so the three drives sit **in a line running away from the rail**
rather than spread along it. That is what the long face gives you
geometrically — the two faces that are 75.8mm long are the ends of the
drive stack.

The trade: the outermost drive sits ~40mm out from the rail, so a loaded
holder puts a real tipping moment on the single key. In exchange you get
75.8mm of rail engagement, the longest available, and the leanest possible
mount.

## Fitting your rail

Defaults match common 20-series T-slot/V-slot extrusion:

| Parameter | Default | What it is |
|---|---|---|
| `rail_size` | 20 | Extrusion cross-section (square) |
| `slot_mouth` | 6.2 | Width of the narrow opening on the rail face |
| `channel_w` | 9.4 | Internal width of the T-slot channel |
| `lip_thickness` | 1.6 | Depth of the mouth before it opens into the channel |
| `head_depth` | 1.6 | How far the key's wide part sits inside the channel |
| `key_clearance` | 0.3 | Per-side slack so the key slides freely |
| `key_lead_in` | 2.5 | Taper at each end of the key |
| `mount_wall_t` | 4 | Thickness of the long wall carrying the key |

**Measure your actual rail** before printing the whole thing — a wrong fit
either won't slide in or will be loose. Test on a scrap of rail first if
you can: too tight, bump `key_clearance` up in 0.1-0.2mm steps; sloppy,
reduce it. `lip_thickness` + `head_depth` (the key's insertion depth,
3.2mm total) must stay shallower than the rail's actual channel depth or it
won't seat.

Footprint: **43.8 x 75.8 x 43 mm** (across the drive stack x along the
rail x height), of which the mount is 3.2mm.

## Files

- `ssd_holder.scad` — parametric source; all variables are at the top
- `ssd_holder.stl` — ready-to-slice mesh, verified manifold (1 part, 0
  defects via `admesh`)

## Print settings

- 3-4 perimeter walls, 20%+ infill
- PETG or ABS recommended (drives run warm); PLA is fine for a desk build
- **No supports needed** — the comb floor sits flat on the bed and the
  key's 3.2mm horizontal protrusion is short enough to print clean
- Print the mount wall and key with clean, well-adhered first layers —
  that's the load-bearing interface with the rail

## Regenerating the STL

```
openscad -o ssd_holder.stl ssd_holder.scad
```
