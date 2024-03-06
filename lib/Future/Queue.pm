package Future::Queue 0.01;
use 5.020;
use Moo;
use experimental 'signatures';

=head1 NAME

Future::Queue - a simple queue with a Future API

=head1 SYNOPSIS

  use Future::Utils 'repeat';
  use Future::Queue;

  my $q = Future::Queue->new();

  $q->enqueue('line 1');
  $q->enqueue('line 2');
  $q->enqueue('line 3');
  $q->enqueue(undef); # our "end" marker

  my $curr = $q->head;
  repeat {
      my ($next,$str) = $curr->get;
      say $str if defined $str;
      $curr = $next;

      my $has_next = defined $str;
      Future->done($has_next);
  } while => sub($cont) { $cont->get };

=cut

has 'head' => (
    is => 'lazy',
    default => sub { Future::Mojo->new },
);

has 'tail' => (
    is => 'lazy',
    default => sub { $_[0]->head },
);

sub enqueue($self, @stuff) {
    my $res = $self->tail;
    $self->{tail} = Future::Mojo->new;
    $res->resolve( $self->tail, @stuff );
    return
}

1;

__END__
