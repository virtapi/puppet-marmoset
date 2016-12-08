# @api private
# This class handles the virtualenv + deps + marmoset itself. Avoid modifying private classes.
class marmoset::install inherits marmoset {

  assert_private("You're calling a private class, you're not supposed to do this")

  if $marmoset::manage_python {
    class{'::python':
      version    => 'system',
      virtualenv => true,
    }
  }
  package{'libvirt':
    ensure => present,
  }
  -> user{$marmoset::username:
    home           => $marmoset::home,
    shell          => '/bin/bash',
    managehome     => true,
    purge_ssh_keys => true,
  }
  -> vcsrepo{$marmoset::vcsrepo:
    ensure   => 'present',
    provider => 'git',
    source   => $marmoset::sourcerepo,
    owner    => $marmoset::username,
    user     => $marmoset::username,
  }
  -> python::pyvenv{$marmoset::pyvenv:
    ensure => present,
    owner  => $marmoset::username,
    group  => $marmoset::groupname,
  }
  -> python::requirements{$marmoset::requirements:
    virtualenv             => $marmoset::pyvenv,
    owner                  => $marmoset::username,
    group                  => $marmoset::groupname,
    proxy                  => $marmoset::http_proxy,
    fix_requirements_owner => false,
    forceupdate            => true,
  }
  systemd::unit_file{'marmoset.service':
    content => epp("${module_name}/marmoset.service.epp"),
  }
}
