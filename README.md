## findairport
This software is made when taking Perl Essentials course by GeekUni. It allows users to search for airport informations in an area. The dataset is provided in the `./data/` folder but can also be found [here](https://github.com/datasets/airport-codes). The software is written in perl.

## Getting started.
To get started, you need to make sure you have perl installed. Next, we need to install some packages for this to work. I personally use `cpanm` because it is what I learned from the GeekUni course. If you are using another package manager, or if you want to install `cpanm` please look it up on how to do so on your system.

These are the packages we need for the software to work, please install them by using `cpanm -L extlib <package_name_here>`

- `Text::CSV`
- `Data::Types`
- `Geo::Coder::Google::V3`
- `LWP::Protocol::https`

## Usage
Running the software is as simple as `./bin/search_airports` from the root directory. However, there are a few flags that you need to be aware of. You can run `./bin/search_airports --help` to find  out more about these flags.

Example usage: `./bin/search_airports --filename=./data/airports1.csv --result_limit=3 --address="Tokyo, Japan"`

## LICENSE
This project is licensed under GNU General Public License v3.0. For more informaiton see `LICENSE`.