# Makefile Commands

Common development commands for ${{ values.appName }}.

## Essential Commands

### `make bootstrap`
Complete project setup (dependencies, code generation, git hooks).

```bash
make bootstrap
```

### `make run`
Run the application.

```bash
make run
```

### `make test`
Run all tests with coverage.

```bash
make test
```

## Development

### `make deps`
Install dependencies.

### `make gen`
Generate code with build_runner.

### `make clean`
Clean build artifacts.

## Code Quality

### `make analyze`
Analyze code for issues.

### `make format`
Format code.

### `make check`
Run format, analyze, and test.

## Building

### `make build`
Build Android APK.

### `make build-ios`
Build iOS application.

### `make build-web`
Build web application.

## Learn More

- [Development Tools](../development/tools.md)
- [Quick Start](../getting-started/quick-start.md)
