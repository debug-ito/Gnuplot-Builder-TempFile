package Gnuplot::Builder::TempFile;
use strict;
use warnings;
use Exporter qw(import);
use File::Temp;
use IPC::Open3 qw(open3);

our $VERSION = "0.01";

our @EXPORT_OK = qw(run);

sub run {
    my (@gnuplot_command) = @_;
    if(!@gnuplot_command) {
        @gnuplot_command = qw(gnuplot --persist);
    }
    my $tempfile = File::Temp->new;
    $tempfile->unlink_on_destroy(0);
    while(defined(my $input = <STDIN>)) {
        $tempfile->print($input);
    }
    $tempfile->close;
    _execute(@gnuplot_command, $tempfile->filename);
    _execute("gnuplot_builder_tempfile_remover", $tempfile->filename);
}

sub _execute {
    my (@command) = @_;
    my $pid = open3(my $in, my $out, undef, @command);
    close $in;
    close $out;
    return $pid;
}

1;
__END__

=pod

=head1 NAME

Gnuplot::Builder::TempFile - gnuplot wrapper using temporary files

=head1 SYNOPSIS

    use Gnuplot::Builder::Process;
    
    @Gnuplot::Builder::Process::COMMAND
        = qw(gnuplot_builder_tempfile_wrapper gnuplot --persist);

=head1 DESCRIPTION

L<Gnuplot::Builder::TempFile> is an implementation of C<gnuplot_builder_tempfile_wrapper> command
bundled in this distribution.

C<gnuplot_builder_tempfile_wrapper> wraps a gnuplot process with a temporary file.
It receives script text from STDIN, stores the text into the temporary file and executes the real gnuplot
with the temporary file.
It also tries to clean up the temporary file it created.

C<gnuplot_builder_tempfile_wrapper> is meant to be used with L<Gnuplot::Builder> as a replacement of
the real gnuplot command. See the L</SYNOPSIS> section for usage.

=head2 Why Do I Need This?

Usually you don't. It is much more efficient to stream script into the real gnuplot process.

However, in some platforms (such as Windows) gnuplot behaves strangely when you stream script with a pipe.
I found it especially difficult to keep plot windows open, so I created this.

If you are in trouble with Windows gnuplot, L<Gnuplot::Builder::Wgnuplot> may help.


=head1 FUNCTIONS

All functions are exported only by request.

=head2 run(@gnuplot_command)

This function executes the following steps.

=over

=item 1.

Open a temporary file.

=item 2.

Receive data from STDIN and write the data to the temporary file.

=item 3.

After STDIN is closed, execute C<@gnuplot_command> in a separate process
with the path to the temporary file appended to the arguments.

This is basically the same as

    system(@gnuplot_command, $path_to_temp_file);

except that it won't wait for the process to finish.

If C<@gnuplot_command> is empty, it uses C<< ("gnuplot", "--persist") >> by default.

=item 4.

Execute C<gnuplot_builder_tempfile_remover> bundled in this distribution in a seprate process.

This is basically the same as

    system("gnuplot_builder_tempfile_remover", $path_to_temp_file);

except that it won't wait for the process to finish.

C<gnuplot_builder_tempfile_remover> removes the temporary file after waiting for a while, then exits.

=back


=head1 SEE ALSO

L<Gnuplot::Builder>

=head1 REPOSITORY

L<https://github.com/debug-ito/Gnuplot-Builder-TempFile>

=head1 BUGS AND FEATURE REQUESTS

Please report bugs and feature requests to my Github issues
L<https://github.com/debug-ito/Gnuplot-Builder-TempFile/issues>.

Although I prefer Github, non-Github users can use CPAN RT
L<https://rt.cpan.org/Public/Dist/Display.html?Name=Gnuplot-Builder-TempFile>.
Please send email to C<bug-Gnuplot-Builder-TempFile at rt.cpan.org> to report bugs
if you do not have CPAN RT account.


=head1 AUTHOR
 
Toshio Ito, C<< <toshioito at cpan.org> >>


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Toshio Ito.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/> for more information.


=cut

