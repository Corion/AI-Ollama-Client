package AI::Ollama::Client 0.01;
use 5.020;
use Moo 2;
use experimental 'signatures';

use parent 'AI::Ollama::Client::Impl';

=head1 NAME

AI::Ollama::Client - Client for AI::Ollama

=head1 SYNOPSIS

  use 5.020;
  use AI::Ollama::Client;

  my $client = AI::Ollama::Client->new(
      server => 'https://example.com/',
  );
  my $res = $client->someMethod()->get;
  say $res;

=head1 METHODS

=head2 C<< checkBlob >>

  $client->checkBlob();

Check to see if a blob exists on the Ollama server which is useful when creating models.

=cut

=head2 C<< createBlob >>

  $client->createBlob();

Create a blob from a file. Returns the server file path.

=cut

=head2 C<< generateChatCompletion >>

  $client->generateChatCompletion();

Generate the next message in a chat with a provided model.

=cut

=head2 C<< copyModel >>

  $client->copyModel();

Creates a model with another name from an existing model.

=cut

=head2 C<< createModel >>

  $client->createModel();

Create a model from a Modelfile.

=cut

=head2 C<< deleteModel >>

  $client->deleteModel();

Delete a model and its data.

=cut

=head2 C<< generateEmbedding >>

  $client->generateEmbedding();

Generate embeddings from a model.

=cut

=head2 C<< generateCompletion >>

  $client->generateCompletion();

Generate a response for a given prompt with a provided model.

=cut

=head2 C<< pullModel >>

  $client->pullModel();

Download a model from the ollama library.

=cut

=head2 C<< pushModel >>

  $client->pushModel();

Upload a model to a model library.

=cut

=head2 C<< showModelInfo >>

  $client->showModelInfo();

Show details about a model including modelfile, template, parameters, license, and system prompt.

=cut

=head2 C<< listModels >>

  $client->listModels();

List models that are available locally.

=cut

1;
