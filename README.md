# bash-example
This repository is aimed at providing some basic examples on how to use 
the bash shell to perform routine, repeatable tasks on a linux platform. 

# Scripts
| name | description |
|------|-------------|
| case.sh | uses case statements to do something based on user input |
| example.sh | script that collects system information and utilizes several components of the operating system and the shell |
| for.sh | Very simple `for` loop |
| functions.sh | Shows a couple of different ways to use functions |
| select.sh | Similar to `case` but instead presents a generated menu to select what to do next|
| while.sh | Another simple loop |

*NOTE* Only the script `example.sh` requires sudo access

# Running the scripts
Each script is located in the `scripts` directory
1. Clone the project<br />
`git clone https://github.com/rha-cp-satx/bash-example.git`
2. Change directory to the repo/scripts directory<br />
`cd bash-example/scripts`
3. Make the scripts executable<br />
`chmod +x *.sh`

If you don't want to make the files executable you can always run them like:<br />
`bash example.sh`
