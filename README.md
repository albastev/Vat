# vat

Build a network of Vats that transfer * between them...

## Run tests in Docker

Build the test image:

```bash
docker build --no-cache --progress=plain -t grammar-modelica-test . 2>&1
```

Run the test suite:

```bash
docker run --rm grammar-modelica-test 2>&1
```
