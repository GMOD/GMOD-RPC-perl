package Bio::GMOD::RPC::v1_1::Cv;

use Moose;
use Log::Log4perl qw(get_logger);
use namespace::autoclean;

has 'name'         => (is => 'rw', isa => 'Str');
has 'definition'   => (is => 'rw', isa => 'Str', default => '');
has 'version'      => (is => 'rw', isa => 'Str');

has 'logger' => (
		 is => 'ro',
		 default => sub { Log::Log4perl->get_logger("Bio.GMOD.RPC.v1_1.Cv") },
		 writer => '_logger'
		);

__PACKAGE__->meta->make_immutable;

1;
