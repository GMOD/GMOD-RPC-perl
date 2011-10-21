#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 6;
BEGIN { use_ok('Bio::GMOD::RPC::Server', 'Bio::GMOD::RPC::v1_1::Cv'); }
require_ok('Bio::GMOD::RPC::v1_1::Cv');

my $cv = new Bio::GMOD::RPC::v1_1::Cv;
$cv->name('my cv');
$cv->definition('This is the definition for my CV');
$cv->version('1.0');

isa_ok($cv, 'Bio::GMOD::RPC::v1_1::Cv');
is($cv->name, 'my cv', 'CV name test');
is($cv->definition, 'This is the definition for my CV', 'CV definition test');
is($cv->version, '1.0', 'CV version test');

done_testing();
