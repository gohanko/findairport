#!/usr/bin/perl -Ilib -Iextlib/lib/perl5

use strict;
use warnings;
use Test::More;
use Airport::Data;

use_ok('Airport::Search');

my $airports_reference =  Airport::Data::parse_airports('t/data/airports1.csv');

# Tests get_latlong_matching_airports
my @coordinate_test_cases = (
    {
        longitude => 1,
        latitude => 1,
        max_radius => 0.00001,
        expected_value => 0,
    },
    {
        longitude => 0,
        latitude => 52,
        max_radius => 4,
        expected_value => 2,
    },
    {
        longitude => -0.461941003799,
        latitude => 51.4706001282,
        max_radius => 0.0001,
        expected_value => 1,
    },
);

foreach my $coordinate_test_case (@coordinate_test_cases) {
    my %coordinate_test_case_hash = %$coordinate_test_case;
    my $search_result_reference = Airport::Search::get_latlong_matching_airports(
        airports => $airports_reference,
        long => $coordinate_test_case_hash{'longitude'},
        lat => $coordinate_test_case_hash{'latitude'},
        max_radius => $coordinate_test_case_hash{'max_radius'},
    );
    my $length = scalar(@$search_result_reference);

    is(
        $length,
        $coordinate_test_case_hash{'expected_value'},
        "Found $length airport near coodinates [$coordinate_test_case_hash{'longitude'}, $coordinate_test_case_hash{'latitude'}]"
    );
}

# Tests get_name_matching_airports.
my @name_test_cases = (
    {
        match_some => 'Joh',
        match_full => 0,
        expected_value => 1,
    },
    {
        match_some => 'Internati',
        match_full => '',
        expected_value => 4,
    },
    {
        match_some => 0,
        match_full => 'Tokyo',
        expected_value => 1,
    },
);

foreach my $name_test_case (@name_test_cases) {
    my %name_test_case_hash = %$name_test_case;
    my $match_some = $name_test_case_hash{'match_some'};
    my $match_full = $name_test_case_hash{'match_full'};

    my $search_result_reference = Airport::Search::get_name_matching_airports(
        airports => $airports_reference,
        match_some => $name_test_case_hash{'match_some'},
        match_full => $name_test_case_hash{'match_full'},
    );
    my $length = scalar(@$search_result_reference);
    
    my $near = $match_some || $match_full;
    is(
        $length,
        $name_test_case_hash{'expected_value'},
        "Found $length airport near $near"
    )
}


done_testing;