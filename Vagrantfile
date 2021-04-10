# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Notes:
#   - Provisioning commands are run as "root"
#   - File provisioner is ran as "vagrant"

Vagrant.configure('2') do |config|
  config.vm.define :sandbox do |sandbox|
    # https://app.vagrantup.com/archlinux/boxes/archlinux
    sandbox.vm.box = 'archlinux/archlinux'
    config.vm.box_version = '20210401.18564'

    sandbox.vm.host_name = 'sandbox'
    sandbox.vm.provider 'virtualbox' do |vb|
      vb.memory = '2048'
      vb.cpus = 1
      vb.name = 'minion'
    end

    # Salt masterless
    sandbox.vm.synced_folder './salt/roots/', '/srv/salt/'
    sandbox.vm.synced_folder './salt/pillars/', '/srv/pillar/'

    # Install salt and upload minion config
    sandbox.vm.provision 'file', source: './salt/minion', destination: '/tmp/minion'
    sandbox.vm.provision 'shell', path: './scripts/sandbox.sh'
  end
end
