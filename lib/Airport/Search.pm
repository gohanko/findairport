=head1 Name

Airport::Search - A module containing functions to search the dataset.

=head1 Description

This module contains methods that is used to process
and find airports based on their names and coordinates.

=head1 Methods

=over 12

=item get_latlong_matching_airports

This method takes 4 arguments (airports, lat, long, max_radius).
It searches the dataset for airports that satisfy these criterias
and returns them.

=item get_name_matching_airports

This method takes 3 arguments (airports, match_some, match_full).
It searches the dataset for airports with names that either
fully matches or partially matches what is passed in.

=back

=cut

package Airport::Search;

use strict;
use List::Util qw( min max );
use warnings;

sub get_latlong_matching_airports {
    my %params = @_;

    my @airport_in_reach;
    foreach my $airport (@{$params{'airports'}}) {
        # This calculates the distance between the airport and area to search
        # using some algorithm that was provided during the GeekUni course.
        my $dist = sqrt(abs($params{'lng'} - $airport->{'longitude_deg'})**2 + (min(abs($params{'lat'} - $airport->{'latitude_deg'}), abs(360 - abs($params{'lat'} - $airport->{'latitude_deg'}))))**2); 
        if ($dist <= $params{'max_radius'}) {
            push @airport_in_reach, $airport;
        }
    };

    return \@airport_in_reach;
}

sub get_name_matching_airports {
    my (%hash) = @_;
    my $match_some = lc $hash{'match_some'};
    my $match_full = lc $hash{'match_full'};

    my @matched;
    foreach my $entry (@{$hash{'airports'}}) {
        my $entry_name = lc $entry->{'name'};

        if ($match_full && $entry_name =~ m/\b($match_full)\b/g) {
            push @matched, $entry;   
        } elsif ($match_some && $entry_name =~ m/$match_some/g) {
            push @matched, $entry;
        }
    }
    
    return \@matched;
}

1;