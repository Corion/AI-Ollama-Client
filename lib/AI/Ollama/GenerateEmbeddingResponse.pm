package AI::Ollama::GenerateEmbeddingResponse 0.01;
# DO NOT EDIT! This is an autogenerated file.
use 5.020;
use Moo 2;
use experimental 'signatures';
use Types::Standard qw(Str Bool);
use MooX::TypeTiny;

sub as_hash( $self ) {
    return { $self->%* }
}

=head2 C<< embedding >>

The embedding for the prompt.

=cut

has 'embedding' => (
    is       => 'ro',
#   isa      => 'array',
);


1;
