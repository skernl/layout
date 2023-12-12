#! /bin/bash

echo -e "这是由Skernl框架提供的shell启动脚本\n"

current_user_uid=$(id -u)
if [ "$current_user_uid" -eq 0 ]; then
    echo -e "\e[1;33m不要以 root/超级用户身份运行 skernl！\e[0m\n";
    echo -en "\e[0;32m以 root/超级用户身份继续\e[0m ";
    echo -en "[\e[1;33m yes \e[0m]？ ";

    # shellcheck disable=SC2162
    while read userInput
    do
        if [ -z "$userInput" ] || [ "$userInput" = "y" ] || [ "$userInput" = "yes" ]; then
            break;
        else
            echo -e "已取消运行";
            exit;
        fi
    done

fi

window_size=$(stty size);

columns=$(echo "$window_size" | awk '{print $2}');

if [ "$columns" -gt 45 ]; then
    echo -en "===============运行命令行====================\n";
    echo -en " [\e[1;32m1\e[0m] 优化加载                [\e[1;32m2\e[0m] 当前状态\n";
    echo -en " [\e[1;32m3\e[0m] 查看路由                [\e[1;32m4\e[0m] 停止运行\n";
    echo -en " [\e[1;32m5\e[0m] 启动项目                [\e[1;32m6\e[0m] 开发调试\n";
    echo -en " [\e[1;32m7\e[0m] 修复输入法\n";
    echo -en " [\e[1;32m0\e[0m] 取消\n";
    echo -en "=============================================\n";
    echo -en "请输入命令编号：";
else
    echo -en "=========运行命令行=========\n";
    echo -en "  [\e[1;32m1\e[0m] 优化加载\n";
    echo -en "  [\e[1;32m2\e[0m] 当前状态\n";
    echo -en "  [\e[1;32m3\e[0m] 查看路由\n";
    echo -en "  [\e[1;32m4\e[0m] 停止运行\n";
    echo -en "  [\e[1;32m5\e[0m] 启动项目\n";
    echo -en "  [\e[1;32m6\e[0m] 开发调试\n";
    echo -en "  [\e[1;32m7\e[0m] 修复输入法\n";
    echo -en "  [\e[1;32m0\e[0m] 取消\n";
    echo -en "============================\n";
    echo -en "请输入命令编号：";
fi

# shellcheck disable=SC2162
read aNum

case $aNum in
    1)
        composer dump-autoload -o
        echo "优化加载完成"
    ;;
    2)
        ps aux | grep "php bin/skernl.php"
        # shellcheck disable=SC2181
        if [ $? -eq 0 ]; then
            echo "\e[4;32m running \e[0m"
        else
            echo -e "\e[4;31m stop \e[0m";
        fi
    ;;
    3)
    ;;
    4)
        content=$(<runtime/skernl.pid)

        if [[ ! $content =~ ^[0-9]+$ ]]; then
            echo "缓存数据被修改，无法识别进程！";
            exit;
        fi

        if kill -0 "$content" 2> /dev/null; then
            # shellcheck disable=SC2086
            kill -9 $content;
            echo "项目已停止运行";
        else
             echo "项目已停止运行，无需再次停止";
        fi
    ;;
    5)
    ;;
    6)
    ;;
    7)
        ibus restart;
    ;;
    0)
        echo "已取消"
        exit
    ;;
    *)
        echo "已取消"
        exit
    ;;
esac
