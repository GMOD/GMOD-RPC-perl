package Bio::GMOD::RPC::v1_1::Cv::ModCv;

use Moose::Role;
use namespace::autoclean;

use Log::Log4perl qw(get_logger);

#Logger is initialized via the Bio::GMOD::RPC::Server package
has 'logger' => (
		 is => 'ro',
		 default => sub { Log::Log4perl->get_logger("Bio.GMOD.RPC.v1_1.Cv.ModCv") },
		 writer => '_logger'
		);

has 'config' => (is => 'rw', isa => 'HashRef', predicate => 'has_config');

requires 'list_cvs';
requires 'list_cvterms';

1;
