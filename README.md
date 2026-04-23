# vllm-docker

## 构建Docker镜像
```bash
bash ./build.sh
```

## 启动容器
```bash
bash ./start.sh
```

## 说明

#### CUDA Toolkit 版本

```bash
nvcc --version
```

- pytorch 一般和CUDA Toolkit 版本一致

#### CUDA Driver 版本 

```bash
nvidia-smi
```

- CUDA Driver 版本要大于等于CUDA Toolkit 版本