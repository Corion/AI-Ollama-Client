package AI::Ollama::CreateModelResponse 0.04;
# DO NOT EDIT! This is an autogenerated file.

use 5.020;
use Moo 2;
use experimental 'signatures';
use stable 'postderef';
use Types::Standard qw(Enum Str Bool Num Int HashRef ArrayRef);
use MooX::TypeTiny;

use namespace::clean;

=encoding utf8

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
    isa      => Enum[
        "creating system layer",
        "parsing modelfile",
        "success",
    ],
);


1;
