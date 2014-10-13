#!/bin/bash
vagrant box add webserver http://images.pontual.taxi.br:8081/debian7.box
vagrant up
vagrant provision
