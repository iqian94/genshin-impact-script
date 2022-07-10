# 记录 Recording

提供可编程的按键录制与重放功能

## 快速开始 Quick start

首先，按下`Ctrl + Numpad Dot`，随意按几个其他按键之后，再次按下`Ctrl + Numpad Dot`，你就获得了第一份录像。它的文件名为`replay/0.txt`

First, press `Ctrl + Numpad Dot` and after pressing a few other keys at random, press `Ctrl + Numpad Dot` again to get your first record. Its file name is `replay/0.txt`

按下`Ctrl + Numpad 0`，你应该可以重复播放这份录像

Press `Ctrl + Numpad 0` and you should be able to replay this record again

`replay/0~9.txt`为内建的十个快捷入口，按下`Ctrl + Numpad 0~9`即可调用它们

`replay/0~9.txt` are built-in shortcut entries, press `Ctrl + Numpad 0~9` to call them

一份录像中的内容通常像是这样：

The contents of a record usually look like this:

```txt
1000 esc:down
500 esc:up
1000 l-button:down 2%,94%
50 l-button:up 2%,94%
1000 l-button:down 60%,70%
50 l-button:up 60%,70%
15000 l-button:down 95%,91%
50 l-button:up 95%,91%
1000 l-button:down 58%,52%
50 l-button:up 58%,52%
1000 l-button:down 35%,58%
50 l-button:up 35%,58%
1000 l-button:down 38%,35%
50 l-button:up 38%,35%
```

每一行代表一个动作，包含动作时间（单位为毫秒）、按键和位置信息（单位为百分比），使用空格分隔开

Each line represents an action and contains the time of the action in milliseconds, keystroke and position information in percentages, separated by spaces

更复杂一些的录像内容也可能会是这样：

More complex recorded content might also look like this:

```txt
# start chat
1000 enter:down
50 enter:up
50 enter:down
50 enter:up

# input
@input hello
50 space:down
50 space:up
@input world

# send
50 enter:down
50 enter:up

# exit
50 esc:down
50 esc:up
```

以`#`开始的行代表注释，不会被解析执行。目前不支持行内注释

Lines starting with `#` represent comments and will not be parsed for execution. In-line comments are not currently supported

以`@`开始的行代表包含特殊标记，目前已有的特殊标志如下：

A line starting with `@` means it contains special tags, and the following special tags are currently available:

- @input
- @run

将上述文本内容保存为`replay/9.txt`后，在游戏中按下`Ctrl + Numpad 9`,应当能看到输入并发送了`hello world`

After saving the above text content as `replay/9.txt`, press `Ctrl + Numpad 9` in the game, you should see `hello world` typed and sent

```txt
@run 9
```

将上述文本内容保存为`replay/0.txt`后，在游戏中按下`Ctrl + Numpad 0`，应当能看到执行了与之前一致的动作。这是因为`@run`标记提供了在不同录像间跳转的功能

After saving the above text as `replay/0.txt`, press `Ctrl + Numpad 0` in the game and you should see the same action performed as before. This is because the `@run` tag provides the ability to jump between records
