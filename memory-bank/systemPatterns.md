# System Patterns: Vat

## High-level architecture

The library follows a small compositional simulation architecture:

- **Vat role (`Vat`)**: shared behavior for stateful liquid containers (volume, level, fill/drain, supply stream)
- **Concrete vat (`Vat::Simple`)**: baseline implementation of level calculation from volume
- **Attachment role (`Vat::Attachment`)**: interface layer between a vat and transfer logic
- **Attachment implementations (`Vat::Hole`, `Vat::Valve`, `Vat::InletValve`, `Vat::OutletValve`, `Vat::Float*`)**: flow policy variants
- **Conduit (`Vat::Conduit`)**: transfer coordinator among multiple attachments based on pressure differential

## Key technical decisions

- **Role-based composition** for shared behavior (`Vat`, `Vat::Attachment`)
- **Tick-driven simulation** to evolve system state in deterministic steps
- **Pressure abstraction** via `vat level - attachment_level`, clamped at zero
- **Capacity throttling** per attachment per tick (`capacity_used` reset in `tick`)
- **Supply/event propagation** from vats to attachments through `Supplier`/`Supply`

## Core flow pattern

1. A conduit attaches vats through attachments and subscribes attachments to vat level updates.
2. On conduit tick, attachments are sorted by pressure (high to low).
3. Candidate source/sink attachments are selected and validated (`accepts_flow_*`, remaining capacity).
4. Unit volume transfer attempts are made (`flow_out` + `flow_in`) while pressure gradient permits.
5. Vats emit updated levels on their own ticks.

## Constraints and invariants

- Attachments above current vat level are non-submerged and contribute zero pressure.
- Transfer requires positive pressure difference and valid source/sink permissions.
- Attachment capacity limits net movement within a tick.
- Existing tests are the behavioral contract and should guard modernization changes.
