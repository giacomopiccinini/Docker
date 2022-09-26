#!/bin/bash

############################################################
# Help                                                     #
############################################################

Help()
{
   # Display Help
   echo
   echo "Syntax: run_reconstruction.sh [-h | -p <parameter>]"
   echo "options:"
   echo "-p     Pass a specific parameter."
   echo "-h     Print this Help."
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

# Get the options
while getopts ":hp:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      p) # Enter a pattern
         parameter=$OPTARG;;
     #\?) 
      *) # Invalid option
         echo
         echo "Error: Invalid option!"
         Help
         exit;;
   esac
done

# Exit if no option is passed
if [ $OPTIND -eq 1 ]; then 
    echo
    echo "No options were passed."
    Help
    exit 
fi



# Run a certain script inside the container 
docker container exec my_container Scripts/run.sh -p $parameter