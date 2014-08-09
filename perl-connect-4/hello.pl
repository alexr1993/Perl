use strict;
use warnings;

# variables
#
# scalars
my $undef; # imlplicitly = undef;
print $undef . "\n";

my $num = 4040.5;
print $num . "\n";

my $string = "world";
print $string . "\n";

my $ref = \$string;
print $ref . "\n";

# booleans
# perl has no bool, the following scalars are falsy:
# undef
# 0
# ""
# "0"
# 1 and "" appear to be canonical true and false values respectively


# operators should only be used on the right scalars otherwise unpredictable
# consequences of type conversion will ensue
# numerical ops: < > <= >= ++ != <=> + *
# string operators: lt gt ge eq ne cmp . x

# array variables
my @array = (
	"print",
	"these",
	"strings",
	"out",
	"for",
	"me", # trailing comma is good, treat like a terminator
);

print $array[0] . "\n";
print $array[-5] . "\n";

# get an arrays length
print "This array has " . (scalar @array) . "elements " . "\n";
print "The last populated index is " . $#array . "\n";

# variables can be interpolated in double quote strings
# when using $, @, or % in a string you must escape them with backslash
# or use single quotes
print "@array\n";

# hash variables
my %scientists = (
	"Newton" => "Isaac",
	"Einstein" => "Albert",
	"Darwin" => "Charles",
);

print $scientists{"Newton"} . "\n";

# a hash is just an array made of (string) key - value pairs
my @scientists = %scientists;

# the hash however has no underlying order

# arrays are subscripted with square brackets and hashes with braces
# square brackets is a numerical operator and braces a string

# a list in perl is different to an array or hash it is a transient
# value which is then assigned to an array or hash variable -
# ("one", 1, "two", 2 ) comma (,) and => is synonymous to the interpreter in
# list definitions, it's only for readability

# seeing as lists are not any concrete variables you cannot have nested
# lists, e.g. ("1", "2", ("2.1", "2.2")) as the interpreter doesn't know
# if it's an array or hash

# perl will flatten the nested list. this makes it easy to concatenate
# lists..
my @array1 = ("head", "shoulders");
my @array2 = ("knees", "toes");
my @array3 = (@array1, @array2);

print @array3 . "\n";


# Every expression in Perl is evaluated in either scalar context or list context
#
# a scalar in scalar context returns the scalar
# a hash or array in list context returns predictably too
# a scalar in list context turns into a single element list
# a list in scalar context returns t he final scalar of the list
# an array in scalar context returns the length

# you can force an expression to be evaluated in scalar context by preceding it
# with "scalar"

# this is the reason why list types cannot contain other list types, because
# the the assignment $array[3] is to a scalar value

# references to list types are scalar however#

my $colour = "Indigo";
my $scalarRef = \$colour;

print $colour . "\n";
print $scalarRef . "\n";
print ${ $scalarRef } . "\n";

# as long as the result is unambiguous, omit the braces
print $$scalarRef;

# if the reference is to an array or hash, dereference with ->
my @colours = ("Red", "Orange", "Yellow", "Green", "Blue");
my $arrayRef = \@colours;

print $colours[0];
print ${ $arrayRef }[0];
print $arrayRef->[0];

# Declaring a data structure

my %owner1 = (
	"name" => "Santa Claus",
	"DOB"  => "1882-12-25",
);

my %owner2 = (
	"name" => "Mickey Mouse",
	"DOB"  => "1928-11-18",
);

my @owners = ( \%owner1, \%owner2 );

my %account = (
	"number" => "12345678",
	"opened" => "2000-01-01",
	"owners" => \@owners,
);

# alternatively create anonymous arrays and hashes use square brackets and
# braces respectively
# the anonymous initialisation returns a reference to the new data structure

my %account = (
	"number" => "31415926",
	"opened" => "3000-01-01",
	"owners" => [
		{
			"name" => "Philip Fry",
			"DOB"  => "1974-08-06",
		},
		{
			"name" => "Hubert Farnsworth",
			"DOB"  => "2841-04-09",
		},
	],
);

# The quickest way to then get the info back out, rather than creating a load of
# variables, dereferencing at each step is the following:
print "Account #", $account{"number"}, "\n";
print "Opened on ", $account{"opened"}, "\n";
print "Joint owners:\n";
print "\t", $account{"owners"}->[0]->{"name"}, " (born ", $account{"owners"}->[0]->{"DOB"}, ")\n";
print "\t", $account{"owners"}->[1]->{"name"}, " (born ", $account{"owners"}->[1]->{"DOB"}, ")\n";

# Watch out for this mistake:
# my @array = (1,2,3,4,5); declares an array
# my @array = [1,2,3,4,5]; declares a reference to an array

# conditionals
#
#
#
# if (cond) { } elsif (cond) { } else { }
#
# unless (cond) { } else { } # generally avoid this like the plague
#
print "Oh no it's cold" unless $temp > 15; # this on the other hand is good

# ternary operator is also available ($num % 2 == 0) "even" : "odd";
# these can be nested functionally

# if conditions evaluate in scalar context, so an array is truthy if it has 
# one or more elements

# Loops

# while (cond) { }
# until (cond) { }
# for (init; cond; increment) { } # avoid, it's outdated
# for/foreach my $string ( @array) { }

# if you need the indices..
# foreach my $i (0 .. $#array) { } # .. is the range operator

# a hash has no underlying order so and you can't iterate through it, so sort and
# iterate through the keys
# foreach my $key (sort keys %scientists) { }

# if you don't specify an iterator the default iterator $_ is used
# when using the default iterator you can use a shorter syntax
print $_ foreach @array;

print "\n";

# next and last work like continue and break respectively, you can optionally
# provide a label for the loop you want to affect
# labels are conventionally ALLCAPS
# CANDIDATE: for...
# next CANDIDATE


# Array Functions
my @stack = ("Fred", "Eileen", "Denise", "Charlie",);
print @stack;
print pop @stack; # "Charlie", removes Charlie
push @stack, "Bob", "Alice"; # Appends args from left to right
print shift @stack; # "Fred", removes Fred
unshift @stack "Hank", "Grace"; # Attaches elements to the front from right
# to left

# These functions are all special cases of splice which swaps in a new
# array slice
print splice(@stack, 1, 4, "to be entered", "also to be entered");
# this swaps in the last two args for elements [1,4) which are printed to 
# stdout

# Array Operations which return new objects
print join(", ", ["Comman", "Delimited", "output", "string"]);

# Reverse reverses list in list mode and the concatenated string in scalar
print reverse("Hello", "World"); # "World Hello"
print scalar reverse("Hello", "World"); # "dlroWolleH 

# map constructs an array of results, based on operations on $_
my @capitals = ("Baton Rouge", "Indianapolis", "Columbus");
print join ", ", map { uc $_ } @capitals; # make them all uppercase

# grep takes an array as input and returns a filtered array
print join ", ", grep { length $_ == 6 } @capitals; # note expression is bool

#use this to check for an element
my $containsColumbus = scalar grep { $_ eq "Columbus" } @capitals; # "1"

# grep + map can give you list comprehensions

# sort returns the input array in lexical order
my @elevations = (19, 1, 2, 3, 98, 100, 1056);

print join ", ", sort @elevations;
# "1, 100, 100, 1056, 19, 2, 3, 98"

# t his is the same as print join ", ", sort { $a cmp $b } @elevations;
# as cmp is the lexical comparison operator

# the spaceship operator <=> does the same for numbers - that is -1 if $a
# is less than $b, 0 if equal, else 1

# if $a and $b are references to complex objects you may want to create a 
# comparison subroutine
sub comparator {
	# lots of code...
	# return -1, 0, or 1
}
# print join ", ", sort comparator @elevations;
# you can't however do this in grep or map operations
# note $a, $b, and $_ are never manually populated, they're global and perl
# populated them in relevant blocks

# these built in functions generally don't require brackets around args unless
# in ambiguous circumstances
# when in doubt read the docs

# User Defined Subroutines
# input is ALWAYS a list of scalars, hashes are taken as a doubly long list
# brackets are optional when calling, but should always be used for clarity

sub printRoutine {
	print @_
}
print("blablablabla");

# NOTE: Perl calls by reference, all arguments passed in are originals
# this could lead to confusion like here:
sub reassign {
	$_[0] = 42;
}
reassign(8); # error - 8 cannot be an lvalue

# the moral of the story is you should always unpack args at the start of a
# subroutine

# Unpacking Arguments
# for up to including 4 args, shifting them into variable suffices..
sub left_pad {
	my $oldString = shift; # shift @_ is implied in a subroutine
	my $width     = shift;
	my $padChar   = shift;
# ...
}

# alternatively, multiple simultaneous scalar assignment
sub left_pad15 {
	my ($oldString, $width, $padChar) = @_;
}

# beyond 4 args, demand the user to pass in a hashtable, then recover it
# inside the subroutine

sub left_pad2 {
	my %args = @_;
	my $newString = ($args{"padChar"}); #...
}

# Subroutines can check if the caller wants a scalar or list return value
sub contextualSubroutine {
	return ("Everest", "K2", "Etna") if wantarray;
	return 3;
}

my @array = contextualSubroutine();
my $scalar = contextualSubroutine();

# System Calls
my $rc = system "perl", "anotherscript.pl", "foor", "bar", "baz";
# this invokes another perl script, rc contains the return code, the first 
# 8 bits of which tell the nature of the processes termination
$rc >>= 8; # take the first 8 bits, 0 implies success;

# in perl, the exit code is given using the exit keyword e.g. exit 37

# backticks `` can be used to run a command and capture stdout
$scalar = `command`; # capture a single string out output
@array = `command`; # capture list of strings of output

# A bit on files
# File tests are unary predicates of -X form, x being a lower or upper case
# char. Search for "perl file tests" as these are google bombs

# Regular Expressions
# match operations performed using =~ m//
# in a scalar context this returns true on success else false

my $string = "Hello World";
if ($string =~ m/(\w+)\s+(\w+)/ {
	print "success";
}

# the groups create sub matches, on success groups are stuffed into variables
# starting with $1 (in this case "Hello")

# In list context =~ m// returns $1, $2 ... as a list

# substitution operations are performed using =~ s///
my $string = "Good morning world";
$string =~ s/world/Vietnam/;
print $string; # "Good morning Vietnam";

# $string has been edited, so you had to pass a scalar, not a literal

# m//g is group match, it returns true until every match has been found
my $string = "a tonne of feathers or a tonne of bricks";
while ($string =~ m/(\w+)/g) {
	print "'".$1."'\n";
}

# in list context m//g returns all matches at once
my @matches = $string =~ m/(\w+)/g;

# =~ s///g will do a global search/replace 

# the /i flag means case-insensitive
# the x flag allow your regex to contain whitespace and comments
"Hello world" =~ m/
	(\w+) # one or more word chars
 	[ ] # single literal space, stored in a character class
	world #literal
/x;

# returns true

# Modules and Packages
# A module is a .pm file with the same syntax as a .pl
# They are executed when loaded and you must return 1 (true) at the end to
# show they loaded successfully
# dirs containing perl modules should be listed in env variable PERL5LIB
# before calling perl.
# List the root dir containing the modules, not individual dirs or modules 
# themselves
#export PERL5LIB=/foo/bar/baz:$PERL5LIB
#set PERL5LIB=C:\foo\bar\baz;%PERL5LIB%

# The script using the perl moddule must use the require built-in to find it
# e.g. require Demo::StringUtils causes perl to search in PERL5LIB for
# Demo/StringUtils.pm and execute it

# to avoid confusiong regarding where a subroutine was originally defined
# packages exist

# any subroutine declared is by implicitly declared in the current package
# by default this is the "main" package
# you can switch package like so:
sub subroutine {
	print "bleh";
}
package Food::Potatoes 

sub subroutine {
	print "bleh";
}
#no collision as it's in a different package

# when you call a subroutine, by default you call the one in the current
# package, unless you specify otherwise: Food::Potatoes::subroutine();

# NOTE: PACKAGES AND MODULES ARE COMPLETELY SEPARATE ENTITIES DESPITE,
# IDENTICAL SYNTAX
# to mitigate the confusion obey the following laws
# 1. A perl script .pl must contain zero package declarations
# 2. A perl module .pm must always contain exactly one celaration, 
#    corresponding to it's name and location, so Demo/StringUtils.pm must
#    begin with package Demo::StringUtils

# OO Perl
#
# pretty poorly supported
# an object is a reference (scalar var) which happens to know which class
# it's referent belongs to
# To tell a reference that its referent belongs to a class, bless it
# To find out what class a referent belongs to if any, ref the reference
# A method is a subroutine that expects an object (or class name if it's a
# class method) as it's first argument
# methods are invoked using $obj->method() for objects,
# Package::Name->method() for classes
# A class is simply a package which has methods

# Example:
# -- Animal.pm --
use strict;
use warnings;

package Animal;

sub eat {
	# first arg is always the object to act on
	my $self = shift @_
	...
}

sub can_eat {
	return 1;
}

return 1;

# And we may use the class like so:

require Animal;

my $animal = {
	"legs" => 4,
	"colour" => "brown",
};
print ref $animal; #"HASH"
bless $animal, "Animal";
print ref $animal; #"Animal"

# Any reference can be blessed onto an object, you must ensure that the
# referent can be used and this class exists/is loaded in

# Although the var is blessed it can still be used in the usual way,
# but now you can call methods on the object
$animal->eat("insects");

# this is equivalent to Animal::eat($animal, "insects");

# Constructors
# -- Animal.pm --
use strict;
use warnings;

package Animal;

sub new {
	my $class = shift @_;
	return bless { "legs" => 4, colour => "brown" }, $class;
}

# then use like so
my $animal = Animal->new();

# Inheritance

# use parent is necessary
use strict;
use warnings;

package Koala;

# Inherit from Animal
use parent ("Animal");

# Override
sub can_eat {
	shift @_; #self is discarded as unnecessary
	my $food = shift @_;
	return $food eq "eucalyptus";

# NOTE: use parent accepts a list of classes, multiple inheritance is supported

# BEGIN {} blocks are parsed at compilation time, ignoring all code outside of 
# them/it, put them at the start only.
# conditional logic can go in them, outside of them will not affect them though

# the use keyword is syntactic sugar for BEGIN blocks
# use Caterpillar = BEGIN { require Caterpillar; Caterpillar->import(); }
# use Caterpillar ("crawl", "pupate");
# = BEGIN {
# 	require Caterpillar;                      # require MODULE
#	Caterpillar->import("crawl", "pupate");   # import from PACKAGE
# }                                               # don't separate them ever

# in order for import() to work the class implemented must have used export
# in the .pm file

use parent ("Exporter");

our @EXPORT_OK = ("crawl", "ear");

# when subroutines are imported they do not have to be called with package
# name syntax e.g. Caterpillar::crawl();

# Perl has no private methods, imply privacy with naming

# The exported module also defines a package var called @EXPORT which can
# be populated by fa list of subroutine names.

# these are the subroutines imported when import() (with no args) is called
# but this defies the point as it's no longer clear where subroutines are
# coming from, so don't give other users this option
# always explicitly name the subroutines you want when importing

# Misc notes!
#
# Data::Dumper can output any scalar to the screen for debugging
# qw{blah1 blah2 blah3} can be used to declare array, used in use statements
# there are many other quote-like operators
#
# for ~= m// and ~= s/// you can use braces instead of slashes as regex delims
# to make slash-heavy regexes more readable as they won't have to be escaped
# ~= m{} ~= s{}{}
# Perl has no constants, but does have subroutine calls with omitted brackets
# Search for "here-doc" if you see something like this <<EOF
# WARNING! many built-ins can be called with no args, causing them to operate
# on @_
#
# }




