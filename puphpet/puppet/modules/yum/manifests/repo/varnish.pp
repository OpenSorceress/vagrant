# = Class: yum::repo::varnish
#
# This class installs the varnish 3.0 repo
#
class yum::repo::varnish {

  yum::managed_yumrepo { 'varnish':
    descr          => 'Varnish 3.0 for Enterprise Linux 5 - $basearch',
    baseurl        => 'http://repo.varnish-cache.org/redhat/varnish-3.0/el5/$basearch',
    enabled        => 1,
    gpgcheck       => 0,
    failovermethod => 'priority',
    # gpgkey       => 'http://yum.theforeman.org/RPM-GPG-KEY-VARNISH',
    priority       => 26,
  }

}
2014-09-07 02:18:05 +0000 Puppet (err): Unable to set ownership of log file
2014-09-07 02:36:05 +0000 Puppet (err): Could not run: Input/output error - <STDIN>
