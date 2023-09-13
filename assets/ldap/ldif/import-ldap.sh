#!/bin/bash

ldapadd -x -H ldap://localhost:389 -D "cn=admin,dc=abexa,dc=pe" -W -f all-entries.ldif
