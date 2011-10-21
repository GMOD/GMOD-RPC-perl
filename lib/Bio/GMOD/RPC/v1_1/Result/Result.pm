package Bio::GMOD::RPC::v1_1::Result::Result;

use Moose;
use namespace::autoclean;

has 'properties' => (is => 'rw', isa => 'HashRef', default => sub { {} });

with 'MooseX::Log::Log4perl', 'Bio::GMOD::RPC::v1_1::AppConfig';

__PACKAGE__->meta->make_immutable;

1;
