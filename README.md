# UtilityColors

![Static Badge](https://img.shields.io/badge/Gem_Version-1.0.0-blue)
[![Static Badge](https://img.shields.io/badge/RubyGems-red)](https://rubygems.org/gems/utility_colors)

> Generate your own colour specific classes in an instance.

Utility Colors is an ruby gem package for use in ruby or other projects that generates styling classes based on your supplied colours.
It can take your SCSS or CSS variable, or even a JSON file of them, and provide you with all the classes you need for adding colour to your HTML.
After importing the UtilityColors stylesheet your styles will produce a large array of BEM classes that you can use to quickly modify the colour properties of your components. If you have a generic card class being used but in one place you want it to be red and another you want it to be light blue you can add the classes `.color--red` and `.color--blue-200` respectively to your html.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add utility_colors
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install utility_colors
```

## Usage

To get the config:

```bash
rails generate utility_colors:config
```

To generate the colour classes:

```bash
rails generate utility_colors:generate
```

## Configuration

>[!WARNING]
> UtilityColors has moved to a Ruby Config file from v1.0.0.
> The Pure SCSS version of the gem and JS package are still fully usable and [the documentation can be found here](README_v0.1.8.md).
> Run `rails generate utility_colors:config` to get the new config and move your values across.
> The `colors` section of the config is now a part of [UtilityPalettes](https://github.com/louiswdavis/utility_palettes)

### Environment

Set the environment that the sub-data will be read in, meaning that the palette generator can only be run in certain environments.

| Option               | Default        | Value Type | Possible Values        |
| :------------------- | :------------: | :--------: | :--------------------: |
| enable_environments  | [:development] | Array      | <any Rails.env symbol> |

### Import

The location of the palette file that you will use to build your colour classes.
Examples can be found for [SCSS](spec/fixtures/imports.palette.scss), [CSS](spec/fixtures/imports.palette.css), or [JSON](spec/fixtures/imports.palette.json) files, and this is how [UtilityPalettes](https://github.com/louiswdavis/utility_palettes) would be exported.

| Option                   | Default                 | Value Type | Possible Values       |
| :----------------        | :---------------------: | :--------: | :-------------------: |
| import_palettes_filepath | 'utility_palettes.scss' | String     | <any filepath string> |

### Output

How the output file and values should be written:

| Option         | Description                                                                       | Default          | Value Type | Possible Values       |
| :------------  | :-------------------------------------------------------------------------------- | :--------------: | :--------: | :-------------------: |
| ouput_filename | Where the file should be output to including filename, without the file extension | 'utility_colors' | String     | <any filepath string> |
| ouput_dated    | Should a timestamp be included in the filenames                                   | false            | Boolean    | true / false          |
| ouput_files    | The types of files the palette should be output in                                | ['scss']         | Array      | json, scss, css       |
| ouput_prefix   | A string that is appended to the start of all class names, i.e. 'uc-'             | nil              | String     | <any string>          |
| ouput_suffix   | A string that is appended to the end of all class names, i.e. '-custom'           | nil              | String     | <any string>          |

### Classes

What types of classes should be built:

| Option                    | Description                                                               | Default | Value Type | Possible Values       |
| :-----------------------  | :------------------------------------------------------------------------ | :-----: | :--------: | :-------------------: |
| regular_classes           | Should 'regular' classes be built, e.g. ".bg--red-50"                     | true    | Boolean    | true / false          |
| breakpoint_classes        | Should 'breakpoint' classes be built, e.g. ".md\\|color--black"           | false   | Boolean    | true / false          |
| pseudo_classes            | Should 'pseudo' classes be built, e.g. ".hover\\|border-c--blue-50:hover" | false   | Boolean    | true / false          |
| pseudo_breakpoint_classes | Should 'regular' classes be built, e.g. ".hover\\|md\\|bg--blue-50:hover" | false   | Boolean    | true / false          |

### Extra Information

Breakpoint list:

- sm: 325px
- md: 768px
- lg: 1024px
- xl: 1440px

Pseudo list:

- input: 'checked', 'disabled', 'enabled', 'focus'
- action: 'active', 'hover', 'link', 'target', 'visited'
- child: 'root', 'first-child', 'first-of-type', 'last-child', 'last-of-type', 'only-of-type', 'only-child', 'empty'

Classes available:

- 'color--key': will change the `color` property
- 'bg--key': will change the `background-color` property
- 'accent-c--key': will change the `accent-color` property
- 'border-c--key': will change the `border-color` property
- 'outline-c--key': will change the `outline-color` property
- 'decoration-c--key': will change the `text-decoration-color` property
- 'caret-c--key': will change the `caret-color` property
- 'svg-fill-c--key': will change the `fill` property
- 'svg-stroke-c--key': will change the `stroke` property

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/louiswdavis/utility_colors>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/louiswdavis/utility_colors/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UtilityColors project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/louiswdavis/utility_colors/blob/master/CODE_OF_CONDUCT.md).
