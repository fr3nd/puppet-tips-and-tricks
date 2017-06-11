%title: Puppet Barcelona: Puppet tips and tricks
%author: Carles Amigó
%date: 2017-06-10

-> Puppet tips and tricks <-
============================

-> *Less known but useful Puppet commands and features* <-

-> Barcelona 2017-06-27 <-

-------------------------------------------------

-> Hello! <-
==============

* Sysadmin since 2000
* Using Puppet since 2009
* Past: Sysadmin at Aedgency, Softonic, Nokia, SocialPoint
* Now: Systems manager at *Rakuten Wuaki TV*
* Contact me: *_https://fr3nd.net_*

-------------------------------------------------

-> Puppet commandline <-
========================

Everybody knows how to run `puppet apply` or `puppet agent` from the
commandline, but there are more less known commands.

-------------------------------------------------

-> puppet describe <-
=====================

Prints help about Puppet resource types, providers, and metaparameters.

    puppet describe --list
    puppet describe mount
    puppet describe file

-------------------------------------------------

-> puppet resource <-
=====================

Uses the Puppet RAL to directly interact with the system.

    puppet resource user
    puppet resource user fr3nd ensure=present
    puppet resource user fr3nd shell=/bin/sh
    puppet resource mount
    puppet resource service
    puppet resource cron puppet_run hour=0 command="/opt/puppetlabs/bin/puppet agent -t"

-------------------------------------------------

-> puppet facts <-
==================

Retrieve a node's facts.

    puppet facts
    puppet facts --render-as yaml
    puppet facts | jq '.'
    puppet facts | jq '.values.mountpoints."/".size'
    facter mountpoints./.size
    facter networking.interfaces.eth0.ip

-------------------------------------------------

-> puppet apply <-
==================

Applies a standalone Puppet manifest to the local system.

    puppet apply -e "notice('foobar')"
    puppet apply -e "service {'postfix': ensure => stopped }"
    puppet apply -e "service {'postfix': ensure => running }"
    puppet apply --detailed-exitcodes /vagrant/ntp.pp

## Exit codes
  * *0* Success. No changes
  * *1* Failed.
  * *2* Success. Resources changed.
  * *4* Success. Some resources failed.
  * *6* Success. Resources changed. Some resources failed

-------------------------------------------------

-> Structured and executable facts <-
==================

* "Regular" facts in modules `module_name/lib/facter`
* Structured facts
  * json
  * yaml
  * txt
* Executable facts
  * Shell
  * Python
  * ...
* Locations
  * `module_name/lib/facts.d`
  * `/etc/facter/facts.d/`

    facter json_fact
    facter yaml_fact
    facter bash_fact
    facter py_fact
    facter fortune

-------------------------------------------------

-> Puppet graph <-
==================

Generate a graph of the resources and relationships in the catalog.

* Graphs are stored in `/opt/puppetlabs/puppet/cache/state/graphs/` in Graphviz format.

    puppet apply /vagrant/ntp.pp --graph
    dot -Tsvg /opt/puppetlabs/puppet/cache/state/graphs/relationships.dot > relationships.svg

-------------------------------------------------

-> Bonus: Puppet module generate <-
===================================

Generate boilerplate for a new module.

    puppet module generate

-------------------------------------------------

-> Q&A <-
=========

-> ┏━┓╻ ╻┏━╸┏━┓╺┳╸╻┏━┓┏┓╻┏━┓┏━┓ <-
-> ┃┓┃┃ ┃┣╸ ┗━┓ ┃ ┃┃ ┃┃┗┫┗━┓ ╺┛ <-
-> ┗┻┛┗━┛┗━╸┗━┛ ╹ ╹┗━┛╹ ╹┗━┛ ╹  <-

-------------------------------------------------

-> 🙏 <-

-> ╺┳╸╻ ╻┏━┓┏┓╻╻┏    ╻ ╻┏━┓╻ ╻╻ <-
->  ┃ ┣━┫┣━┫┃┗┫┣┻┓   ┗┳┛┃ ┃┃ ┃╹ <-
->  ╹ ╹ ╹╹ ╹╹ ╹╹ ╹    ╹ ┗━┛┗━┛╹ <-

-> Slides and code available here: <-
-> *_https://github.com/fr3nd/puppet-tips-and-tricks/_* <-
