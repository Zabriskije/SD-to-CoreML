# Core ML Scripts

Hi folks! Here you'll find Shell scripts to convert Stable Diffusion PyTorch CKPT models to Core ML MLMODELC:
- convert_to_all: converts CKPT → Diffusers; Diffusers → `ORIGINAL`, `ORIGINAL_512x768`, `ORIGINAL_768x512`, and `SPLIT_EINSUM`
- convert_to_diffusers: converts CKPT → Diffusers only
- convert_to_original: converts Diffusers → `ORIGINAL` only
- convert_to_original_512x768: converts Diffusers → `ORIGINAL_512x768` only
- convert_to_original_768x512: converts Diffusers → `ORIGINAL_768x512` only
- convert_to_split-einsum: converts Diffusers → `SPLIT_EINSUM` only

## Usage

Before running those scripts, open them with a code editor since there is some folder path that needs to be specified. They are full of comments to guide you throughout the whole process.

To always open them with the Terminal App, right-click on one of the files → "Get Info" → "Open with" → select the Terminal app, and click on "Change All". You can also open the Terminal app and drag the script into its window, then press Enter.

## Requirements

These scripts assume you have Homebrew, Wget, Xcode, and Miniconda (with the ml-stable-diffusion env) already installed. If not, follow these steps:

1. Install Homebrew by running `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` in the Terminal app, and remember to follow the instructions under "Next steps"
1. Install Wget via `brew install wget`
1. Download and install [Xcode](https://developer.apple.com/download/all/?q=Xcode)
1. Install [Miniconda](https://docs.conda.io/en/latest/miniconda.html), then run in the Terminal app the commands below
2. `git clone https://github.com/apple/ml-stable-diffusion.git`
3. `conda create -n coreml_stable_diffusion python=3.8 -y`
4. `conda activate coreml_stable_diffusion`
5. `cd ml-stable-diffusion`
6. `pip install -e .`
7. `pip install omegaconf`

More info about other possibilities [here](https://github.com/godly-devotion/MochiDiffusion/wiki/How-to-convert-CKPT-or-SafeTensors-files-to-Core-ML).

## Troubleshooting

If you get the error "This package is incompatible with this version of macOS" while installing Miniconda: after the Software Licence Agreement, click on "Change Install Location..." and select "Install for me only".

If you get the error `xcrun: error: unable to find utility "coremlcompiler", not a developer tool or in PATH` while running a script — and you are sure both Xcode and Xcode Command Line Tools are installed, open Xcode and go to "Settings..." → "Locations", then click on the "Command Line Tools" drop-down menu and reselect the Command Line Tools version.
