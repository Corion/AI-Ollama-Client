package AI::Ollama::CreateModelRequest 0.02;
# DO NOT EDIT! This is an autogenerated file.
use 5.020;
use Moo 2;
use experimental 'signatures';
use Types::Standard qw(Str Bool Num Int Object ArrayRef);
use MooX::TypeTiny;

=head1 NAME

AI::Ollama::CreateModelRequest -

=head1 SYNOPSIS

  my $obj = AI::Ollama::CreateModelRequest->new();
  ...

=cut

sub as_hash( $self ) {
    return { $self->%* }
}

=head1 PROPERTIES

=head2 C<< modelfile >>

The contents of the Modelfile.

=cut

has 'modelfile' => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

=head2 C<< name >>

The model name.

Model names follow a `model:tag` format. Some examples are `orca-mini:3b-q4_1` and `llama2:70b`. The tag is optional and, if not provided, will default to `latest`. The tag is used to identify a specific version.

=cut

has 'name' => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

=head2 C<< stream >>

If `false` the response will be returned as a single response object, otherwise the response will be streamed as a series of objects.

=cut

has 'stream' => (
    is       => 'ro',
);


1;
