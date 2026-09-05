# Extra Task 09 — Process Hunter

**难度：★★★★☆**

这是附加题，不计入主线 8 题完成度。

运行：

```bash
./scripts/start-workers.sh
```

它会启动 `worker-alpha`、`worker-beta`、`worker-gamma` 三个后台进程。`worker-beta` 出现异常。

## 任务

找到并正常终止 `worker-beta`，同时保证另外两个 worker 继续运行。

不要通过关闭整个终端、重启系统或粗暴结束所有相关进程绕过题目。

可能需要：`ps`、`pgrep`、PID、`kill`、signal、`&`、`jobs`。

```bash
./check.sh 09
```
