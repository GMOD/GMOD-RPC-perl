package Bio::GMOD::RPC::Server;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
		   ConfigLoader
		   Static::Simple
	       /;

extends 'Catalyst';

use Catalyst::Log::Log4perl;

our $VERSION = '1.1';
$VERSION = eval $VERSION;

# Configure logging
__PACKAGE__->log(Catalyst::Log::Log4perl->new('log4perl.conf'));


# Configure the application.
#
# Note that settings in bio_gmod_rpc_server.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
		    'Plugin::ConfigLoader' => {
					       driver => {
							  'General' => { -ForceArray => 1}
							 }
					       },
		    name => 'Bio::GMOD::RPC::Server',
		    # Disable deprecated behavior needed by old applications
		    disable_component_resolution_regex_fallback => 1,
		   );

# Start the application
__PACKAGE__->setup();


=head1 NAME

Bio::GMOD::RPC::Server - Catalyst based application

=head1 SYNOPSIS

    script/bio_gmod_rpc_server_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Bio::GMOD::RPC::Server::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Josh Goodman,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
