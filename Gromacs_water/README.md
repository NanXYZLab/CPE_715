# Pure Water Simulation Tutorial

This tutorial will guide you step by step to build and run a pure water system.

## Step 1. Install Required Software

You will need the following packages:

- **Packmol** → for initial configuration of the system  
- **GROMACS** → for running molecular dynamics simulations  
- **VMD** → for visualization of trajectories

## Step 2. Build the Water Box

Next, we will construct the water box using **Packmol**.

1. Make sure you have **Packmol** installed.  
2. Prepare a **PDB file** of a single water molecule. In this tutorial, we will use `water.pdb`.  
   - `water.pdb` is a coordinate file that contains:
     - The **x, y, z coordinates** of each atom  
     - Residue information  
     - Atom names and connectivity (absent sometimes)  

3. (Optional) Open `water.pdb` to inspect it:
   - Using a text editor (e.g., `vi water.pdb`) to view text file.  
   - Using **VMD** (`vmd water.pdb`) to visualize the molecular structure.  

4. Use Packmol to pack water molecules into a simulation box

   - Now we will use **Packmol** to pack the number of water molecules you want into a box.  
   - An example Packmol input file is shown in the folder as `test.inp`. You will be able to modify this input yourself later.  
   - For more advanced usage and to build fancier systems, see the Packmol tutorial: https://m3g.github.io/packmol/

   In this example, we place **2000 water molecules** inside a box with corners at  
   `(-24, -24, -24)` and `(24, 24, 24)`.

   To run the example with Packmol, simply use:

   ```bash
   packmol < test.inp
   ```

5. Check the Generated Water Box

   After running Packmol, a new file will be created:

   This file contains the coordinates of **2000 water molecules** packed inside the simulation box.

   Check the file to make sure the system looks correct:

   Open with a text editor to see the raw coordinates:
   ```bash
   vi water_2000.pdb
   ```

   Open with VMD to visualize the system:
      ```bash
   vmd water_2000.pdb
      ```

   This way, you can confirm that the molecules are properly placed inside the box.

6. Converting PDB to GRO

In GROMACS, coordinate files are often required in `.gro` format. If you start with a `.pdb` structure, you can convert it as follows:

   ```bash
   gmx editconf -f input.pdb -o output.gro
   ```

## Step 3. Run Molecular Dynamics (MD) Simulations

Now that we have generated the initial structure with Packmol, we can set up and run molecular dynamics (MD) simulations in GROMACS. This stage typically consists of three main parts:

1. **Energy Minimization (EM)**  
   Relax unfavorable contacts in the initial structure to avoid unstable dynamics.  
2. **Equilibration**  
   Bring the system to the desired temperature and pressure in controlled steps.  
3. **Production Run**  
   Generate the actual trajectory for analysis.  

---

### Input files needed for each step

For every stage, GROMACS requires a **TPR file** (`.tpr`). This is a binary input file that cannot be read directly. To generate it, you need:

- **`*.gro` file** – GROMACS coordinate file (similar to `.pdb`, but in GROMACS format).  
- **`*.top` file** – topology file describing molecules, force field parameters, and system composition.  
- **`*.mdp` file** – parameter (control) file specifying integration settings, thermostat/barostat choices, cutoffs, etc.  

The `.tpr` file is generated using `gmx grompp`, and the simulation is run with `gmx mdrun`.

---

### 3.1 Energy Minimization

Minimization is necessary because Packmol structures often place atoms too close together, leading to extremely high forces and unstable dynamics.

Preprocess and generate *.tpr file
```
gmx grompp -f minim.mdp -c conf.gro -p topol.top -o em.tpr
```
Run minimization
```
gmx mdrun -deffnm em
```
After minimization, check the potential energy:
```
gmx energy -f em.edr -o potential.xvg
```

Select Potential when prompted. The energy should decrease smoothly.

### 3.2 NVT Equilibration (constant N, V, T)

Equilibrate the system at the target temperature while keeping the volume fixed.

```
gmx grompp -f nvt.mdp -c em.gro -p topol.top -o nvt.tpr
```
Run NVT equilibration
```
gmx mdrun -deffnm nvt
```

Check temperature stability:

gmx energy -f nvt.edr -o temperature.xvg

### 3.3 NPT Equilibration (constant N, P, T)

Next, equilibrate both pressure and temperature to reach the correct system density.

```
gmx grompp -f npt.mdp -c nvt.gro -p topol.top -o npt.tpr
```
Run NPT equilibration

```
gmx mdrun -deffnm npt
```

Check pressure and density:

```
gmx energy -f npt.edr -o pressure.xvg
gmx energy -f npt.edr -o density.xvg
```

### 3.4 Production Run

After equilibration, you are ready to run **production MD**. This stage is where you generate the actual trajectories (`.xtc` or `.trr`) for your scientific analysis.  

The setup is very similar to the equilibration runs, but with one key difference:  
- **Do not re-generate velocities**. The production simulation must continue smoothly from the equilibrated system state, so you should disable velocity generation in the `*.mdp` file (set `gen_vel = no`).


### Notes

The .mdp files (minim.mdp, nvt.mdp, npt.mdp, npt2.mdp) are templates you can adjust. For example, you can change the thermostat (e.g., Berendsen, V-rescale) or barostat (e.g., Parrinello–Rahman). For more details please refer to https://manual.gromacs.org/current/user-guide/mdp-options.html

Always inspect your log files and energy output before moving to the next step.

Visualization with VMD, PyMOL, or gmx view is highly recommended to confirm system stability.
