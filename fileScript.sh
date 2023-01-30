#Area Size Variation
>output.txt
for i in 250 500 750 1000 1250
do
    ns tclScript.tcl 40 20 $i $i
    awk -f parse.awk trace.tr
done

#run pythonScript