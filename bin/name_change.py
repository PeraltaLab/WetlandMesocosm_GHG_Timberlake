#!/usr/local/bin/python

################################################################################
#
# name_change.py: renames multifasta file containing representative sequences
#                 output from mothur. The file searches for a string starting
#                 with 'Otu' followed by any 6 characters. If the names are
#                 a different length you will need to change the code
#
# Required Inputs: [1] input file name [2] output file name
#
# written by Mario Muscarella
# last update 25 Aug 2016
#
################################################################################

import sys
import os
import re
from Bio import SeqIO

# in_file = "./WL.final.0.03.rep.fasta"
# out_file ="./WL.final.0.03.rep.rename.fasta"

in_file = sys.argv[1]
out_file = sys.argv[2]

output_handle = open(out_file, "w")

OldseqID = list()
seqInfo = list()
NewseqID = list()

for seq_record in SeqIO.parse(in_file, "fasta"):
    OldseqID.append(seq_record.id)
    seqInfo.append(seq_record.description)
    seqID_New = seq_record.description
    seqID_New = re.findall('Otu.{6}',seq_record.description)
    NewseqID.append(seqID_New)
    seq_record.id = seqID_New[0]

    SeqIO.write(seq_record, output_handle, "fasta")

output_handle.close()
renamed = len(NewseqID)

print("done")
print("renamed %i sequence records" %(renamed))
