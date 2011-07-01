#!/usr/bin/perl -w
#
# I honestly don't remember where I found this script.  It's been
#  pretty handy over the years...
#
# attempts to organize mp3s into dirs by:
#   1. checking ID3 tag for Artist name
#   2. scanning the filename
#
# it will further organize the mp3s into subdirectories under the
# artist name by album
#

use strict;
use MP3::Info;

use vars qw( $mp3dir @files %dirs );

# change as necessary
#
$mp3dir = './';

chdir $mp3dir or die "can't chdir to $mp3dir: $!\n\n";

# get file list
#
opendir(DIR, $mp3dir) or die "can't open $mp3dir for read: $!\n\n";
@files = grep { /\.[Mm][Pp]3$/ } readdir(DIR);
closedir(DIR) or warn "error closing $mp3dir: $!\n\n";

&make_dir_list;
&move_files;
exit;


# create dir listing
# %dirs = ( 'dirname' => { 'subdir1' => [ file1, file2, ... ], ... }, ...  );
#
sub make_dir_list {
  foreach ( @files ) {
    my ($artist, $album, $tag);

    # attempt to find artist name through mp3 tag
    #
    $tag = get_mp3tag( $_ );

    # fall back to scanning filename. we're assuming artist name
    # is everything up to the first hyphen
    #
    unless ( $tag && $tag->{ARTIST} !~ /^\s*$/ && $tag->{ARTIST} ne 'artist' ) {
      ($artist) = /^([^-]+?)-.+$/;
      $artist ||= 'unsorted';
    }
    else {
      $artist = $tag->{ARTIST};
    }

    $album  = $tag->{ALBUM} || "";
    if ( $album =~ /^\s*$/ || $album eq 'title' ) { $album = 'misc' }

    $artist = clean_name( $artist ) unless $artist eq 'unsorted';
    $album  = clean_name( $album ) unless $album eq 'misc';
    push @{ $dirs{$artist}{$album} }, $_;
  }
}


# sanitize artist name (or filename fragment) for use as a dir name
#
sub clean_name {
  my $dir = shift;
  return 'unsorted' unless $dir;

#  $dir =  lc($dir);
  $dir =~ s/\bthe\b//;
  $dir =~ s/_/ /g;
  $dir =~ s/^ +//;
  $dir =~ s/ +$//;
  $dir =~ s/ +/ /g;
  $dir =~ s/;//g;
  $dir =~ s/://g;
  $dir =~ s/\//\\/g;
  $dir =~ s/[,(){}\[\]]//g;

#  $dir =~ s/ */_/g;
  return $dir;
}


# create dirs, put sorted files into them
#
sub move_files {
  foreach my $artist ( keys %dirs ) {
    # XXX debug
    #
    print "  $artist\n";

    unless ( -d qq{$artist} ) {
      mkdir( qq{$artist}, 0755 ) or die "error mkdir($artist): $!\n\n";
    }

    foreach my $album ( keys %{ $dirs{$artist} } ) {
      # XXX debug
      #
      #print "    $album\n", map { "\t$_\n" } @{ $dirs{$artist}{$album} }, "\n";

      unless ( -d qq{$artist/$album} ) {
        mkdir( qq{$artist/$album}, 0755 ) or die "2error $artist   $album  mkdir($artist/$album): $!\n\n";
      }

      #system('/bin/mv', @{ $dirs{$artist}{$album} }, qq{$artist/$album/}) == 0
      #  or die "system('/bin/mv'): $?\n\n";

      foreach my $mp3 ( @{ $dirs{$artist}{$album} } ) {
        rename $mp3, qq{$artist/$album/$mp3} or die "can't rename $mp3: $!\n\n";
      }
    }
  }
}

