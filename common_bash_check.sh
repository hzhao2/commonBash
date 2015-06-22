
# _     _
#| |   | |__ _                    _
#| |___| /___ |   _ _    _ _   __| |
#|  ___  | / /   / '__\ / _ \ / _  |
#| |   | |/ /___ | |_ _| |_| | (_| |
#|_|   |_|___ _(_)_ __/ \_ _/ \__,_|
#
# [common_bash_check] (C) 1988-2014 Hz Inc.
# 通用工具类-检测操作
# common_bash_check.sh
#
# [校验类函数调用方式]
#   函数最终输出是以 echo outputMsg 方式标准输出,如果执行异常会输出0
#   所以调用函数并获取返回结果如下:
#   outputMsg=$(fun1 "param1" "param2")
#
#!/bin/sh

# 检测参数是否存在
#
# @param $1 $2 $3
#
# return array
check_param_exits()
{
    paramNum=$(($1+2))
    for((i=2;i<$paramNum;++i))
    do
        echo "(($i))"
        if [ -z $$i ];then
            return 0;
        fi
    done
    return 1
#    for param in $*
#    do
#        echo $param
#        if [ -z $param ];then
#            return 0
#        fi
#    done
#    return 1
}

# 判断参数是否为数字
#
# @param num1
#
# return
is_numeric()
{
    #echo "$1" | grep -qv '[^0-9]'
    until [ $1 -ge 0 ] 2>/tmp/null
    do
        echo 0
        return
    done
    echo 1
}

# 判断两组数字大小,$1 比 $2 大返回1 小返回0
#
# @param num1
# @param num2
#
# return
compare_num()
{
    if [ $(is_numeric $1) == 0 ];then
        echo 0
        return
    fi

    if [ $(is_numeric $2) == 0 ];then
        echo 0
        return
    fi

    if [ $1 -gt $2 ];then
        echo 1
        return
    fi
    echo 0
}

# 检测参数个数是否正确
#
# @param num
# @param paramCount
#
# return array
check_param_num()
{
    if [ $1 != $2 ];then
        echo 0
        return;
    fi
    echo 1
}

test()
{
    echo $(compare_num $1 $2)
}
#echo $(test 2 a)
#test 1 2 3
#compare_num a 3 4 2 
#echo $?
