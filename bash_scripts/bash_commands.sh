# convert fastq to fasta
sed -n '1~4s/^@/>/p;2~4p' sample.fastq > sample.fasta

# convert from fastq.gz to fasta
gunzip -c sample.fastq.gz | awk '{if(NR%4==1) {printf(">%s\n",substr($0,2));} else if(NR%4==2) print;}' > sample.fasta

# merge all paired_1 fastq files to "greywater_paired_1.fastq" for co-assembly
# merge all paired_2 fastq files to "greywater_paired_2.fastq" for co-assembly

# Count bin numbers
sample=($(cat SampleNames.txt))
cd ./reassembled_bins_metaspades_90_5
for i in {0..9}
do
    count=$(ls ./${sample[${i}]}/reassembled_bins | wc -l)
    echo ${count} >> bin_numbers.txt
done


# change output file names
cd ./reassembled_bins_metaspades_70_10
for i in {0..9}
do
    mv ./${sample[${i}]}/reassembled_bins.stats ./${sample[${i}]}_reassembled_bins_stats_70_10.txt
done

cd ../reassembled_bins_metaspades_90_5
for i in {0..9}
do
    mv ./${sample[${i}]}/reassembled_bins.stats ./${sample[${i}]}_reassembled_bins_stats_90_5.txt
done
