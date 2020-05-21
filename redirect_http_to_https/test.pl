#!/usr/bin/perl

use strict;
use Getopt::Long;
use REST::Client;
use Data::UUID;
use URI::Escape;
use Digest::SHA qw(hmac_sha1_base64);
use Data::Dumper;
use Mojo::JSON qw(to_json from_json);

my $client = REST::Client->new();
$client->setTimeout(10);
$client->setFollow(1);
$client->GET('https://blog.csdn.net/eroswang/article/details/1805434');

my @headers = $client->responseHeaders();
for my $elem (@headers) {
print($elem . ": " . $client->responseHeader($elem) . "\n");
}
#print("responseCode: ". $client->responseCode() . "responseContent: " . $client->responseContent() . "\n");
#print("responseHeaders: " . join(", ", @headers) . "\n");
#if ($client->responseCode() ge 300 and $client->responseCode() lt 400) {
#    my $location = $client->responseHeader('Location');   
#    print("Location is $location\n");
#    $client->GET($location);

#print("\n\n\n redirect:\n\n");
#for my $elem ($client->responseHeaders()) {
#print ($elem . ": " . $client->responseHeader($elem) . "\n");
#}  
#    print("Redirect to $location res: " . $client->responseCode() . ", " . $client->responseContent() . "\n");
#}
