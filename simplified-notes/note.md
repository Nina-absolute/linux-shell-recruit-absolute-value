# Linux & Shell 招新练习笔记

## 完成情况

- 主线 Task 01–08：`./check.sh` 通过
- 附加 Task 09：`./check.sh 09` 通过

![主线自检通过](../screenshot-PASS/check01-08_PASS.png)

![附加题自检通过](../screenshot-PASS/check09_PASS.png)

这份笔记围绕题目所需能力整理：先记录解决思路，再保留能迁移到其他项目的结论。扩展知识不作为完成本题的前提。

## 01 Project Hunt：路径、隐藏文件与搜索

目标是从 `workspace/` 中找到包含 `PROJECT_ID` 的文件，并从 `workspace/src/utils/` 写出访问它的相对路径。

- `pwd` 显示当前工作目录的绝对路径；绝对路径从 `/` 开始。
- 相对路径从当前目录解析；`.` 是当前目录，`..` 是父目录。
- 隐藏文件或目录以 `.` 开头；`ls -a` 才会显示它们。
- `find` 按路径、文件类型等元数据查找；`grep` 按文件内容匹配文本。两者可以组合使用。

权限要点：对目录，`r` 允许读取目录项，`x` 允许进入目录和访问已知名称的子项；要在目录中创建、删除或重命名条目，通常需要同时拥有 `w` 和 `x`。对普通文件，`x` 表示可执行。

## 02 Missing Command：执行权限与 PATH

`./tools/recruit-info` 含有斜杠，Shell 会把它当作路径直接执行；因此它不依赖 `PATH`，但文件本身必须有执行权限。直接输入 `recruit-info` 不含斜杠，Shell 才会按命令解析规则查找：别名、函数、内建命令，以及 `PATH` 中的可执行文件。

```bash
chmod +x tools/recruit-info
export PATH="$PATH:$(pwd)/tools"
command -v recruit-info
```

`command -v` 适合确认当前 Shell 最终会解析到什么；相比之下，`which` 的实现和对别名、函数的处理在不同环境中不一致，不应作为唯一依据。

## 03–05：文本筛选、统计与管道

处理日志的通用步骤是：筛选需要的行 → 提取字段 → 排序 → 去重或计数 → 取最终结果。

- `grep -l` 输出匹配文件名；`grep -c` 统计每个文件中匹配行数。
- `cut -d ' ' -f N` 按指定分隔符抽取第 N 个字段。
- `sort` 默认按当前 locale 的排序规则排序；数值排序用 `-n`。
- `uniq` 只处理相邻的重复行。若要全局去重或统计总次数，通常先 `sort`，再用 `uniq` 或 `uniq -c`。
- `head -n 1` 取第一行。

管道 `a | b` 将左侧命令的标准输出连接到右侧命令的标准输入。它以流式方式传输数据，由内核的管道缓冲区协调，不需要人为创建中间文件。默认情况下，标准错误不会进入管道。

## 06 Streams & Redirection：三条标准流

每个进程默认有三个标准文件描述符：stdin（0）、stdout（1）和 stderr（2）。`>` 是 `1>` 的简写，重定向 stdout；`2>` 重定向 stderr；`>>` 追加 stdout。

```bash
./tools/check-project > output/06_stdout.txt 2> output/06_stderr.txt
./tools/check-project | tee output/06_tee.txt
```

`tee` 从 stdin 读取，同时写入文件和 stdout。重定向顺序有意义：`> file 2>&1` 先让 stdout 指向文件，再让 stderr 复制 stdout 当前的去向；反过来两条流不会进入同一文件。

## 07 Analyze Script：脚本的输入校验

脚本应从位置参数读取日志路径，而不是写死路径。先检查参数数量，再检查文件是否存在，最后运行统计逻辑；异常情况输出明确提示并以非零状态退出。

```bash
if [ "$#" -ne 1 ]; then
  echo "Usage: ./scripts/analyze.sh FILE" >&2
  exit 1
fi

file=$1
if [ ! -f "$file" ]; then
  echo "Error: file not found: $file" >&2
  exit 1
fi
```

`$(...)` 会执行命令并把其标准输出替换到当前位置。变量和文件路径应使用双引号，例如 `"$file"`，以避免空格或通配符导致参数被拆分或展开。

## 08 Script Debug：参数与引用

`"$@"` 会保留每个位置参数的边界，适合逐个处理文件：

```bash
for file in "$@"; do
  cp "$file" "$dest/"
done
```

调用脚本时，带空格的路径也必须由调用方加引号，例如：

```bash
./scripts/batch-copy.sh "data/my files" "report.txt" "my report.txt"
```

Shell 不会为普通文件参数自动补全后缀；`PATH` 只用于查找不含斜杠的命令名，不会把 `report` 自动解析为 `report.txt`。

## 09 Process Hunter：定位并优雅停止目标进程

`ps` 查看进程状态，`pgrep -af worker-beta` 可按完整命令行定位目标脚本。对脚本进程，`comm` 往往是解释器名称（如 `bash`），而完整命令行在 `cmd/args` 中，因此这里需要 `-f`。

确认 PID 属于 `worker-beta` 后，优先使用默认的 `kill PID`（SIGTERM），让进程有机会清理资源；不要因为一个异常 worker 而结束另外两个 worker。`jobs` 仅显示当前 Shell 创建的后台任务，不能替代系统范围的进程查询。

## 自检前的复盘清单

1. 输出文件是否只有题目要求的内容，没有调试文本。
2. 是否分别处理 stdout 与 stderr，且重定向顺序正确。
3. 脚本是否校验参数和文件，并对含空格路径正确引用。
4. 进程操作前是否用完整命令行核实了目标。
5. 是否能解释每条命令为何满足题目限制。
