# File Transfer

Run transfer commands from a terminal on your **local computer**, not from inside the remote cluster session.

## Upload One File

```bash
scp local_file.txt YOUR_KU_ID@CLUSTER_HOSTNAME:~/CPE715/
```

## Upload a Directory

```bash
scp -r local_directory YOUR_KU_ID@CLUSTER_HOSTNAME:~/CPE715/
```

## Download a File

```bash
scp YOUR_KU_ID@CLUSTER_HOSTNAME:~/CPE715/output.log .
```

## Resumable Directory Transfer

For a directory containing larger files:

```bash
rsync -avP local_directory/ YOUR_KU_ID@CLUSTER_HOSTNAME:~/CPE715/local_directory/
```

## Safety and Privacy

- Do not upload passwords, private keys, authentication codes, or restricted data to GitHub.
- Do not place private research files in a public course repository.
- Follow the current KU CRC storage and data-retention policies.
- Large trajectory files generally should not be committed to Git.

