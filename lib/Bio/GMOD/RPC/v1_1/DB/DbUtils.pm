package Bio::GMOD::RPC::v1_1::DB::DbUtils;

use Moose;
use Try::Tiny;
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

sub dsn {
    my $self = shift;
    $self->logger->debug("dsn called.");
    return 'dbi:' . $self->driver . ':database=' . $self->database . ';host=' . $self->hostname . ';port=' . $self->port;
}

sub dbh {
    my $self = shift;
    my $dsn = $self->dsn;
    $self->logger->debug("Trying to connect to DB and return a dbh object.");
    return try {
        DBI->connect($dsn,$self->username,$self->password,{AutoCommit => 0, RaiseError => 1, PrintError => 1});
    }
    catch {
        $self->logger->fatal("Can't connect to the database: $DBI::errstr");
        undef;
    };
}


__PACKAGE__->meta->make_immutable;

1;
