# Linux & Shell 学习笔记

### Stage 1 — Explore the Project

### #0 获取题目仓库

1. 思考1
>注意：不要直接用git clone，否则无法直接提交你的仓库链接。

【分析】
我没有题目仓库 `Gwen1023/linux-shell-recruit` 的写入权限。如果直接 `clone` 它，本地的远程地址默认指向这个原仓库。也就是说，最终推送文件没法弄到自己的仓库里。

2. 思考2
>思考为什么需要执行`chmod +x check.sh tools/check-project scripts/start-workers.sh scripts/worker.sh`

【分析】
`chmod` = change mode，用于修改文件的访问权限，`+x` = execute 执行，用于添加执行权限。添加权限后，就可以让检查工具等程序正常运行了:）

3. 总结1
***常见参数小汇总**：
    `x` = execute 执行，可以`cd`进入目录 or 访问子路径，可运行（对于文件）；
    `r` = read 读取，可见文件名（`ls`可见目录下文件名称），可查看文件内容（对于文件）；
    `w` = write 写入，能修改文件列表（在目录中可以`touch``rm``mv`），能修改文件内容（对于文件）。

### #1 Project Hunt

