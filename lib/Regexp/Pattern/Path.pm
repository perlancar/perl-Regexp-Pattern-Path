package Regexp::Pattern::Path;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

our %RE;

$RE{filename_unix} = {
    summary => 'Valid filename pattern on Unix',
    description => <<'_',

Length must be 1-255 characters. The only characters not allowed include "\0"
(null) and "/" (forward slash, for path separator).

_
    pat => qr![^\0/]{1,255}!,
    examples => [
        {str=>'foo', matches=>1},
        {str=>'foo bar', matches=>1},
        {str=>'', matches=>0, summary=>'Too short'},
        {str=>"a" x 256, anchor=>1, matches=>0, summary=>'Too long'},
        {str=>"foo/bar", anchor=>1, matches=>0, summary=>'contains slash'},
        {str=>"foo\0", anchor=>1, matches=>0, summary=>'contains null (\\0)'},
    ],
};

1;
# ABSTRACT: Regexp patterns related to path

=head1 SEE ALSO

L<Regexp::Pattern>
