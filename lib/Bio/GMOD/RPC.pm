package Bio::GMOD::RPC;

use strict;
use warnings;

use Bio::GMOD::RPC::WebService;
use Bio::GMOD::RPC::Types qw/HashOfHashes/;
use Dancer ':syntax';

my $config = config();

my $services = $config->{services};

die "No services configured" unless $services;
die "Service information structure is incorrect - should be a HashRef[HashRef]"
     unless HashOfHashes->check($services);

for my $version (keys %$services) {
    my $service = Bio::GMOD::RPC::WebService->new(
        version => $version, 
        config => $config,
    );
    $service->register_routes();
}

1;

