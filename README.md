<h1 align="center">Core ML Conversion Scripts</h1>

Hi folks! Here you'll find Shell scripts to convert PyTorch CKPT models to Core ML:
- convert_to_all: convert CKPT → Diffusers; Diffusers → `ORIGINAL`, `ORIGINAL_512x768`, `ORIGINAL_768x512`, and `SPLIT_EINSUM`
- convert_to_diffusers: convert CKPT → Diffusers only
- convert_to_original: convert Diffusers → `ORIGINAL` only
- convert_to_original_512x768: convert Diffusers → `ORIGINAL_512x768` only
- convert_to_original_768x512: convert Diffusers → `ORIGINAL_768x512` only
- convert_to_split-einsum: convert Diffusers → `SPLIT_EINSUM` only

Before running the scripts, open them with a code editor (TextEdit works too) since there is some folder path that needs to be specified. They are full of comments to guide you throughout the whole process.\
To open them with the Terminal App, right-click on one of the files → "Get Info" → "Open with" → select the Terminal app, and click on "Change All". You can also open the Terminal app and drag the script into its window, then press Enter.
