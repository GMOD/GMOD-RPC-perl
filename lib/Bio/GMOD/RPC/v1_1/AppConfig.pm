package Bio::GMOD::RPC::v1_1::AppConfig;

use Moose::Role;
use Log::Log4perl qw(get_logger);
use namespace::autoclean;

has 'config' => (is => 'rw', isa => 'HashRef', predicate => 'has_config');

with 'MooseX::Log::Log4perl';

1;
