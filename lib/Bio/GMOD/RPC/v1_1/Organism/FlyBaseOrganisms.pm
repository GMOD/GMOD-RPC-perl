package Bio::GMOD::RPC::v1_1::Organism::FlyBaseOrganisms;

use Moose;
use Bio::GMOD::RPC::v1_1::Organism::Organism;
use namespace::autoclean;

with 'Bio::GMOD::RPC::v1_1::Organism::ModOrganisms';

sub create_organisms {
    my $self = shift;
    $self->logger->debug('Populating the subclassed organism container object ' . __PACKAGE__);
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'melanogaster',
							   abbreviation => 'dmel',
							   taxonid => 7227));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'simulans',
							   abbreviation => 'dsim',
							   taxonid => 7240));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'persimilis',
							   abbreviation => 'dper',
							   taxonid => 7234));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'pseudoobscura pseudoobscura',
							   abbreviation => 'dpse',
							   taxonid => 46245));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'sechellia',
							   abbreviation => 'dsec',
							   taxonid => 7238));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'yakuba',
							   abbreviation => 'dyak',
							   taxonid => 7245));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'erecta',
							   abbreviation => 'dere',
							   taxonid => 7220));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'ananassae',
							   abbreviation => 'dana',
							   taxonid => 7217));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'willistoni',
							   abbreviation => 'dwil',
							   taxonid => 7260));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'mojavensis',
							   abbreviation => 'dmoj',
							   taxonid => 7230));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'virilis',
							   abbreviation => 'dvir',
							   taxonid => 7244));
    $self->add(Bio::GMOD::RPC::v1_1::Organism::Organism->new(genus => 'Drosophila',
							   species => 'grimshawi',
							   abbreviation => 'dgri',
							   taxonid => 7222));
}


__PACKAGE__->meta->make_immutable;

1;
