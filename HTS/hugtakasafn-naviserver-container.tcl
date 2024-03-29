ns_log notice "nsd.tcl: starting to read config file..."

# which database do you want? postgres or oracle
set database              postgres

# oracle needs a password
if {$database == "oracle"} {
    set db_password        "mydbpassword"
}

# listen on these ports
set httpport              8080
set httpsport             8443

# ns_info will try to guess these values based on
# your OS settings, but you may have to replace them
# with sane values if it guesses wrong!
set hostname               [ns_info hostname]
#set address                [ns_info address]
set address                   0.0.0.0

set server              "hugtakasafn"
set db_name             $server
set servername          "Hugtakasafn ���ingami�st��var utanr�kisr��uneytis"

# User account
# This is used in 2 places
#  1) to set the serverroot
#  2) to access Postgresql via this username
set user_account         nsadmin
set serverdir          "/home/${user_account}/web/${server}"

# if debug is false, all debug-level logging will be turned off
set debug false

# you shouldn't need to adjust much below here
# for a standard install

#
# AOLserver's home and binary directories. Autoconfigurable.
#
set homedir                 [file dirname [file dirname [ns_info nsd]]]
set bindir                  [file dirname [ns_info nsd]]

#
# Where are your pages going to live ?
#
set pageroot                ${serverdir}/www
set directoryfile           index.tcl,index.adp,index.html,index.htm

ns_log notice "pageroot is ${pageroot}"

#
# nsssl: Only loads if keyfile.pem and certfile.pem exist.
# If you are using SSL, make sure you have these dirs and files (refer
# to the AOLserver docs)

# set sslkeyfile ${homedir}/servers/${server}/modules/nsssl/keyfile.pem
# set sslcertfile ${homedir}/servers/${server}/modules/nsssl/certfile.pem

#
# Global server parameters
#

ns_section ns/parameters
ns_param   serverlog          error.log
ns_param   home               $homedir
ns_param   maxkeepalive       0
ns_param   logroll            on
ns_param   logmaxbackup       365
ns_param   debug              $debug
ns_param   mailhost        eldur.stjr.is

#
# Thread library (nsthread) parameters
#
ns_section ns/threads
ns_param   mutexmeter         true      ;# measure lock contention
ns_param   stacksize          500000

#
# MIME types.
#
#  Note: AOLserver already has an exhaustive list of MIME types, but in
#  case something is missing you can add it here.
#

ns_section ns/mimetypes
ns_param   Default            text/plain
ns_param   NoExtension        text/plain
ns_param   .pcd               image/x-photo-cd
ns_param   .prc               application/x-pilot
ns_param   .xls               application/vnd.ms-excel
ns_param   .xul               application/vnd.mozilla.xul+xml

#
# Tcl Configuration
#
ns_section ns/server/${server}/tcl
ns_param   library        ${serverdir}/tcl
ns_param   autoclose      on
ns_param   debug          $debug
# ekki i NaviServer:  ns_param   SharedLibrary  ${homedir}/modules/tcl

############################################################
#
# Server-level configuration
#
#  There is only one server in AOLserver, but this is helpful when multiple
#  servers share the same configuration file.  This file assumes that only
#  one server is in use so it is set at the top in the "server" Tcl variable
#  Other host-specific values are set up above as Tcl variables, too.
#
ns_section "ns/servers"
ns_param   $server     $servername

#
# Server parameters
#
ns_section "ns/server/${server}"
ns_param   directoryfile      $directoryfile

ns_param   pagedir           $pageroot

#ns_param   maxconnections     5
ns_param   maxconnections     100
ns_param   maxdropped         0
#ns_param   maxthreads         5
ns_param   maxthreads         15
ns_param   minthreads         5
ns_param   threadtimeout      120
ns_param   globalstats        false    ;# Enable built-in statistics
ns_param   urlstats           false    ;# Enable URL statistics
ns_param   maxurlstats        1000     ;# Max number of URL's to do stats on
ns_param   enabletclpages  true     ;# Parse *.tcl files in pageroot.
#ns_param   directoryadp    $pageroot/dirlist.adp ;# Choose one or the other
#ns_param   directoryproc    _ns_dirlist          ;#  ...but not both!
#ns_param   directorylisting  fancy               ;# Can be simple or fancy
ns_param   spread          20        ;# Variance factor for threadtimeout and maxconnections
                                         ;# to prevent mass mortality of theads (e.g. +-20%)
#sja: http://panoptic.com/wiki/aolserver/Annotated_AOLserver_Configuration_Reference

set htscfgsection "ns/server/${server}"

set minthreads [ns_config $htscfgsection minthreads 0]
set maxthreads [ns_config $htscfgsection maxthreads 20]
set maxconns [ns_config $htscfgsection maxconnections 100]
set timeout [ns_config $htscfgsection threadtimeout 120]
set spread [ns_config $htscfgsection spread 20]

# ns_pools set default -minthreads $minthreads -maxthreads $maxthreads -maxconns $maxconns -timeout $timeout -spread $spread

# ns_log notice "default hts thread pool: [ns_pools get default]"



### naviserver nytt
ns_section      "ns/fastpath"
ns_param        cache               false     ;# default: false
ns_param        cachemaxsize        10240000  ;# default: 1024*10000
ns_param        cachemaxentry       8192      ;# default: 8192
ns_param        mmap                false     ;# default: false

ns_section     "ns/server/${server}/fastpath"
ns_param        pagedir             $pageroot
#ns_param       serverdir           ""
ns_param        directoryfile       "index.adp index.tcl index.html index.htm"
ns_param        directoryproc       _ns_dirlist
ns_param        directorylisting    fancy    ;# default: simple
#ns_param        directoryadp       dir.adp




#
# ADP (AOLserver Dynamic Page) configuration
#
ns_section ns/server/${server}/adp
ns_param   map           "/*.adp"    ;# Extensions to parse as ADP's
ns_param   map           "/*.xul"
#ns_param   map          "/*.html" ;# Any extension can be mapped
ns_param   enableexpire  false     ;# Set "Expires: now" on all ADP's
ns_param   enabledebug   $debug    ;# Allow Tclpro debugging with "?debug"
ns_param   defaultparser fancy
#ns_param   GlobalInclude true

ns_section ns/server/${server}/adp/parsers
ns_param   fancy	".adp"

#
# Socket driver module (HTTP)  -- nssock
#
ns_section ns/server/${server}/module/nssock
ns_param   timeout            120
ns_param   address            $address
ns_param   hostname           $hostname
ns_param   port               $httpport

# ns_section  ns/server/${server}/module/nsunix
# ns_param    hostname              hugtakasafn.utn.stjr.is
# ns_param    socketfile            hugtakasafn.nsunix

#
# Socket driver module (HTTPS) -- nsssl
#
#  nsssl does not load unless sslkeyfile/sslcertfile exist (above).
#
# ns_section ns/server/${server}/module/nsssl
# ns_param   port        $httpsport
# ns_param   hostname    $hostname
# ns_param   address     $address
# ns_param   keyfile     $sslkeyfile
# ns_param   certfile    $sslcertfile


set db_user_account         hugtakasafn

ns_section "ns/db/drivers"
ns_param postgres nsdbpg.so

#ns_section "ns/db/pools"
#ns_param main "SjalfgefinnDBpollur"

ns_section ns/db/pools
    ns_param   pool1              "Pool 1"
    ns_param   pool2              "Pool 2"
    ns_param   pool3              "Pool 3"

ns_section ns/db/pool/pool1
    ns_param   maxidle            1000000000
    ns_param   maxopen            1000000000
    ns_param   connections        5
    ns_param   extendedtableinfo  true
    ns_param   driver             postgres
    ns_param   datasource         postgres::${db_name}
    ns_param   user               $db_user_account

ns_section ns/db/pool/pool2
    ns_param   maxidle            1000000000
    ns_param   maxopen            1000000000
    ns_param   connections        5
    ns_param   extendedtableinfo  true
    ns_param   driver             postgres
    ns_param   datasource         postgres::${db_name}
    ns_param   user               $db_user_account

ns_section ns/db/pool/pool3
    ns_param   maxidle            1000000000
    ns_param   maxopen            1000000000
    ns_param   connections        5
    ns_param   extendedtableinfo  true
    ns_param   driver             postgres
    ns_param   datasource         postgres::${db_name}
    ns_param   user               $db_user_account

ns_section ns/server/${server}/db
    ns_param   pools              pool1,pool2,pool3
    ns_param   defaultpool        pool1

#ns_section "ns/db/pool/main"
#ns_param driver postgres
#ns_param connections 5
#ns_param datasource postgres::${db_name}
#ns_param User $db_user_account

#ns_section "ns/server/${server}/db"
#ns_param pools *
#ns_param defaultpool main


ns_section ns/server/${server}/redirects
ns_param   404                "global/file-not-found.html"
ns_param   403                "global/forbidden.html"

#
# Access log -- nslog
#
ns_section ns/server/${server}/module/nslog
ns_param   file                 access.log
ns_param   enablehostnamelookup false
ns_param   logcombined          true
#ns_param   logrefer             false
#ns_param   loguseragent         false
ns_param   maxbackup            365
ns_param   rollday              *
ns_param   rollfmt              %Y-%m-%d-%H:%M
ns_param   rollhour             0
ns_param   rollonsignal         true
ns_param   rolllog              true

#
# nsjava - aolserver module that embeds a java virtual machine.  Needed to
#          support webmail.  See http://nsjava.sourceforge.net for further
#          details. This may need to be updated for OpenACS4 webmail
#

ns_section ns/server/${server}/module/nsjava
ns_param   enablejava         off  ;# Set to on to enable nsjava.
ns_param   verbosejvm         off  ;# Same as command line -debug.
ns_param   loglevel           Notice
ns_param   destroyjvm         off  ;# Destroy jvm on shutdown.
ns_param   disablejitcompiler off
ns_param   classpath          /usr/local/jdk/jdk118_v1/lib/classes.zip:${bindir}/nsjava.jar:${pageroot}/webmail/java/activation.jar:${pageroot}/webmail/java/mail.jar:${pageroot}/webmail/java

#
# CGI interface -- nscgi, if you have legacy stuff. Tcl or ADP files inside
# AOLserver are vastly superior to CGIs. I haven't tested these params but they
# should be right.
#
#ns_section "ns/server/${server}/module/nscgi"
#       ns_param   map "GET  /cgi-bin /web/$server/cgi-bin"
#       ns_param   map "POST /cgi-bin /web/$server/cgi-bin"
#       ns_param   Interps CGIinterps

#ns_section "ns/interps/CGIinterps"
#       ns_param .pl "/usr/bin/perl"

#
# Modules to load
#
ns_section ns/server/${server}/modules
ns_param   nssock          ${bindir}/nssock.so
ns_param   nslog           ${bindir}/nslog.so
###ns_param   nssha1          ${bindir}/nssha1.so
###ns_param   nscache         ${bindir}/nscache.so

# ns_param   nsrewrite       ${bindir}/nsrewrite.so
# ns_param   nsxml           ${bindir}/nsxml.so
#ns_param   nsfts           ${bindir}/nsfts.so
ns_param   nsperm          ${bindir}/nsperm.so
#ns_param   nscgi           ${bindir}/nscgi.so
#ns_param   nsjava          ${bindir}/libnsjava.so
# ns_param   nsunix          ${bindir}/nsunix.so
#ns_param   libtdom         ${bindir}/libtdom0.7.5g.so
# ns_param   libtdom         ${bindir}/libtdom0.8.0.so
###ns_param   libtdom         /usr/local/aolserver45/lib/tdom0.8.0/libtdom0.8.0.so
ns_param nsdb nsdb.so

#
## nsssl: loads only if requisite files already exist (see top of this
# file).
#
# if { [file exists $sslcertfile] && [file exists $sslkeyfile] } {
#     ns_param nsssl ${bindir}/nsssle.so
# } else {
#     ns_log warning "nsd.tcl: nsssl not loaded because key/cert files do not exist."
# }

ns_log notice "hugtakasafn-naviserver4.99.15.tcl: finished reading config file."
