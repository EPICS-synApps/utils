# FILENAME...	makeConfigAppInclude.pl
#
# ORIGINAL AUTHOR: Janet Anderson
# CURRENT AUTHOR: Ron Sluiter
#
# USAGE... This is a modified version of Janet Anderson's
#          makeConfigAppInclude.pl file. It is modified to support "include"
#          directives and various macros; i.e., SUPPORT, GATEWAY,
#
# SYNOPSIS...	makeConfigAppInclude.pl(host_arch, output file, ioctop)
#
#Version:	$Revision: 1.4.2.1 $
#Modified By:	$Author: sluiter $
#Last Modified:	$Date: 2004-03-22 20:37:43 $

eval 'exec perl -S $0 ${1+"$@"}'  # -*- Mode: perl -*-
    if $running_under_some_shell; # makeConfigAppInclude.pl

use Env;

if ($ENV{GATEWAY} ne "")
{
    # Add GATEWAY to macro list.
    $applications{GATEWAY} = $ENV{GATEWAY};
}

use Cwd;

$arch = $ARGV[0];
$outfile = $ARGV[1];
$top = $ARGV[2];
# Get the absolute path name of $(TOP)
$savedir = Cwd::getcwd();
Cwd::chdir($top);
$top_abs = Cwd::getcwd();
Cwd::chdir($savedir);
# Add TOP to macro list.
$applications{TOP} = $top_abs;

unlink("${outfile}");
open(OUT,">${outfile}") or die "$! opening ${outfile}";
print OUT "#Do not modify this file.\n";
print OUT "#This file is created during the build.\n";

@files =();
push(@files,"$top/config/RELEASE");
push(@files,"$top/config/RELEASE.${arch}");
foreach $file (@files) {
  if (-r "$file") {
    open(IN, "$file") or die "Cannot open $file\n";
    while ($line = <IN>) {
        next if ( $line =~ /\s*#/ );
	chomp($line);
        $_ = $line;
	($prefix,$macro,$post) = /(.*)\s* \s*\$\((.*)\)(.*)/;
	#test for "include" command
	if ($prefix eq "include") {
	    if ($macro eq "") {
		# true if no macro is present
		#the following looks for
		#prefix = post
		($prefix,$post) = /(.*)\s* \s*(.*)/;
	    }
	    else
	    {
		$base = $applications{$macro};
		if ($base eq "")
		{
		    #print "error: $macro was not previously defined\n";
		}
		else
		{
		    $post = $base . $post;
		}
	    }
	    push(@files,"$post")
	}
	else {
	    #the following looks for
	    # prefix = $(macro)post
	    ($prefix,$macro,$post) = /(.*)\s*=\s*\$\((.*)\)(.*)/;
	    if ($macro eq "") { # true if no macro is present
		# the following looks for
		# prefix = post
		($prefix,$post) = /(.*)\s*=\s*(.*)/;
	    } else {
		$base = $applications{$macro};
		if ($base eq "") {
		    #print "error: $macro was not previously defined\n";
		} else {
		    $post = $base . $post;
		}
	    }
	    
	    $prefix =~ s/^\s+|\s+$//g; # strip leading and trailing whitespace.
	    $applications{$prefix} = $post;
	    if ( -d "$post") { #check that directory exists
		print OUT "\n";
		if ( -d "$post/bin/$arch") { #check that directory exists
		    print OUT "${prefix}_BIN = $post/bin/${arch}\n";
		}
		if ( -d "$post/lib/$arch") { #check that directory exists
		    print OUT "${prefix}_LIB = $post/lib/${arch}\n";
		}
		if ( -d "$post/include") { #check that directory exists
		    print OUT "EPICS_INCLUDES += -I$post/include\n";
		}
		if ( -d "$post/dbd") { #check that directory exists
		    print OUT "EPICS_DBDFLAGS += -I $post/dbd\n";
		}
	    }
	}
    }
    close IN;
  }
}
close OUT;
