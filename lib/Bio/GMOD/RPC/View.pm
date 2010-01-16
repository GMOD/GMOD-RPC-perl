package Bio::GMOD::RPC::View;
use namespace::autoclean;
use Moose::Role;
use Carp;

use Bio::GMOD::RPC::Types qw/ PositiveNum /;

=head1 NAME

Bio::GMOD::RPC::View - base class for GMOD-RPC views

=head1 ATTRIBUTES

C<data_version> - required.  the data version string to render in output.

=cut

has 'data_version', (
    isa => 'Str',
    is => 'ro',
    default => 'not specified',
);

=pod

C<api_version> - required. the numeric GMOD-RPC API version.

=cut

has 'api_version', (
    isa => PositiveNum,
    is  => 'ro',
    required => 1,
);

=pod

C<data_provider> - required. string data provider name.

=cut

has 'data_provider', (
    isa => 'Str',
    is  => 'ro',
    required => 1,
);

=head1 REQUIRED METHODS

_render_data - simple method, takes a perl hashref data structure,
renders it in the appropriate format

=cut

requires '_render_data';

=head1 PROVIDED METHODS

=head2 render_result

  Usage: my $str = Bio::GMOD::RPC::View::XML
                      ->new
                      ->render_result({ foo => 'bar', baz => 'boo' });
  Desc : render a perl-native data structure into XML
  Args : one or more hashrefs of data
  Ret  : a string of xml, including the doctype header
  Side Effects: none

=cut

sub render_result {
    my $self = shift;

    my $data = shift;
    my %rs = (
        api_version   => $self->api_version   ,
	data_provider => $self->data_provider ,
	data_version  => $self->data_version  ,
	%$data,
    );

    return $self->_render_data( 'resultset', \%rs );
}

=head2 render_error

  Usage: $xml->render_error
  Desc : render an error in XML
  Args : type string, message string
  Ret  : string of XML to return
  Side Effects: none

=cut

sub render_error {
    my $self = shift;
    return $self->_render_data( 'error', { type => shift, message => shift } );
}

=head1 AUTHOR

Robert Buels, E<lt>rmb32@cornell.eduE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2010 Josh Goodman

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

####
no Moose::Role;
1;
###
