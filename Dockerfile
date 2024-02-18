FROM python:3-bookworm

RUN apt-get update \
    && apt-get upgrade -yqq \
    && apt-get install -y \
        jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip \
    && pip3 install ansible>=9.20

# Add the hosts file
RUN mkdir -p /etc/ansible
COPY hosts ansible.cfg /etc/ansible/
