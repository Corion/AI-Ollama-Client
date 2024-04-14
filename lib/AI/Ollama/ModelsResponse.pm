package AI::Ollama::ModelsResponse 0.03;
# DO NOT EDIT! This is an autogenerated file.
use 5.020;
use Moo 2;
use experimental 'signatures';
use stable 'postderef';
use Types::Standard qw(Str Bool Num Int ArrayRef HashRef);
use MooX::TypeTiny;

=head1 NAME

AI::Ollama::ModelsResponse -

=head1 SYNOPSIS

  my $obj = AI::Ollama::ModelsResponse->new();
  ...

=cut

sub as_hash( $self ) {
    return { $self->%* }
}

=head1 PROPERTIES

=head2 C<< models >>

List of models available locally.

=cut

has 'models' => (
    is       => 'ro',
    isa      => ArrayRef[HashRef],
);


1;
