# nixos-dots

<p align="center">
    <a href="https://wiki.nixos.org/wiki/Flakes" target="_blank">
        <img alt="Nix Flakes Ready" src="https://img.shields.io/static/v1?logo=nixos&logoColor=d8dee9&label=Nix%20Flakes&labelColor=7A8478&message=Ready&color=d8dee9&style=for-the-badge">
    </a>
    <a href="https://github.com/tommy-donavon/nixos-dots/actions/workflows/analysis.yml">
        <img src="https://img.shields.io/github/actions/workflow/status/tommy-donavon/nixos-dots/analysis.yml?logo=github&label=analysis&logoColor=83C092&labelColor=7A8478&color=83C092&style=for-the-badge"/>
    </a>
    <a href="https://github.com/tommy-donavon/nixos-dots/commits">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/tommy-donavon/nixos-dots?style=for-the-badge&logo=github&logoColor=83C092&labelColor=7A8478&color=BB8568"/>
    </a>
</p>

## Overview

This repository contains my personal Nix configs, managed using [flake-parts](https://flake.parts/), which provides a structured approach to organizing NixOS and macOS system configurations across multiple machines.

## Table of Contents

1. [Features](#features)
2. [Getting Started](#getting-started)
3. [Project Structure](#project-structure)
4. [Resources](#resources)
5. [Acknowledgements](#acknowledgements)
6. [Screenshots](#screenshots)

## Features

- Cross-platform configuration support (NixOS and macOS)
- Reproducible and declarative system setup
- Custom modules and home configurations

## Getting Started

### Prerequisites

- [Nix](https://nixos.org/download.html)
- [Nix-Darwin](https://github.com/LnL7/nix-darwin/tree/master) if using macOS

### Installation

```bash
git clone git@github.com:tommy-donavon/nixos-dots.git ~/dots
cd ~/dots

# Linux
sudo nixos-rebuild switch --flake .

# macOS
darwin-rebuild switch --flake .

# using nh (recommended)
nh os switch . --ask     # linux
nh darwin switch . --ask # macOS
```

## Project Structure

```
.
├── assets         # static misc files
├── home           # home manager configurations
├── modules
│   ├── darwin     # darwin specific configurations
│   ├── flake      # configuration for this flake
│   ├── home       # home manager modules
│   ├── nixos      # nixos specific configurations
│   └── shared     # shared system configurations
└── systems        # system specific configurations
```

## Acknowledgements

Other user configurations that I used and referenced

- [isabelroses/dotfiles](https://github.com/isabelroses/dotfiles) main reference for project structure
- [khaneliman/khanelinix](https://github.com/khaneliman/khanelinix)
- [JakeHamilton/config](https://github.com/jakehamilton/config)

## Screenshots

![Workflow](./assets/workflow.png)

![Desktop](./assets/desktop.png)
