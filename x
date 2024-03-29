
#less -S /var/log/windowserver.log | ./bin/pebble.pl 'App::Pebble::Object->split({ has => [qw/ month day time  number error module message/] }) | pgrep { $_->time =~ /14:54:20/ }'

less -S /var/log/windowserver.log | ./bin/pebble.pl \
'App::Pebble::Object->match({
regex => qr/(\w+ \d+ [\d:]+)\s+\[\d+\] (\w+): (\w+): (.+)/,
has => [qw/ date error module message /] }) | pgrep { $_->date =~ /:20/ }'

/bin/pebble.pl

        
# less -S /var/log/windowserver.log | ./bin/pebble.pl \
# 'App::Pebble::Object->match({
# regex => qr/(\w+) (.+)/,
# has => [qw/ first line /] })'


#  | p { use Data::Dumper; $_->module }
# pebble --split --split-count=7 --split-has=month,day,time,number,error,module,message --has=date[DateTime] 'P->also_has( "date[DateTime]" ) | p { $_->date( P->parse_date(qw/ month day  /) } | pgrep { $_->month < 3 }'

        
# Dec 02 16:05:32  [68] kCGErrorIllegalArgument: CGXSetWindowFilter: Invalid
sub web_scraper_example {
      p { P->split( has => "url", "id", "title" ) }
    | p {
        O->mod {
            -delete => "url",
            html => S::Web->get( $url ),
        }
    }
    | oadd {
        S::XPath->match(
            url => $url,  # Get it first using S::Web->get, can aso be "file", etc.
            value => {
                author => "//book/author",
            }
        )
    }
    | oreplace {
        html => {
            S::XPath->match(
                xml => $html,
                value => { # text? also get attributes, etc.
                    title                   => "/html/head/title",
                    "chapter_number[Array]" => "//chapter/index",
                },
            },
        ),
    },
  }
}

# Create object from scratch
sub new_pobject {
    p {
        O->new(
            html         => "<html>...</html>",
            "file[File]" => $file,
        );
    }
    |
    onew {
        html => ... etc
    }
    
}

# Create object from existing object
# Take the definition of -object, or by default $_, and add/remove fields
#  Copy any vaues from the initial object
#  If -keep, delete all others
#  If -delete, delete those
#  If -replace, delete any existing keys, add the result of values
#  If -add, add the keys and values. This is just to be able to call a Source
#  Add any other regular keys, values
sub mod_object {
    p {
        O->mod {
            -object  => $_,
            -delete  => ["html"], # or single scalar for one
            -keep    => ["id", "name"],
            -add     => { size => 23 }, # Or Object::Collection with keys/values
            -replace => { url => { html => S::Web->get( $url ) } } # Or Object::Collection with keys/values
            "title"  => $title,
        };
    }
}

# pipe dream:
# pconcurrent would need to be a IO endpoint collecting the objects,
# funneling then to workers and restoring them to the end of a new
# pipeline.
# Can you freeze Moose objects and anonymous meta classes? They would
# need to go both ways.
sub concurrency {
    p { 1..10 }
    | pnew { url => "http://abc/$_" }
    | pconcurrent {
        oadd { html => S::Web->get( $url ) }
    }
    | pkeep { "url" }
}

# 
sub get_missing_bc {
      p { 1..10 } # days back
    | p { DateTime->now->subtract( days => $_ ) }
    | pdebug # warn nice Dumper or something
    | onew { date => $_ }
    | oadd {
        start_time => $date,
        end_time   => $date->clone->add( days => 1 ),
    }
    | oadd {
        S::XPath->match(
            url  => "http://piabcps/bc/start/$start_time/end/$end_time/",
            text => { "bc_pid[Array]" => '//change_to/@pid' },
        ),
    }
    | p { map { O->new( "pid[Num]" => $_ ) } @$bc_pid }
    # or: onew_from_field { bc_pid => "pid[Num]" } # really?
    | oadd {
        S::XPath->match(
            url => "http:/dynabcte/idtype/id/$pid",
            text => { exists => "//type/[ text() = 'bc' ]}" },
        );
    }
    | pgrep { $exists }
    | p {
        O->mod(
            -keep => "pid",
            -add => {
                "cache_time[Int]" => 18600,
                "duration[Int]"   => 3600,
                "url"             => "http://piabcs/bc/$pid",
            },
        );
    }
    | p { R->SQL( "mysql" )->insert( "change" ) }
}

