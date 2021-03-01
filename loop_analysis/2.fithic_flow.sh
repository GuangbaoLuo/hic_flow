## 0 prepare the input file for fithic, changge the hic-pro matrix into fithic file 
python HiCPro2FitHiC.py -i sample_symmetric.matrix -b sample.bed -o outpath -r   dpi -sp sample_name
## output fragmentMappability; interactionCounts

## 1 generate bias file 
python HiCKRy.py -i interactionCounts.gz -f fragmentMappability.gz -o bias.gz
## 2 run Fit-Hi-C
python fithic -i interactionCounts.gz -f fragmentMappability.gz -t bias.gz \
	-o outpath -r 100000 -x All -v -l -p 2

## 3 result explannation
  # outres-->  sample.spline_pass2.res10000.significances.txt.gz
zcat sample.spline_pass2.res10000.significances.txt.gz | \
awk '$6 < 0.01 && $7 < 0.01' > sample.10000.pq0.01significances_interaction.txt

