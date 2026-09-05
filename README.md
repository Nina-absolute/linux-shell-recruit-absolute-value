# Linux & Shell Recruit

一个面向 Linux / Shell 初学者的项目式招新挑战。

## 题目结构

主线共 8 题，分为 4 个 Stage；另有 1 道附加题。

- Stage 1 — Explore the Project
  - 01 Project Hunt
  - 02 Missing Command
- Stage 2 — Search the Project
  - 03 Code Search
  - 04 Log Statistics
- Stage 3 — Connect the Tools
  - 05 Pipeline Challenge
  - 06 Streams & Redirection
- Stage 4 — Automate the Work
  - 07 Analyze Script
  - 08 Script Debug
- Extra
  - 09 Process Hunter

## 开始

```bash
git clone https://github.com/Gwen1023/linux-shell-recruit.git
cd linux-shell-recruit
chmod +x check.sh tools/check-project scripts/start-workers.sh scripts/worker.sh
./check.sh
```

查看题目：

```bash
cat tasks/01_project_hunt.md
```

检查单题：

```bash
./check.sh 01
```

检查主线全部 8 题：

```bash
./check.sh
```

附加题单独检查：

```bash
./check.sh 09
```

> 本项目强调理解与探索，不要求死记命令。允许查阅 `man`、`--help`、官方文档、搜索引擎和 AI，但请确保能够解释自己的提交。
