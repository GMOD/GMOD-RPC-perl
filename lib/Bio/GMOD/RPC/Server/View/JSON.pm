package Bio::GMOD::RPC::Server::View::JSON;
use Moose;
use Carp;

use JSON::Any;

=head1 NAME

Bio::GMOD::RPC::Server::View::JSON - view class for JSON output

=head1 SYNOPSIS

    my $json = Bio::RPC::View::JSON
                  ->new( 'data_version'  => 4,
                         'api_version'   => 3,
                         'data_provider' => 'The Fooish Provider',
		       );

    print $json->render_result({ foo => 'bar' });

    # or maybe

    print $json->render_error( $message_type, $message_text );

=head1 ROLES

Does L<Bio::GMOD::RPC::Server::View>

=head1 SUBCLASSES

=head1 ATTRIBUTES

=head1 METHODS

=head2 render_result

  Usage: my $str = Bio::GMOD::RPC::Server::View::JSON
                      ->new
                      ->render_result({ foo => 'bar', baz => 'boo' });
  Desc : render a perl-native data structure into XML
  Args : one or more hashrefs of data
  Ret  : a string of xml, including the doctype header
  Side Effects: none

=cut

# actually in base role

=head2 render_error

  Usage: $json->render_error;
  Desc : render an error in XML
  Args : type string, message string
  Ret  : string of XML to return
  Side Effects: none

=cut

# actually in base role

sub _render_data {
    my ( $self, $tag, $data ) = @_;

    my $j = JSON::Any->new;

    return $j->encode( { $tag => $data } );
}


with 'Bio::GMOD::RPC::Server::View';

=head1 AUTHOR

Robert Buels, E<lt>rmb32@cornell.eduE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2010 Josh Goodman

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

####
__PACKAGE__->meta->make_immutable;
no Moose;
1;
###
