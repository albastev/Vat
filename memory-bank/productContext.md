# Product Context: Vat

## Why this project exists

`Vat` provides a compact simulation model for liquid movement across connected containers. It is designed as a composable library where individual vats and attachments can be wired into networks to model transfer behavior over time (tick-based progression).

## Problems it solves

- Simulates directional and bidirectional transfer between containers
- Encodes realistic-enough constraints (attachment height, per-tick capacity, open/closed valves)
- Enables experimentation with flow behavior in multi-vat systems using small, testable primitives

## How it should work

- Each vat tracks volume and exposes derived level/pressure behavior
- Attachments represent transfer interfaces mounted at specific heights on vats
- Conduits orchestrate flow by comparing attachment pressure and moving volume accordingly
- System evolution happens in ticks, with each tick recalculating levels and applying constrained transfers

## User experience goals

- Easy to understand core API for building simulation setups
- Predictable behavior validated by tests
- Straightforward local test execution and modern Raku ecosystem alignment
- Clear documentation for onboarding contributors and users
