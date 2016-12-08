node ('linux') {

     checkout scm

     stage 'Try bundle'
     sh 'ls -la'
     sh '/usr/local/bin/bundle -v'

     stage 'Build Image'
     sh 'docker build -t rubyspectests .'

     stage 'Build Sourcecode'
     //withDockerContainer('rubyspectests', '-v /var/lib/jenkins/.ssh:/home/rspecdude/.ssh:ro') {
     docker.image('rubyspectests').inside('-v /var/lib/jenkins/.ssh:/home/rspecdude/.ssh:ro') {
            stage 'setup dependencies'
            sh '''
              export http_proxy=http://proxy.hosteurope.de:3128
              export https_proxy=http://proxy.hosteurope.de:3128
              /usr/local/bin/bundle install --without system_tests development --path .vendor
              /usr/local/bin/bundle update
            '''

            stage 'execute spec tests'
            sh """
              export STRICT_VARIABLES="yes"
              /usr/local/bin/bundle exec rake spec_clean
              /usr/local/bin/bundle exec rake test --trace
            """

            stage 'rubocop'
            sh '/usr/local/bin/bundle exec rake rubocop'

            stage 'build the module'
            sh '/usr/local/bin/bundle exec rake build'
     }

//     stage 'acceptance testing with docker'
//     sh """
//     export http_proxy=http://proxy.hosteurope.de:3128
//     export https_proxy=http://proxy.hosteurope.de:3128
//     rm -rf .vendor/
//     rm -rf Gemfile.lock
//     /usr/local/bin/bundle install --path .vendor --with system_tests
//     BEAKER_debug=true BEAKER_set=docker/ubuntu-14.04 PUPPET_INSTALL_TYPE=agent PUPPET_INSTALL_VERSION=1.5.1 /usr/local/bin/bundle exec rake acceptance
//     """
}
