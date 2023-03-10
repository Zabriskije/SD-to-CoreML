#!/bin/bash

# Change your conda path here
source /Users/YOUR_USERNAME/miniconda3/etc/profile.d/conda.sh
conda activate coreml_stable_diffusion

# Change your model path here
cd /Users/YOUR_USERNAME/YOUR_PATH

###############################################################################
##                                                                           ##
##                               Model prompt                                ##
##                                                                           ##
###############################################################################

B=$(printf %"$(tput cols)"s |tr " " "-")
R='\033[0;31m'
G='\033[0;32m'
N='\033[0m'

printf '\33c\e[3J'
echo -e "${B}\nSD to Core ML script by ${R}φ Zabriskije${N}\n${B}\n"
read -p "Enter model name: " mname

###############################################################################
##                                                                           ##
##                              Conversion menu                              ##
##                                                                           ##
###############################################################################

PS3=$'\n'"Pick a number: "
while true; do
   printf '\33c\e[3J'
   echo -e "${B}\nSD to Core ML script by ${R}φ Zabriskije${N}\n${B}\n"
   COLUMNS="0"; options=("CKPT → All" "CKPT → Diffusers" "SafeTensors → All" "SafeTensors → Diffusers" "Diffusers → ORIGINAL" "Diffusers → ORIGINAL 512x768" "Diffusers → ORIGINAL 768x512" "Diffusers → SPLIT_EINSUM" "Credits" "Quit") &&
   select opt in "${options[@]}"; do
      case $opt in
         
         ###############################################################################
         ##                                                                           ##
         ##                                CKPT → All                                 ##
         ##                                                                           ##
         ###############################################################################
         
         "CKPT → All")
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                           CKPT → All (Diffusers)                            #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "\n${G}Converting [1/5] to Diffusers...${N}\n"
            
            SECONDS=0
            
            until
               python "./convert_original_stable_diffusion_to_diffusers.py" --checkpoint_path "./${mname}.ckpt" --device cpu --extract_ema --dump_path "./${mname}_diffusers"
            do
               osascript -e 'display notification "Conversion [1/5] to Diffusers failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "$\n{R}Conversion [1/5] to Diffusers failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [1/5] to Diffusers completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                           CKPT → All (ORIGINAL)                             #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "${G}Converting [2/5] to ORIGINAL...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./${mname}_original"
            do
               osascript -e 'display notification "Conversion [2/5] to ORIGINAL failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion [2/5] to ORIGINAL failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_original deleting...
            mv deleting.../Resources deleting.../${mname}_original
            mv deleting.../${mname}_original .
            rm -rf deleting...
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [2/5] to ORIGINAL completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                       CKPT → All (ORIGINAL 512x768)                         #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "${G}Converting [3/5] to ORIGINAL 512x768...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --latent-w 64 --latent-h 96 --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./${mname}_original_512x768"
            do
               osascript -e 'display notification "Conversion [3/5] to ORIGINAL 512x768 failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion [3/5] to ORIGINAL 512x768 failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_original_512x768 deleting...
            mv deleting.../Resources deleting.../${mname}_original_512x768
            mv deleting.../${mname}_original_512x768 .
            rm -rf deleting...
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [3/5] to ORIGINAL 512x768 completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                       CKPT → All (ORIGINAL 768x512)                         #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "${G}Converting [4/5] to ORIGINAL 768x512...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --latent-w 96 --latent-h 64 --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./${mname}_original_768x512"
            do
               osascript -e 'display notification "Conversion [4/5] to ORIGINAL 768x512 failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion [4/5] to ORIGINAL 768x512 failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_original_768x512 deleting...
            mv deleting.../Resources deleting.../${mname}_original_768x512
            mv deleting.../${mname}_original_768x512 .
            rm -rf deleting...
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [4/5] to ORIGINAL 768x512 completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                         CKPT → All (SPLIT_EINSUM)                           #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "${G}Converting [5/5] to SPLIT_EINSUM...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation SPLIT_EINSUM -o "./${mname}_split-einsum"
            do
               osascript -e 'display notification "Conversion [5/5] to SPLIT_EINSUM failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion [5/5] to SPLIT_EINSUM failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_split-einsum deleting...
            mv deleting.../Resources deleting.../${mname}_split-einsum
            mv deleting.../${mname}_split-einsum .
            rm -rf deleting...
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [5/5] to SPLIT_EINSUM completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            echo -e "${G}All conversions completed${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                                  Zip files                                  #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            while true; do
               read -p "Do you want to zip your files? (y/n) " zip
               case "$zip" in
                  y|Y)
                     echo -ne "\nZipping..."\ 
                     zip -r ${mname}_original.zip ${mname}_original -x "*.DS_Store" &
                     zip -r ${mname}_original_512x768.zip ${mname}_original_512x768 -x "*.DS_Store" &
                     zip -r ${mname}_original_768x512.zip ${mname}_original_768x512 -x "*.DS_Store" &
                     zip -r ${mname}_split-einsum.zip ${mname}_split-einsum -x "*.DS_Store"
                     echo -ne "${G}Done${N}\n\n"
                     break ;;
                  n|N) echo; break ;;
                  *)
                     roll=$(($RANDOM % 8))
                     wtf=("That option is Coming Soon™" "Are you sure about that?" "Try again with, I don't know, [y] or [n]?" "I don't know what that is, and at this point, I'm too afraid to ask" "I know you're happy about the script, but please stop keysmashing" "¯\_(ツ)_/¯" "ಠಿ_ಠ" "ಠ_ಠ")
                     echo -e "\n${R}${wtf[$roll]}${N}\n"
                  ;;
               esac
            done
            
            read -p "Press [Enter] to see the menu or [⌘.] to quit "
            
            break ;;

         ###############################################################################
         ##                                                                           ##
         ##                             CKPT → Diffusers                              ##
         ##                                                                           ##
         ###############################################################################
         
         "CKPT → Diffusers")
            echo -e "\n${G}Converting to Diffusers...${N}\n"
            
            SECONDS=0
            
            until
               python "./convert_original_stable_diffusion_to_diffusers.py" --checkpoint_path "./${mname}.ckpt" --device cpu --extract_ema --dump_path "./${mname}_diffusers"
            do
               osascript -e 'display notification "Conversion to Diffusers failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion to Diffusers failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            time=$SECONDS
            
            osascript -e 'display notification "Conversion to Diffusers completed 🥳" with title "SD to Core ML" sound name "Funk"'
            echo -e "\n${G}Conversion to Diffusers completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            read -p "Press [Enter] to see the menu or [⌘.] to quit "
            
            break ;;
         
         ###############################################################################
         ##                                                                           ##
         ##                             SafeTensors → All                             ##
         ##                                                                           ##
         ###############################################################################
         
         "SafeTensors → All")
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                        SafeTensors → All (Diffusers)                        #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "\n${G}Converting [1/5] to Diffusers...${N}\n"
            
            SECONDS=0
            
            until
               python "./convert_original_stable_diffusion_to_diffusers.py" --checkpoint_path "./${mname}.safetensors" --from_safetensors --device cpu --extract_ema --dump_path "./${mname}_diffusers"
            do
               osascript -e 'display notification "Conversion [1/5] to Diffusers failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "$\n{R}Conversion [1/5] to Diffusers failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [1/5] to Diffusers completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                        SafeTensors → All (ORIGINAL)                         #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "${G}Converting [2/5] to ORIGINAL...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./${mname}_original"
            do
               osascript -e 'display notification "Conversion [2/5] to ORIGINAL failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion [2/5] to ORIGINAL failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_original deleting...
            mv deleting.../Resources deleting.../${mname}_original
            mv deleting.../${mname}_original .
            rm -rf deleting...
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [2/5] to ORIGINAL completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                    SafeTensors → All (ORIGINAL 512x768)                     #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "${G}Converting [3/5] to ORIGINAL 512x768...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --latent-w 64 --latent-h 96 --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./${mname}_original_512x768"
            do
               osascript -e 'display notification "Conversion [3/5] to ORIGINAL 512x768 failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion [3/5] to ORIGINAL 512x768 failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_original_512x768 deleting...
            mv deleting.../Resources deleting.../${mname}_original_512x768
            mv deleting.../${mname}_original_512x768 .
            rm -rf deleting...
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [3/5] to ORIGINAL 512x768 completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                     SafeTensors → All (ORIGINAL 768x512)                    #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "${G}Converting [4/5] to ORIGINAL 768x512...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --latent-w 96 --latent-h 64 --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./${mname}_original_768x512"
            do
               osascript -e 'display notification "Conversion [4/5] to ORIGINAL 768x512 failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion [4/5] to ORIGINAL 768x512 failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_original_768x512 deleting...
            mv deleting.../Resources deleting.../${mname}_original_768x512
            mv deleting.../${mname}_original_768x512 .
            rm -rf deleting...
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [4/5] to ORIGINAL 768x512 completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                      SafeTensors → All (SPLIT_EINSUM)                       #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            echo -e "${G}Converting [5/5] to SPLIT_EINSUM...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation SPLIT_EINSUM -o "./${mname}_split-einsum"
            do
               osascript -e 'display notification "Conversion [5/5] to SPLIT_EINSUM failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion [5/5] to SPLIT_EINSUM failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_split-einsum deleting...
            mv deleting.../Resources deleting.../${mname}_split-einsum
            mv deleting.../${mname}_split-einsum .
            rm -rf deleting...
            
            time=$SECONDS
            
            echo -e "\n${G}Conversion [5/5] to SPLIT_EINSUM completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            echo -e "${G}All conversions completed${N}\n"
            
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            #                                  Zip files                                  #
            # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
            
            while true; do
               read -p "Do you want to zip your files? (y/n) " zip
               case "$zip" in
                  y|Y)
                     echo -ne "\nZipping..."\ 
                     zip -r ${mname}_original.zip ${mname}_original -x "*.DS_Store" &
                     zip -r ${mname}_original_512x768.zip ${mname}_original_512x768 -x "*.DS_Store" &
                     zip -r ${mname}_original_768x512.zip ${mname}_original_768x512 -x "*.DS_Store" &
                     zip -r ${mname}_split-einsum.zip ${mname}_split-einsum -x "*.DS_Store"
                     echo -ne "${G}Done${N}\n\n"
                     break ;;
                  n|N) echo; break ;;
                  *)
                     roll=$(($RANDOM % 8))
                     wtf=("That option is Coming Soon™" "Are you sure about that?" "Try again with, I don't know, [y] or [n]?" "I don't know what that is, and at this point, I'm too afraid to ask" "I know you're happy about the script, but please stop keysmashing" "¯\_(ツ)_/¯" "ಠಿ_ಠ" "ಠ_ಠ")
                     echo -e "\n${R}${wtf[$roll]}${N}\n"
                  ;;
               esac
            done
            
            read -p "Press [Enter] to see the menu or [⌘.] to quit "
            
            break ;;
         
         ###############################################################################
         ##                                                                           ##
         ##                          SafeTensors → Diffusers                          ##
         ##                                                                           ##
         ###############################################################################
         
         "SafeTensors → Diffusers")
            echo -e "\n${G}Converting to Diffusers...${N}\n"
            
            SECONDS=0
            
            until
               python "./convert_original_stable_diffusion_to_diffusers.py" --checkpoint_path "./${mname}.safetensors" --from_safetensors --device cpu --extract_ema --dump_path "./${mname}_diffusers"
            do
               osascript -e 'display notification "Conversion to Diffusers failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion to Diffusers failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            time=$SECONDS
            
            osascript -e 'display notification "Conversion to Diffusers completed 🥳" with title "SD to Core ML" sound name "Funk"'
            echo -e "\n${G}Conversion to Diffusers completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            read -p "Press [Enter] to see the menu or [⌘.] to quit "
            
            break ;;
         
         ###############################################################################
         ##                                                                           ##
         ##                           Diffusers → ORIGINAL                            ##
         ##                                                                           ##
         ###############################################################################
         
         "Diffusers → ORIGINAL")
            echo -e "\n${G}Converting to ORIGINAL...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./${mname}_original"
            do
               osascript -e 'display notification "Conversion to ORIGINAL failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion to ORIGINAL failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_original deleting...
            mv deleting.../Resources deleting.../${mname}_original
            mv deleting.../${mname}_original .
            rm -rf deleting...
            
            time=$SECONDS
            
            osascript -e 'display notification "Conversion to ORIGINAL completed 🥳" with title "SD to Core ML" sound name "Funk"'
            echo -e "\n${G}Conversion to ORIGINAL completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            read -p "Press [Enter] to see the menu or [⌘.] to quit "
            
            break ;;
         
         ###############################################################################
         ##                                                                           ##
         ##                       Diffusers → ORIGINAL 512x768                        ##
         ##                                                                           ##
         ###############################################################################
         
         "Diffusers → ORIGINAL 512x768")
            echo -e "\n${G}Converting to ORIGINAL 512x768...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --latent-w 64 --latent-h 96 --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./${mname}_original_512x768"
            do
               osascript -e 'display notification "Conversion to ORIGINAL 512x768 failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion to ORIGINAL 512x768 failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_original_512x768 deleting...
            mv deleting.../Resources deleting.../${mname}_original_512x768
            mv deleting.../${mname}_original_512x768 .
            rm -rf deleting...
            
            time=$SECONDS
            
            osascript -e 'display notification "Conversion to ORIGINAL 512x768 completed 🥳" with title "SD to Core ML" sound name "Funk"'
            echo -e "\n${G}Conversion to ORIGINAL 512x768 completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            read -p "Press [Enter] to see the menu or [⌘.] to quit "
            
            break ;;
         
         ###############################################################################
         ##                                                                           ##
         ##                       Diffusers → ORIGINAL 768x512                        ##
         ##                                                                           ##
         ###############################################################################
         
         "Diffusers → ORIGINAL 768x512")
            echo -e "\n${G}Converting to ORIGINAL 768x512...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --latent-w 96 --latent-h 64 --compute-unit CPU_AND_GPU --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation ORIGINAL -o "./${mname}_original_768x512"
            do
               osascript -e 'display notification "Conversion to ORIGINAL 768x512 failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion to ORIGINAL 768x512 failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_original_768x512 deleting...
            mv deleting.../Resources deleting.../${mname}_original_768x512
            mv deleting.../${mname}_original_768x512 .
            rm -rf deleting...
            
            time=$SECONDS
            
            osascript -e 'display notification "Conversion to ORIGINAL 768x512 completed 🥳" with title "SD to Core ML" sound name "Funk"'
            echo -e "\n${G}Conversion to ORIGINAL 768x512 completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            read -p "Press [Enter] to see the menu or [⌘.] to quit "
            
            break ;;
         
         ###############################################################################
         ##                                                                           ##
         ##                         Diffusers → SPLIT_EINSUM                          ##
         ##                                                                           ##
         ###############################################################################
         
         "Diffusers → SPLIT_EINSUM")
            echo -e "\n${G}Converting to SPLIT_EINSUM...${N}\n"
            
            SECONDS=0
            
            until
               python -m python_coreml_stable_diffusion.torch2coreml --convert-vae-decoder --convert-vae-encoder --convert-unet --convert-text-encoder --model-version "./${mname}_diffusers" --bundle-resources-for-swift-cli --attention-implementation SPLIT_EINSUM -o "./${mname}_split-einsum"
            do
               osascript -e 'display notification "Conversion to SPLIT_EINSUM failed 😢 Trying again in 30s..." with title "SD to Core ML" sound name "Sosumi"'
               echo -e "\n${R}Conversion to SPLIT_EINSUM failed. Trying again in 30s...${N}\n"
               sleep 30
            done
            
            mv ${mname}_split-einsum deleting...
            mv deleting.../Resources deleting.../${mname}_split-einsum
            mv deleting.../${mname}_split-einsum .
            rm -rf deleting...
            
            time=$SECONDS
            
            osascript -e 'display notification "Conversion to SPLIT_EINSUM completed 🥳" with title "SD to Core ML" sound name "Funk"'
            echo -e "\n${G}Conversion to SPLIT_EINSUM completed in $(($time / 60))min and $(($time % 60))s${N}\n"
            
            read -p "Press [Enter] to see the menu or [⌘.] to quit "
            
            break ;;
         
         ###############################################################################
         ##                                                                           ##
         ##                                  Credits                                  ##
         ##                                                                           ##
         ###############################################################################
         
         "Credits") open https://github.com/Zabriskije; break ;;
         
         ###############################################################################
         ##                                                                           ##
         ##                                   Quit                                    ##
         ##                                                                           ##
         ###############################################################################
         
         "Quit") echo -e "\n👋"; break 2 ;;
      
         ###############################################################################
         ##                                                                           ##
         ##                                   WTF?                                    ##
         ##                                                                           ##
         ###############################################################################
         
         *)
            roll=$(($RANDOM % 8))
            wtf=("That option is Coming Soon™" "Are you sure about that?" "Try again with, I don't know, maybe a number in the menu?" "I don't know what that is, and at this point, I'm too afraid to ask" "I know you're happy about the script, but please stop keysmashing" "¯\_(ツ)_/¯" "ಠಿ_ಠ" "ಠ_ಠ")
            echo -e "\n${R}${wtf[$roll]}${N}"
         ;;
         
      esac
   done
done
