#!/bin/bash

# 检查Git是否安装
if ! command -v git &> /dev/null; then
    echo "Git未安装,正在尝试安装..."
    sudo apt update
    sudo apt install -y git
    if [ $? -ne 0 ]; then
        echo "Git安装失败,请手动安装Git后再运行此脚本"
        exit 1
    fi
    echo "Git安装成功"
fi

# 检查是否在Git仓库中
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "错误:当前目录不是Git仓库"
    exit 1
fi

# 获取提交数量
commit_count=$(git rev-list --count HEAD)

echo "Git仓库的总提交数量: $commit_count"
echo $commit_count > git_commit_count
export ENV_COMMIT_COUNT = $commit_count