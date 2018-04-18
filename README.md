# Push notification to offline user

This is to send push notification to offline user via using rest api

## Getting Started

Clone this repo and follow the installation steps. This has been testes with ejabberd-17.04

### Prerequisites

```
You need to have ejabberd-17.04 working.
```

### Installing

follow the steps to get a development env running

```
1.Clone the repo
2.sudo erlc -I /usr/local/lib/ejabberd-17.04/include/ mod_ejabberd_offline_push.erl
3.sudo rm -f /usr/local/lib/ejabberd-17.04/ebin/mod_ejabberd_offline_push.beam
4.sudo mv mod_ejabberd_offline_push.beam /usr/local/lib/ejabberd-17.04/ebin
5.Add mod change in yml file path in /usr/local/etc/ejabberd 
6.mod_ejabberd_offline_push: {}
7.sudo ejabberdctl  restart
```




## Authors

* **Jitendra Pathak**
