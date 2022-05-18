# B_mexicanum
This is to pull out all of the double copies of genes from Bmex and Bhyb but sinlge copy from brachy spceis and rice.

#### 1 Pull out the genes IDs from the orthogroups

The orthogroup files are from the John Lovell's GENESPACE

```
:~/Downloads/liBrachyOrthos/Orthogroups$ 
awk '$2 == "1" && $3 == "1" && $4 == "2" && $5 == "2" && $6 == "1" && $7 == "1" && $9 == "1"' Orthogroups.GeneCount.tsv|wc -l
    8525

awk '$2 == "1" && $3 == "1" && $4 == "2" && $5 == "2" && $6 == "1" && $7 == "1" && $9 == "1"' Orthogroups.GeneCount.tsv >double_ccopy.list

```

### 2 based on the gene list, pull out hte sequence. For each gene, put their sequence in sinlge fasta file.

```
./pull_orthsequence.pl /global/cfs/cdirs/plantbox/phytozome/browser.build/results/bulk_files/phytozome/BsylvaticumAin_1_721_v2.1/annotation/BsylvaticumAin_1_721_v2.1.cds_primaryTranscriptOnly.fa /global/cfs/cdirs/plantbox/phytozome/browser.build/results/bulk_files/phytozome/Bmexicanum_577_v1.1/annotation/Bmexicanum_577_v1.1.cds_primaryTranscriptOnly.fa  /global/cfs/cdirs/plantbox/phytozome/browser.build/results/bulk_files/phytozome/BarbusculaBARB1_720_v3.1/annotation/BarbusculaBARB1_720_v3.1.cds_primaryTranscriptOnly.fa /global/u2/l/llei2019/plantbox/cscratch/CSP_Dave/Genome_assembly/OsativaKitaake/annotation/OsativaKitaake_499_v3.1.cds_primaryTranscriptOnly.fa /global/u2/l/llei2019/plantbox/cscratch/CSP_Dave/Genome_assembly/Bstacei/annotation/Bstacei_316_v1.1.cds_primaryTranscriptOnly.fa /global/u2/l/llei2019/plantbox/cscratch/CSP_Dave/Genome_assembly/Bdist_v3.2/v3.2/annotation/Bdistachyon_556_v3.2.cds_primaryTranscriptOnly.fa /global/u2/l/llei2019/plantbox/cscratch/CSP_Dave/Genome_assembly/Bhybridum/annotation/Bhybridum_463_v1.1.cds_primaryTranscriptOnly.fa /global/u2/l/llei2019/plantbox/cscratch/CSP_Dave/orth_tree/double_copy_genes.txt
```

### 3 Run muscle to do the multiple sequence alignment 

````
./muscle3.8.31_i86linux64 -in /global/u2/l/llei2019/plantbox/cscratch/CSP_Dave/orth_tree/fasta/OG0020886.fasta  -out OG0020886.MSA.fasta

````
job submission

```

find $PWD -type f -name "*.fasta" >/global/u2/l/llei2019/plantbox/cscratch/CSP_Dave/orth_tree /fasta_8525_file.list

sbatch --array=0-1 -C haswell run_muscle.job

```

### 4 build the tree with iqtree

```
./iqtree -s ~/plantbox/bscratch/llei2019/software/OG0020886.MSA.fasta -o OsKitaake03g033100 -redo -m GTR+I+G 

```
