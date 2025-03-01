package AI::Ollama::Message 0.05;
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

AI::Ollama::Message -

=head1 SYNOPSIS

  my $obj = AI::Ollama::Message->new();
  ...

=cut

sub as_hash( $self ) {
    return { $self->%* }
}

=head1 PROPERTIES

=head2 C<< content >>

The content of the message

=cut

has 'content' => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

=head2 C<< images >>

(optional) a list of Base64-encoded images to include in the message (for multimodal models such as llava)

=cut

has 'images' => (
    is       => 'ro',
    isa      => ArrayRef[Str],
);

=head2 C<< role >>

The role of the message

=cut

has 'role' => (
    is       => 'ro',
    isa      => Enum[
        "system",
        "user",
        "assistant",
    ],
    required => 1,
);


1;
