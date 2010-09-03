#!/usr/bin/perl
use Plack::Handler::FCGI;

my $app = do('/home/jogoodma/development/Bio_GMOD_RPC-dancer/Bio_GMOD_RPC/app.psgi');
my $server = Plack::Handler::FCGI->new(nproc  => 5, detach => 1);
$server->run($app);
