FROM python:3-bookworm

RUN apt-get update \
    && apt-get upgrade -yqq \
    && apt-get install -y \
        jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSLk https://github.com/go-task/task/releases/download/v3.34.1/task_linux_amd64.deb -o /tmp/task.deb \
    && dpkg -i /tmp/task.deb \
    && rm /tmp/task.deb

RUN curl -fsSLk https://firmware.turingpi.com/tpi/debian/tpi_1.0.5-1_amd64.deb -o /tmp/tpi.deb \
    && dpkg -i /tmp/tpi.deb \
    && rm /tmp/tpi.deb

RUN pip install --upgrade pip \
    && pip3 install ansible>=9.20

# Add the hosts file
RUN mkdir -p /etc/ansible
COPY hosts ansible.cfg /etc/ansible/
