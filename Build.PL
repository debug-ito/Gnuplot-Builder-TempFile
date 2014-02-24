use 5.006;
use strict;
use warnings;
use Module::Build::Pluggable (
    'CPANfile'
);
 
my $builder = Module::Build::Pluggable->new(
    module_name         => 'Gnuplot::Builder::TempFile',
    license             => 'perl',
    dist_author         => q{Toshio Ito <toshioito@cpan.org>},
    dist_version_from   => 'lib/Gnuplot/Builder/TempFile.pm',
    release_status      => 'stable',
    add_to_cleanup     => [ 'Gnuplot-Builder-TempFile-*' ],
    recursive_test_files => 1,
    no_index => {
        directory => ["t", "xt", "eg", "inc"],
        file => ['README.pod'],
    },
    meta_add => {
        resources => {
            bugtracker => 'https://github.com/debug-ito/Gnuplot-Builder-TempFile/issues',
            repository => 'git://github.com/debug-ito/Gnuplot-Builder-TempFile.git',
        }
    }
);
 
$builder->create_build_script();
