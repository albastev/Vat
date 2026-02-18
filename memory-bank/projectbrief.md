# Project Brief: Vat (Raku Modernization + Documentation)

## Context

`Vat` is an early-stage Raku simulation library for modeling liquid transfer between connected containers (vats) through pressure-aware attachments and conduits.

Current state highlights:

- Ecosystem metadata still references legacy Perl 6 naming (`perl: "6.c"`)
- CI uses Travis (`.travis.yml`) and `perl6` keys
- Source/test files use shebangs and patterns from older Raku-era Perl 6 conventions
- README is currently minimal and should be expanded significantly

This brief defines the modernization and documentation direction for the repository.

---

## Objectives

1. **Modernize project positioning to current Raku conventions**
2. **Preserve existing behavior while updating tooling and metadata**
3. **Ship strong, user-facing documentation (README) for onboarding and contribution**

---

## Scope

### In Scope

- Refresh package metadata (`META6.info`) for modern Raku compatibility expectations
- Replace outdated references (`perl6`) with `raku` where appropriate
- Introduce modern CI workflow (GitHub Actions) for automated test runs
- Expand README with:
  - project overview and core concepts
  - installation instructions
  - usage examples
  - architecture/module map
  - test instructions
- Keep existing API semantics and test expectations intact unless intentionally changed

### Out of Scope (for initial modernization pass)

- Major redesign of conduit transfer algorithm
- Breaking API redesign across modules
- Deep physics realism improvements beyond current tick-based model

---

## Proposed Modernization Plan

### 1) Metadata & Ecosystem Alignment

- Update `META6.info` fields to align with modern usage expectations
- Validate module loading with current Rakudo
- Confirm installability via `zef install .`

### 2) CI Modernization

- Add GitHub Actions workflow to run test suite on push/PR
- Keep Travis file temporarily (optional) until migration confidence is high
- Ensure CI command path is explicit and reproducible (`prove -e raku -Ilib t`)

### 3) Codebase Compatibility Sweep

- Verify all files compile and tests pass under current stable Rakudo
- Normalize any clearly outdated syntax if needed while preserving behavior
- Review shebangs and script conventions (`#!/usr/bin/env raku` where relevant)

### 4) Documentation Upgrade

- Rebuild README as a practical guide:
  - What Vat does
  - How to install
  - How to simulate with `Vat::Conduit`, `Vat::Simple`, and attachments
  - How each attachment type behaves
  - How to run tests locally
- Include caveats and current maturity level (`0.0.1`)

---

## Risks & Mitigations

- **Risk:** Modernization introduces subtle behavioral changes.
  - **Mitigation:** Use existing tests as behavior guardrails; add tests for any uncovered modernization edge cases.

- **Risk:** CI migration fails due to environment assumptions.
  - **Mitigation:** Start with minimal workflow and explicit dependency install steps.

- **Risk:** Documentation drifts from implementation.
  - **Mitigation:** Tie README examples to tested scenarios from `t/` where possible.

---

## Success Criteria

- Project installs with modern Raku + zef without legacy setup requirements
- Test suite passes locally and in CI
- README is comprehensive enough for a new user to run and understand the simulation
- Repo messaging consistently uses **Raku** terminology

---

## Immediate Next Actions

1. Expand and finalize `README.md`
2. Update `META6.info` and verify with `zef` + local tests
3. Add GitHub Actions workflow for test automation
4. Run compatibility pass and capture any follow-up issues
