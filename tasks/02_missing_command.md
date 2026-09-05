# Task 02 — Missing Command

**难度：★☆☆☆☆**

项目提供工具 `tools/recruit-info`，但它现在不能直接执行。

## 任务

1. 不修改脚本内容、不使用 `sudo`，让 `./tools/recruit-info` 可以执行。
2. 在 `answers/02.md` 简要说明：为什么 `./tools/recruit-info` 能运行，而直接输入 `recruit-info` 可能找不到？Shell 输入 `ls` 时如何找到程序？
3. 不移动文件、不修改 `.bashrc`，让当前 Shell 会话可以直接执行 `recruit-info`。

## 可能需要了解

`ls -l`、`chmod`、`./`、`PATH`、`command -v`、`export`。

```bash
./check.sh 02
```
