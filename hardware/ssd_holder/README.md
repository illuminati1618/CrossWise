# 3-Bay Vertical 2.5" SSD Holder (T-Slot Mount)

Parametric OpenSCAD design for a small bracket that holds three 2.5" drives
(70 x 100 x 9 mm) upright, side by side, and bolts to a 20x20mm T-slot
aluminum extrusion.

![preview](preview_iso.png)

## Design

- **Comb slots, open top** — each drive drops into a 9.6mm gap between two
  2.6mm dividers. The dividers only rise 40mm (drives are 100mm tall), so
  the top ~60mm — where the SATA/power connectors are — stays completely
  open for cable routing.
- **Rear T-slot bracket** — a single 4mm plate spans the back of the comb
  and bolts straight to the rail with two M5 bolts + T-nuts (26mm apart,
  centered on the rail). Counterbored holes let the bolt heads sit flush
  against the rail face. No printed threads, no extra hardware.
- **One part, no supports** — everything is a single print, nothing
  overhangs past 90 degrees.

Footprint: **39.2 x 70 x 43 mm**.

## Files

- `ssd_holder.scad` — parametric source (edit the variables at the top to
  change drive size, clearance, wall height, bolt spacing, etc.)
- `ssd_holder.stl` — ready-to-slice mesh, verified manifold (1 part, 0
  defects via `admesh`)

## Print settings

- 3-4 perimeter walls, 20%+ infill
- PETG or ABS recommended (drives run warm); PLA is fine for a desk build
- No supports needed

## Hardware

- 2x M5 bolts + M5 T-nuts sized for your rail's slot (standard for 2020
  T-slot extrusion)

## Regenerating the STL

```
openscad -o ssd_holder.stl ssd_holder.scad
```
