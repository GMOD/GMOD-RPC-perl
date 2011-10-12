package Bio::GMOD::RPC::v1_1::Name::ChadoNameResolver;

use Moose;
use DBI;
use Bio::GMOD::RPC::v1_1::DbUtils;
use namespace::autoclean;

with 'Bio::GMOD::RPC::v1_1::Name::ModNameResolver';

has 'dbutils' => (is => 'rw',
                  isa => 'Bio::GMOD::RPC::v1_1::DbUtils',
                  lazy_build => 1,
                 );

sub _build_dbutils {
    my $self = shift;
    $self->logger->debug("Building the database utils object.");
    my $dbutils = new Bio::GMOD::RPC::v1_1::DbUtils;

    if ($self->has_config) {
        $self->logger->debug("Found database config.");
        $dbutils->config($self->config);
    }
    else {
        $self->logger->error("No configuration found for database info.  Using defaults...");
    }
    return $dbutils;
}

sub find_gene_by_name {
    my $self = shift;

    my $dbh = $self->dbutils->dbh;
    my @genes;
    $self->logger->info("Fetching all matching gene names from Chado database.");
    my $sql = <<SQL;
select 

SQL
    my $fuzzy_sql = <<SQL;
select 
SQL
    my $chado_genes = $dbh->selectall_arrayref("");
}

sub list_cvs {
    my $self = shift;

    my $dbh = $self->dbutils->dbh;
    my @cvs;
    $self->logger->info("Fetching all CV names from Chado database.");
    my $chado_cvs = $dbh->selectall_arrayref("select name,definition from cv;");
    foreach my $cv (@$chado_cvs) {
        my ($name,$definition) = @$cv;
        next if ($name !~ /\w+/);
        $definition = '' unless defined $definition;
        push(@cvs,Bio::GMOD::RPC::v1_1::Cv::Cv->new(name => $name, definition => $definition));
    }
    $dbh->disconnect;
    return \@cvs;
}

sub list_cvterms {
    my $self = shift;
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
    $self->logger->info("Fetching all cvterms for $cv");
    my $dbh = $self->dbutils->dbh;
    my $chado_cvterms = $dbh->selectall_arrayref($sql,{},($cv));
    foreach my $cvterms (@$chado_cvterms) {
        my ($name,$definition,$db,$acc) = @$cvterms;
        next if ($name !~ /\w+/);
        $definition = '' unless defined $definition;
        push(@cvterms,Bio::GMOD::RPC::v1_1::Cv::Cvterm->new(name => $name, definition => $definition, db => $db, id => $acc));
    }
    $dbh->disconnect;
    return \@cvterms;
}

__PACKAGE__->meta->make_immutable;

1;
