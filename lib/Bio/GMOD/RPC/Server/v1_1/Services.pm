package Bio::GMOD::RPC::Server::v1_1::Services;
use Dancer ':syntax';
use Template;
use POSIX;
use Log::Log4perl;

Log::Log4perl->init_once('log4perl.conf');

#Initialize logger object.
my $logger = Log::Log4perl::get_logger("Bio.GMOD.RPC.Server.v1_1.Services");

#Fetch service provider objects for v1.1 API services.
my $providers = config->{providers}->{v1_1};

#Dynamically load each service provider object that is configured
#in the config.yml file.
foreach my $service (keys %{$providers}) {
    eval "use " . $providers->{$service};
}

#Initialize providers
my $orgs = new {$providers->{organism}};
my $mod_cv = new {$providers->{cv}};
$mod_cv->config(config);

#=================================
# Dancer controller code follows.
#=================================
prefix '/gmodrpc/v1.1';

before sub {
    if (request->path =~ m/\.json/) {
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
    $logger->info("/gmodrpc/v1.1 called");
    template 'services_v1_1' . vars->{template_suffix};
}

get '/organisms'      => \&organisms;
get '/organisms/'     => \&organisms;
get '/organisms.xml'  => \&organisms;
get '/organisms.json' => \&organisms;

sub organisms {
    $logger->info("/gmodrpc/v1.1/organisms called");
    template 'organisms' . vars->{template_suffix} => { organisms => $orgs->organisms,
							data_provider => config->{data_provider},
							data_version => config->{data_version}
						      };
}

get '/cv'      => \&cv;
get '/cv.xml'  => \&cv;
get '/cv.json' => \&cv;

sub cv {
    $logger->info("/gmodrpc/v1.1/cv called");
    template 'cv' . vars->{template_suffix} => {
						cvs => $mod_cv->list_cvs,
						api_version => config->{api_version},
						data_provider => config->{data_provider},
						data_version => config->{data_version},
						query_time => POSIX::strftime("%Y-%m-%d %H:%M:%S %z", localtime),
						query_url => request->uri_for(request->path,request->params),
					       };
}

get '/cv/:name'      => \&get_cvterms;
get '/cv/:name.xml'  => \&get_cvterms;
get '/cv/:name.json' => \&get_cvterms;

sub get_cvterms {
    $logger->info("/gmodrpc/v1.1/cv called with cv name");
    my $cv_name = params->{name};
    template 'cvterm' . vars->{template_suffix} => {
						    cvterms => $mod_cv->list_cvterms($cv_name),
						    api_version => config->{api_version},
						    data_provider => config->{data_provider},
						    data_version => config->{data_version},
						   };
}

get '/gene/name/:name' => \&find_by_name;
get '/gene/name/:name.xml' => \&find_by_name;
get '/gene/name:name.json' => \&find_by_name;

sub find_by_name {
    my $name = params->{name};
    $logger->debug("/gmodrpc/v1.1/name called with $name");
    my $name_resolver = new {$providers->{name}};
    
}



get '/location/chromosome/:chrom' => \&location;
get '/location/chromosome/:chrom.xml' => \&location;
get '/location/chromosome/:chrom.json' => \&location;

sub location {
    my $chrom   = params->{chrom};
    my $type    = params->{type};
    my $fmin    = params->{fmin};
    my $fmax    = params->{fmax};
    my $strand  = params->{strand};
    my $taxid   = params->{taxid};
    my $genus   = params->{genus};
    my $species = params->{species};

    $logger->debug("Chrome is $chrom");
    $logger->debug("Request path is " . request->path);
    $type;
}

true;
