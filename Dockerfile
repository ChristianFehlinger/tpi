FROM python:3-bookworm

RUN apt-get update \
    && apt-get upgrade -yqq \
    && apt-get install -y \
        jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSLk  https://github.com/alexellis/arkade/releases/download/0.11.3/arkade -o /usr/local/bin/arkade \
    && chmod +x /usr/local/bin/arkade

RUN arkade get kubectl@v1.29.1 \
    && arkade get kubectx \
    && arkade get k9s \
    && arkade get just \
    && arkade get helm \
    && arkade get stern \
    && arkade get task@v3.34.1

ENV PATH=$PATH:/root/.arkade/bin

RUN curl -fsSLk https://firmware.turingpi.com/tpi/debian/tpi_1.0.5-1_amd64.deb -o /tmp/tpi.deb \
    && dpkg -i /tmp/tpi.deb \
    && rm /tmp/tpi.deb

RUN pip install --upgrade pip \
    && pip3 install ansible>=9.20

# Add the hosts file
RUN mkdir -p /etc/ansible
COPY hosts ansible.cfg /etc/ansible/
