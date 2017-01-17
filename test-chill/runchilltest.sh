#!/bin/bash 


## Exit with a hard error, or continue
maybe_exit_with_error_code() {
    if [ $1 != 0 ]; then
        echo $@
        exit 99
    fi
}


## Exit as either pass or fail, depending on both ther error code
##      and whether or not the expectfail flag is set
exit_with_passfail_code() {
    local err=$1
    if [ $expect_fail == 0 ]; then
        if [ $err != 0 ]; then
            echo $@
            exit $err
        else
            exit 0
        fi
    else
        if [ $err == 0 ]; then
            echo $@
            exit 1
        else
            echo $@
            exit 0
        fi
    fi
}

exit_with_skip_code() {
    echo $@
    exit 77 
}


## Get the destination filename from the script
get_destination() {   
    cmd="sed -n \"s/destination('\(.*\)')/\1/p\" $1"
    echo `eval $cmd`
}


## Read input
call_path=$(dirname `realpath $0`)
chill_exec=`realpath $1`
chill_script_path=$(dirname `realpath $2`)
chill_script=$(basename $2)
shift 2

pushd $chill_script_path >/dev/null
chill_generated_source=$(get_destination $chill_script)

## remove generated file if it exists
if [ -e $chill_generated_source ]; then
    rm $chill_generated_source
fi


## Defaults
expect_fail=0
skip_test=0

## Read arguments
arg_index=1
while [ $arg_index -lt $(( $# + 1 )) ]; do
    case ${!arg_index} in
        exfail)
                expect_fail=1
            ;;
        skip)
                skip_test=1
            ;;
        check-run)
                test_type=${!arg_index}
            ;;
        check-generated-diff)
                test_type=${!arg_index}
                arg_index=$[$arg_index + 1]
                pushd $call_path >/dev/null
                check_output_diff_answer_file=`realpath ${!arg_index}`
                popd >/dev/null
            ;;
    esac
    arg_index=$[$arg_index + 1]
done

## A basic run chill command
##      $1 - file to send stdout to
##      $2 - file to send stderr to
##      $3 - check output file exists
##          0 or nothing    - don't check
##          > 0             - the error code if file does not exist
run_chill() {
    $chill_exec $chill_script 1>$1 2>$2
    err=$?
    if [ $err == 0 -a -n "$3" -a $3 -gt 0 ]; then
        if [ ! -e $chill_generated_source ]; then
            err=$3
            msg="output file was not generated"
        fi
    else
        msg="error while running CHiLL"
    fi
    echo $err $msg
}

## Skip Test? ##
if [ $skip_test != 0 ]; then
    exit_with_skip_code
fi

## Run Test $$
case $test_type in
    check-run)
            err=`run_chill /dev/null /dev/null 2`
            if [ -e $chill_generated_source ]; then
                rm $chill_generated_source
            fi
            exit_with_passfail_code $err
        ;;
esac

popd >/dev/null
