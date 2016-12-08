require 'spec_helper'

describe 'marmoset', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'the marmoset module on all systems' do
        describe 'with default params' do
          it { is_expected.not_to compile.with_all_deps }
        end
        describe 'with needed params' do
          let :params do
            {
              sourcerepo: 'https://github.com/virtapi/installimage.git',
              ldap_bind_dn: 'foo',
              ldap_password: 'test',
              ldap_client_base_dn: 'giggle',
              auth_password: 'derp'
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('marmoset::install') }
          it { is_expected.to contain_class('marmoset::config') }
          it { is_expected.to contain_class('marmoset::service') }
          it { is_expected.to contain_package('libvirt') }
          it { is_expected.to contain_service('marmoset') }
          it { is_expected.to contain_user('marmoset') }
          it { is_expected.to contain_python__pyvenv('/home/marmoset/marmoset/venv') }
          it { is_expected.to contain_python__requirements('/home/marmoset/marmoset/requirements.txt') }
          it { is_expected.to contain_systemd__unit_file('marmoset.service') }
          it { is_expected.to contain_vcsrepo('/home/marmoset/marmoset') }
          it { is_expected.to contain_file('/home/marmoset/marmoset/marmoset.conf') }
        end
      end
    end
  end
end
