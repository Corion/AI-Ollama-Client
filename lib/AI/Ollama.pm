package main;
use 5.020;
use Mojo::JSON 'decode_json';
use experimental 'signatures';
use AI::Ollama::Client;
use Future::Utils 'repeat';

my $ol = AI::Ollama::Client->new(
    server => 'http://192.168.1.29:11434/api',
);

#my $tx = $ol->showModelInfo(
#    name => 'llama2',
#)->then( sub ($res) {
#    say $res->modelfile;
#    #Mojo::IOLoop->stop_gracefully;
#    #return Future->done($res);
#});

#my $tx2 = $ol->listModels(
#)->then( sub ($res) {
#    use Data::Dumper; say Dumper $res->models;
#});

my $tx = $ol->generateCompletion(
    model => 'llama2',
    prompt => 'How are you?',
);

#my $tx2 = $ol->generateCompletion(
#    model => 'llama2',
#    prompt => 'What is the difference between imperative and async/await?',
#);

repeat {
    $| = 1;
    my( $next, $resp ) = $tx->get;
    print $resp->response;
    $tx = $next;

    Future::Mojo->done( $resp->done );
} until => sub($done) { $done->get };

#repeat {
#    $| = 1;
#    my( $next, $resp ) = $tx2->get;
#    print $resp->response;
#    $tx2 = $next;
#    Future->done( $resp->done );
#} until => sub($done) { $done->get };

Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
