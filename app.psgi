# PSGI application bootstraper for Dancer
use Dancer;
load_app 'Bio::GMOD::RPC::Server';

use Dancer::Config 'setting';
setting apphandler  => 'PSGI';
Dancer::Config->load;

my $handler = sub {
    my $env = shift;
    my $request = Dancer::Request->new($env);
    Dancer->dance($request);
};
