#!/bin/bash

echo "=== Start provisioning ===" | tee -a /tmp/provisioning.log

# Tạo thư mục
mkdir -p /root/miniconda3
echo "Downloaded directory created" | tee -a /tmp/provisioning.log

# Tải Miniconda
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /root/miniconda3/miniconda.sh
echo "Miniconda downloaded" | tee -a /tmp/provisioning.log

# Cài Miniconda
bash /root/miniconda3/miniconda.sh -b -u -p /root/miniconda3
echo "Miniconda installed" | tee -a /tmp/provisioning.log

# Kích hoạt conda
source /root/miniconda3/etc/profile.d/conda.sh || echo "Failed to source conda.sh" | tee -a /tmp/provisioning.log

# Tạo môi trường
conda create -n visomaster python=3.10.13 -y && echo "Env created" | tee -a /tmp/provisioning.log

# Cài các gói
conda run -n visomaster conda install -c nvidia/label/cuda-12.4.1 cuda-runtime -y && echo "CUDA installed" | tee -a /tmp/provisioning.log
conda run -n visomaster conda install -c conda-forge cudnn -y && echo "CUDNN installed" | tee -a /tmp/provisioning.log
conda run -n visomaster conda install scikit-image -y && echo "scikit-image installed" | tee -a /tmp/provisioning.log

# Clone mã nguồn
git clone https://github.com/visomaster/VisoMaster.git && echo "Repo cloned" | tee -a /tmp/provisioning.log
cd VisoMaster

# Cài requirements
conda run -n visomaster pip install -r requirements_cu124.txt && echo "Requirements installed" | tee -a /tmp/provisioning.log

# Tải model
conda run -n visomaster python download_models.py && echo "Models downloaded" | tee -a /tmp/provisioning.log

echo "=== Done provisioning ===" | tee -a /tmp/provisioning.log
