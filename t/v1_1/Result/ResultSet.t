#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('Bio::GMOD::RPC::v1_1::Result::ResultSet'); }

my $result_set = new_ok('Bio::GMOD::RPC::v1_1::Result::ResultSet');

done_testing();
