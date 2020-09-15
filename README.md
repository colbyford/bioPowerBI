# bio-Power BI

<h3 align="right">Josh Crittenden and Colby T. Ford</h3>

Resources for reading and visualizing bioinformatics and genomics data. Using the following M (Power Query) scripts and Power BI examples, you can easily read in various unique file types commonly found in genomics.

<p align="right"><img src="https://raw.githubusercontent.com/colbyford/bioPowerBI/master/img/icon.png" width="100px"></p>

## File Parsers

| Filetype 	| Specification                                    	| Directory    	                | Notes                               |
|----------	|--------------------------------------------------	|-------------------------------|-------------------------------------|
| .vcf     	| https://samtools.github.io/hts-specs/VCFv4.3.pdf 	| [\vcf](vcf)         	        |                                     |
| .fastq   	| http://maq.sourceforge.net/fastq.shtml           	| [\fastq](fastq)       	      | For analysis, this file's sequences should likely be aligned. |
| .sam     	| https://samtools.github.io/hts-specs/SAMv1.pdf   	| [\sam](sam) 	|                                     |
| .bam     	| https://samtools.github.io/hts-specs/SAMv1.pdf   	| [\bam](bam) 	| Requires the `Rsamtools` R package  |
| .gff     	| https://m.ensembl.org/info/website/upload/gff3.html   	| [\gff3](gff3) 	| `attributes` column still needs to be parsed.  |
