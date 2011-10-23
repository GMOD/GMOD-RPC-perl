package Bio::GMOD::RPC::Provider::Testing::Organism::v1_1;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub get_data {
    return [
        {
            genus => "Drosophila",
            species => "melanogaster",
            taxonomy_id => 7227
        },
        {
            genus => "Drosophila",
            species => "simulans",
            taxonomy_id => 7240
        },
    ];
}

1;
