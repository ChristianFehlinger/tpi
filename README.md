# Install Kubernetes on a TuringPi2

## Hardware

- Node01 - 03: Raspberry Pi Compute Module 4 Lite, BCM2711, ARM Cortex-A72, 4GB-RAM [CM4004000](http://datasheets.raspberrypi.com/cm4/cm4-datasheet.pdf?_gl=1*18neyi7*_ga*MjA3Mjk1NDYzOC4xNzA4Njc4NTkz*_ga_22FD70LWDS*MTcwODY3ODU5My4xLjEuMTcwODY3ODYxNi4wLjAuMA..)
- Node04: 16GB-RAM [Truing RK1](https://docs.turingpi.com/docs/turing-rk1-specs-and-io-ports)

## Software

**Truing PI**

- Baseboard Management Controller: 2.0.5

**Node**

- Node01 - 03: Debian GNU/Linux 11 (bullseye)
- Node04:

# Usage

1. Easiest way is to install [just](https://github.com/casey/just)

- Execute `just install`, to install pre-commit and node

2. Create an `.auth` file in the repository root
   This file is used from ansible to connect to the clients.

```bash
  export turing_password=<PASSWORD>
  export turing_ip=<IP>
  export id_rsa_pub=c3NoLXXX
  export id_rsa=LS0tXXXX
```

3. Use the `local.sh` to start ansible. In the best case use the dev-container.

# K3s - cluster access

There is a short [article](https://docs.k3s.io/cluster-access).
Copy the file `/etc/rancher/k3s/k3s.yaml` to your local.
Replace `default` with e.g. `turingpi` and add the sections `cluster`, `contexts` and `user` to your existing kube-config.

# Links

- [TuringPi2](https://docs.turingpi.com)
- [k3s](https://docs.k3s.io/)
- [ansible](https://www.ansible.com/)
- [arkade](https://github.com/alexellis/arkade)
