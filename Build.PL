use strict;
use Module::Build;

my $build = Module::Build->new(
    dist_name     => 'GMOD-RPC',
    dist_author   => 'Josh Goodman',
    dist_abstract => 'controllers, views, and pluggable storage backend for implementing GMOD-RPC services on Perl-based sites',
    license       => 'perl',
    create_makefile_pl => 'passthrough',

    # current version of our core libraries distribution
    dist_version => '0.1',

    recursive_test_files => 1,

    # list of dependencies for the production code
    requires => {
	'JSON::Any'                       => 0,
        'Moose'                           => '0.93',
        'namespace::autoclean'            => '0.09',
    },

    # list of dependencies that are only needed for running tests (not
    # for a production installation)
    build_requires => {
	'aliased'     => 0,
	'XML::Simple' => 0,
    },

);
$build->create_build_script;

