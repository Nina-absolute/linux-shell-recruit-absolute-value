# Task 04 — Log Statistics

**难度：★★☆☆☆**

分析 `logs/server.log`：

1. 统计 ERROR 条数，写入 `output/04_error_count.txt`。
2. 输出所有出现过 ERROR 的用户名，去重并按字典序排列，写入 `output/04_error_users.txt`。
3. 找出出现次数最多的错误码，写入 `output/04_top_code.txt`。

可能需要：`grep`、`wc`、`sort`、`uniq`、`cut`。

```bash
./check.sh 04
```
