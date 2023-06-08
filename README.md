<h1 align="center">SD to Core ML</h1>

<p align="center">The neatest script for converting Stable Diffusion models to Core ML</p>

<p align="center"><a href="#features">Features</a> • <a href="#usage">Usage</a> • <a href="#prerequisites">Prerequisites</a> • <a href="#troubleshooting">Troubleshooting</a></p>

## Features

- Works with both CKPT and SafeTensors files
- Displays a log message and a system notification with status updates
- If a conversion fails, it will attempt it every 30s until it's successful
- Resume your conversions at any time by entering the same model name
- Automatically deletes all unnecessary files once the conversion is done
- When converting to `All`, asks whether to zip folders (useful for sharing purposes)
- If zipped, asks whether to delete the model and its folders
- ControlNet support already integrated
- Some easter eggs 👀

## Usage

Before running: be sure to meet the [prerequisites](#prerequisites), place the script in the same folder as the model you want to convert, and open it with a code editor since there is two folder paths that need to be adjusted. You'll find both at the start of the script:

<p align="center"><img width="800" src="images/1-script-paths.png"></p>

When done, the script is ready to be used.

You can run it by dragging it into the Terminal app and then pressing Enter, or set it to (always) open with the Terminal App: right-click on the file → "Get Info" → "Open with" → "Terminal".

Once started, it will prompt you to specify your model's name:

<p align="center"><img width="800" src="images/2-model-prompt.png"></center></p>

When set, the script will proceed to display all the possible conversion options:

1. CKPT → All
2. CKPT → Diffusers
3. SafeTensors → All
4. SafeTensors → Diffusers
5. Diffusers → ORIGINAL
6. Diffusers → ORIGINAL 512x768
7. Diffusers → ORIGINAL 768x512
8. Diffusers → SPLIT_EINSUM
9. Change model name

The `CKPT → All` and `SafeTensors → All` options will convert your model to `Diffusers`, then `Diffusers` to `ORIGINAL`, `ORIGINAL 512x768`, `ORIGINAL 768x512`, and `SPLIT_EINSUM` — all in one go.

<p align="center"><img width="800" src="images/3-menu-options.png"></p>

All the steps will show a success or failure log message, including a visual and auditory system notification. In case you don't like the latter, you can change its behavior by going to "System Settings..." → "Notifications" → "Script Editor"; or by deleting all the lines in the script starting with `osascript`.

<br>
<p align="center"><img width="350" src="images/4-notification.png"></p>
<p align="center"><img width="800" src="images/5-log-message.png"></p>

## Prerequisites

The script assumes you have Homebrew, Wget, Xcode, and Miniconda (with the `ml-stable-diffusion` environment) already installed. If not, please proceed as follows:

1. Install Homebrew and remember to follow the instructions under "Next steps"
   
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
   
1. Install Wget
   
   ```bash
   brew install wget
   ```
   
1. Download and install [Xcode](https://developer.apple.com/download/all/?q=Xcode)
1. Download and Install [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
1. Once done, run the commands below according to their display order
   
   ```bash
   git clone https://github.com/apple/ml-stable-diffusion.git
   ```
   
   ```bash
   conda create -n coreml_stable_diffusion python=3.8 -y
   ```
   
   ```bash
   conda activate coreml_stable_diffusion
   ```
   
   ```bash
   cd ml-stable-diffusion
   ```
   
   ```bash
   pip install -e .
   ```
   
   ```bash
   pip install omegaconf
   ```
   
   ```bash
   pip install safetensors
   ```
   
1. Download [this Python script](https://github.com/huggingface/diffusers/raw/main/scripts/convert_original_stable_diffusion_to_diffusers.py) and place it in the same folder as the model

## Troubleshooting

#### File

- `sd-to-coreml.sh: permission denied`: type `chmod +x `, drag the script into the Terminal window, and then press <kbd>Enter ⏎</kbd>

#### Miniconda

- `This package is incompatible with this version of macOS`: after the "Software Licence Agreement" step, click on "Change Install Location..." and select "Install for me only"

#### Terminal errors

- `xcrun: error: unable to find utility "coremlcompiler", not a developer tool or in PATH`: open Xcode and go to "Settings..." → "Locations" then click on the "Command Line Tools" drop-down menu and reselect the Command Line Tools version
- `ModuleNotFoundError: No module named 'pytorch_lightning'`: while the conda `coreml_stable_diffusion` environment is active, run
  
  ```bash
  pip install pytorch_lightning
  ```
  
  Every time you see a similar message, you can solve it by installing what is requested via `pip install <name>`
  
- `zsh: killed python`: your Mac has run out of memory. Close some memory-hungry applications you may have open and do the process again. Still not working? Reboot. Still not working? Use `nice -n 10` before running the script. Still not working? Well, `SPLIT_EINSUM` conversions tend to be the more demanding, so while converting, I often close all the other apps and leave my MacBook melting alone

#### Terminal warnings

- If you get any of these
  
  ```
  TracerWarning: Converting a tensor to a Python boolean might cause the trace to be incorrect. We can't record the data flow of Python values, so this value will be treated as a constant in the future. This means that the trace might not generalize to other inputs!
  ```
  
  ```bash
  WARNING:__main__:Casted the `beta`(value=0.0) argument of `baddbmm` op from int32 to float32 dtype for conversion!
  ```
  
  ```bash
  WARNING:coremltools:Tuple detected at graph output. This will be flattened in the converted model.
  ```
  
  ```bash
  WARNING:coremltools:Saving value type of int64 into a builtin type of int32, might lose precision!
  ```
  
  You're fine
