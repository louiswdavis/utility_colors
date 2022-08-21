# UtilityColors

Utility Colors is a library built and centred around creating quick and effective colour palettes based off of any base colour and then utilizing them in a wide variety of BEM style modifier classes to be used in styling that can come into effect at varying screen sizes and element states.

It's
- pure sass
- simple and easily usable right out of the box
- configurable with the intent to become part of a larger utility class eco-system
- easily swappable between the gem and package with minimal changes

Firstly, yes the library is called Utility COLORS (for a wide range of reasons) but in this documentation, unless referencing something library specific I'll be spelling it 'colours'.


## Installation

### Yarn

Add the package

    $ yarn add utility_colors;

Import the styles from your node_modules and add the **OPTIONAL** configuration map at the top of your scss file

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
      'base-colour-A-name': value,
      // and more colours
    ),
    tri-use: (
      'base-colour-B-name': value,
      // and more colours
    ),
    single-use: (
      'base-colour-C-name': value,
      // and more colours
    ),
  )
);

@import "utility_colors/utility_colors/utility_colors";
```

### Ruby

**Please be aware there seem to be widespread issues with importing gem styles when using cssbundling so if you are using that you may want to use the package until this is resolved**

Add this line to your application's Gemfile:

```ruby
gem 'utility_colors'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install utility_colors

Import the styles from the gem and add the **optional** configuration map at the top of your scss file

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
      'base-colour-A-name': value,
      // and more colours
    ),
    tri-use: (
      'base-colour-B-name': value,
      // and more colours
    ),
    single-use: (
      'base-colour-C-name': value,
      // and more colours
    ),
  )
);

@import "utility_colors";
```

## Examples

![v0.1.7 Colour Palette Example](https://github.com/louiswdavis/utility_colors/blob/master/examples/v0.1.7.png)

## Usage

### Palettes & Classes

After importing the UtilityColors stylesheet your styles will produce a large array of BEM classes that you can use to quickly modify the colour properties of your components. If you have a generic card class being used but in one place you want it to be red and another you want it to be light blue you can add the classes `.color--red` and `.color--blue-200` respectively to your html.

Every default colour supplied by UtilityColors has a base, and a shades palette based off that base. These colours are all given keys which are then appended to the various classes available. The base colours key is simply it's name; 'red', 'blue'. The shade palette colours keys are the base colour they are based off, then appended with a '-' and then a value of **50, 100, 200, ..., 900**, where the large number indicates a darker colour. You may be familiar with this style of naming if you've used other style frameworks.

Additionally to the default colours, UtilityColors also supplies a small collection of role colours based off the defaults; success (green), danger (red), information (blue), warning (gold). And each of these has a light and dark variation where the key is the colour role appended with either `-light` or `-dark`. These variations are referred to as the 'tri palette' (the base, the light, and the dark).

Classes available:
- change the color property: `.color--key`
- change the background-color property: `.bg--key`
- change the border-color property: `.border-c--key`
- change the outline-color property: `.outline-c--key`
- change the text-decoration-color property: `.decoration-c--key`

where the key is the colour's 'name' i.e. `red` `green-100` `blue-900` `success-light` `danger-dark`

### Advanced Classes

As previously stated you can use basic UtilityColors classes to change the colours properties of your components but sometimes you may want to make adjustments only in select circumstances. One of these circumstances is the size of the screen, or more accurately the width of the screen. 

You can turn any basic class into an advanced breakpoint class by prepending it with sm, md, lg, or xl followed by a '|' i.e. `.md|color--red` where 325px, 768px, 1024px, 1440px are the minimum screen width where the class will come into effect respectively. 
Alongside breakpoint classes there are also pseudo-state classes which are advanced classes that can make a colour property come into effect a certain state or condition of an element if achieved. These follow the style of breakpoint where they must be prepended to the basic classes separated by a '|'  i.e. `.hover|color--red`. The pseudo properties currently applicable to these classes are; checked, disabled, enabled, focus, in-range, invalid, optional, out-of-range, read-only, read-write, require, valid, active, hover, link, target, visited, root, first-child, first-of-type, last-child, last-of-type, only-of-type, only-child, empty. 
And if that wasn't enough you can also combine pseudo-state and breakpoint classes  i.e. `.hover|md|color--red`


### Custom Configuration

There are some optional configuration options you can tweak to reduce the number of classes or colours the library will produce for you. All the options listed above are true by default. If you don't want to produce any classes at all you can set `classes` to false. If you don't want to produce any breakpoint classes you can set `breakpoint` to false. This will also not produce the hybrid pseudo-state|breakpoint classes. If you don't want to produce any pseudo-state classes you can set `pseudo` to false. This will also not produce the hybrid pseudo-state|breakpoint classes. If you want to remove all the default colour and subsequent palettes right from the start you can set `defaults` to false.

Obviously a default palette is nice, but it may not include the colours you want or the current named ones may not be based off your preferred variant of that colour (maybe you want your red palette to have a hint more orange to it). That is where the `colors` portion of the $utility_colors configuration variable comes in. 
If you want to create a new palette or overwrite an existing one simply add the name you want to use for your colour as the key, and the hex, rgb, or hsl code related to it as the value. If you add this colour to the `shades-use` then a base colour and shades palette of colours will be produced and have corresponding classes created for them. 
If you add this colour to the `tri-use` then a base colour and tri palette of colours will be produced and have corresponding classes created for them. 
If you add this colour to the `single-use` then just the base colour will be used to create corresponding classes created for it. 
Don't worry if you want to produce a shades and tri palette for a single base. Adding that colour to both sections will produce all the colours you want and the latter base colour will replace the former. This can also be useful if you want to make slight adjustments to shades or tri palettes as you can add the **full** colour name as a single-use key with the value you want to use and this will overwrite the corresponding matching key colour from any of the palettes.

### Additional Usability

There is also a scss function called `get-uc` that will retrieve the colours value from the various palettes so that it can be used in your later custom classes. It just requires the correct colour key to be called with the function i.e. `color: get-uc(red-400)`.

## Palette Creation

To achieve the shades or tri colour palettes, colours are created by incrementing and decrementing the lightness and saturation of a base colour to get the colours on either side of the base needed for the palettes. I have found this the most effective way of creating custom colour palettes compared to other generators as this method uses and retains your base colour as a part of the larger palette, unlike other generators which take your base and adjust it to suit the generators preferred colour style. This may work if you need to integrate various colours into a larger, pre-determined colour palette but often we are creating the colour palettes from scratch and with the requirement that our base colour be used in it.

This also gives the added benefit that if you used one of the specific shade colour's as your key and provided a different colour value then it would use this new value in the palette and replace the previously created one. As the methods used to create the shade and tri palettes are the same, their outputs will overlap which means you don't have to worry about a extra large amount of classes. Tri colours are two 'steps' away from their base so a base colour `col` that produces that produces the colour `col-400` will mean `col-200` and `col-light` are the same, and `col-600` and `col-dark`. 
This is just another way to keep palettes in sync and prevent palettes of the same base from becoming unlinked from one another. Be aware that if a colour is very dark or very light one of it's tri colours may only be one step away, or may not be created at all, corresponding to the amount of 'space' available on either side of the base to create the colour.

## Future Development

- add classes for the singular sides of borders and outlines
- add config variables to disable the creation of certain classes i.e. color, background-color, etc
- move the config variables to a config.js file as per the norm across many packages
- make a page/partial/component that can be used to view the colour outputs
  - first step is putting raw html in a file that can be copied and used
  - second step is to make a page that can be added to routes
  - further development of this would be to show accessibilty ratings and more in-depth information of the palettes
- add the ability to output colour variables/palettes in the terminal to make them more accessible for users to see, check and export
- validate the user variables added before they are used
- create a site that will display the descriptions and examples of colours and classes produced by the library more effectively than this markdown file (this markdown is getting a little crowded already)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/louiswdavis/utility_colors. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/louiswdavis/utility_colors/blob/master/CODE_OF_CONDUCT.md). I am not incredibly familiar with creating gems or packages so there may be things missing that seem obvious to others but are not to me.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UtilityColors project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/louiswdavis/utility_colors/blob/master/CODE_OF_CONDUCT.md).
