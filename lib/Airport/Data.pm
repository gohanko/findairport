=head1 Name

Airport::Data - A module that retrieves data.

=head1 Description

This module only contains one method. It is used to
retrieve data from CSV files.

=head1 Methods

=over 12

=item parse_airports

This method takes one argument which is the path to the CSV file
which contains the data. It extract the data and return a
reference the the value which contains the data.

=back

=cut

package Airport::Data;

use strict;
use warnings;
use Getopt::Long;
use Text::CSV;

sub parse_airports {
    open(my $file_handler, "<", $_[0]);

    my $csv = Text::CSV->new ({ binary => 1, eol => $\ });
    my $ra_colnames = $csv->getline($file_handler);
    $csv->column_names(@$ra_colnames);
    my $ra_airports = $csv->getline_hr_all($file_handler);

    close($file_handler);
    return $ra_airports;
}

1;