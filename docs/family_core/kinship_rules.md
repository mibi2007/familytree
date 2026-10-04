# Vietnamese Kinship Rule Catalog

This catalog defines the deterministic baseline used by the kinship calculator. It follows common northern Vietnamese terms. Regional or family-specific overrides remain future configuration.

## Inputs

- The relationship is calculated from an acting member to a target member in one family.
- `parent_id` defines ancestry and the lowest common ancestor path.
- The acting member's parent gender determines paternal (`nội`) or maternal (`ngoại`) side.
- Birth dates determine older/younger order. Missing or equal dates produce an explicitly ambiguous result.
- `spouse_id` permits calculation through the acting member's spouse. Such results are marked `via_spouse`.

## Baseline Titles

| Relationship | Rule | Title |
|---|---|---|
| Parent | Male / female | `Bố` / `Mẹ` |
| Grandparent | Paternal male / female | `Ông nội` / `Bà nội` |
| Grandparent | Maternal male / female | `Ông ngoại` / `Bà ngoại` |
| Parent's older sibling | Any gender or side | `Bác` |
| Father's younger sibling | Male / female | `Chú` / `Cô` |
| Mother's younger sibling | Male / female | `Cậu` / `Dì` |
| Older sibling | Male / female | `Anh` / `Chị` |
| Younger sibling | Any gender | `Em` |
| Spouse | Male / female | `Chồng` / `Vợ` |

## Ambiguity Policy

- Unknown gender uses a combined neutral fallback such as `Cha/Mẹ` or `Ông/Bà`.
- Missing age order for a parent's sibling uses the side-and-gender younger title but marks the result ambiguous because `Bác` may be correct.
- Unsupported distant or malformed relationships return `ErrKinshipNotResolved`; they do not invent a title.
- Spouse-side results reuse the title calculated from the spouse's position and are marked `via_spouse` so UI and AI consumers can explain the affinity path.
