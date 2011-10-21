package Bio::GMOD::RPC::v1_1::Organism::ModOrganisms;

use Moose::Role;
use namespace::autoclean;

with 'MooseX::Log::Log4perl';

has 'organisms' => (
		    is      => 'ro',
		    isa     => 'ArrayRef[Bio::GMOD::RPC::v1_1::Organism::Organism]',
		    writer  => '_organisms',
		    default => sub { [] },
		   );

requires 'create_organisms';

sub add {
    my $self = shift;
    push(@{$self->organisms},@_);
}

sub count {
    my $self = shift;
    $self->logger->debug("Count called.");
    return scalar @{$self->organisms};
}

sub fetch_by_genus {
    my $self = shift;
    my $genus = shift;
    $self->logger->debug("Fetch by genus called with $genus.");
    return $self->fetch_by_genus_species($genus,undef);
}

sub fetch_by_species {
    my $self = shift;
    my $species = shift;
    $self->logger->debug("Fetch by species called with $species.");
    return $self->fetch_by_genus_species(undef,$species);
}

sub fetch_by_genus_species {
    my $self    = shift;
    my $genus   = shift;
    my $species = shift;

    $genus = '' unless defined $genus;
    $species = '' unless defined $species;

    $self->logger->debug("Fetch by genus and species called with genus: $genus species: $species");

    my @organisms = ();

    foreach my $organism (@{$self->organisms}) {
	if ($organism->genus eq $genus && $organism->species eq $species) {
	    push(@organisms,$organism);
	}
	elsif ($organism->species eq $species && $genus eq '') {
	    push(@organisms,$organism);
	}
	elsif ($organism->genus eq $genus && $species eq '') {
	    push(@organisms,$organism);
	}
    }
    $self->logger->debug('Found a total of ' . scalar(@organisms) . ' organisms');
    return @organisms;
}

sub fetch_by_abbreviation {
    my $self   = shift;
    my $abbrev = shift;

    $self->logger->debug("Fetch by abbreviation called with $abbrev");
    $abbrev = qr/^$abbrev$/i;
    my @organisms = ();

    foreach my $organism (@{$self->organisms}) {
	if ($organism->abbreviation =~ $abbrev) {
	    push(@organisms,$organism);
	}
    }
    $self->logger->debug('Found a total of ' . scalar(@organisms) . ' organisms');
    return @organisms;
}

sub fetch_by_taxonid {
    my $self    = shift;
    my $taxonid = shift;

    $self->logger->debug("Fetch by taxonid called with $taxonid");
    my @organisms = ();

    foreach my $organism (@{$self->organisms}) {
	if ($organism->taxonid == $taxonid) {
	    push(@organisms,$organism);
	}
    }
    $self->logger->debug('Found a total of ' . scalar(@organisms) . ' organisms');
    return @organisms;
}


sub BUILD {
    my $self = shift;
    $self->logger->debug('Calling the subclassed create_organisms function.');
    $self->create_organisms;
}

1;
