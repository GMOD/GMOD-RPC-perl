package Bio::GMOD::RPC::v1_1::DbUtils;

use Moose;
use Log::Log4perl qw(get_logger);
use namespace::autoclean;

has 'driver'         => (is => 'rw', isa => 'Str', default => 'Pg');
has 'database'   => (is => 'rw', isa => 'Str', default => '');
has 'hostname' => (is => 'rw', isa => 'Str', default => 'localhost');
has 'port' => (is => 'rw', isa => 'Int', default => 5432);
has 'username' => (is => 'rw', isa => 'Str', default => '');
has 'password' => (is => 'rw', isa => 'Str', default => '');
has 'config' => (is => 'rw', isa => 'HashRef', trigger => \&_update_vars);

has 'logger' => (
		 is => 'ro',
		 default => sub { Log::Log4perl->get_logger("Bio.GMOD.RPC.v1_1.DbUtils") },
		 writer => '_logger'
		);

sub _update_vars {
    my $self = shift;
    my $config = $self->config;

    $self->logger->debug("_update_vars called with a config object.");

    $self->driver($config->{chado}->{driver});
    $self->hostname($config->{chado}->{hostname});
    $self->database($config->{chado}->{database});
    $self->username($config->{chado}->{username});
    $self->password($config->{chado}->{driver});
    $self->port($config->{chado}->{port});
};

sub dsn {
    my $self = shift;
    return 'dbi:' . $self->driver . ':database=' . $self->database . ';host=' . $self->hostname . ';port=' . $self->port;
}

sub dbh {
    my $self = shift;
    my $dsn = $self->dsn;
    return DBI->connect($dsn,$self->username,$self->password,{AutoCommit => 0, RaiseError => 1, PrintError => 1});
}


__PACKAGE__->meta->make_immutable;

1;
