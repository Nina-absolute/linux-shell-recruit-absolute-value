#!/usr/bin/env bash

# Task 08: this script is intentionally buggy.
# Usage: ./scripts/batch-copy.sh DEST FILE...

destination="$1"
# 添加了`""`以保证后续引用（变量展开到命令行）时不出错
shift

mkdir -p "$destination"
# 添加了`""`以保证文件目录含空格时`mkdir`将其识别为多个参数

for file in "$@"
# 添加了`""`以保证文件名含空格时被拆分为多个参数

do
    cp "$file" "$destination"
# 添加了`""`以保证文件名和文件目录含空格时`cp`将其识别为多个参数
done
