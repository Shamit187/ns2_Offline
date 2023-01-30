tclFile=tclScript.tcl
awkFile=parse.awk
pythonFile=graphGenerator.py

if [[ $1 == "802.11" ]]
then
    tclFile=tclScript_802_11.tcl
fi

#variation parameters
area=(250 500 750 1000 1250)
node=(20 40 60 80 100)
flow=(10 20 30 40 50)

#Area Size Variation
>output.txt
for i in ${area[@]}
do
    echo $i >> output.txt
    ns $tclFile 40 20 $i $i
    awk -f $awkFile trace.tr
done

python3 $pythonFile output.txt area

#Node Size Variation
>output.txt
for i in ${node[@]}
do
    echo $i >> output.txt
    ns $tclFile $i 20 500 500
    awk -f $awkFile trace.tr
done

python3 $pythonFile output.txt node

#Flow Size Variation
>output.txt 
for i in ${flow[@]}
do
    echo $i >> output.txt
    ns $tclFile 40 $i 500 500
    awk -f $awkFile trace.tr
done

python3 $pythonFile output.txt flow