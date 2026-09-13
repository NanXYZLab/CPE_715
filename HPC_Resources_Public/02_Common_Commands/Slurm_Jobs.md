# Submit, Monitor, and Cancel Slurm Jobs

## Submit a Job

```bash
sbatch run_em.slurm
```

Slurm returns a job ID, for example:

```text
Submitted batch job 123456
```

## Monitor Your Jobs

```bash
squeue -u "$USER"
```

Common states include:

| State | Meaning |
|---|---|
| `PD` | Pending |
| `R` | Running |
| `CG` | Completing |

A pending job is not necessarily an error; it may be waiting for resources.

## Cancel One Job

```bash
scancel JOB_ID
```

Replace `JOB_ID` with the numeric ID returned by `sbatch`.

## Inspect Output

```bash
ls -lh
less slurm-JOB_ID.out
tail -n 30 em.log
```

Partition names, accounts, time limits, and resource requests are cluster-specific. Use the course-tested script and current KU CRC guidance rather than copying directives from an unrelated research job.

