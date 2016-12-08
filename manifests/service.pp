# @api private
# This class handles the marmoset service. Avoid modifying private classes.
class marmoset::service inherits marmoset {

  assert_private("You're calling a private class, you're not supposed to do this")

  service{'marmoset':
    ensure => 'running',
    enable => true,
  }
}
