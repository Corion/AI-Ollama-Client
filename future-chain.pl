use 5.020;
use experimental 'signatures';
use Future;
use Future::Utils 'repeat';
use Future::Queue;

use Test2::V0 '-no_srand';

my @lines = qw(
    line1
    line2
    line3
    line4
);

my $queue = Future::Queue->new;

for my $l (@lines) {
    $queue->enqueue($l);
}
$queue->enqueue(undef);

my $curr = $queue->head;
repeat {
    my ($next,$str) = $curr->get;
    say $str if defined $str;
    $curr = $next;
    Future->done($str);
} while => sub($cont) { defined $cont->get };
