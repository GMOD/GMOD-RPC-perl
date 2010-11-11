package Bio::GMOD::RPC::v1_1::Cv::ChadoCv;

use Moose;
use DBI;
use Bio::GMOD::RPC::v1_1::Cv;
use Bio::GMOD::RPC::v1_1::Cvterm;
use Bio::GMOD::RPC::v1_1::DbUtils;
use Data::Dumper;
use namespace::autoclean;

with 'Bio::GMOD::RPC::v1_1::Cv::ModCv';

sub list_cvs {
    my $self = shift;
    my $dbh  = shift;

    my @cvs;
    my $chado_cvs = $dbh->selectall_arrayref("select name,definition from cv;");
    foreach my $cv (@$chado_cvs) {
	my ($name,$definition) = @$cv;
	next if ($name !~ /\w+/);
	$definition = '' unless defined $definition;
	push(@cvs,Bio::GMOD::RPC::v1_1::Cv->new(name => $name, definition => $definition));
    }
    return \@cvs;
}

sub list_cvterms {
    my $self = shift;
    my $dbh  = shift;
    my $cv   = shift;

    my @cvterms;
    my $sql = <<SQL;
select cvt.name,cvt.definition,db.name,dbx.accession
    from cvterm cvt join cv on (cvt.cv_id=cv.cv_id)
         join dbxref dbx on (cvt.dbxref_id=dbx.dbxref_id)
         join db on (dbx.db_id=db.db_id)
    where cv.name = ?
          and cvt.is_obsolete = 0
;
SQL
    $self->logger->debug("Fetching cvterms for $cv");
    my $chado_cvterms = $dbh->selectall_arrayref($sql,{},($cv));
    foreach my $cvterms (@$chado_cvterms) {
	my ($name,$definition,$db,$acc) = @$cvterms;
	next if ($name !~ /\w+/);
	$definition = '' unless defined $definition;
	push(@cvterms,Bio::GMOD::RPC::v1_1::Cvterm->new(name => $name, definition => $definition, db => $db, id => $acc));
    }
    return \@cvterms;
}

__PACKAGE__->meta->make_immutable;

1;
