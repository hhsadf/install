#!/bin/bash

# Cài Miniconda im lặng
mkdir -p /root/miniconda3
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /root/miniconda3/miniconda.sh
bash /root/miniconda3/miniconda.sh -b -u -p /root/miniconda3
rm /root/miniconda3/miniconda.sh

# Kích hoạt conda (không cần init)
source /root/miniconda3/etc/profile.d/conda.sh

# Tạo và cài môi trường (dùng lệnh conda trực tiếp)
conda create -n visomaster python=3.10.13 -y
conda run -n visomaster conda install -c nvidia/label/cuda-12.4.1 cuda-runtime -y
conda run -n visomaster conda install -c conda-forge cudnn -y
conda run -n visomaster conda install scikit-image -y

# Clone code
git clone https://github.com/visomaster/VisoMaster.git
cd VisoMaster

# Cài requirements và tải model bằng conda run
conda run -n visomaster pip install -r requirements_cu124.txt
conda run -n visomaster python download_models.py
