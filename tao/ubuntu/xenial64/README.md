Creates a prepacked vagrant base box to use for Tao development.

- Ubuntu Xenial 64 (16.04)
- PHP 7.0
- Apache 2.4
- MySQL 5.7
- Node <latest:8.2.1>


#### Instructions to create a vagrant box

- `$ vagrant init v0rtex/xenial64`
- `$ vagrant up`
- `$ vagrant ssh -c 'source /vagrant/init.sh'`
- `$ vagrant package --output tao-ubuntu-xenial64.box`
- `$ vagrant box add tao/ubuntu/xenial64 tao-ubuntu-xenial64.box`
