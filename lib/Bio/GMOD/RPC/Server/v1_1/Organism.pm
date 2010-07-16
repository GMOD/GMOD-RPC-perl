#!/usr/bin/perl -w

package Bio::GMOD::RPC::Server::v1_1::Organism;

use Moose;
use namespace::autoclean;

has 'species'      => (is => 'rw', isa => 'Str');
has 'genus'        => (is => 'rw', isa => 'Str');
has 'abbreviation' => (is => 'rw', isa => 'Str');
has 'common_name'  => (is => 'rw', isa => 'Str');
has 'taxonid'      => (is => 'rw', isa => 'Int');
has 'taxon_url'     => (is => 'rw', isa => 'Str', default => 'http://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=');


sub get_full_taxon_url {
    my $self = shift;
    return $self->ncbi_url . $self->taxonid;
}


__PACKAGE__->meta->make_immutable;

1;
