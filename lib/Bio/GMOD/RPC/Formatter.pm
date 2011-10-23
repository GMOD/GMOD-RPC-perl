package Bio::GMOD::RPC::Formatter;

use Moose::Role;
use Bio::GMOD::RPC::Types qw/WebService/;
use MooseX::Types::Moose qw/HashRef/;
use JSON;
use XML::Simple;

has service => (
    isa => WebService,
    is => 'ro',
    required => 1,
);

has _json_encoder => (
    default => sub { JSON->new() },
    handles => {jsonify => 'encode' },
);

has _xml_encoder => (
    default => sub { XML::Simple->new(RootName => "resultset") },
    handles => {xmlify => 'XMLout'},
);

sub json {
    my $self = shift;
    my $result = shift;
    my $resultset = {
        api_version => $self->service->api_version, 
        data_provider => $self->service->data_provider,
        data_version => $self->service->data_version,
        result => $result,
    };
    return $self->jsonify($resultset);
}

sub xml {
    my $self = shift;
    my $result = shift;
    my $resultset = {
        api_version => [$self->service->api_version], 
        data_provider => [$self->service->data_provider],
        data_version => [$self->service->data_version],
        result => _make_values_arrays($result),
    };
    return $self->xmlify($resultset);
}

sub _make_values_arrays {
    my $data = shift;
    if (ref $data eq 'HASH') {
        while (my ($k, $v) = each %$data) {
            if (ref $v eq 'HASH') {
                $data->{$k} = _make_values_arrays($v);
            } elsif (ref $v eq 'ARRAY') {
                $data->{$k} = [map {_make_values_arrays($_)} @$v];
            } else {
                $data->{$k} = [$v];
            }
        }
    } elsif (ref $data eq 'ARRAY') {
        $data = [map {_make_values_arrays($_)} @$data];
    }
    return $data;
}

1;
