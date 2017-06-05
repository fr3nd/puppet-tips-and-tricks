package { 'ntp':
  ensure => installed,
}

service { 'ntpd':
  ensure  => running,
  enable  => true,
  require => Package['ntp'],
}

$ntp_config = @(END)
  driftfile /var/lib/ntp/drift
  restrict default nomodify notrap nopeer noquery
  restrict 127.0.0.1
  restrict ::1
  server 0.centos.pool.ntp.org iburst
  server 1.centos.pool.ntp.org iburst
  server 2.centos.pool.ntp.org iburst
  server 3.centos.pool.ntp.org iburst
  includefile /etc/ntp/crypto/pw
  keys /etc/ntp/keys
  | END

file { '/etc/ntp.conf':
  ensure  => present,
  content => $ntp_config,
  require => Package['ntp'],
  notify  => Service['ntpd'],
}
