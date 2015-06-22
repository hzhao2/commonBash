
# _     _
#| |   | |__ _                    _
#| |___| /___ |   _ _    _ _   __| |
#|  ___  | / /   / '__\ / _ \ / _  |
#| |   | |/ /___ | |_ _| |_| | (_| |
#|_|   |_|___ _(_)_ __/ \_ _/ \__,_|
#
# [common_bash_str] (C) 1988-2014 Hz Inc.
# 通用工具类-字符串操作
# common_bash_str.sh
#
# [字符串类函数调用方式]
#   函数最终输出是以 echo outputMsg 方式标准输出,如果执行异常会输出0
#   所以调用函数并获取返回结果如下:
#   outputMsg=$(fun1 "param1" "param2")
#
#!/bin/sh
. common_bash_check.sh

# 获取字符串长度
#
# @param string
#
# return int
strlen()
{
    if [ $(check_param_num 1 $#) == 0 ];then
        echo 0
        return
    fi
    echo `expr length "$1"`
    return
}

# 消除字符串两边的空格,\t,\n.\r,\0,\x0B
#
# @param string
#
# return
trim()
{
    if [ $(check_param_num 1 $#) == 0 ];then
        echo 0
        return
    fi

    echo `echo "$1" | sed 's/^\s*\|\s*$//g'`
}

# 消除字符串开头的空格,\t,\n.\r,\0,\x0B
#
# @param string
#
# return
ltrim()
{
    if [ $(check_param_num 1 $#) == 0 ];then
        echo 0
        return
    fi

    echo "`echo "$1" | sed 's/^\s*//g'`"
}

# 消除字符串结尾的空格,\t,\n.\r,\0,\x0B
#
# @param string
#
# return
rtrim()
{
    if [ $(check_param_num 1 $#) == 0 ];then
        echo 0
        return
    fi

    echo "`echo "$1" | sed 's/\s*$//'`"
}
#test case
#ltrim " a b c d       "
#strlen "$(ltrim " a b c d       ")"

# 返回字符串的子串
#
# @param string
# @param start
# @param length
#
# return string
substr()
{
    if [ $(check_param_num 3 $#) == 0 ];then
        echo 0
        return
    fi

    if [ $(is_num $2) == 0 ];then
        echo 0
        return
    fi

    if [ $(is_num $3) == 0 ];then
        echo 0
        return
    fi

    echo ${1:$2:$3}
    return
}

# 将一个字符串转换为数组
#
# @param string
# @param split_length
#
# return array
str_split()
{
    if [ $(check_param_num 2 $#) == 0 ];then
        echo 0
        return
    fi

    if [ $(compare_num $2 0) == 0 ];then
        echo 0
        return
    fi

    if [ $(strlen "$1") == 0 ];then
        echo 0
        return
    fi

    local str=$1
    local start=0
    local cnt=$2
    local str_ary=''
    local i=0
    local tmp=''
    while [ 1 == 1 ]
    do
        if [ $i -gt 999 ];then
            break
        fi

        tmp=$(substr "$str" $start $cnt)

        if [ $(strlen "$tmp") == 0 ];then
            break
        fi

        str_ary=$str_ary' '$tmp
        start=$(($start+$cnt))

        ((i++))
    done
    echo $str_ary
    return

}

# 指定标点分割字符串
#
# @param string
# @param symbol
#
# return string
explode()
{
    if [ $(check_param_num 2 $#) == 0 ];then
        echo 0
        return
    fi

    if [ $(strlen "$1") == 0 ];then
        echo 0
        return
    fi

    if [ $(strlen "$2") == 0 ];then
        echo 0
        return
    fi

    local tmp=''
    local str=''
    local i=1
    while [ 1 == 1 ]
    do
        tmp=`echo "$1" | cut -d "$2" -f$i`
        if [ "$tmp" != "" ];then
            ((i++))
            str=$str' '$tmp
        else
            break
        fi
    done
    echo $str
}

# 重复一个字符串
#
# @param string
# @param count
#
# return string
str_repeat()
{
    if [ $(strlen "$1") == 0 ];then
        echo 0
        return
    fi

    if [ $(is_numeric $2) == 0 ];then
        echo 0
        return
    fi

    if [ $(compare_num $2 0) == 0 ];then
        echo 0
        return
    fi

    local str=''
    for((i=0;i<$2;i++))
    do
        str=${str}$1
    done
    echo $str
    return
}

# 返回字符串首次出现的位置
#
# @param string
# @param match
#
# return
strpos()
{
    if [ $(check_param_num 2 $#) == 0 ];then
        echo 0
        return
    fi

    if [ $(strlen "$1") == 0 ];then
        echo 0
        return
    fi

    if [ $(strlen "$2") == 0 ];then
        echo 0
        return
    fi

    echo `expr index "$1" "$2"`
}

# 返回字符串最后一次出现的位置
#
# @param string
# @param match
#
# return
strrchr()
{
    if [ $(check_param_num 2 $#) == 0 ];then
        echo 0
        return
    fi

    local tmp=`echo $1 | sed 's/\(.*'$2'\)\(.*\)/\1/'`
    echo ${#tmp}

}

# 判断两个字符串是否相同
#
# @param string
# @param string
#
# return
strcmp()
{
    if [ $(check_param_num 2 $#) == 0 ];then
        echo 0
        return
    fi

    if [ `expr match "$1" "$2"` == $(strlen "$1") ];then
        echo 1
    else
        echo 0
    fi

    return
}

# 反转字符串
#
# @param string
#
# return
strrev()
{
    if [ $(check_param_num 1 $#) == 0 ];then
        echo 0
        return
    fi

    echo `echo "$1" | rev`
}

# 将字符串转为大写
#
# @param string
#
# return
strtoupper()
{
    if [ $(check_param_num 1 $#) == 0 ];then
        echo 0
        return
    fi

    echo `echo "$1" | tr '[a-z]' '[A-Z]'`
}

# 将字符串转为小写
#
# @param string
#
# return
strtolower()
{
    if [ $(check_param_num 1 $#) == 0 ];then
        echo 0
        return
    fi

    echo `echo "$1" | tr '[A-Z]' '[a-z]'`
}

# 返回字符串出现的次数
#
# @param string
# @param match
#
# return
substr_count()
{
    if [ $(check_param_num 2 $#) == 0 ];then
        echo 0
        return
    fi

    if [ $(strlen "$2") == 0 ];then
        echo 0
        return
    fi

    echo `echo "$1" | awk -F"$2" '{print NF-1}'`
}

# 标题
#
# @param
#
# return
test()
{
    test=123
    time for i in $(seq 10000);
    do
        a=$(expr length $tset);
    done
}


