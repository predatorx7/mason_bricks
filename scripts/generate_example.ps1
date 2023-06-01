.\scripts\cleanup_mason.ps1

mason init
mason add generate --path ./bricks/generate
mason make generate --output-dir ./examples/generate/
