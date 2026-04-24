ARG CUDA_VERSION=12.4.1
ARG UBUNTU_VERSION=22.04
ARG VLLM_VERSION=0.19.1
ARG PYTORCH_CU_VERSION=118 
ARG CUDNN=cudnn
ARG PYTORCH_EXTRA_INDEX_URL=https://download.pytorch.org/whl
ARG PYPI_INDEX_URL=https://mirrors.aliyun.com/pypi
ARG PYPI_TRUSTED_HOST=mirrors.aliyun.com

FROM nvidia/cuda:${CUDA_VERSION}-${CUDNN}-devel-ubuntu${UBUNTU_VERSION}

# 定义环境变量
ARG VLLM_VERSION
ARG PYTORCH_CU_VERSION
ARG PYTORCH_EXTRA_INDEX_URL
ARG PYPI_INDEX_URL
ARG PYPI_TRUSTED_HOST

ENV VLLM_USE_MODELSCOPE=true
ENV TF_ENABLE_ONEDNN_OPTS=0

# 安装python依赖库
RUN sed -i "s@http://.*archive.ubuntu.com@https://mirrors.aliyun.com@g" /etc/apt/sources.list && \
  sed -i "s@http://.*security.ubuntu.com@https://mirrors.aliyun.com@g" /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y python3 python3-dev python3-pip 

# 安装vllm
RUN pip3 config set global.index-url ${PYPI_INDEX_URL}/simple/ && \
  pip3 config set install.trusted-host ${PYPI_TRUSTED_HOST} && pip3 install modelscope

# 安装vllm依赖库
RUN pip3 install vllm==${VLLM_VERSION} --extra-index-url ${PYTORCH_EXTRA_INDEX_URL}/cu${PYTORCH_CU_VERSION}

ENTRYPOINT ["vllm", "serve"]
