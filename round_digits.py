#Yulia Newton
#python2.7 round_digits.py --in_matrix input.tab --num_digits 2 --out_matrix output.tab

import optparse

def main():
	parser = optparse.OptionParser()
	parser.add_option("--in_matrix", dest="in_matrix", action="store", default="", help="")
	parser.add_option("--num_digits", dest="num_digits", action="store", default="", help="")
	parser.add_option("--out_matrix", dest="out_matrix", action="store", default="", help="separated by comma")
	opts, args = parser.parse_args()
	
	#process input arguments:
	in_matrix = opts.in_matrix
	num_digits = int(opts.num_digits)
	out_matrix = opts.out_matrix
	
	input = open(in_matrix, 'r')
	output = open(out_matrix, 'w')
	line_num = 0
	for line in input:
		line_elems = line.replace("\n", "").split("\t")
		if line_num == 0:
			output_line = "\t".join(line_elems)
		else:
			output_line = line_elems[0]
			for e in line_elems[1:]:
				if float(e) == 0.0:
					val_str = "0"
				else:
					val_str = format(float(e), '.2f')
				output_line = output_line + "\t" + val_str
		print >> output, output_line
		line_num += 1
	
	output.close()
	input.close()
	
main()
