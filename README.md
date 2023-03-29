# Matlab Essentials

[![View Matlab Essentials on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://nl.mathworks.com/matlabcentral/fileexchange/126989-matlab-essentials)

Matlab Essentials is an attempt to fill the gaps of standard function that are not included into the base installation. Some of these functions are for example `lerp`, `sigmoid`, `linespacen`, `rot2d`, `rotx`,  `random`, `randint`, `depfun`, `isodd`, `isneg` and many others. Additionally, we provide an extensive color packages with syntax `color_` and colormaps under `cmap_` (based on the matplotlib in Python).


## Improved Matlab colors
The package comes with an improved color pallete for plotting. These colors can simply be selected by `plot(...,'Color',col(int))` or can be overwritten
`set_color_pallete` (a dropdown menu appears to choose). 
<img src="./assets/colors.png" alt="Improved color pallete" height="230">

## Improved Matlab colormaps
Matlab lacks many of the standard colormaps. Colormaps in the package are based on the ones from Python in the package MatPlotLib, which are given under `cmap_...`. These colormaps can also be modified using an additional input, e.g., `cmap_turbo(-1)` flips the colors, whereas `cmap_turbo(0)` mirrors the colormap.
<img src="./assets/colormaps.png" alt="Improved color maps" height="500">