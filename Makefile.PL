
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
	      NAME                => 'Bio_GMOD_RPC',
	      AUTHOR              => q{Josh Goodman <jogoodma@indiana.edu>},
	      VERSION_FROM        => 'lib/Bio/GMOD/RPC/Server.pm',
	      ABSTRACT            => 'YOUR APPLICATION ABSTRACT',
	      ($ExtUtils::MakeMaker::VERSION >= 6.3002
	       ? ('LICENSE'=> 'perl')
	       : ()),
	      PL_FILES            => {},
	      PREREQ_PM => {
			    'Test::More' => 0,
			    'YAML'       => 0,
			    'Dancer'     => 1.1805,
			    'Log::Log4perl' => 0,
			    'Moose'      => 0,
			    'MooseX::Log::Log4perl' => 0,
			    'DBI'        => 0,
			    'DBD::Pg'    => 0,
			   },
	      dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
	      clean               => { FILES => 'Bio_GMOD_RPC-*' },
	     );
