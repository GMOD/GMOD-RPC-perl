package view;
use strict;
use warnings;

# tests for GMOD-RPC views
use Test::More;
use Test::Exception;

use Data::Dumper;

sub test_view_create {
    my $class = shift;
    
    my $xml;
    lives_ok {
	$xml = $class->new( 'data_version'  => 4,
			   'api_version'   => 3,
			   'data_provider' => 'The Fooish Provider',
			  );
    } 'create OK with valid view args';


    throws_ok {
	$class->new( 'api_version'   => -1,
		     'data_version'  => 'fog',
		     'data_provider' => 'me',
		    );
    } qr/api_version/, 'dies on negative api version';
}

my @roundtrip_tests = (
    {
	foo => 'bar',
	baz => 'boo',
    },
    {
	something => 1,
	nested_thing => {
	    foo => 'bar',
	    baz => 'boo',
	    multi_nest => [
		{ gof => 'bar' },
		{ noggin => 'butter' },
	    ],
	},
    },
    {
	something => 1,
 	nested_thing => {
	    foo => 'bar',
	    baz => 'boo',
	    multi_nest => [
		{ gof => 'bar' },
		{ noggin => 'butter' },
	    ],
	},
 	nested_thing2 => [
	    'foo',
	    'bar',
	    'baz',
	    'boo',
	    'multi_nest',
	    { gof => 'bar' },
	    { noggin => 'butter' },
	 ],
	
    },
);

sub test_view_roundtrip {
    my $class = shift;
    my $parse_sub = shift;

    my $test_cnt = 0;
    foreach my $test ( @roundtrip_tests ) {
	my %meta = (
	    data_version  => 3,
	    api_version   => 3,
	    data_provider => 'Some provider',
	   );
	my $view = $class->new( %meta );
	my $result = $view->render_result( $test );
	my $parsed = $parse_sub->( $result );
	is_deeply( $parsed,
		   { resultset => { %$test,
				    %meta,
				  },
		   },
		   "test ".++$test_cnt,
		  )
	    or diag "return was:\n${result}parsed as:\n".Dumper $parsed;
    }
}

###
1;#
###

