package DummyService;

sub api_version { return "API_VERSION" };
sub data_provider { return "DATA_PROVIDER" };
sub data_version { return "DATA_VERSION" };

sub new {
    my $class = shift;
    return bless {}, $class;
}

package main;

use Test::More tests => 2;

use Bio::GMOD::RPC::Formatter::Standard::Organism::v1_1;
use Bio::GMOD::RPC::Provider::Testing::Organism::v1_1;

my $provider = Bio::GMOD::RPC::Provider::Testing::Organism::v1_1->new;
my $formatter = Bio::GMOD::RPC::Formatter::Standard::Organism::v1_1->new(service => DummyService->new);

my $expected_json = q!{"api_version":"API_VERSION","data_version":"DATA_VERSION","result":[{"genus":"Drosophila","species":"melanogaster","taxonomy_id":7227},{"genus":"Drosophila","species":"simulans","taxonomy_id":7240}],"data_provider":"DATA_PROVIDER"}!;
my $expected_xml = q!<resultset>
  <api_version>API_VERSION</api_version>
  <data_provider>DATA_PROVIDER</data_provider>
  <data_version>DATA_VERSION</data_version>
  <result>
    <genus>Drosophila</genus>
    <species>melanogaster</species>
    <taxonomy_id>7227</taxonomy_id>
  </result>
  <result>
    <genus>Drosophila</genus>
    <species>simulans</species>
    <taxonomy_id>7240</taxonomy_id>
  </result>
</resultset>
!;

is($expected_json, $formatter->json($provider->get_data)) or diag $formatter->json($provider->get_data);
is($expected_xml, $formatter->xml($provider->get_data)) or diag $formatter->xml($provider->get_data);
