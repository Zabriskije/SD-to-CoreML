#!/bin/bash

R='\033[0;31m' #red
G='\033[0;32m' #green
N='\033[0m' #none
# Those are used to modify the text color

SECONDS=0
# Starts counting time

source /Users/YOUR-NAME/miniconda3/etc/profile.d/conda.sh
# Replace "YOUR-NAME" with your username. If Miniconda has been installed in a different folder than your user home folder, choose that path instead. To copy a folder path, simply right-click on a folder, press the Option key, and choose "Copy "FOLDER-NAME" as pathname"

conda activate coreml_stable_diffusion
# This activate the conda coreml_stable_diffusion environment

cd FOLDER-WITH-convert_original_stable_diffusion_to_diffusers.py
# Replace the line after "cd " with the folder path where the python script is located at


until
	python ./convert_original_stable_diffusion_to_diffusers.py --checkpoint_path "./model.ckpt" --device cpu --extract_ema --dump_path "./diffusers"
	# This is the command for converting to DIFFUSERS. You can change "./model.ckpt" with your model name (e.g. "./MODEL-NAME.ckpt"), or leave it as it is and rename your CKPT file to "model.ckpt". It's easier to do the latter, since you don't have to edit this script every time you convert a model with a different name
do
	afplay /System/Library/Sounds/Sosumi.aiff -v 5
	# Plays a sound if the conversion fails. "-v" is volume. You can also use: say "error"; Siri will pronunce it for you. Or remove it altogether if you don't like it
	echo -e "\n\n"
	# Displays three empty lines
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Displays a divider large as the Terminal window
	echo -e "${R}Conversion to DIFFUSERS failed. Retrying conversion in 10 seconds...${N}"
	# Displays a message. "${R}" and "${N}" are for the text color
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Divider again
	echo -e "\n\n"
	# Empty lines
	sleep 10
	# This command will run until it's successful. In case it fails multiple times, check the Terminal log to see if there's something that needs to be adjusted. The number after "sleep" tells the command how long it should wait to try again
done


echo -e "\n\n"
# Displays three empty lines
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Displays a divider large as the Terminal window
echo -e "${G}Conversion to DIFFUSERS completed.${N}"
# Displays a message. "${G}" and "${N}" are for the text color
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Divider again
echo -e "\n\n"
# Empty lines


cd FOLDER-WITH-MODEL-CKPT
# Replace the line after "cd " with the folder path where the model CKPT is located at. If your model is in the same folder as the convertoriginal_stable_diffusion_to_diffusers.py file, you can delete this command


until
	python -m python_coreml_stable_diffusion.torch2coreml --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./original"
	# This is the command for converting to ORIGINAL
do
	afplay /System/Library/Sounds/Sosumi.aiff -v 5
	# Plays a sound if the conversion fails. "-v" is volume. You can also use: say "error"; Siri will pronunce it for you. Or remove it altogether if you don't like it
	echo -e "\n\n"
	# Displays three empty lines
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Displays a divider large as the Terminal window
	echo -e "${R}Conversion to ORIGINAL failed. Retrying conversion in 10 seconds...${N}"
	# Displays a message. "${R}" and "${N}" are for the text color
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Divider again
	echo -e "\n\n"
	# Empty lines
	sleep 10
	# This command will run until it's successful. In case it fails multiple times, check the Terminal log to see if there's something that needs to be adjusted. The number after "sleep" tells the command how long it should wait to try again
done


echo -e "\n\n"
# Displays three empty lines
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Displays a divider large as the Terminal window
echo -e "${G}Conversion to ORIGINAL completed.${N}"
# Displays a message. "${G}" and "${N}" are for the text color
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Divider again
echo -e "\n\n"
# Empty lines


until
	python -m python_coreml_stable_diffusion.torch2coreml --latent-w 64 --latent-h 96 --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./original_512x768"
	# This is the command for converting to ORIGINAL 512x768. You can change "--latent-w #" and "--latent-h #" to your preferred size. Note that at this time, 64x96 and 96x46 are recommended, since other sizes don't work well with all machines; and sizes above 96x96 just can't run. The chosen values will be multiplied by 8, so in this case, you will obtain a 512x768 model. Also, the final image size must be divisible by 64 (must return a whole number), for example: 768/64=12
do
	afplay /System/Library/Sounds/Sosumi.aiff -v 5
	# Plays a sound if the conversion fails. "-v" is volume. You can also use: say "error"; Siri will pronunce it for you. Or remove it altogether if you don't like it
	echo -e "\n\n"
	# Displays three empty lines
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Displays a divider large as the Terminal window
	echo -e "${R}Conversion to ORIGINAL 512x768 failed. Retrying conversion in 10 seconds...${N}"
	# Displays a message. "${R}" and "${N}" are for the text color
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Divider again
	echo -e "\n\n"
	# Empty lines
	sleep 10
	# This command will run until it's successful. In case it fails multiple times, check the Terminal log to see if there's something that needs to be adjusted. The number after "sleep" tells the command how long it should wait to try again
done


echo -e "\n\n"
# Displays three empty lines
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Displays a divider large as the Terminal window
echo -e "${G}Conversion to ORIGINAL 512x768 completed.${N}"
# Displays a message. "${G}" and "${N}" are for the text color
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Divider again
echo -e "\n\n"
# Empty lines


until
	python -m python_coreml_stable_diffusion.torch2coreml --latent-w 96 --latent-h 64 --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./original_768x512"
	# This is the command for converting to ORIGINAL 768x512. You can change "--latent-w #" and "--latent-h #" to your preferred size. Note that at this time, 64x96 and 96x46 are recommended, since other sizes don't work well with all machines; and sizes above 96x96 just can't run. The chosen values will be multiplied by 8, so in this case, you will obtain a 768x512 model. Also, the final image size must be divisible by 64 (must return a whole number), for example: 768/64=12
do
	afplay /System/Library/Sounds/Sosumi.aiff -v 5
	# Plays a sound if the conversion fails. "-v" is volume. You can also use: say "error"; Siri will pronunce it for you. Or remove it altogether if you don't like it
	echo -e "\n\n"
	# Displays three empty lines
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Displays a divider large as the Terminal window
	echo -e "${R}Conversion to ORIGINAL 768x512 failed. Retrying conversion in 10 seconds...${N}"
	# Displays a message. "${R}" and "${N}" are for the text color
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Divider again
	echo -e "\n\n"
	# Empty lines
	sleep 10
	# This command will run until it's successful. In case it fails multiple times, check the Terminal log to see if there's something that needs to be adjusted. The number after "sleep" tells the command how long it should wait to try again
done


echo -e "\n\n"
# Displays three empty lines
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Displays a divider large as the Terminal window
echo -e "${G}Conversion to ORIGINAL 768x512 completed.${N}"
# Displays a message. "${G}" and "${N}" are for the text color
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Divider again
echo -e "\n\n"
# Empty lines


until
	python -m python_coreml_stable_diffusion.torch2coreml --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./diffusers" --bundle-resources-for-swift-cli --attention-implementation SPLIT_EINSUM -o "./_split-einsum"
	# This is the command for converting to SPLIT_EINSUM
do
	afplay /System/Library/Sounds/Sosumi.aiff -v 5
	# Plays a sound if the conversion fails. "-v" is volume. You can also use: say "error"; Siri will pronunce it for you. Or remove it altogether if you don't like it
	echo -e "\n\n"
	# Displays three empty lines
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Displays a divider large as the Terminal window
	echo -e "${R}Conversion to SPLIT_EINUM failed. Retrying conversion in 10 seconds...${N}"
	# Displays a message. "${R}" and "${N}" are for the text color
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	# Divider again
	echo -e "\n\n"
	# Empty lines
	sleep 10
	# This command will run until it's successful. In case it fails multiple times, check the Terminal log to see if there's something that needs to be adjusted. The number after "sleep" tells the command how long it should wait to try again
done


rm -rf diffusers
mv original deleting...
mv deleting.../Resources deleting.../original
mv deleting.../original .
rm -rf deleting...
mv original_512x768 deleting...
mv deleting.../Resources deleting.../original_512x768
mv deleting.../original_512x768 .
rm -rf deleting...
mv original_768x512 deleting...
mv deleting.../Resources deleting.../original_768x512
mv deleting.../original_768x512 .
rm -rf deleting...
mv split-einsum deleting...
mv deleting.../Resources deleting.../split-einsum
mv deleting.../split-einsum .
rm -rf deleting...
# This whole block removes all the unnecessary files by deleting the "diffusers" folder, renaming the output folders to "deleting...", renaming the "Resource" folders as the original output folders, extracting them, and deleting the original output folders


duration=$SECONDS
# Sets the "duration" command
echo -e "\n\n"
# Displays three empty lines
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Displays a divider large as the Terminal window
echo -e "${G}Conversion to SPLIT_EINSUM completed.${N}"
# Displays a message. "${G}" and "${N}" are for the text color
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Divider again
echo -e "\n\n"
# Empty lines
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Displays a divider large as the Terminal window
echo -e "${G}All conversions completed in $(($duration / 60))min and $(($duration % 60))s.${N}"
# Displays a message with the execution time
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
# Divider again
echo -e "\n\n"
# Empty lines


afplay /System/Library/Sounds/Funk.aiff -v 5
# Plays a sound if all the conversions are successful


# Wiki: https://github.com/godly-devotion/MochiDiffusion/wiki/How-to-convert-ckpt-or-safetensors-files-to-Core-ML
# FAQ: https://github.com/godly-devotion/MochiDiffusion/wiki/Frequently-Asked-Questions
# Hugging Face: https://huggingface.co/coreml
# Discord: https://discord.gg/x2kartzxGv

# You can erase all the comments preceded by the # symbol
# Just don't erase #!/bin/bash ;)
# Have fun! — Zabriskije