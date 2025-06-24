#!/bin/bash
# Thiết lập ghi log để dễ dàng gỡ lỗi
exec > >(tee -a /tmp/provisioning.log) 2>&1

echo "=== Bat dau qua trinh cai dat (phien ban toi uu) ==="

# 1. Cài đặt Miniconda
mkdir -p /root/miniconda3
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /root/miniconda3/miniconda.sh
bash /root/miniconda3/miniconda.sh -b -u -p /root/miniconda3
rm /root/miniconda3/miniconda.sh
echo ">>> Miniconda da duoc cai dat."

# Khởi tạo conda cho script này (quan trọng)
source /root/miniconda3/etc/profile.d/conda.sh
echo ">>> Da source conda.sh."

# 2. Tạo môi trường Conda
conda create -n visomaster python=3.10.13 -y
echo ">>> Moi truong 'visomaster' da duoc tao."

# 3. Cài đặt các gói bằng lệnh `conda install -n <tên_môi_trường>`
# Đây là cách đáng tin cậy hơn 'conda run' hoặc 'activate' trong script
conda install -n visomaster -c nvidia/label/cuda-12.4.1 cuda-runtime -y
echo ">>> Da cai dat CUDA Runtime."

conda install -n visomaster -c conda-forge cudnn -y
echo ">>> Da cai dat CUDNN."

conda install -n visomaster -c conda-forge scikit-image -y
echo ">>> Da cai dat Scikit-image."

# 4. Clone mã nguồn và cài đặt dependencies
# Dùng 'cd ... &&' để đảm bảo các lệnh sau chỉ chạy khi cd thành công
git clone https://github.com/visomaster/VisoMaster.git && cd VisoMaster
echo ">>> Da clone repo VisoMaster và chuyen vao thu muc."

# 5. Cài đặt requirements bằng cách gọi thẳng PIP của môi trường visomaster
# Đây là cách làm triệt để nhất để tránh lỗi môi trường
/root/miniconda3/envs/visomaster/bin/pip install -r requirements_cu124.txt
echo ">>> Da cai dat cac goi tu requirements_cu124.txt."

# 6. Tải model bằng cách gọi thẳng PYTHON của môi trường visomaster
/root/miniconda3/envs/visomaster/bin/python download_models.py
echo ">>> Da tai xong cac model."

echo "=== HOAN TAT CAI DAT ==="
