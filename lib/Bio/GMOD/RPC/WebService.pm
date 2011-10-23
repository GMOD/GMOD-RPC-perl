package Bio::GMOD::RPC::WebService;

use Moose;
use Dancer ':moose';
use Bio::GMOD::RPC::Types qw/Version Formatter Provider/;
use MooseX::Types::Moose qw/HashRef/;

has version => (
    isa =>  Version,
    is => 'ro', 
    required => 1,
    coerce => 1,
);

has config => (
    isa => HashRef,
    is => 'ro',
    required => 1,
);

has api_version => (
    isa => Str,
    is => 'ro',
    lazy_build => 1,
);

sub _build_api_version {
    my $self = shift;
    return $self->config->{api}{version};
}

has data_provider => (
    isa => Str,
    is => 'ro',
    lazy_build => 1,
);

sub _build_data_provider {
    my $self = shift;
    return $self->config->{data}{provider};
}

has data_version => (
    isa => Str,
    is => 'ro',
    lazy_build => 1,
);

sub _build_data_version {
    my $self = shift;
    my $version = $self->config{data}{version};
    return $version if $version;
    my $version_service = $self->providers->{version};
    return $version_service->get_data if $version_service;
    die "Could not generate the data version";
}

has providers => (
    isa => HashRef[Provider],
    is => 'ro',
    default => sub { {} },
    traits => ['Hash'],
    handles => {set_provider => 'set'},
);

has formatters => (
    isa => HashRef[Formatter],
    is => 'ro',
    default => sub { {} },
    traits => ['Hash'],
    handles => {set_provider => 'set'},
);

sub BUILD {
    my $self = shift;
    my $version = $self->version;
    my $opts = $self->config->{services}{$version};
    while (my ($k, $v) = each( %$opts ) ) {
        (my $default = $k) =~ s{[/:]+}{_};
        my $suffix = "Standard::${default}::${version}");
        my $provider_class = $self->PREFIX . 'Provider::' 
                    . ($v->{provider} || $suffix );
        my $formatter_class = $self->PREFIX . 'Formatter::' 
                    . ($v->{formatter} || $suffix );
        for my $class ($provider_class, $formatter_class) {
            Class::MOP::load_class($class);
        }

        my $provider = $provider_class->new(service => $self);
        my $formatter = $formatter_class->new(service => $self);
        $self->set_provider($k, $provider);
        $self->set_formatter($k, $formatter);
    }
}

sub generate_handler {
    my $self = shift;
    my ($call, $format) = @_;
    return sub {
        my $data = $self->providers->{$call}->get_data(params);
        content_type ($format eq 'xml') ? "text/xml" : "application/json";
        return $self->formatters->{$call}->$format($data);
    };
}


sub register_routes {
    my $self = shift;

    for my $call (keys %{ $self->config->{services}{$self->version} }) {
        my $xml_handler = $self->generate_handler($call => 'xml');
        my $json_handler = $self->generate_handler($call => 'json');

        get $call           => $xml_handler;
        get $call . '/'     => $xml_handler;
        get $call . '.xml'  => $xml_handler;
        get $call . '.json' => $json_handler;
    }
}

1;
