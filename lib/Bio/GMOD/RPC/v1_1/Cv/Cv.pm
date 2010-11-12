package Bio::GMOD::RPC::v1_1::Cv::Cv;

use Moose;
use namespace::autoclean;

with 'MooseX::Log::Log4perl';

has 'name'         => (is => 'rw', isa => 'Str');
has 'definition'   => (is => 'rw', isa => 'Str', default => '');
has 'version'      => (is => 'rw', isa => 'Str');

__PACKAGE__->meta->make_immutable;

1;
