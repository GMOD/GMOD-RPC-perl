#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

use Test::More tests => 4;
BEGIN { use_ok('Dancer', 'Bio::GMOD::RPC::Server', 'Bio::GMOD::RPC::v1_1::Cv::ChadoCv', 'Bio::GMOD::RPC::v1_1::DbUtils'); }
require_ok('Bio::GMOD::RPC::v1_1::Cv::ChadoCv');

my $db_util = new Bio::GMOD::RPC::v1_1::DbUtils;
$db_util->config(config);

my $cv = new Bio::GMOD::RPC::v1_1::Cv::ChadoCv;
my $cvs = $cv->list_cvs($db_util->dbh);

ok(scalar(@$cvs) > 1, "Find CVs?");

isa_ok($cv, 'Bio::GMOD::RPC::v1_1::Cv::ChadoCv');
#is($cv->name, 'my cv', 'CV name test');
#is($cv->definition, 'This is the definition for my CV', 'CV definition test');
#is($cv->version, '1.0', 'CV version test');

done_testing();
