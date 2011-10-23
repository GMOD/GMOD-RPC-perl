package Bio::GMOD::RPC::Types;

use MooseX::Types -declare => [
    "Version", "Formatter", "Provider", "WebService", "HashOfHashes"
];
use MooseX::Types::Moose qw/Str HashRef/;

subtype Version() => as Str, 
    where {/^v\d+_\d+$/}, 
    message { "Illegal version string: $_" };

duck_type Formatter() => [qw/json xml/];

duck_type Provider() => [qw/get_data/];

duck_type WebService() => [qw/data_provider data_version api_version/];

subtype HashOfHashes, as HashRef[HashRef];

coerce Version, from Str, via {s/\./_/g; $_};
1;

