tclFile=tclScript.tcl
awkFile=parse.awk
pythonFile=graphGenerator.py

if [[ $1 == "802.11" ]]
then
    tclFile=tclScript_802_11.tcl
fi

#variation parameters
area=(250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1050 1100 1150 1200 1250)
node=(20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100)
flow=(10 13 15 17 20 23 25 27 30 33 35 37 40 43 45 47 50)

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