# Guided GROMACS Exercise: Pure Water

In this exercise, you will run a small molecular-dynamics workflow on the KU
Community Cluster. The starting water box and input templates are provided.
You are not expected to build a force field from scratch.

## Learning Goals

By the end of the exercise, you should be able to:

- identify coordinate, topology, parameter, and run-input files;
- explain why energy minimization precedes molecular dynamics;
- distinguish NVT, NPT, and production stages;
- prepare a GROMACS run with `gmx grompp`;
- submit and monitor a calculation with Slurm; and
- inspect energy, temperature, pressure, and density outputs.

## Before Class

Request KU Community Cluster access as described in
[`HPC_Resources_Public`](../HPC_Resources_Public/README.md). Your instructor
will announce the current login hostname, GROMACS module, course account, and
partition.

## Files Used

| File | Purpose |
|---|---|
| `water_2000.pdb` | Provided coordinates for 2,000 water molecules |
| `topol.top` | System topology and force-field includes |
| `minim.mdp` | Energy-minimization settings |
| `nvt.mdp` | Constant-volume temperature equilibration |
| `npt.mdp` | Constant-pressure temperature equilibration |
| `production.mdp` | Short production MD run |
| `run_water.slurm` | Example Slurm workflow |

`water.pdb` and `test.inp` show how the initial configuration was constructed
with Packmol. The prepared `water_2000.pdb` is supplied so Packmol is not
required for the classroom exercise.

## 1. Log In and Copy the Course Repository

Follow the instructor's current cluster directions. After obtaining the course
files, move into this directory:

```bash
cd CPE_715/Gromacs_water
```

Load the GROMACS module announced in class and verify the command:

```bash
module avail gromacs
module load GROMACS_MODULE_NAME
gmx --version
```

Do not type the placeholder literally; replace `GROMACS_MODULE_NAME` with the
module announced by the instructor.

## 2. Prepare the Coordinate File

The Packmol box is 48 angstrom on each side. Center it and set the GROMACS box
dimensions (GROMACS uses nm):

```bash
gmx editconf -f water_2000.pdb -o conf.gro -c -box 4.8 4.8 4.8
```

Check the last line of `conf.gro`; it should contain the box dimensions.

## 3. Run the Workflow Interactively for Learning

Only run these commands during an instructor-approved interactive session or
on a compute node—not as a substantial job on the login node.

### Energy minimization

```bash
gmx grompp -f minim.mdp -c conf.gro -p topol.top -o em.tpr
gmx mdrun -deffnm em
```

### NVT equilibration

```bash
gmx grompp -f nvt.mdp -c em.gro -p topol.top -o nvt.tpr
gmx mdrun -deffnm nvt
```

### NPT equilibration

```bash
gmx grompp -f npt.mdp -c nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -deffnm npt
```

### Production MD

```bash
gmx grompp -f production.mdp -c npt.gro -t npt.cpt -p topol.top -o production.tpr
gmx mdrun -deffnm production
```

## 4. Submit Through Slurm

Edit the two placeholder lines in `run_water.slurm` using the course values
announced by the instructor:

```text
#SBATCH --partition=sixhour
```

Also replace `GROMACS_MODULE_NAME`, then submit:

```bash
sbatch run_water.slurm
squeue -u "$USER"
```

## 5. Inspect the Results

```bash
gmx energy -f em.edr -o potential.xvg
gmx energy -f nvt.edr -o temperature.xvg
gmx energy -f npt.edr -o density.xvg
gmx energy -f production.edr -o total_energy.xvg
```

Select the requested quantity when prompted. Before proceeding between stages,
read the end of each `.log` file and check that the calculation completed.

## Short Check-In

Be prepared to show:

1. the submitted job and its final status;
2. one energy or thermodynamic plot;
3. the average density from the NPT stage; and
4. two or three sentences explaining whether the system appears ready for a
   production simulation.

## Optional: Rebuild the Starting Box

Packmol is optional. If it is available, `test.inp` creates the provided box:

```bash
packmol < test.inp
```

The bundled `packmol` executable is platform-specific and is not required.

