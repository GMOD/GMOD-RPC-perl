package Bio::GMOD::RPC::v1_1::Organism::Organism;

use Moose;
use namespace::autoclean;

with 'MooseX::Log::Log4perl';

has 'species'      => (is => 'rw', isa => 'Str');
has 'genus'        => (is => 'rw', isa => 'Str');
has 'abbreviation' => (is => 'rw', isa => 'Str');
has 'common_name'  => (is => 'rw', isa => 'Str');
has 'taxonid'      => (is => 'rw', isa => 'Int');
has 'taxon_base_uri'     => (is => 'rw', isa => 'Str', default => 'http://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=');


sub taxonomy_uri {
    my $self = shift;
    return $self->taxon_base_uri . $self->taxonid;
}


__PACKAGE__->meta->make_immutable;

1;
