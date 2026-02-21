# dotfiles

This repository tracks my dotfiles (configuration files) and everything needed to reproduce my environment declaratively, mainly using GNU Guix.

## Structure

- `guix/`
  - `config.scm`: system configuration (GNU Guix System), including kernel/firmware, bootloader, file systems, users, and services (e.g., Docker, Syncthing, DHCP, and OpenSSH).
  - `home-configuration.scm`: user environment configuration with GNU Guix Home (packages and files under `$HOME`/XDG), such as `zsh`, `emacs`, `git`, and `pass`, plus files under `~/.config/emacs/`.
  - `channels.scm`: Guix channel definitions (including `nonguix`).

- `zsh/`
  - `.zshrc`: shell configuration.

- `emacs/`
  - Submodule containing the Emacs configuration: https://github.com/morazotti/emacs-config

## Notes

- The goal is for this repository to be the “source of truth” for my configuration.
- Some files are consumed directly by tools like GNU Guix Home (via `home-configuration.scm`) instead of manual symlinks.
