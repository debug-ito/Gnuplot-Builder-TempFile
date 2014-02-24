package Gnuplot::Builder::Wgnuplot;
use strict;
use warnings;

1;
__END__

=pod

=head1 NAME

Gnuplot::Builder::Wgnuplot - wrap wgnuplot with gnuplot_builder_tempfile_wrapper

=head1 SYNOPSIS

    ## use Gnuplot::Builder;         ## instead of Gnuplot::Builder...
    use Gnuplot::Builder::Wgnuplot;  ## use this in Windows interactive session.
    
    my $script = gscript(terminal => "windows");
    $script->plot("sin(x)", "cos(x)");


=head1 DESCRIPTION

L<Gnuplot::Builder::Wgnuplot> is a drop-in replacement (or strictly speaking, a wrapper) for L<Gnuplot::Builder>.
It loads L<Gnuplot::Builder> and sets

    @Gnuplot::Builder::Process::COMMAND = qw(gnuplot_builder_tempfile_wrapper wgnuplot -persist)

This means it changes the back-end to "wgnuplot" and script text is given to it as a temporary file.

=head2 Why Do I Need This?

It seems "wgnuplot" is the only implementation in Windows platform that can handle persistent plot windows.

You don't need it if you don't use Windows or you don't use plot windows ("windows" or "wxt" terminals).


=head1 FUNCTIONS

L<Gnuplot::Builder::Wgnuplot> exports just the same functions as L<Gnuplot::Builder>.


=head1 AUTHOR
 
Toshio Ito, C<< <toshioito at cpan.org> >>


=cut
