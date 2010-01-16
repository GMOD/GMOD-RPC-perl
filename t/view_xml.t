#!/usr/bin/env perl
use strict;
use warnings;

use aliased 'Bio::GMOD::RPC::View::XML';

use Test::More tests => 6;
use Test::Warn;
use Test::Exception;

use Data::Dumper;
use XML::Simple;

use FindBin;
use lib "$FindBin::RealBin/lib";
use view;

BEGIN {
  use_ok(  'Bio::GMOD::RPC::View::XML'  )
    or BAIL_OUT('could not include the module being tested');
}

view::test_view_create( XML );
view::test_view_roundtrip( XML, sub { { resultset => XMLin(shift) } } );
