package AI::Ollama::Client::Impl 0.01;
# DO NOT EDIT! This is an autogenerated file.
use 5.020;
use Moo 2;
use experimental 'signatures';

# These should go into a ::Role
use YAML::PP;
use Mojo::UserAgent;
use OpenAPI::Modern;

use Future::Mojo;

use AI::Ollama::CopyModelRequest;
use AI::Ollama::CreateModelRequest;
use AI::Ollama::CreateModelResponse;
use AI::Ollama::DeleteModelRequest;
use AI::Ollama::GenerateChatCompletionRequest;
use AI::Ollama::GenerateChatCompletionResponse;
use AI::Ollama::GenerateCompletionRequest;
use AI::Ollama::GenerateCompletionResponse;
use AI::Ollama::GenerateEmbeddingRequest;
use AI::Ollama::GenerateEmbeddingResponse;
use AI::Ollama::Message;
use AI::Ollama::Model;
use AI::Ollama::ModelInfo;
use AI::Ollama::ModelInfoRequest;
use AI::Ollama::ModelsResponse;
use AI::Ollama::PullModelRequest;
use AI::Ollama::PullModelResponse;
use AI::Ollama::PushModelRequest;
use AI::Ollama::PushModelResponse;
use AI::Ollama::RequestOptions;

# XXX this should be more configurable, and potentially you don't want validation?!
my $schema = YAML::PP->new( boolean => 'JSON::PP' )->load_file( 'ollama/ollama-curated.yaml' );
has 'openapi' => (
    is => 'lazy',
    default => sub { OpenAPI::Modern->new( openapi_schema => $schema, openapi_uri => '/api' )},
);

# The HTTP stuff should go into a ::Role I guess
has 'ua' => (
    is => 'lazy',
    default => sub { Mojo::UserAgent->new },
);

has 'server' => (
    is => 'lazy',
    default => sub { 'http://localhost:11434/api' }, # XXX pull from OpenAPI file instead
);

=head2 C<< checkBlob >>

Check to see if a blob exists on the Ollama server which is useful when creating models.

=cut

sub checkBlob( $self, %options ) {

    my $method = 'HEAD';
    my $url = $self->server . '/blobs/{digest}';

    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => '',
        }
        # XXX Need to fill the body
        # => $body,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Blob exists on the server
            return $res;
        }
        if( $res->code == 404 ) {
            # Blob was not found
            return $res;
        }
    }

    return $res
}

=head2 C<< createBlob >>

Create a blob from a file. Returns the server file path.

=cut

sub createBlob( $self, %options ) {

    my $method = 'POST';
    my $url = $self->server . '/blobs/{digest}';

    my $request = AI::Ollama::->new( \%options );
    # resp. validate %options against 
    # send as application/octet-stream
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/octet-stream',
        }
        # XXX Need to fill the body
        # => $body,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 201 ) {
            # Blob was successfully created
            return $res;
        }
    }

    return $res
}

=head2 C<< generateChatCompletion >>

Generate the next message in a chat with a provided model.

=cut

sub generateChatCompletion( $self, %options ) {

    my $method = 'POST';
    my $url = $self->server . '/chat';

    my $request = AI::Ollama::GenerateChatCompletionRequest->new( \%options );
    # resp. validate %options against GenerateChatCompletionRequest
    # send as application/json
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/json',
        }
        => json => $request->as_hash,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            if( $res->content_type eq 'HASH(0x560c48b55420)' ) {
            }
            if( $res->content_type eq 'application/x-ndjson' ) {
            }
        }
    }

    return $res
}

=head2 C<< copyModel >>

Creates a model with another name from an existing model.

=cut

sub copyModel( $self, %options ) {

    my $method = 'POST';
    my $url = $self->server . '/copy';

    my $request = AI::Ollama::CopyModelRequest->new( \%options );
    # resp. validate %options against CopyModelRequest
    # send as application/json
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/json',
        }
        => json => $request->as_hash,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            return $res;
        }
    }

    return $res
}

=head2 C<< createModel >>

Create a model from a Modelfile.

=cut

sub createModel( $self, %options ) {

    my $method = 'POST';
    my $url = $self->server . '/create';

    my $request = AI::Ollama::CreateModelRequest->new( \%options );
    # resp. validate %options against CreateModelRequest
    # send as application/json
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/json',
        }
        => json => $request->as_hash,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            if( $res->content_type eq 'HASH(0x560c48b6bf60)' ) {
            }
            if( $res->content_type eq 'application/x-ndjson' ) {
            }
        }
    }

    return $res
}

=head2 C<< deleteModel >>

Delete a model and its data.

=cut

sub deleteModel( $self, %options ) {

    my $method = 'DELETE';
    my $url = $self->server . '/delete';

    my $request = AI::Ollama::DeleteModelRequest->new( \%options );
    # resp. validate %options against DeleteModelRequest
    # send as application/json
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/json',
        }
        => json => $request->as_hash,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            return $res;
        }
    }

    return $res
}

=head2 C<< generateEmbedding >>

Generate embeddings from a model.

=cut

sub generateEmbedding( $self, %options ) {

    my $method = 'POST';
    my $url = $self->server . '/embeddings';

    my $request = AI::Ollama::GenerateEmbeddingRequest->new( \%options );
    # resp. validate %options against GenerateEmbeddingRequest
    # send as application/json
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/json',
        }
        => json => $request->as_hash,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            if( $res->content_type eq 'HASH(0x560c48b62e58)' ) {
            }
            if( $res->content_type eq 'application/json' ) {
            }
        }
    }

    return $res
}

=head2 C<< generateCompletion >>

Generate a response for a given prompt with a provided model.

=cut

sub generateCompletion( $self, %options ) {

    my $method = 'POST';
    my $url = $self->server . '/generate';

    my $request = AI::Ollama::GenerateCompletionRequest->new( \%options );
    # resp. validate %options against GenerateCompletionRequest
    # send as application/json
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/json',
        }
        => json => $request->as_hash,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            if( $res->content_type eq 'HASH(0x560c48b4a7e0)' ) {
            }
            if( $res->content_type eq 'application/x-ndjson' ) {
            }
        }
    }

    return $res
}

=head2 C<< pullModel >>

Download a model from the ollama library.

=cut

sub pullModel( $self, %options ) {

    my $method = 'POST';
    my $url = $self->server . '/pull';

    my $request = AI::Ollama::PullModelRequest->new( \%options );
    # resp. validate %options against PullModelRequest
    # send as application/json
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/json',
        }
        => json => $request->as_hash,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            if( $res->content_type eq 'HASH(0x560c48ba20e0)' ) {
            }
            if( $res->content_type eq 'application/json' ) {
            }
        }
    }

    return $res
}

=head2 C<< pushModel >>

Upload a model to a model library.

=cut

sub pushModel( $self, %options ) {

    my $method = 'POST';
    my $url = $self->server . '/push';

    my $request = AI::Ollama::PushModelRequest->new( \%options );
    # resp. validate %options against PushModelRequest
    # send as application/json
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/json',
        }
        => json => $request->as_hash,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            if( $res->content_type eq 'HASH(0x560c48baf538)' ) {
            }
            if( $res->content_type eq 'application/json' ) {
            }
        }
    }

    return $res
}

=head2 C<< showModelInfo >>

Show details about a model including modelfile, template, parameters, license, and system prompt.

=cut

sub showModelInfo( $self, %options ) {

    my $method = 'POST';
    my $url = $self->server . '/show';

    my $request = AI::Ollama::ModelInfoRequest->new( \%options );
    # resp. validate %options against ModelInfoRequest
    # send as application/json
    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => 'application/json',
        }
        => json => $request->as_hash,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            if( $res->content_type eq 'HASH(0x560c48b80b58)' ) {
            }
            if( $res->content_type eq 'application/json' ) {
            }
        }
    }

    return $res
}

=head2 C<< listModels >>

List models that are available locally.

=cut

sub listModels( $self, %options ) {

    my $method = 'GET';
    my $url = $self->server . '/tags';

    my $tx = $self->ua->build_tx(
        $method => $url,
        {
            "Content-Type" => '',
        }
        # XXX Need to fill the body
        # => $body,
    );

    # validate our request while developing
    my $results = $self->openapi->validate_request($tx->req);
    say $results;
    say $tx->req->to_string;

    # We need to start $tx here and then append us to the promise?!
    my $res = $self->ua->start_p($tx)->then(sub($tx) {
        my $res = $tx->res;

        if( $res->code == 200 ) {
            # Successful operation.
            if( $res->content_type eq 'HASH(0x560c48b74590)' ) {
            }
            if( $res->content_type eq 'application/json' ) {
            }
        }
    }

    return $res
}


1;
