package AI::Ollama::GenerateEmbeddingResponse 0.03;
# DO NOT EDIT! This is an autogenerated file.
use 5.020;
use Moo 2;
use experimental 'signatures';
use stable 'postderef';
use Types::Standard qw(Str Bool Num Int Object ArrayRef);
use MooX::TypeTiny;

=head1 NAME

AI::Ollama::GenerateEmbeddingResponse -

=head1 SYNOPSIS

  my $obj = AI::Ollama::GenerateEmbeddingResponse->new();
  ...

=cut

sub as_hash( $self ) {
    return { $self->%* }
}

=head1 PROPERTIES

=head2 C<< embedding >>

The embedding for the prompt.

=cut

has 'embedding' => (
    is       => 'ro',
    isa      => ArrayRef[Num],
);


1;
