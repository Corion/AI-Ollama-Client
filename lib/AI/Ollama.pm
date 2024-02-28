#package AI::Ollama::GenerateCompletionRequest 0.01;
#use 5.020;
#use Moo 2;
#use experimental 'signatures';
#use Types::Standard qw(Str Bool);
#use MooX::TypeTiny;
#
#has 'model' => (
#    is => 'ro',
#    required => 1,
#    isa => Str,
#);
#has 'prompt' => (
#    is => 'ro',
#    required => 1,
#    isa => Str,
#);
#has 'images' => (
#    is => 'lazy',
#    default => sub { [] },
#);
#
#has 'system' => (
#    is => 'ro',
#);
#has 'template' => (
#    is => 'ro',
#);
#
#has 'context' => (
#    is => 'ro',
#);
#
#has 'options' => (
#    is => 'lazy',
#    default => sub { AI::Ollama::RequestOptions->new },
#);
#has 'format' => (
#    is => 'lazy',
#    default => sub { AI::Ollama::ResponseFormat->new },
#);
#
#has 'raw' => (
#    is => 'ro',
#    isa => Bool,
#);
#has 'stream' => (
#    is => 'ro',
#);
#has 'keep_alive' => (
#    is => 'ro',
#);
#
#sub as_hash( $self ) {
#    return { $self->%* }
#}
#
#1;

#package AI::Ollama::GenerateCompletionResponse 0.01;
#use 5.020;
#use Moo 2;
#use experimental 'signatures';
#use Types::Standard qw(Str Bool ArrayRef);
#use MooX::TypeTiny;
#
#has 'model' => (
#    is => 'ro',
#    isa => Str,
#);
#
#has 'created_at' => (
#    is => 'ro',
#    isa => Str,
#);
#
#has 'response' => (
#    is => 'ro',
#    isa => Str,
#);
#
#
#has 'done' => (
#    is => 'ro',
#    isa => Bool,
#);
#
#has 'context' => (
#    is => 'ro',
#    isa => ArrayRef[Int],
#);
#
#has 'total_duration' => (
#    is => 'ro',
#    isa => Int,
#);
#
#has 'load_duration' => (
#    is => 'ro',
#    isa => Int,
#);
#
#has 'prompt_eval_count' => (
#    is => 'ro',
#    isa => Int,
#);
#
#has 'prompt_eval_duration' => (
#    is => 'ro',
#    isa => Int,
#);
#
#has 'eval_count' => (
#    is => 'ro',
#    isa => Int,
#);
#
#has 'eval_duration' => (
#    is => 'ro',
#    isa => Int,
#);
#
#1;

#package AI::Ollama 0.01;
#use 5.020;
#use Moo 2;
#use experimental 'signatures';
#use Mojo::JSON 'encode_json';
#use Mojo::UserAgent;
#use Mojo::Message::Request;
#use OpenAPI::Modern;
#use YAML::PP;
#
#my $schema = YAML::PP->new( boolean => 'JSON::PP' )->load_file( 'ollama/ollama-curated.yaml' );
#has 'openapi' => (
#    is => 'lazy',
#    default => sub { OpenAPI::Modern->new( openapi_schema => $schema, openapi_uri => '/api' )},
#);
#
#has 'ua' => (
#    is => 'lazy',
#    default => sub { Mojo::UserAgent->new },
#);
#
#has 'server' => (
#    is => 'lazy',
#    default => sub { 'http://192.168.1.97:11434/api' },
#);
#
#sub generate( $self, %options ) {
#    my $req = AI::Ollama::GenerateCompletionRequest->new(
#        %options,
#    );
#    my $url = $self->server . '/generate';
#    my $tx = $self->ua->build_tx(
#        POST => $url,
#        {
#            "Content-Type" => 'application/json',
#        }
#        => json => $req->as_hash,
#    );
#
#    # validate our request while developing
#    my $results = $self->openapi->validate_request($tx->req);
#    say $results;
#say $tx->req->to_string;
#
#    return $tx
#}

package main;
use 5.020;
use Mojo::JSON 'decode_json';
use experimental 'signatures';
use AI::Ollama::Client;

my $ol = AI::Ollama::Client->new(
    server => 'https://192.168.1.97:11434/api',
);

my $tx = $ol->generateCompletion(
    model => 'llama2',
    prompt => 'How are you?',
);

sub decode_ndjson( $stream, $r_buffer ) {
    if( $$r_buffer ) {
        $stream = $$r_buffer . $stream;
        $$r_buffer = '';
    };

    my @res;
    while( $stream and $stream =~ m/^(.+[\]\"\}])$/gm ) {
        my $payload = eval { decode_json($1) };
        if( $@ ) {
            $$r_buffer = $stream;
            last;
        }
        push @res, $payload;
    }
    return @res
}

my $buffer;
$tx->res->on( progress => sub($stream) {
    for my $elt (decode_ndjson( $stream->body, \$buffer )) {
        local $| = 1;
        if( $elt->{response} eq "\n" ) {
            print "\r";
        } else {
            print $elt->{response};
        }
        if( $elt->{done} ) {
            print "\n";
            Mojo::IOLoop->stop_gracefully;
        };
    };
});

$tx = $ol->ua->start_p($tx);
Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
