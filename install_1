#!/bin/bash
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
source ~/miniconda3/bin/activate
conda init --all
git clone https://github.com/visomaster/VisoMaster.git
cd VisoMaster
conda create -n visomaster python=3.10.13 -y
conda activate visomaster
conda install -c nvidia/label/cuda-12.4.1 cuda-runtime -y
conda install -c conda-forge cudnn -y
conda install scikit-image -y
pip install -r requirements_cu124.txt
python download_models.py

