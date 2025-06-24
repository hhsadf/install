#!/bin/bash

echo "=== Start provisioning ===" | tee -a /tmp/provisioning.log

mkdir -p /root/miniconda3
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /root/miniconda3/miniconda.sh
bash /root/miniconda3/miniconda.sh -b -u -p /root/miniconda3
rm /root/miniconda3/miniconda.sh

source /root/miniconda3/etc/profile.d/conda.sh

conda create -n visomaster python=3.10.13 -y && echo "Env created" | tee -a /tmp/provisioning.log
conda activate visomaster

conda install -c nvidia/label/cuda-12.4.1 cuda-runtime -y && echo "CUDA installed" | tee -a /tmp/provisioning.log
conda install -c conda-forge cudnn -y && echo "CUDNN installed" | tee -a /tmp/provisioning.log
conda install scikit-image -y && echo "scikit-image installed" | tee -a /tmp/provisioning.log

git clone https://github.com/visomaster/VisoMaster.git && echo "Repo cloned" | tee -a /tmp/provisioning.log
cd VisoMaster

pip install -r requirements_cu124.txt && echo "Requirements installed" | tee -a /tmp/provisioning.log
python download_models.py && echo "Models downloaded" | tee -a /tmp/provisioning.log

echo "=== Done provisioning ===" | tee -a /tmp/provisioning.log
