## [0.1.8] - 2022-08-20

- Made utility_colors accessible as both a ruby gem and npm package
- Added functions that create a linear, equally spaced and smooth shade palette based off any colour supplied regardless of it's hue, saturation, or lightness
- Added ability to use default color palettes (shades & tri)
- Added ability to create custom custom shade and tri palettes
- Added creation of BEM style utility classes to use colour palette for styles; color, background-color, etc TODO
  - classes that can be created include:
    - basic styles `color--red-400`
    - breakpoint style `md|color--red-400`
    - pseudo-element styles `hover|color--red-400`
    - pseudo-element breakpoint styles `hover|md|color--red-400`
- Created function to get colour variable value based off the name of the colour `get-uc(red-400)`
- Added configuration map to allow uses to:
  - add custom colours to be used to create shade palettes, tri palettes, single use colours, and to overwrite the default colour options
  - disable the creation of classes if they only want to utilize the colour palette variables created
  - disable the creation of pseudo-element and pseudo-element breakpoint classes by setting a boolean
  - disable the creation of breakpoint and pseudo-element breakpoint classes by setting a boolean
  - disable the creation and use of any default colour classes or shades

```scss
$utility_colors: (
  config: (
    classes: BOOLEAN,
    breakpoint: BOOLEAN,
    pseudo: BOOLEAN,
    defaults: BOOLEAN,
  ),
  colors: (
    shades-use: (
      'base-colour-A-name': hexcode,
    ),
    tri-use: (
      'base-colour-B-name': hexcode,
    ),
    single-use: (
      'base-colour-C-name': hexcode,
    ),
  )
);
```


## [0.1.0] - 2022-08-13

- Initial commits
