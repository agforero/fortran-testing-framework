# A script to add env.txt file to a subdirectory. Allows the generic test to also load in necessary environmental commands, e.g. module load <whatever>.

cd source
if [ ! -d $1 ]; then 
    echo "Directory not found in /source/"
    exit 1
elif [ $# -ne 1 ]; then
    echo "Usage: ./addEnv.sh <directory>"
    exit 2
else
    cd $1
    echo "Enter preemptive environmental commands to be included in env.txt (and, by extension, test.bats)."
    echo "Type ctrl + D when done."
    echo -e "\n============================ BEGIN INPUT ============================"
    while read comm 
    do
        echo "$comm" >> env.txt
    done
    echo -e "============================  END INPUT  ============================\n"
    echo "Generation complete. env.txt saved in $(pwd)".
fi