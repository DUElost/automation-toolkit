#system/bin/sh
time=500
runShell(){
	sleep 3
    if [ $# -eq 3 ]
    then
        mymodule=$1
		myexecute=$2
		script=$3
    elif [ $# -eq 4 ]
    then
        mymodule=$1
		myexecute=$2
		script=$3
		looptime=$4
		# shellcheck disable=SC2206
		ar=(${script//_/ })
		module=`echo ${ar[2]}"module" | tr '[A-Z]' '[a-z]' `
    else
        echo "The function shall be: runShell script [times]."
        exit
    fi
    echo test script is $script
	echo test module is $module
	setenforce 0
	echo am instrument -w -m -e listener com.transsion.common.TestCaseRunListener   -e debug  false -e loop $looptime -e class com.transsion.testcaserepository.${mymodule}.${myexecute}#${script} com.transsion.testcaserepository.test/androidx.test.runner.AndroidJUnitRunner
	am instrument -w -m -e listener com.transsion.common.TestCaseRunListener   -e debug  false -e loop $looptime -e class com.transsion.testcaserepository.${mymodule}.${myexecute}#${script} com.transsion.testcaserepository.test/androidx.test.runner.AndroidJUnitRunner
}

runShell stressgpu TestStressGpuExecute test_StressSpecial_GPUTest_002 700

