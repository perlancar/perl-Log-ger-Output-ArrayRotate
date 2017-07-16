package Log::ger::Output::ArrayRotate;

# DATE
# VERSION

use strict;
use warnings;

sub get_hooks {
    my %conf = @_;

    my $ary = $conf{array} or die "Please specify array";
    ref $ary eq 'ARRAY' or die "Please specify arrayref in array";

    return {
        create_log_routine => [
            __PACKAGE__, 50,
            sub {
                my %args = @_;

                my $logger = sub {
                    my ($ctx, $msg) = @_;
                    push @$ary, $msg;
                    if (defined $conf{max_elems} && @$ary > $conf{max_elems}) {
                        shift @$ary;
                    }
                };
                [$logger];
            }],
    };
}

1;
# ABSTRACT: Log to array, rotating old elements

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 use Log::ger::Output ArrayRotate => (
     array         => $ary,
     max_elems     => 100,  # defaults unlimited
 );


=head1 DESCRIPTION


=head1 CONFIGURATION


=head1 SEE ALSO

L<Log::ger>

=cut
