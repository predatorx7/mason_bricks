./scripts/cleanup_mason.sh

mason init
mason add generate --path ./bricks/generate
mason make generate --output-dir ./examples/generate/
