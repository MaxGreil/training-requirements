# Answers to questions from "Linux for Bioinformatics"

Q1. What is your home directory?

A:
```
/home/ubuntu
```

Q2. What is the output of this command?

A:
```
hello_world.txt
```

Q3. What is the output of each `ls` command?

A:
```
ls my_folder:
ls my_folder2: hello_world.txt
```
   
Q4. What is the output of each?

A:
```
ls my_folder:
ls my_folder2:
ls my_folder3: hello_world.txt
```
   
Q5. Why didn't that work? 

A: 
```
We get the following error message: 
Server refused our key. No supported authentication methods available (server sent: publickey).
Explanation here is that for new user sudouser we need to generate a new private/public keypair to access sudouser via ssh.
```

Q6. What was the solution?

A:
```
1) Switch to user sudouser with command: su - sudouser
2) Generate new private/public ssh keypair with command: ssh-keygen -t rsa -b 4096
3) Copy generated public key from file ~/.ssh/id_rsa.pub into new file ~/.ssh/authorized_keys
4) Use generated private key to access new user sudouser via ssh
```

Q7. what does the sudo docker run part of the command do? and what does the salmon swim part of the command do?

A:
```
The sudo docker run command executes the docker command run in sudo mode, which executes the docker image specified after it.
The samon swim command executes the salmon docker image with command swim. Swim checks correctness of docker image salmon and its current version.
```

Q8. What is the output of this command?

A:
```
serveruser is not in the sudoers file.  This incident will be reported.
```

Q9. What does -c bioconda do?
 
A:
```
Conda command -b bioconda instructs conda to search for a package in the bioconda channel.
```

Q10. What does the -o athal.ga.gz part of the command do? 

A:
```
Command -o renames donwloaded file Arabidopsis_thaliana.TAIR10.28.cdna.all.fa.gz to athal.ga.gz.
```

Q11. What is a .gz file?

A:
```
A .gz file is a Gunzip compressed file.
```

Q12. What does the zcat command do?

A:
```
Zcat is a command line utility for viewing the contents of a compressed file without literally uncompressing it.
```

Q13. what does the head command do?

A:
```
The head command prints the top N lines (by default the first 10) of the given input.
```

Q14. what does the number 100 signify in the command?

A:
```
The number 100 signifies that the top 100 lines of the input are printed.
```

Q15. What is | doing? 

A:
```
"Piping" in Linux redirects the output of one command to the input of another command. Thereby you can chain commands/processes into one line.
```

Q16. What format are the downloaded sequencing reads in?

A:
```
The downloaded sequencing reads are in .sra file format.
```

Q17. What is the total size of the disk?

A:
```
The total size of the disk is 7.7G.
```

Q18. How much space is remaining on the disk?

A:
```
1.8G space are remaining.
```

Q19. What went wrong?

A:
```
While using fastq-dump SRR074122 we ran out of free disk space.
```

Q20: What was your solution? 

A:
```
I used option --gezip for fastq-dump to compress the output using gzip.
```