# @api private
# This class handles the configuration file. Avoid modifying private classes.
class marmoset::config inherits marmoset {

  assert_private("You're calling a private class, you're not supposed to do this")

  # on a long term view it would be cool to use ini_setting
  # right now not possible because there isn't a default config that we can modify
  # we've to wait with this until we have a proper package for marmoset
  #Ini_setting {
  #  ensure => present,
  #  path   => "$marmoset::vcsrepo/marmoset.conf",
  #}
  file{"${marmoset::vcsrepo}/marmoset.conf":
    content => epp("${module_name}/marmoset.conf.epp"),
  }
}
