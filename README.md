# dotfiles

This repository versions my dotfiles (configuration files) and everything I need to reproduce my environment declaratively, mainly with GNU Guix.

## Structure

- `guix/`
  - `config.scm`: system configuration (GNU Guix System), including kernel/firmware, bootloader, file systems, users, and services (e.g., Docker, Syncthing, DHCP, and OpenSSH).
  - `home-configuration.scm`: user environment configuration with GNU Guix Home (packages and files under `$HOME`/XDG), such as `zsh`, `emacs`, `git`, and `pass`, plus files under `~/.config/emacs/`.
  - `channels.scm`: Guix channel definitions (including `nonguix`).

- `zsh/`
  - `.zshrc`: shell configuration.

- `emacs/`
  - Submodule containing my Emacs configuration: https://github.com/morazotti/emacs-config

- `mail/`
  - Configuration for a local email setup based on **isync/mbsync** + **notmuch**:
    - `mail/.config/isync/mbsyncrc`: IMAP account/channel definitions (e.g., Gmail and UFSCar) and synchronization to Maildir under `~/.local/share/`.
    - `mail/.config/notmuch/default/config`: notmuch database configuration (path, default tags, filters/excludes, etc.).
    - `mail/.config/notmuch/default/hooks/pre-new`: hook that runs `mbsync -a` before `notmuch new`.
    - `mail/.config/notmuch/default/hooks/post-new`: hook to automatically apply tags after importing messages.
  - Note: passwords are read via `gpg2` using `PassCmd` (files `~/.mailpass.gpg` and `~/.ufscar-mailpass.gpg`) and are **not** versioned in this repository.

## Notes

- The idea is for this repository to be the “source of truth” for my configuration.
- Part of the setup is consumed directly by tools like GNU Guix Home (via `home-configuration.scm`) instead of manual symlinks.
