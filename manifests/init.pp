class marmoset (
  String $ldap_bind_dn,
  String $ldap_password,
  String $ldap_client_base_dn,
  String $auth_password,
  Optional[String] $http_proxy = undef,
  String $sourcerepo           = 'https://github.com/virtapi/marmoset.git',
  String $servername           = $::fqdn,
  Integer $port                = 5000,
  String $host                 = $facts['network_primary_ip'],
  String $ldap_server          = 'localhost',
  Integer $ldap_port           = 389,
  String $username             = 'marmoset',
  String $groupname            = 'marmoset',
  String $auth_username        = 'youwontguessthis',
  String $home                 = "/home/${username}",
  String $vcsrepo              = "${home}/marmoset",
  String $pyvenv               = "${vcsrepo}/venv",
  String $requirements         = "${vcsrepo}/requirements.txt",
  Boolean $manage_python       = true,
) {

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues

  contain ::marmoset::install
  contain ::marmoset::config
  contain ::marmoset::service

  Class['::marmoset::install']
  -> Class['::marmoset::config']
  ~> Class['::marmoset::service']
}
