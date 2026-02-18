# Vat

`Vat` is a small Raku simulation library for modeling liquid transfer between connected containers.

It provides composable primitives for:

- containers (`Vat::Simple`)
- transfer interfaces mounted at specific heights (`Vat::Attachment` implementations)
- transfer coordination across a network (`Vat::Conduit`)

The simulation advances in **ticks**, and transfer is based on pressure differences, attachment type, and per-tick capacity.

## Status

This project is currently early-stage (`0.0.1`) and best treated as an experimental simulation toolkit.

## Installation

### From source (local clone)

```bash
zef install .
```

### For local development

Use the repository directly and include `lib` on your load path:

```bash
raku -Ilib your-script.raku
```

## Quick start

```raku
use v6;
use lib 'lib';

use Vat::Simple;
use Vat::Conduit;
use Vat::Hole;

my $vat1 = Vat::Simple.new(volume => 100);
my $vat2 = Vat::Simple.new(volume => 0);

my $conduit = Vat::Conduit.new;

# attachment_level controls where the interface sits on each vat
my $a1 = Vat::Hole.new(attachment_level => 0,  capacity => 1);
my $a2 = Vat::Hole.new(attachment_level => 10, capacity => 1);

$conduit.attach($vat1, $a1);
$conduit.attach($vat2, $a2);

# Prime level updates for attachments
$vat1.tick;
$vat2.tick;

for 1..10 {
    $conduit.tick;
    $vat1.tick;
    $vat2.tick;
}

say "vat1 level: {$vat1.calculate_level}";
say "vat2 level: {$vat2.calculate_level}";
```

## Core concepts

### Vat

The `Vat` role models a container with:

- `volume`
- derived `level`
- `fill` and `drain` behavior
- a level `Supply` used by attachments/conduits

`Vat::Simple` is the provided concrete implementation.

### Attachment

Attachments sit at an `attachment_level` and define transfer policy.

Implemented attachment types:

- `Vat::Hole` - bidirectional flow
- `Vat::Valve` - bidirectional flow, but only when explicitly opened
- `Vat::InletValve` - allows inflow only
- `Vat::OutletValve` - allows outflow only
- `Vat::FloatValve` - opens when submerged
- `Vat::FloatPlug` - closes when submerged

Each attachment also enforces per-tick transfer `capacity`.

### Conduit

`Vat::Conduit` connects vats through attachments and performs transfer on each tick by:

1. sorting attachments by pressure
2. selecting source/sink candidates
3. moving unit volume while constraints permit
4. respecting directionality and capacity limits

## Running tests

### Local

Run all tests with:

```bash
prove -e raku -Ilib t
```

Or run a single test directly:

```bash
raku -Ilib t/Conduit.t
```

### Docker

Build the test image:

```bash
docker build --no-cache --progress=plain -t vat-test .
```

Run the test suite:

```bash
docker run --rm vat-test
```

## Project layout

```text
lib/
  Vat.rakumod                # Core Vat role
  Vat/Simple.rakumod         # Basic vat implementation
  Vat/Attachment.rakumod     # Attachment role
  Vat/Conduit.rakumod        # Transfer coordinator
  Vat/Hole.rakumod
  Vat/Valve.rakumod
  Vat/InletValve.rakumod
  Vat/OutletValve.rakumod
  Vat/FloatValve.rakumod
  Vat/FloatPlug.rakumod
t/                            # Behavioral tests
```

## Development notes

- Existing tests in `t/` are the behavioral contract.
- The simulation is deterministic and tick-driven.
- If you add a new attachment type, add matching tests under `t/` to capture flow policy.

## License

Licensed under the terms in [`LICENSE`](LICENSE).
