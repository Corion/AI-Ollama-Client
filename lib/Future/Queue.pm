package Future::Queue 0.01;
use 5.020;
use Moo;
use experimental 'signatures';

has 'curr' => (
    is => 'lazy',
    default => sub { Future->new },
);

sub enqueue($self, @stuff) {
    my $curr = $self->curr;
    $self->{curr} = Future->new;
    return $curr->resolve( $self->curr, @stuff );
}

1;
