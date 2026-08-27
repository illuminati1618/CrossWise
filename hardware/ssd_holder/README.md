# 3-Bay Vertical 2.5" SSD Holder (T-Slot Mount)

Parametric OpenSCAD design for a small bracket that holds three 2.5" drives
(70 x 100 x 9 mm) upright, side by side, and mounts to a 20x20mm T-slot
aluminum extrusion.

![preview](preview_iso.png)

## Design

- **Fully enclosed bays, open top only** — each drive drops into a boxed-in
  tub: floor + left/right dividers + front/back walls, all 40mm tall. Only
  the top (where the SATA/power connectors are, on a 100mm-tall drive) is
  open, for cable routing.
- **Sliding T-slot key** — the front wall doubles as the rail bracket. A
  T-shaped key is molded onto its outer face and slides in from the end of
  the extrusion, trapped by the channel's back wall and both side lips (3
  sides of the channel), so the bracket resists being pulled straight off
  the rail — no bolts, no separate T-nuts. Default key dims (6.2mm slot
  mouth / 9.4mm channel, 3.2mm total engagement) match common 20-series
  T-slot/V-slot extrusion. **Measure your actual rail** and adjust
  `slot_mouth`, `channel_w`, `lip_thickness`, `head_depth` in the .scad if
  it differs — a wrong fit either won't slide in or will be loose.
- **One part, no supports** — everything is a single print, nothing
  overhangs past 90 degrees.

Footprint: **39.2 x 80.4 x 43 mm** (width x front-to-back depth x height,
front-to-back includes the 4mm bracket wall and the 3.2mm key
protrusion).

## Files

- `ssd_holder.scad` — parametric source (edit the variables at the top to
  change drive size, clearance, wall height, key dimensions, etc.)
- `ssd_holder.stl` — ready-to-slice mesh, verified manifold (1 part, 0
  defects via `admesh`)

## Print settings

- 3-4 perimeter walls, 20%+ infill
- PETG or ABS recommended (drives run warm); PLA is fine for a desk build
- No supports needed
- Print the key with clean, well-adhered first layers — it's the
  load-bearing interface with the rail

## Fit-checking the key

Slide the printed key into a short scrap of your rail before printing the
full holder if you can. If it's too tight, bump `key_clearance` up in
0.1-0.2mm steps; if it's sloppy, reduce it. `lip_thickness` + `head_depth`
(the key's total insertion depth) must stay shallower than your rail's
actual channel depth or it won't seat.

## Regenerating the STL

```
openscad -o ssd_holder.stl ssd_holder.scad
```
