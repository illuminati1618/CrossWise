# 3-Bay Vertical 2.5" SSD Holder (T-Slot Mount)

Parametric OpenSCAD design for a bracket that holds three 2.5" drives
(70 x 100 x 9 mm) upright, side by side along a 20x20mm T-slot aluminum
extrusion.

![preview](preview_iso.png)

## Design

- **Drives side-by-side along the rail** — all three bays sit the same
  distance out from the rail, spread along its length, rather than
  receding front-to-back. No drive hangs off the end of a long lever arm,
  so the load stays close to the mount.
- **Fully enclosed bays, open top only** — each drive drops into a boxed-in
  tub: floor + left/right dividers + front/back walls, all 40mm tall. Only
  the top (where the SATA/power connectors are, on a 100mm-tall drive) is
  open, for cable routing.
- **Cradle wraps 3 faces, keyed on all 3** — a U-shaped cradle wraps the
  rail's top, bottom, and back faces, leaving the outward face open.
  T-shaped keys are molded into all three wrapped faces and engage the
  rail's top, bottom, and back channels, each trapped by its own channel's
  back wall and side lips. Three keyed faces resist pull-off, twist, *and*
  rock. No bolts, no separate T-nuts.
- **Long engagement** — the cradle runs `cradle_len` along the rail
  (default 70mm) even though the comb itself is only 39.2mm wide, so
  restacking the drives side-by-side doesn't cost mounting length. It
  overhangs the comb by ~15mm at each end; reduce `cradle_len` if space is
  tight.

![section](preview_section.png)

*Cross-section through the cradle: the C-channel opens to the left, with
all three T-keys protruding into the rail pocket.*

## Sliding it on and off

The cradle slides on and off from the **end of the rail**. Every key runs
straight along the rail's axis and has a tapered lead-in at both ends
(`key_lead_in`), so it starts easily and can be backed straight off the way
it went on — nothing to unbolt.

Because the back face is keyed too, the holder can *only* come off the
rail's end, not be lifted off sideways. If your rail's ends turn out to be
blocked, the fix is to make the top arm a separate removable cap — a small
change, just ask.

## Fitting your rail

Defaults match common 20-series T-slot/V-slot extrusion:

| Parameter | Default | What it is |
|---|---|---|
| `rail_size` | 20 | Extrusion cross-section (square) |
| `slot_mouth` | 6.2 | Width of the narrow opening on the rail face |
| `channel_w` | 9.4 | Internal width of the T-slot channel |
| `lip_thickness` | 1.6 | Depth of the mouth before it opens into the channel |
| `head_depth` | 1.6 | How far a key's wide part sits inside its channel |
| `key_clearance` | 0.3 | Per-side slack so keys slide freely |
| `rail_pocket_clear` | 0.6 | Total slack around the rail inside the pocket |

**Measure your actual rail** before printing the whole thing — a wrong fit
either won't slide in or will be loose. Test the cradle on a scrap of rail
first if you can: too tight, bump `key_clearance` up in 0.1-0.2mm steps;
sloppy, reduce it. `lip_thickness` + `head_depth` (each key's insertion
depth, 3.2mm total) must stay shallower than the rail's actual channel
depth or it won't seat.

`add_back_key` assumes the rail is slotted on **all four faces**, which is
standard for 20-series extrusion. If the face that lands against the
cradle's back wall is solid in your rail, set `add_back_key = false` so the
cradle clamps it flat instead of jamming a key into solid aluminum.

Footprint: **70 x 96.8 x 43 mm** (along rail x out from rail x height).

## Files

- `ssd_holder.scad` — parametric source; all variables are at the top
- `ssd_holder.stl` — ready-to-slice mesh, verified manifold (1 part, 0
  defects via `admesh`)

## Print settings

- 3-4 perimeter walls, 20%+ infill
- PETG or ABS recommended (drives run warm); PLA is fine for a desk build
- Print as oriented — the comb floor and the cradle's bottom arm both sit
  flat on the bed
- **Light support is needed under the cradle's top arm**, which reaches out
  over the rail pocket. Everything else is support-free.
- Print the cradle and keys with clean, well-adhered first layers — that's
  the load-bearing interface with the rail

## Regenerating the STL

```
openscad -o ssd_holder.stl ssd_holder.scad
```
