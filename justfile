# default recipe to display help information
default:
  @just --list

build_docker: install
  devcontainer build --image-name ansible-turingpi:latest .

install:
    #!/usr/bin/env bash
    npm install -g @vscode/dev-container-cli
    pre-commit install
