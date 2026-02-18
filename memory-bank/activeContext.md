# Active Context: Vat

## Current work focus

Initialize the Memory Bank so all required core context files exist and accurately describe the repository’s current state.

## Recent changes

- Created `memory-bank/productContext.md`
- Created `memory-bank/systemPatterns.md`
- Created `memory-bank/techContext.md`

## Current repository snapshot

- Core simulation code is present in `lib/` with role/class composition centered around vats, attachments, and conduits.
- Test suite exists in `t/` and acts as behavioral guardrails.
- Documentation and modernization are active priorities, per `projectbrief.md`.

## Active decisions and considerations

- Use existing tests as the source of truth for behavior preservation.
- Keep modernization incremental: improve metadata/tooling/docs before deeper algorithmic changes.
- Preserve compatibility with current API semantics unless explicitly planned otherwise.

## Next steps

1. Finalize memory bank initialization by adding `progress.md`.
2. Use memory bank files as baseline for upcoming modernization tasks (README expansion, CI refresh, metadata alignment).

## Important patterns/preferences

- Favor clear, practical docs over abstract descriptions.
- Keep simulation patterns explicit (tick progression, pressure-based flow, attachment capacity).
- Record meaningful architectural/behavioral decisions when they emerge.
