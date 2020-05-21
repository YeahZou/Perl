#!/user/bin/perl

# 返回hash
sub retHash {
    my %hash = (
        'a' => 'A',
        'b' => 'B'
    );
    return %hash;
}

# 返回Hash的引用（地址）
sub retHashRef {
    my %hash = (
        'a' => 'A',
        'b' => 'B'
    );
    return \%hash;
}

# 引用保存在普通变量中
my $hashRef = retHashRef();
my %hash    = retHash();

print( 'hashRef:' . $hashRef->{'a'} . "\n" );    # print A
print( 'hash :' . $hash{'a'} . "\n" );            # print A

