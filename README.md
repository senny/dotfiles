# Dotfiles

### Installation

To link files and directories into the user home:

```
curl https://mise.run | sh

git clone git@github.com:senny/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles

cp mise.local.toml.example mise.local.toml
~/.local/bin/mise trust -a

```

Set required variables
```
~/.local/bin/mise config set \
  --file mise.local.toml \
  --type string \
  vars.git_name "Your Name"

~/.local/bin/mise config set \
  --file mise.local.toml \
  --type string \
  vars.git_email "you@example.com"
```

Run the bootstrap
```
~/.local/bin/mise bootstrap
```
