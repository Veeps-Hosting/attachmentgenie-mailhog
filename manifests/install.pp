# == Class mailhog::install
#
# This class is called from mailhog for install.
#

class mailhog::install inherits mailhog {

  # Add user to run mailhog with lower privileges
  user { $mailhog::user:
    ensure => 'present',
    home   => $mailhog::homedir,
    system => true,
  }

  package { 'daemon':
    ensure => present,
  }

  # Download Mailhog binary
  if $mailhog::download_mailhog {

    file { $mailhog::homedir:
      ensure => directory,
    }

    exec { "Download MailHog $mailhog::mailhog_version":
      command => "/usr/bin/curl -o $mailhog::homedir/mailhog-$mailhog::mailhog_version -L $mailhog::download_url",
      require => [Package['curl'], File[$mailhog::homedir]],
      creates => "$mailhog::homedir/mailhog-$mailhog::mailhog_version",
    }

    file { "$mailhog::homedir/mailhog-$mailhog::mailhog_version":
      ensure  => present,
      mode    => '0755',
      require => Exec["Download MailHog $mailhog::mailhog_version"],
      notify  => File[$mailhog::binary_file],
    }

    file { $mailhog::binary_file:
      ensure  => link,
      target  => "$mailhog::homedir/mailhog-$mailhog::mailhog_version",
      require => File["$mailhog::homedir/mailhog-$mailhog::mailhog_version"],
    }

    if ! defined(Package['curl']) {
      package { 'curl':
        ensure => installed,
      }
    }
  }

  # else use binary files located on puppet master.
  else {

    file { "$mailhog::homedir/mailhog-$mailhog::mailhog_version":
      ensure => present,
      mode   => '0755',
      owner  => 'root',
      group  => 'root',
      source => $mailhog::source_file,
      notify => File[$mailhog::binary_file],
    }

    file { $mailhog::binary_file:
      ensure  => link,
      target  => "$mailhog::homedir/mailhog-$mailhog::mailhog_version",
      require => File["$mailhog::homedir/mailhog-$mailhog::mailhog_version"],
    }

  }

  # Deploy mailhog init script
  file { $mailhog::init:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template($mailhog::init_template),
  }

  # Deploy mhsendmail
  file { ['/usr/local/bin/mhsendmail']:
    ensure  => file,
    source  => 'puppet:///modules/mailhog/mhsendmail',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    replace => true,
  }

}
