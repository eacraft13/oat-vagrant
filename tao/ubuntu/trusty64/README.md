Creates a prepacked vagrant base box to use for Tao development.

- Ubuntu Trusty 64 (14.04)
- PHP 7.1
- Apache 2.4
- MySQL 5.5
- NVM & RVM


#### Instructions to create a vagrant box

- `$ vagrant init ubuntu/trusty64`
- `$ vagrant up`
- `$ vagrant ssh -c 'source /vagrant/lib/init.sh'`
- `$ vagrant package --output tao-ubuntu-trusty64.box`
- `$ vagrant box add tao/ubuntu/trusty64 tao-ubuntu-trusty64.box`
