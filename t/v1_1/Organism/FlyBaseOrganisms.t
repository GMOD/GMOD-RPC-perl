#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

BEGIN { use_ok('Bio::GMOD::RPC::Server', 'Bio::GMOD::RPC::Server::v1_1::Organism::FlyBaseOrganisms'); }
require_ok('Bio::GMOD::RPC::Server::v1_1::Organism::FlyBaseOrganisms');

my $flybase_organisms = new Bio::GMOD::RPC::Server::v1_1::Organism::FlyBaseOrganisms;

my @dmel = $flybase_organisms->fetch_by_genus_species('Drosophila','melanogaster');
ok(scalar(@dmel) == 1, 'fetch_by_genus_species count test');
is($dmel[0]->species,'melanogaster','fetch_by_genus_species test');

my @dsim = $flybase_organisms->fetch_by_abbreviation('dsim');
ok(scalar(@dsim) == 1, 'fetch_by_abbreviation count test');
is($dsim[0]->abbreviation,'dsim','fetch_by_abbreviation test');

my @orgs = $flybase_organisms->fetch_by_genus('Drosophila');
ok(scalar(@orgs) == 12,'Fetch by genus test');

@orgs = $flybase_organisms->fetch_by_species('simulans');
ok(scalar(@orgs) == 1, 'Fetch by species test');

@orgs = $flybase_organisms->fetch_by_taxonid(7227);
is($orgs[0]->abbreviation,'dmel','Fetch by taxonid test');

ok($flybase_organisms->count == 12,'count test');

done_testing();
