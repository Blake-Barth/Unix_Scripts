#!/bin/sh
# Blake Barth
# Plots data given by file and fieldname

# Check for correct # of args
if [ "$#" -ne 2 ]; then
    echo "Usage: plot.sh <filename> <fieldname>"
    exit 1
fi

filename=$1
fieldname=$2

# Check for file existing
if [ ! -f "$filename" ]; then
    echo "Error: File not found!"
    exit 1
fi

header=$(head -n 1 "$filename")

# Check for field not found
if [ $(grep -cw "$fieldname" "$filename") -lt 1 ] 
then
    echo "Error: Fieldname not found!"
    exit 1
fi

# Get index using awk statement
index=$(awk -F' ' -v fieldname="$fieldname" 'NR==1 { for (i=1; i<=NF; i++) if ($i == fieldname) print i }' "$filename")

touch tmp1.dat

# Use cut to get all values at index, only ints accepted
cut -d' ' -f"$index" "$filename" | grep -E '^-?[0-9]+$' > tmp1.dat

# Sort values from high to low
touch tmp2.dat
sort -n tmp1.dat > tmp2.dat

# Get low and high using head and tail
lowx=$(head -n 1 tmp2.dat)
highx=$(tail -n 1 tmp2.dat)

# Tmp files
touch tmp3.dat
touch tmp4.dat
touch tmp5.dat

# Get table of unique values and frequencies
uniq -c tmp2.dat > tmp3.dat

# Sort by frequency to easily get high y
sort -nr tmp3.dat | awk '{print $1}' > tmp4.dat
highy=$(head -n 1 tmp4.dat)

# Change order of frequency value given in uniq -c
awk '{print $2, $1}' tmp3.dat > tmp5.dat

# Copy plot file
cp /home/faculty/whalley/cop4342exec/plot.p plot1.p

# Change plot values
sed -i "s/LOWX/$lowx/g" plot1.p
sed -i "s/HIGHX/$highx/g" plot1.p
sed -i "s/HIGHY/$highy/g" plot1.p
sed -i "s/FILE/tmp5.dat/g" plot1.p

# Create plot
gnuplot plot1.p
ps2pdf graph.ps graph.pdf
evince graph.pdf & # display pdf in background

# Cleanup
rm tmp1.dat tmp2.dat tmp3.dat tmp4.dat tmp5.dat plot1.p graph.ps
echo "Plotting Successful"
exit 0
