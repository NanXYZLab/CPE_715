# Using Software Modules

HPC systems commonly use environment modules to provide software packages.

## Discover Software

```bash
module avail
module spider gromacs
```

## Load Software

First use `module spider` to identify an available version and any required dependencies. Then load the module reported by the cluster:

```bash
module load GROMACS_MODULE_NAME
```

The exact module name may change. Do not assume that a version shown in an old example is currently available.

## Check the Environment

```bash
module list
which gmx
gmx --version
```

Depending on the module, the executable may have a different name, such as `gmx_mpi`. Use the command provided by the current module and course instructions.

## Reset Modules

```bash
module purge
```

