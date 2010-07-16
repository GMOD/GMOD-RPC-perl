#!/usr/bin/perl

package Bio::GMOD::RPC::Server::v1_1::Organism::ModOrganisms;

use Moose::Role;
use namespace::autoclean;

has 'organisms' => (
		    is      => 'ro',
		    isa     => 'ArrayRef[Bio::GMOD::RPC::Server::v1_1::Organism]',
		    default => sub { [] }
		   );

requires 'create_organisms';

sub add {
    my $self = shift;
    push(@{$self->organisms},@_);
}

sub count {
    my $self = shift;
    return scalar @{$self->organisms};
}

sub fetch_by_genus {
    my $self = shift;
    my $genus = shift;

    return $self->fetch_by_genus_species($genus,undef);
}

sub fetch_by_species {
    my $self = shift;
    my $species = shift;

    return $self->fetch_by_genus_species(undef,$species);
}

sub fetch_by_genus_species {
    my $self    = shift;
    my $genus   = shift;
    my $species = shift;

    $genus = '' unless defined $genus;
    $species = '' unless defined $species;

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
    return @organisms;
}

sub fetch_by_abbreviation {
    my $self   = shift;
    my $abbrev = shift;

    $abbrev = qr/^$abbrev$/i;
    my @organisms = ();

    foreach my $organism (@{$self->organisms}) {
	if ($organism->abbreviation =~ $abbrev) {
	    push(@organisms,$organism);
	}
    }
    return @organisms;
}


sub BUILD {
    my $self = shift;
    $self->create_organisms;
}

1;
