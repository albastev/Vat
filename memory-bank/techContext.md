# Tech Context: Vat

## Language and runtime

- **Language:** Raku (`use v6` syntax currently in source)
- **Primary runtime target:** modern Rakudo-compatible environment
- **Package metadata:** `META6.info` (`perl: "6.d"`, module provides map)

## Project structure

- `lib/` contains core library modules (`Vat`, `Vat::Simple`, `Vat::Conduit`, attachment types)
- `t/` contains test scripts covering vats, conduits, and attachment behaviors
- `memory-bank/` contains persistent project context for continuity
- `Dockerfile` enables containerized test execution
- `.travis.yml` indicates legacy/transition CI context

## Tooling and workflows

- Local test pattern in repo: execute Raku tests from `t/` with `-Ilib`
- Recommended explicit test command for modernization: `prove -e raku -Ilib t`
- Docker test flow available via `docker build` + `docker run`
- Ecosystem install expectation: `zef install .`

## Constraints

- Preserve existing behavior as defined by current tests
- Prefer incremental modernization (metadata/CI/docs) over algorithmic rewrites
- Keep API compatibility during initial modernization pass

## Known technical debt

- Minimal README currently does not reflect module capabilities
- Legacy CI configuration (`.travis.yml`) remains present
- Some code style/era conventions are older and may need gradual normalization
