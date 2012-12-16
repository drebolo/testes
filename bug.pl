#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

use Bug;

my $m = Bug->new(
    gender => 'female',
    parents_genes => {
        mother => {
            size  => 157,
            color => '',
        },
        father => {
            size  => 178,
            color => '',
        }
    },
);

my $f = Bug->new(
    gender => 'male',
    parents_genes => {
        mother => {
            size => 153,
        },
        father => {
            size => 170,
        }
    }
);

$m->size;
$f->size;

print Dumper $m;

print Dumper $f;

my $c = Bug->new(   
                    father => $f,
                    mother => $m
                );
$c->size;
print Dumper $c;
