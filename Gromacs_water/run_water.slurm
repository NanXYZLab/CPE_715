#!/bin/bash
#SBATCH --job-name=cpe715-water
#SBATCH --account=COURSE_ACCOUNT
#SBATCH --partition=COURSE_PARTITION
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:30:00
#SBATCH --output=water-%j.out
#SBATCH --error=water-%j.err

set -euo pipefail

module purge
module load GROMACS_MODULE_NAME

gmx editconf -f water_2000.pdb -o conf.gro -c -box 4.8 4.8 4.8

gmx grompp -f minim.mdp -c conf.gro -p topol.top -o em.tpr
gmx mdrun -deffnm em

gmx grompp -f nvt.mdp -c em.gro -p topol.top -o nvt.tpr
gmx mdrun -deffnm nvt

gmx grompp -f npt.mdp -c nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -deffnm npt

gmx grompp -f production.mdp -c npt.gro -t npt.cpt -p topol.top -o production.tpr
gmx mdrun -deffnm production

