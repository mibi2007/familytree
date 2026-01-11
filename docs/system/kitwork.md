# Kitwork Scheduling

This project uses [Kitwork](https://kitwork.io) for managing scheduled jobs.

## Installation

To install Kitwork, run:

```bash
go install github.com/kitwork/kitwork@latest
```

## Running the Scheduler

To start the Kitwork scheduler and run the defined workflows:

```bash
kitwork run
```

Or specific file:

```bash
kitwork run workflows/example_job.work
```

## Workflows

Workflows are defined in the `familytree_go/workflows/` directory with `.work` extension.
The `example_job.work` is configured to run `cmd/worker/main.go` every minute.

## Library

The project also has `github.com/kitwork/work` installed if you need to define workflows programmatically in Go, although generic usage is via the `.work` files.
