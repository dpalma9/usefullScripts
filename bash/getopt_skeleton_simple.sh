#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: scriptTemplate [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
   echo
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################
############################################################
# Process the input options. Add options as needed.        #
############################################################

# Check if arguments:
if [ $# -eq 0 ]; then
    echo "No parameters provided"
    exit 1
fi

# Get the options
while getopts ":hHn:N: \
        --long help,name:" option; do
   case $option in
     [hH] |--help) # display Help
         Help
         exit;;
     [nN]|--name) # Enter a name
         #Name=$OPTARG;;
         ## Note: we can use $2
         #Name=$2;;
         # or use shift
         shift
         Name=$1;;
     -test)
       echo "hola, test";;
     :)
         echo "Option -$OPTARG requires an argument" >&2
         exit;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

echo "Hello, world!"
echo "Hi, $Name"
echo "Hi, $2"
