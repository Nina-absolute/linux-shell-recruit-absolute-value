# Task 05 — Pipeline Challenge

**难度：★★★☆☆**

分析 `logs/access.log`，找出请求次数最多的 IP 地址，把最终 IP 写入 `output/05_top_ip.txt`。

## 特别要求

不允许通过自己创建 `temp1.txt`、`temp2.txt` 等中间文件逐步传递数据。请尝试使用 pipeline 直接连接多个程序。

可能需要：`|`、`cut`、`sort`、`uniq`、`head`。

```bash
./check.sh 05
```
