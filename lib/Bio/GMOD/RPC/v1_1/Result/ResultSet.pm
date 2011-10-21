package Bio::GMOD::RPC::v1_1::Result::ResultSet;

use Moose;
use Try::Tiny;
use namespace::autoclean;

has 'api_version' => (is => 'rw',
                      isa => 'Num',
                      lazy => 1
                      default => $self->config->{api_version}
                     );

has 'data_provider' => (is => 'rw',
                        isa => 'Str',
                        lazy => 1,
                        default => $self->config->{data_provider}
                       );

has 'data_version' => (is => 'rw',
                       isa => 'Str',
                       lazy => 1,
                       default => $self->config->{data_version}
                      );

has 'query_url'  -> (is => 'rw',
                     isa => 'Str',
                     default => '');

has 'query_time' => (is => 'rw',
                     isa => 'Str',
                     default => POSIX::strftime("%Y-%m-%d %H:%M:%S %z", localtime)
                    );

has 'results' => (is => 'ro',
                  isa => 'ArrayRef[Bio::GMOD::RPC::v1_1::Result::Result]',
                  default => sub { [] },
                  predicte => 'has_results'
                 );

with 'MooseX::Log::Log4perl', 'Bio::GMOD::RPC::v1_1::AppConfig';

after 'config' => sub {
    my ($self, @args) = @_;

    if (@args) {
    my $config = $self->config;

    $self->logger->debug("Parsing config object for DB parameters.");

    $self->driver($config->{chado}->{driver});
    $self->hostname($config->{chado}->{hostname});
    $self->database($config->{chado}->{database});
    $self->username($config->{chado}->{username});
    $self->password($config->{chado}->{driver});
    $self->port($config->{chado}->{port});
    }
};

sub add {
    my $self = shift;
    for my $result (@_) {
        if ($result->isa('Bio::GMOD::RPC::v1_1::Result::Result')) {
           push($self->results,$result);
        }
        else {
            $self->logger->error($result . ' is not a Bio::GMOD::RPC::v1_1::Result::Result object, ignoring.');
        }
    }
}

sub count {
    return scalar $self->results;
}

__PACKAGE__->meta->make_immutable;

1;
