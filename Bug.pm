package Bug;
use Moose;
use Data::Dumper;

has 'gender' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
    default  => sub { ( 'male', 'female' )[ int( rand 2 ) ] }
);
has 'size' => (
    is       => 'ro',
    isa      => 'Num',
    required => 1,
    lazy     => 1,
    default  => sub {
        my $self = shift;
        return $self->_default_size();
    }
);

has 'color' => (
    is      => 'ro',
    lazy    => 1,
    isa     => 'Bug::Color',
    default => sub {
        my $self = shift;

        return;
    }
);

has 'parents_genes' => (
    is  => 'ro',
    isa => 'HashRef',
);

has 'father' => (
    is  => 'ro',
    isa => 'Bug',
#    handles => {
#        father_fertility => 'fertil()'
#    }
    #    required => 1
);

has 'mother' => (
    is  => 'ro',
    isa => 'Bug',
    
    #    required => 1
);

has 'childreen' => (
    is  => 'ro',
    isa => 'ArrayRef'
);

has 'generation' => (
    is => 'ro',
    isa => 'Num',
    required => 1,
    default => sub { my $self = shift;
                    return ( $self->mother->generation + 1 ) if $self->mother;
                    return 0;
                    }
);

has 'fertil' => (
    is => 'ro',
#    writer => '_set_fertil',
    isa => 'Num',
    default  => sub {  int( rand 10 )  }
);

sub _default_size {
    my $self = shift;
    my $f_size =
      (   $self->father
        ? $self->father->size
        : $self->parents_genes->{father}->{size} );
    my $m_size =
      (   $self->mother
        ? $self->mother->size
        : $self->parents_genes->{mother}->{size} );
    my @factors =
      $self->gender eq 'male' ? ( 1.03, 1.07, 1.1 ) : ( 0.9, 0.93, 0.97 );

    my $size =
      ( $f_size + $m_size +
          ( $self->gender eq 'male' ? $f_size : $m_size ) ) / 3;
    $size = $size * ( 1, @factors )[ int( rand 4 ) ];
    return $size;
}

sub _set_fertil {
    my ($self) = @_;
    $self->fertil() - 1;
}

sub get_genes {
    my ($self) = @_;
    return { size => $self->size };
}

package Bug::Color;
use Moose;

has 'p_color' => (
    is       => 'ro',
    isa      => 'int',
    required => 1,
    trigger  => sub { print "aqui\n" }
);

has 'm_color' => (
    is       => 'ro',
    isa      => 'int',
    required => 1
);

has 'color' => (
    is  => 'ro',
    isa => 'int',

    #    required => 1

);

1;

