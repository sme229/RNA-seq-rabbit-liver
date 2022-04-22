#Matt Neave's data re-analysis, RHDV2 raw files: K378, K376, K375 are uninfected; K14, K12, K3 uninfected    
#open the terminal

cd /datasets/work/hb-rabbits/work/Lena_MS_RAW_DATA/transcriptom                            #this is where the files are located                      

module load bowtie/2.2.9                                                                   #load the programs needed 
module load samtools/1.3.1

bowtie2-build KF594473.fasta RDHV1_index                                                   #this is to map RHDV genome itself to the reads - checking if the virus is there; don't have to do it  

bowtie2 -x RDHV1_index -q rabA440.fastq -S rabA440_RDHV.sam                        

samtools view -Sb rabA440_RDHV.sam > rabA440_RDHV.bam
samtools sort -@4 rabA440_RDHV.bam > sorted_rabA440_RHDV.bam
samtools index sorted_rabA440_RHDV.bam

samtools view -f4 sorted_rabA440_RHDV.bam > rabA440_RHDV-unmapped.sam
samtools view -F4 sorted_rabA440_RHDV.bam > rabA440_RHDV-mapped.sam

############################################################################################here we map the rabbit genome to the reads  

module load bowtie/2.2.9                                              
module load tophat/2.1.1 
module load samtools/1.3.1

gunzip *.gz                                                                               #unzip the downloaded rabbit files (has to be done just once)
 
cp Oryctolagus_cuniculus.OryCun2.0.dna.toplevel.fa rab_index.fa                           #just copies the file and renames it... it's easier to type and to remember :)
bowtie2-build rab_index.fa rab_index                                                      #index fasta-file

tophat -p 10 -G Oryctolagus_cuniculus.OryCun2.0.101.gtf -o rabA449_test rab_index rabA449.fastq       #mapping to the rabbit genome


module load python/2.7.13

htseq-count --format bam --type exon --stranded=no rabA440_test/accepted_hits.bam Oryctolagus_cuniculus.OryCun2.0.101.gtf > rabA440.exons.htseq   #count the reads for each gene


