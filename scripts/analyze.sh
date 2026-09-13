#!/usr/bin/env bash

# Task 07: complete this script.
# Usage: ./scripts/analyze.sh FILE

# TODO: validate arguments
# TODO: validate file existence
# TODO: print:
# Total ERROR: <number>
# Top Code: <code>

#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Usage: ./scripts/analyze.sh FILE" >&2
    exit 1
fi
# 首先检查是否传入参数；
# 没有输入时，输出用法提示，返回非零状态（没有传入参数，脚本执行失败）；


FILE="$1"
# 接收命令行参数;
if [[ ! -f "$FILE" ]]; then
    echo "Error: file not found: $FILE" >&2
    exit 1
fi
# 文件不存在时报错;

# 以下所有预备写入的文件位置全部借用task4/5/6的示例
# 对正常日志文件的分析结果写入文件


ERROR_COUNT=$(grep -c "ERROR" "$FILE")
echo "$ERROR_COUNT" > output/04_error_count.txt
echo "Total ERROR: $ERROR_COUNT"
# 统计日志中有多少条错误，将数据写入文件并输出到终端屏幕；


TOP_CODE=$(grep "ERROR" "$FILE" | grep -oE "code=[0-9]+" | cut -d'=' -f2 | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
echo "$TOP_CODE" > output/04_top_code.txt
echo "Top Code: $TOP_CODE"
# 找出日志中出现次数最多的错误码，将错误码写入文件并输出到终端屏幕；

exit 0

