package Bio::GMOD::RPC::v1_1::Cv::Cvterm;

use Moose;
use Log::Log4perl qw(get_logger);
use namespace::autoclean;


has 'name'         => (is => 'rw', isa => 'Str');
has 'definition'   => (is => 'rw', isa => 'Str', default=> '');
has 'db'           => (is => 'rw', isa => 'Str');
has 'id'           => (is => 'rw', isa => 'Str');

#Logger is initialized via the Bio::GMOD::RPC::Server package
has 'logger' => (
		 is => 'ro',
		 default => sub { Log::Log4perl->get_logger("Bio.GMOD.RPC.v1_1.Cv.Cvterm") },
		 writer => '_logger'
		);

__PACKAGE__->meta->make_immutable;

1;
