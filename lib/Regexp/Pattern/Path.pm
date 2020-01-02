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
    summary => 'Valid filename on Unix',
    description => <<'_',

Length must be 1-255 characters. The only characters not allowed include "\0"
(null) and "/" (forward slash, for path separator). Also cannot be '.' or '..'.

_
    pat => qr(\A(?:

                  # 1. does not contain forward slash or nul
                  (?!.*[\0/])

                  # 2. is not '.' or '..'
                  (?!\.\.?\z)

                  # 3. must be between 1-255 characters
                  .{1,255}

              )\z)x,
    tags => ['anchored'],
    examples => [
        {str=>'foo', matches=>1},
        {str=>'foo bar', matches=>1},
        {str=>'', matches=>0, summary=>'Too short'},
        {str=>"a" x 256, matches=>0, summary=>'Too long'},
        {str=>"foo/bar", matches=>0, summary=>'contains slash'},
        {str=>"/foo", matches=>0, summary=>'begins with slash'},
        {str=>"foo/", matches=>0, summary=>'ends with slash'},
        {str=>"foo\0", matches=>0, summary=>'contains null (\\0)'},
        {str=>'.', matches=>0, summary=>'Cannot be "."'},
        {str=>'..', matches=>0, summary=>'Cannot be ".."'},
        {str=>'...', matches=>1},
    ],
};

$RE{dirname_unix} = {
    summary => 'Valid directory name on Unix',
    description => <<'_',

Just like `filename_unix` but allows '.' and '..' (strictly speaking they are
special pseudonames to refer to current and parent directory).

_
    pat => qr(\A(?:

                  # 1. does not contain forward slash or nul
                  (?!.*[\0/])

                  # 2. must be between 1-255 characters
                  .{1,255}

              )\z)x,
    tags => ['anchored'],
    examples => [
        {str=>'foo', matches=>1},
        {str=>'foo bar', matches=>1},
        {str=>'', matches=>0, summary=>'Too short'},
        {str=>"a" x 256, matches=>0, summary=>'Too long'},
        {str=>"foo/bar", matches=>0, summary=>'contains slash'},
        {str=>"/foo", matches=>0, summary=>'begins with slash'},
        {str=>"foo/", matches=>0, summary=>'ends with slash'},
        {str=>"foo\0", matches=>0, summary=>'contains null (\\0)'},
        {str=>'.', matches=>1},
        {str=>'..', matches=>1},
        {str=>'...', matches=>1},
    ],
};

1;
# ABSTRACT: Regexp patterns related to path

=head1 SEE ALSO

L<Regexp::Pattern>
