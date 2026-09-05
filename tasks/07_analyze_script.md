# Task 07 — Analyze Script

**难度：★★★☆☆**

完成 `scripts/analyze.sh`。

## 用法

```bash
./scripts/analyze.sh FILE
```

正常输出格式：

```text
Total ERROR: <number>
Top Code: <code>
```

要求：

- 必须从命令行参数读取日志路径，不能写死；
- 没有参数时显示 Usage，并以非零状态退出；
- 文件不存在时给出错误提示并以非零状态退出；
- 正常输入应正确分析并成功退出。

可能需要：`$1`、`$#`、`$(...)`、`if`、`[[ ]]`、`exit`。

```bash
./check.sh 07
```
