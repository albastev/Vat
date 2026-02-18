FROM rakudo-star:latest

WORKDIR /app

COPY . /app

# Run the full test suite
CMD ["sh", "-lc", "set -e; for t in t/*.t; do echo \"==> $t\"; raku -Ilib \"$t\"; done"]