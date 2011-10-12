package Bio::GMOD::RPC::v1_1::Name::ModNameResolver;

use Moose::Role;
use namespace::autoclean;

with 'Bio::GMOD::RPC::v1_1::AppConfig', 'MooseX::Log::Log4perl';

requires 'find_gene_by_name';

1;
