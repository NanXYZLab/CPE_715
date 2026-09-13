# CPE 715: Molecular Modeling Tools

Welcome to the course repository for **CPE 715: Molecular Modeling Tools**.

This repository contains course computing resources, HPC instructions, and
guided molecular simulation exercises.

## Where Should I Start?

Please begin with:

1. [`HPC_Resources_Public`](HPC_Resources_Public/)  
   Learn how to request access to the KU Community Cluster, connect to the
   cluster, transfer files, load software, and submit Slurm jobs.

2. [`Gromacs_water`](Gromacs_water/)  
   Complete the guided GROMACS water simulation exercise.

Each folder contains its own `README.md` with more detailed instructions.

## Repository Contents

### `HPC_Resources_Public/`

This folder contains the minimum HPC information needed for the course,
including:

- requesting access to the KU Community Cluster;
- connecting through the KU/KUMC network or KU Anywhere VPN;
- logging in with SSH;
- basic Linux commands;
- transferring files;
- loading software modules; and
- submitting and monitoring Slurm jobs.

For additional information, consult the official
[KU CRC Quick Start Guide](https://docs.crc.ku.edu/quick-start/).

### `Gromacs_water/`

This folder contains a guided molecular dynamics simulation of pure water using
GROMACS.

The exercise includes:

- examining and preparing the initial water structure;
- energy minimization;
- NVT equilibration;
- NPT equilibration;
- a short production MD simulation;
- submitting the simulation through Slurm; and
- basic analysis of energy, temperature, pressure, and density.

The required structure, topology, parameter, and example job files are provided
in the folder.

## Important Notes

- Follow the instructions provided in each folder.
- Use only your authorized KU Community Cluster account and course resources.
- Do not run substantial simulations directly on a login node.
- Never share your password, authentication code, or private key.
- Cluster software and settings may change. Follow current course announcements
  and KU CRC documentation.

## Questions

If you encounter a problem, bring the following information to class or office
hours:

- the command you entered;
- the relevant error message; and
- the name of the file or simulation step involved.
