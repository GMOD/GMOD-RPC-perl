package Bio::GMOD::RPC::Server::v1_1::Services;
use Dancer ':syntax';
use Template;
use Log::Log4perl;

use Bio::GMOD::RPC::v1_1::Organism::FlyBaseOrganisms;

Log::Log4perl->init_once('log4perl.conf');

my $logger = Log::Log4perl::get_logger("Bio::GMOD::RPC::Server::v1_1::Services");

prefix '/gmodrpc/v1.1';

before sub {
    if (request->path =~ m/\.json$/) {
	content_type 'application/json';
	var template_suffix => '_json';
    }
    else {
	content_type 'text/xml';
	var template_suffix => '_xml';
    }
};

get '.xml' => \&services;
get '.json' => \&services;
get '/' => \&services;

sub services {
    $logger->debug("/gmodrpc/v1.1 called");
    template 'services_v1_1' . vars->{template_suffix};
}

get '/organisms' => \&organisms;
get '/organisms.xml' => \&organisms;
get '/organisms.json' => \&organisms;

sub organisms {
    $logger->debug("/gmodrpc/v1.1/organisms called");
    my $fb_orgs = new Bio::GMOD::RPC::v1_1::Organism::FlyBaseOrganisms;

    template 'organisms' . vars->{template_suffix} => { organisms => $fb_orgs->organisms,
							data_provider => config->{data_provider},
							data_version => config->{data_version}
						      };
}


true;
