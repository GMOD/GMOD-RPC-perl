#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('Bio::GMOD::RPC::v1_1::Result::Result'); }

my $result = new_ok('Bio::GMOD::RPC::v1_1::Result::Result');

done_testing();
