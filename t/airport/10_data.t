#!/usr/bin/perl -Ilib -Iextlib/lib/perl5

use strict;
use warnings;
use Test::More;
use Data::Types qw(:all);

use_ok('Airport::Data');

my $airports_reference = Airport::Data::parse_airports("t/data/airports1.csv");
is (ref $airports_reference, 'ARRAY', 'parse_airports returns the correct type');

my @airports = @$airports_reference;
is (scalar(@airports), 5, 'correct number');

foreach my $airport (@airports) {
    is(ref $airport, 'HASH', 'Checking if $airport is a hash reference.');

    my @fields = @{['id', 'name', 'latitude_deg', 'longitude_deg', 'iata_code']};
    foreach my $field (@fields) {
        ok(exists($airport->{$field}), "Checking for the existence of '$field' field.");
        ok($airport->{$field}, "Checking for the existence of value in '$field' field");
    }

    ok(is_float $airport->{latitude_deg}, "Checking if 'latitude_deg' is a floating point.");
    ok(is_float $airport->{longitude_deg}, "Checking if 'longitude_deg' is a floating point.");
}

done_testing;