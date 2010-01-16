#!/usr/bin/env perl
use strict;
use warnings;

use aliased 'Bio::GMOD::RPC::Server::View::JSON';

use Test::More tests => 6;
use Test::Warn;
use Test::Exception;

use JSON::Any;

use FindBin;
use lib "$FindBin::RealBin/lib";
use view;

BEGIN {
  use_ok(  'Bio::GMOD::RPC::Server::View::JSON'  )
    or BAIL_OUT('could not include the module being tested');
}

view::test_view_create( JSON );
my $j = JSON::Any->new;
view::test_view_roundtrip( JSON, sub { $j->decode(shift) } );
