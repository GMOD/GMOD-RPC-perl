package Bio::GMOD::RPC::v1_1::SQL::Queries;

use Moose;
use namespace::autoclean;

with 'MooseX::Log::Log4perl', 'Bio::GMOD::RPC::v1_1::AppConfig';

has 'driver'         => (is => 'rw', isa => 'Str', default => 'Pg');
has 'database'   => (is => 'rw', isa => 'Str', default => '');
has 'hostname' => (is => 'rw', isa => 'Str', default => 'localhost');
has 'port' => (is => 'rw', isa => 'Int', default => 5432);
has 'username' => (is => 'rw', isa => 'Str', default => '');
has 'password' => (is => 'rw', isa => 'Str', default => '');


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

sub get_query {
    my $self = shift;
    my $version = shift;
    my $query_name = shift;

}


__PACKAGE__->meta->make_immutable;

1;
