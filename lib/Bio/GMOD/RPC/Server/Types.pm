package Bio::GMOD::RPC::Server::Types;

use MooseX::Types
    -declare => [qw(
        PositiveNum
    )];


use MooseX::Types::Moose qw/ Str Num HashRef /;

# type definition.
subtype PositiveNum,
    as Num,
    where { $_ > 0 },
    message { "Number is not larger than 0" };


###
1;#
###
