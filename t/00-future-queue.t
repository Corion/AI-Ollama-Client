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
$queue->shutdown;

my $curr = $queue->head;
my @received;
repeat {
    my ($next,$str) = $curr->get;
    if( defined $next ) {
        note $str;
        push @received, $str;
    };
    $curr = $next;
} while => sub($cont) { defined $cont->get };

is \@received, \@lines, "We receive/send the same lines";

done_testing();
