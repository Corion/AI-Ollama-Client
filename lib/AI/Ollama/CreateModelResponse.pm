package AI::Ollama::CreateModelResponse 0.02;
# DO NOT EDIT! This is an autogenerated file.
use 5.020;
use Moo 2;
use experimental 'signatures';
use Types::Standard qw(Str Bool Num Int Object ArrayRef);
use MooX::TypeTiny;

=head1 NAME

AI::Ollama::CreateModelResponse -

=head1 SYNOPSIS

  my $obj = AI::Ollama::CreateModelResponse->new();
  ...

=cut

sub as_hash( $self ) {
    return { $self->%* }
}

=head1 PROPERTIES

=head2 C<< status >>

Status creating the model

=cut

has 'status' => (
    is       => 'ro',
    isa      => Str,
);


1;
