#!/usr/bin/perl
use strict;
use warnings;


use Test::More tests => 9;
BEGIN { use_ok('Dancer','Bio::GMOD::RPC::Server', 'Bio::GMOD::RPC::v1_1::DbUtils'); }
require_ok('Bio::GMOD::RPC::v1_1::DbUtils');

my $db_util = new Bio::GMOD::RPC::v1_1::DbUtils;
isa_ok($db_util, 'Bio::GMOD::RPC::v1_1::DbUtils');
$db_util->driver('Pg');
$db_util->database('test');
$db_util->hostname('localhost');
$db_util->port(5432);
$db_util->username('nobody');
$db_util->password('blah');

is($db_util->driver, 'Pg','Driver');
is($db_util->database, 'test', 'Database');
is($db_util->hostname, 'localhost', 'Hostname');
is($db_util->port, 5432, 'Port');
is($db_util->username, 'nobody', 'Username');
is($db_util->password, 'blah', 'Password');

done_testing();
