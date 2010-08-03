package Bio::GMOD::RPC::Server::Controller::Root;
use Moose;
use namespace::autoclean;
use Data::Dump qw(dump);

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

Bio::GMOD::RPC::Server::Controller::Root - Root Controller for Bio::GMOD::RPC::Server

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 auto

=cut

sub auto : Private {
    my ($self, $c) = @_;
    my $content_type = 'text/xml';
    my $template_suffix = '_xml.tt';
    if ($c->request->match =~ /\.json$/) {
	$content_type = 'application/json';
	$template_suffix = '_json.tt';
    }
    $c->log->debug("Setting content type to $content_type");
    $c->response->content_type($content_type);

    #Setup template suffix
    $c->stash(template_suffix => $template_suffix);
    return 1;
}



=head2 gmodrpc

The GMOD RPC versions page.

=cut

sub gmodrpc :Regex('^gmodrpc(\.xml|\.json)?$') :Args(0) {
    my ($self, $c) = @_;
    $c->log->info('Received a request for list of supported GMOD RPC versions.');

    my $db = $c->config->{use_db_config};
    my @versions = @{$c->config->{db}->{$db}->{supported_versions}};
    $c->log->debug("Got the supported versions " . $versions[0]);

    $c->stash(template           => 'versions' . $c->stash->{template_suffix},
	      supported_versions => \@versions);
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    #Reset the content type if no action picks up the URL.
    $c->response->content_type('text/html');
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Josh Goodman,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
