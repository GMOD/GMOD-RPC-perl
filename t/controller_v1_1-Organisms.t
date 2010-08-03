use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Bio::GMOD::RPC::Server' }
BEGIN { use_ok 'Bio::GMOD::RPC::Server::Controller::v1_1::Organisms' }

ok( request('/v1_1/organisms')->is_success, 'Request should succeed' );
done_testing();
