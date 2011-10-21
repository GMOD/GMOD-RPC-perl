package Bio::GMOD::RPC::Server;
use Dancer ':syntax';
use Template;
use Log::Log4perl;
use Data::Dumper;

our $VERSION = '1.1';

Log::Log4perl->init_once('log4perl.conf');

my $logger = Log::Log4perl::get_logger("Bio::GMOD::RPC::Server");

hook before => \&set_rettype;

sub set_rettype {
    $logger->debug("Trying to figure out the return type.");
    if (request->path =~ m/\.json$/) {
        content_type 'application/json';
        var template_suffix => '_json';
    }
    else {
        content_type 'text/xml';
        var template_suffix => '_xml';
    }
}

get '/gmodrpc' => \&gmodrpc;
get '/gmodrpc/' => \&gmodrpc;
get '/gmodrpc.xml' => \&gmodrpc;
get '/gmodrpc.json' => \&gmodrpc;

sub gmodrpc {
    $logger->debug("/gmodrpc called");
    my $template = 'versions' . vars->{template_suffix};
    template $template => { supported_versions => config->{supported_versions} };
}

for (@{config->{supported_versions}}) {
    my $version = $_;
    $version =~ s/\./\_/g;
    my $service = 'Bio::GMOD::RPC::Server::v' . $version . '::Services';
    $logger->debug("Trying to load $service");
    load_app $service;
    $logger->info("$service loaded.");
}

true;
