# Linux Basics

## Navigate and Inspect

| Command | Purpose |
|---|---|
| `pwd` | Show the current directory |
| `ls` | List files |
| `ls -lh` | List files with readable sizes |
| `cd directory` | Enter a directory |
| `cd ..` | Move to the parent directory |
| `cd "$HOME"` | Return to your home directory |
| `mkdir directory` | Create a directory |

## View Text Files

| Command | Purpose |
|---|---|
| `less file.log` | Scroll through a file; press `q` to quit |
| `head -n 20 file.log` | Show the first 20 lines |
| `tail -n 30 file.log` | Show the final 30 lines |
| `tail -f file.log` | Follow new output; press `Ctrl+C` to stop |
| `nano file.txt` | Edit a text file with a beginner-friendly editor |

## Copy and Move

```bash
cp input.mdp input_backup.mdp
cp -r source_directory copied_directory
mv old_name new_name
```

## Delete Carefully

```bash
rm unwanted_file.txt
```

Command-line deletion may not be recoverable. Confirm your current directory and the exact target before deleting anything. Avoid recursive deletion until you understand precisely what it will remove.

## Useful Habits

- Press `Tab` to complete paths and filenames.
- Use the up arrow to recall previous commands.
- Use `history` to review recent commands.
- Use `Ctrl+C` to stop a foreground command.

