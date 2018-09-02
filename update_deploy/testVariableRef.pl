#!/user/bin/perl

sub retHash {
    my %hash = (
        'a' => 'A',
        'b' => 'B'
    );
    return %hash;
}

sub retHashRef {
    my %hash = (
        'a' => 'A',
        'b' => 'B'
    );
    return \%hash;
}

my $hashRef = retHashRef();
my %hash    = retHash();

print( 'hashRef:' . $hashRef->{'a'} . "\n" );    # print A
print( 'hash :' . %hash{'a'} . "\n" );            # print A

