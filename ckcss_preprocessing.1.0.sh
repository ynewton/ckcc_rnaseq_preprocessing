#!/bin/bash
# CKCC mRNA RNASeq preprocessing pipeline (v1.0):
# 1. reduces file size by replacing 0.0000 with 0 and rounding to 2nd floating point digit
# 2. filter out all features (genes) unexpressed in 80% of all samples
# 3. filter out 20% lowest varying genes

if [ -z "$1" ]
  then
    echo "You must supply the input file as a command line argument"
    exit 1
fi

echo "Apply CKCC preprocessing pipeline v1.0 to $1"

echo "Applying number rounding and truncation ..."
python2.7 /usr/bin/round_digits.py --in_matrix $1 --num_digits 2 --out_matrix $1.2decimals

echo "Aggregating duplicate features ..."
python2.7 /usr/bin/aggregate_dups.py --in_file $1.2decimals --out_file temp.tab

echo "Aggregating duplicate samples ..."
/usr/bin/./transpose.pl temp.tab > temp_t.tab
python2.7 /usr/bin/aggregate_dups.py --in_file temp_t.tab --out_file temp_t2.tab
/usr/bin/./transpose.pl temp_t2.tab > $1.2decimals.no_dups
rm temp.tab
rm temp_t.tab
rm temp_t2.tab

echo "Apply expression level filter ..."
python2.7 /usr/bin/filter_out_genes_unexpressed_in_most_samples.py --in_file $1.2decimals.no_dups --proportion_unexpressed 0.8 --out_file $1.2decimals.no_dups.expression_filter_0.8

echo "Applying variance filter ..."
python2.7 /usr/bin/filter_out_lowest_varying_genes.py --in_file $1.2decimals.no_dups.expression_filter_0.8 --filter_level .2 --out_file $1.2decimals.no_dups.expression_filter_0.8.variance_filter_0.2
