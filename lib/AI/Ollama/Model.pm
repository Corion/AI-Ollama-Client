package AI::Ollama::Model 0.04;
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

AI::Ollama::Model -

=head1 SYNOPSIS

  my $obj = AI::Ollama::Model->new();
  ...

=cut

sub as_hash( $self ) {
    return { $self->%* }
}

=head1 PROPERTIES

=head2 C<< modified_at >>

Model modification date.

=cut

has 'modified_at' => (
    is       => 'ro',
    isa      => Str,
);

=head2 C<< name >>

The model name.

Model names follow a `model:tag` format. Some examples are `orca-mini:3b-q4_1` and `llama2:70b`. The tag is optional and, if not provided, will default to `latest`. The tag is used to identify a specific version.

=cut

has 'name' => (
    is       => 'ro',
    isa      => Str,
);

=head2 C<< size >>

Size of the model on disk.

=cut

has 'size' => (
    is       => 'ro',
    isa      => Int,
);


1;
