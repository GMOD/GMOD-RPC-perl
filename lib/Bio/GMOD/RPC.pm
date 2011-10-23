package Bio::GMOD::RPC;

use strict;
use warnings;

use Bio::GMOD::RPC::WebService;
use Dancer ':syntax';

my $config = config();

for my $version (keys %{ $config->{services} }) {
    my $service = Bio::GMOD::RPC::WebService->new(
        version => $version, 
        config => $config,
    );
    $service->register_routes();
}

1;

