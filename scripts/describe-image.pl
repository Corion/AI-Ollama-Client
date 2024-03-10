package main;
use 5.020;
use Mojo::JSON 'decode_json';
use experimental 'signatures';
use AI::Ollama::Client;
use Future::Utils 'repeat';

my $ol = AI::Ollama::Client->new(
    server => 'http://192.168.1.97:11434/api',
);

my $tx = $ol->pullModel(
    name => 'llava:latest',
)->get;

my $tx = $ol->generateCompletion(
    model => 'llava:latest',
    prompt => 'You are tagging images. Please list all the objects in this image as tags. Also list where it was taken.',
    images => [
        { filename => 't/testdata/objectdetection.jpg' },
    ],
);

repeat {
    $| = 1;
    my( $next, $resp ) = $tx->get;
    print $resp->response;
    $tx = $next;

    Future::Mojo->done( $resp->done );
} until => sub($done) { $done->get };

Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
