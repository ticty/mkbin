#!/bin/bash


usage()
{
cat << EOF

Something to show

EOF
}


if [ $# -ne 0 ]
then
    case "$1" in
    "-h"|"-help"|"--help")
        usage
        exit 0
    ;;
    *)
        echo "not accept option \"$1\""
        exit 1
    ;;
    esac
fi


proc_line=@LINENUM@
data_md5=@MD5SUM@
tmp_dir="`mktemp -d`"
tmp_data="`tempfile -d \"$tmp_dir\" -s \"gz\"`"
bak_dir="`mktemp -d --tmpdir=\"$tmp_dir\"`"

trap "rm -rf $tmp_dir" EXIT


# extract data and check its md5 value
tail -n +$((@LINENUM@+1)) "$0" > "$tmp_data"
md5=`md5sum "$tmp_data" | awk '{printf $1}'`

if [ "${md5}" != "${data_md5}" ]
then
    echo "packet is broken, please download a new one!"
    exit 1
fi


# extract data
#tar -C "$tmp_dir" -xf "$tmp_data"
cd "$tmp_dir"
tar -xf "$tmp_data"

if [ $? -ne 0 ]
then
	echo "extract the data fail"
	exit 0
fi

#do anything here

# exit here, so the install data would not exec
exit 0
