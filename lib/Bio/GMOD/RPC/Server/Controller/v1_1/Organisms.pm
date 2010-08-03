package Bio::GMOD::RPC::Server::Controller::v1_1::Organisms;
use Moose;
use Data::Dump qw(dump);
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Bio::GMOD::RPC::Server::Controller::v1_1::Organisms - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 list

=cut

sub list :Regex('^gmodrpc/v1\.1/organisms(\.xml|\.json)?$') {
    my ( $self, $c ) = @_;
    my $mod_org_list = $c->model('v1_1::Organisms');
    my $db = $c->config->{use_db_config};
    $c->stash(template      => 'organisms' . $c->stash->{template_suffix},
	      api_version   => 1.1,
	      data_provider => $c->config->{db}->{$db}->{data_provider},
	      data_version  => $c->config->{db}->{$db}->{data_version},
	      organisms     => $mod_org_list->organisms);
}


=head1 AUTHOR

Josh Goodman,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
