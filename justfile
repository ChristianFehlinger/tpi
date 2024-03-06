set shell := ["/bin/bash", "-uc"]
set export := true
set dotenv-filename := ".auth"
set quiet

# default recipe to display help information
default:
  @just --list

build_docker: install
  devcontainer build --image-name ansible-turingpi:latest .

# install pre-commit and vscode dev container cli
install:
    #!/usr/bin/env bash
    npm install -g @vscode/dev-container-cli
    pre-commit install

# turn on turing pi
@turn_on:
    just power 1

# turn off turing pi
@turn_off:
    just power 0

[private]
@power input:
    #!/usr/bin/env bash
    token=$(curl -s 'https://turingpi/api/bmc/authenticate' -X POST -d '{"username":"root", "password":"'"$turing_password"'"}' -k | jq -r '.id')
    if [ "$input" -eq 0 ] || [ "$input" -eq 1 ]; then
        response=$(curl -sk  "https://$turing_ip/api/bmc?type=power&opt=set&node1=${input}&node2=${input}&node3=${input}&node4=${input}" --header "Authorization: Bearer $token")
        if [[ $(echo "$response" | jq -r '.response[0].result') == "ok" ]]; then
          echo "Should start be starting"
        fi
    else
        echo "wrong input. Please use 0 or 1."
    fi

# shows status of the turing pi
status:
    #!/usr/bin/env bash
    token=$(curl -s 'https://turingpi/api/bmc/authenticate' -X POST -d '{"username":"root", "password":"'"$turing_password"'"}' -k | jq -r '.id')
    response=$(curl -sk  "https://$turing_ip/api/bmc?opt=get&type=power" --header "Authorization: Bearer $token")
    echo "$response" | jq -r '.response[0].result[0] | to_entries[] | "\(.key): \(.value)"'

# run ansible playbook
ansible:
    task ansible_apply

# check if nodes are up via ansible
ping:
    #!/usr/bin/env bash
    out_put=$(ansible nodes -m ping -u pi)

    if echo "$out_put" | grep -q '"unreachable": true'; then
        echo "Some hosts are unreachable."
    else
        echo "All nodes up."
    fi
