#Yulia Newton
#python2.7 aggregate_dups.py --in_file input.tab --out_file output.tab

import optparse, sys, os, glob, numpy, operator, math
parser = optparse.OptionParser()
parser.add_option("--in_file", dest="in_file", action="store", default="", help="")
parser.add_option("--out_file", dest="out_file", action="store", default="", help="")
opts, args = parser.parse_args()

#process input arguments:
in_file = opts.in_file
out_file_name = opts.out_file

print >> sys.stderr, "Reading in input..."
line_count = 1
feature_val_dict = {}
feature_count_dict = {}
input = open(in_file, 'r')
for line in input:
	line = line.replace("\n", "")
	if line_count == 1:
		header_line = line
	else:
		line_elems = line.split("\t")
		if not(line_elems[0] in feature_val_dict):
			feature_val_dict[line_elems[0]] = []
		feature_val_dict[line_elems[0]].append([float(x) for x in line_elems[1:]])
		
		if not(line_elems[0] in feature_count_dict):
			feature_count_dict[line_elems[0]] = 0
		feature_count_dict[line_elems[0]] += 1
		
	line_count += 1

input.close()

print >> sys.stderr, "Outputting and aggregating duplicates..."
output = open(out_file_name, 'w')
print >> output, header_line
for k in feature_count_dict.keys():
	k_count = feature_count_dict[k]
	if k_count == 1:	#not duplicated
		output_vals = [str(x) for x in feature_val_dict[k][0]]
	
	else:
		k_vals_t = numpy.transpose(feature_val_dict[k])
		aggregated_vals = []
		for i in range(len(k_vals_t)):
			aggregated_vals.append(numpy.median(k_vals_t[i]))
		output_vals = [str(x) for x in aggregated_vals]
		
	print  >> output, k + "\t" + "\t".join(output_vals)

output.close()
