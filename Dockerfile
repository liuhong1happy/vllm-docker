ARG CUDA_VERSION=12.4.1
ARG UBUNTU_VERSION=22.04
ARG VLLM_VERSION=0.19.1
ARG PYTORCH_CU_VERSION=118 

FROM nvidia/cuda:${CUDA_VERSION}-cudnn-devel-ubuntu${UBUNTU_VERSION}

# 定义环境变量
ARG VLLM_VERSION
ARG PYTORCH_CU_VERSION

# 安装python依赖库
RUN sed -i "s@http://.*archive.ubuntu.com@https://mirrors.aliyun.com@g" /etc/apt/sources.list && \
  sed -i "s@http://.*security.ubuntu.com@https://mirrors.aliyun.com@g" /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y python3 python3-dev python3-pip 

# 安装vllm
RUN  pip3 install modelscope && \
  pip3 install vllm==${VLLM_VERSION} --extra-index-url https://download.pytorch.org/whl/cu${PYTORCH_CU_VERSION}

ENTRYPOINT ["vllm", "serve"]
