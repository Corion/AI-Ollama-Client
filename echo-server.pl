#!perl
use Mojolicious::Lite '-signatures';

# Simple Mojolicious echo server

any '/*url' => sub ($c) {
    my $str = $c->req->to_string;
    app->log->info( $str );

    # Allow CORS so that https://dhcode.github.io/openapi-ui/ works:
    my $origin = $c->req->headers->header('Origin');
    $c->res->headers->header('Access-Control-Allow-Origin' => $origin);
    $c->res->headers->header('Access-Control-Allow-Headers' => '*');
    $c->res->headers->header('Vary' => 'Origin');
    $c->res->headers->content_type('text/plain');

    $c->render(text => $str);
};

app->start;
