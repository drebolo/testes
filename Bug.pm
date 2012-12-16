package Bug;
use Moose;

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
        $self->default_size();
        return;
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

sub default_size {
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

