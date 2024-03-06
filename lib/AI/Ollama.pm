package main;
use 5.020;
use Mojo::JSON 'decode_json';
use experimental 'signatures';
use AI::Ollama::Client;
use Future::Utils 'repeat';

my $ol = AI::Ollama::Client->new(
    server => 'http://192.168.1.97:11434/api',
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

repeat {
    $| = 1;
    my( $next, $resp ) = $tx->get;
    print $resp->response;
    $tx = $next;
    Future->done( $resp->done );
} until => sub($done) { $done->get };

#my $buffer;
#$tx->res->on( progress => sub($stream) {
#    for my $elt (decode_ndjson( $stream->body, \$buffer )) {
#        local $| = 1;
#        if( $elt->{response} eq "\n" ) {
#            print "\r";
#        } else {
#            print $elt->{response};
#        }
#        if( $elt->{done} ) {
#            print "\n";
#            Mojo::IOLoop->stop_gracefully;
#        };
#    };
#});

Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
