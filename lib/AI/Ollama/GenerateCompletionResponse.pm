package AI::Ollama::GenerateCompletionResponse 0.03;
# DO NOT EDIT! This is an autogenerated file.
use 5.020;
use Moo 2;
use experimental 'signatures';
use stable 'postderef';
use Types::Standard qw(Str Bool Num Int ArrayRef HashRef);
use MooX::TypeTiny;

=head1 NAME

AI::Ollama::GenerateCompletionResponse -

=head1 SYNOPSIS

  my $obj = AI::Ollama::GenerateCompletionResponse->new();
  ...

=cut

sub as_hash( $self ) {
    return { $self->%* }
}

=head1 PROPERTIES

=head2 C<< context >>

An encoding of the conversation used in this response, this can be sent in the next request to keep a conversational memory.

=cut

has 'context' => (
    is       => 'ro',
    isa      => ArrayRef[Int],
);

=head2 C<< created_at >>

Date on which a model was created.

=cut

has 'created_at' => (
    is       => 'ro',
    isa      => Str,
);

=head2 C<< done >>

Whether the response has completed.

=cut

has 'done' => (
    is       => 'ro',
);

=head2 C<< eval_count >>

Number of tokens the response.

=cut

has 'eval_count' => (
    is       => 'ro',
    isa      => Int,
);

=head2 C<< eval_duration >>

Time in nanoseconds spent generating the response.

=cut

has 'eval_duration' => (
    is       => 'ro',
    isa      => Int,
);

=head2 C<< load_duration >>

Time spent in nanoseconds loading the model.

=cut

has 'load_duration' => (
    is       => 'ro',
    isa      => Int,
);

=head2 C<< model >>

The model name.

Model names follow a `model:tag` format. Some examples are `orca-mini:3b-q4_1` and `llama2:70b`. The tag is optional and, if not provided, will default to `latest`. The tag is used to identify a specific version.

=cut

has 'model' => (
    is       => 'ro',
    isa      => Str,
);

=head2 C<< prompt_eval_count >>

Number of tokens in the prompt.

=cut

has 'prompt_eval_count' => (
    is       => 'ro',
    isa      => Int,
);

=head2 C<< prompt_eval_duration >>

Time spent in nanoseconds evaluating the prompt.

=cut

has 'prompt_eval_duration' => (
    is       => 'ro',
    isa      => Int,
);

=head2 C<< response >>

The response for a given prompt with a provided model.

=cut

has 'response' => (
    is       => 'ro',
    isa      => Str,
);

=head2 C<< total_duration >>

Time spent generating the response.

=cut

has 'total_duration' => (
    is       => 'ro',
    isa      => Int,
);


1;
