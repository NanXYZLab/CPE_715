# First Login and Course Workspace

## Before You Log In: Connect to the KU Network

You must be connected to the **KU/KUMC network** before accessing the cluster.

- If you are on campus and connected directly to the KU/KUMC network, you may
  proceed to the login step below.
- If you are off campus, first install and connect to
  [KU Anywhere VPN](https://technology.ku.edu/catalog/ku-anywhere-vpn).

After the VPN connection is active, continue with the SSH login.

## Log In to the Cluster

Use the hostname provided in your KU CRC welcome email or the current KU CRC documentation:

```bash
ssh YOUR_KU_ID@CLUSTER_HOSTNAME
```

Replace `YOUR_KU_ID` and `CLUSTER_HOSTNAME` with your own information.

example:

```bash
ssh apple@hpc.crc.ku.edu
```

## Create a Personal Course Directory

After logging in:

```bash
mkdir -p "$HOME/CPE715"
cd "$HOME/CPE715"
pwd
ls -lh
```

Keep your own work inside your authorized personal or course directory.

## Login Node vs. Compute Node

The login node is appropriate for:

- Organizing and inspecting files
- Editing small text files
- Loading modules for brief checks
- Preparing and submitting jobs

Submit substantial calculations through the scheduler. Do not run long molecular simulations directly on the login node.

## End the Session

```bash
exit
```
