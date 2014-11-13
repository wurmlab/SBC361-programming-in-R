# Intro to Unix

You'll want to find some Unix cheat sheet on google.

Commands: 

 * ls  # -a -l -t -h)
 * pwd
 * cd  # dir .. ~ 
 * mkdir
 * nano 
 * mv
 * cp
 * ln 
 * rm
 * rmdir
 * wget  # download file (first)
 * head
 * tail
 * less
 * grep 
 * getting help; running stuff
 * R 

 * example: run blast of gene against swissprot
   http://www.antgenomes.org/~yannickwurm/tmp/2014-10-15-Swissprot.zip

 * example: seqtk compile ; extract specific scaffold. 


Resource monitoring
 * htop or top
 * who


HPC concept

Remote: 
 
 * ssh mscstudent@          
 * ssh mpx163@frontend1.apocrita.hpc.qmul.ac.uk
 * qlogin
   qlogin -pe smp 4 -l h_vmem=10G  # four cores and 40 gigs of Ram 
 * (qsub)
 * scp 