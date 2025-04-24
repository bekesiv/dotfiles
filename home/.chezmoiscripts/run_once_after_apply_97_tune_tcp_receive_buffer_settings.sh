#!/bin/bash
set -e

echo -e "net.ipv4.tcp_rmem=40960 873800 62914560\nnet.core.rmem_max=25000000" | sudo tee -a /etc/sysctl.conf > /dev/null
