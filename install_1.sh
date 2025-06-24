#!/bin/bash

echo "=== Bat dau cai dat VisoMaster ===" | tee -a /tmp/provisioning.log

# Cai Miniconda
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p /root/miniconda3
rm miniconda.sh
source /root/miniconda3/etc/profile.d/conda.sh
echo ">>> Miniconda cai xong" | tee -a /tmp/provisioning.log

# Clone VisoMaster
cd /
git clone https://github.com/visomaster/VisoMaster.git
cd /VisoMaster
echo ">>> Da clone VisoMaster ve /VisoMaster" | tee -a /tmp/provisioning.log

# Tao environment + cai dat nhu trong huong dan
conda create -n visomaster python=3.10.13 -y
conda run -n visomaster conda install -c nvidia/label/cuda-12.4.1 cuda-runtime -y
conda run -n visomaster conda install -c conda-forge cudnn -y
conda run -n visomaster conda install scikit-image -y
conda run -n visomaster pip install -r requirements_cu124.txt
conda run -n visomaster python download_models.py

echo "=== Cai dat hoan tat ===" | tee -a /tmp/provisioning.log
