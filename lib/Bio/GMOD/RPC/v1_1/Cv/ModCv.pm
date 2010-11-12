package Bio::GMOD::RPC::v1_1::Cv::ModCv;

use Moose::Role;
use namespace::autoclean;

with 'Bio::GMOD::RPC::v1_1::AppConfig', 'MooseX::Log::Log4perl';

requires 'list_cvs';
requires 'list_cvterms';

1;
