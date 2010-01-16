package Bio::GMOD::RPC::Server::View::XML;
use Moose;
use Carp;

use utf8;

=head1 NAME

Bio::GMOD::RPC::Server::View::XML - GMOD-RPC XML view

=head1 SYNOPSIS

    my $xml = XML->new( 'data_version'  => 4,
			'api_version'   => 3,
			'data_provider' => 'The Fooish Provider',
		       );

    print $xml->render_result({ foo => 'bar' });

    # or maybe

    print $xml->render_error( $message_type, $message_text );

=head1 DESCRIPTION

Class to render simple attribute-less XML from a perl data structure.

NOTE: In data, nested arrays will be flattened to single-level arrays.  For
example, C<['bar',['baz','quux']]> will be rendered the same as
C<['bar','baz','quux']>.

=head1 ROLES

Does L<Bio::GMOD::RPC::Server::View>

=cut

=head1 METHODS

=cut

=head2 render_result

  Usage: my $str = Bio::GMOD::RPC::Server::View::XML
                      ->new
                      ->render_result({ foo => 'bar', baz => 'boo' });
  Desc : render a perl-native data structure into XML
  Args : one or more hashrefs of data
  Ret  : a string of xml, including the doctype header
  Side Effects: none

=cut

# render_result is actually in the View role

=head2 render_error

  Usage: $xml->render_error
  Desc : render an error in XML
  Args : type string, message string
  Ret  : string of XML to return
  Side Effects: none

=cut

# render_result is actually in the View role

# function to render an XML response
sub _render_data {
    my $self = shift;
    my $tag  = shift;

    return
	join "\n",
	'<?xml version="1.0" encoding="UTF-8"?>',
	map {
	    _xml_tag( $tag, $_, 0 )
	} @_;
}

# recursive function to render an xml tag, with contents, at a given
# indendation
sub _xml_tag {
    my ( $tag, $data, $indent ) = @_;
    my $str = '';
    my $indstr = ' ' x $indent;
    if( my $ref = ref $data ) {
	if( $ref eq 'HASH' ) {
	    $str .= $indstr."<$tag>\n";
	    while( my ($k,$v) = each %$data ) {
		$str .= _xml_tag( $k, $v, $indent + 4 );
	    }
	    $str .= $indstr."</$tag>\n";
	}
	elsif( $ref eq 'ARRAY' ) {
	    foreach my $v ( @$data ) {
		$str .= _xml_tag( $tag, $v, $indent );
	    }
	}
	else {
	    croak "invalid data '".substr("$data",0,20)."'";
	}
	return $str;
    } else {
	return "$indstr<$tag>$data</$tag>\n";
    }
}

=head1 AUTHOR

Robert Buels, E<lt>rmb32@cornell.eduE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2010 Josh Goodman

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

with 'Bio::GMOD::RPC::Server::View';

####
__PACKAGE__->meta->make_immutable;
no Moose;
1;
###
