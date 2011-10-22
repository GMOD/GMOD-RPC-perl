package Bio::GMOD::RPC::Server::Generator;

use strict;
use warnings;

use perl5i::2;
use Dancer ':syntax';
use Class::MOP;

use constant PREFIX => "Bio::GMOD::RPC::";

=head2 Initialize providers

All providers provide the same interface:

=over

=item * construct with global config

=item * produce data with "get_data(params)"

=back

=cut

sub load_services {
    my ($version) = @_;

    my $providers = config->{providers}->{$version};

    #Dynamically load each service provider object that is configured
    #in the config.yml file.
    my $services = {};
    foreach my $service (keys %{$providers}) {
        my $classname = PREFIX  . 'Provider::' . $providers->{$service} . '::' . $version;
        Class::MOP::load_class($classname);
        $services->{$service} = $classname->new(config => config);
    }
    return $ret;
}

sub load_formatters {
    my ($version) = @_;
    my $configured = config->{formatters}->{$version};

    my $formatters = {};

    for my $name (keys %$configured) {
        my $classname = PREFIX . 'Formatter::' . $configured->{$name} . '::' . $version;
        Class::MOP::load_class($classname);
        $formatters->{$name} = $classname->new(config);
    }
    return $ret;
}

sub generate_handler {
    my ($call, $format) = @_;
    return sub {
        my $data = $services->{organisms}->get_data(params);
        content_type ($format eq 'xml') ? "text/xml" : "application/json";
        return $formatters->{organisms}->$format($data);
    };
}

#=================================
# Dancer controller code follows.
#=================================

sub set_up {
    my $version = config->{api}->{version};
    my $services = load_services($version);
    my $formatters = load_formatters($version);

    prefix '/gmodrpc/' . API_VERSION . '/';

    my $service_handler = sub {
        template "services$version" . vars->{template_suffix};
    };

    get '.xml'  => $service_handler;
    get '.json' => $service_handler;
    get '/'     => $service_handler;

    for my $call (@{ config->{supported_services} }) {
        my $xml_handler = generate_handler($call => 'xml');
        my $json_handler = generate_handler($call => 'json');

        get $call           => $xml_handler;
        get $call . '/'     => $xml_handler;
        get $call . '.xml'  => $xml_handler;
        get $call . '.json' => $json_handler;
    }
}

set_up();

true;
