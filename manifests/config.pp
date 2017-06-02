# == Class: openswan::config
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Authors
#
# Ayoub Elhamdani <a.elhamdani90@gmail.com>
#
class openswan::config(
  $nat_traversal            = $openswan::params::nat_traversal,
  $virtual_private          = $openswan::params::virtual_private,
  $opportunistic_encryption = $openswan::params::opportunistic_encryption,
  $protostack               = $openswan::params::protostack,
  $uniqueids                = $openswan::params::uniqueids,
  $ipsec_conf               = $openswan::params::ipsec_conf,
  $ipsec_secrets_conf       = $openswan::params::ipsec_secrets_conf,
  $connections_dir          = $openswan::params::connections_dir,
  $secrets_dir              = $openswan::params::secrets_dir
) {

  file { $openswan::ipsec_conf:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('openswan/ipsec.erb'),
  }
  file { $openswan::connections_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0744',
    force  => true,
  }

  file { $openswan::ipsec_secrets_conf:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('openswan/ipsec.secrets.erb'),
  }

  if ! defined (File[$openswan::secrets_dir]) {

    file {$openswan::secrets_dir:
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0744',
      force  => true,
    }

  }

}
