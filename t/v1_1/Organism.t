#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 8;
BEGIN { use_ok('Bio::GMOD::RPC::Server', 'Bio::GMOD::RPC::Server::v1_1::Organism'); }
require_ok('Bio::GMOD::RPC::Server::v1_1::Organism');

my $organism = new Bio::GMOD::RPC::Server::v1_1::Organism;
$organism->genus('Drosophila');
$organism->species('melanogaster');
$organism->taxonid(7227);
$organism->abbreviation('Dmel');
$organism->common_name('fruit fly');

isa_ok($organism, 'Bio::GMOD::RPC::Server::v1_1::Organism');
is($organism->genus, 'Drosophila', 'Genus test');
is($organism->species, 'melanogaster', 'Species test');
is($organism->taxonid, 7227, 'Taxon ID test');
is($organism->abbreviation, 'Dmel', 'Abbreviation test');
is($organism->common_name, 'fruit fly', 'Common name test');

done_testing();
