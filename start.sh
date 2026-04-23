# 环境变量
CUDA_VERSION=12.4.1
UBUNTU_VERSION=22.04
VLLM_VERSION=0.19.1
PYTORCH_CU_VERSION=118

# 镜像和容器名称
DOCKER_IMAGE=vllm:${VLLM_VERSION}-cuda-${CUDA_VERSION}-ubuntu${UBUNTU_VERSION}-pytorch-cu${PYTORCH_CU_VERSION}
DOCKER_CONTAINER_NAME=vllm-${VLLM_VERSION}

# 模型名称和API_KEY
MODEL_NAME=Qwen/Qwen3.5-4B
API_KEY=sk-12345678

# 如果容器存在，先停止
if docker ps -aq | grep -q "${DOCKER_CONTAINER_NAME}"; then
  docker rm -f ${DOCKER_CONTAINER_NAME}
fi

# 启动容器
docker run -d --name ${DOCKER_CONTAINER_NAME} \
  -v /etc/localtime:/etc/localtime \
  -v /Users/${USER}/.cache/modelscope:/root/.cache/modelscope \
  --gpus all \
  -p 9999:8000 \
  ${DOCKER_IMAGE} \
  --model ${MODEL_NAME} \
  --max-model-len 262144 \
  --language-model-only \
  --api-key ${API_KEY}

# 打印容器启动信息
echo "<----------------->"
echo "容器 ${DOCKER_CONTAINER_NAME} 已启动"
echo "访问地址：http://localhost:9999/v1"
echo "API_KEY: ${API_KEY}"
echo "MODEL_NAME: ${MODEL_NAME}"
echo "VLLM_VERSION: ${VLLM_VERSION}"
echo "<----------------->"
