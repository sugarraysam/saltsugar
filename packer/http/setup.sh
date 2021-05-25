#!/usr/bin/env bash

echo root:vagrant | chpasswd
/usr/bin/systemctl start sshd.service
