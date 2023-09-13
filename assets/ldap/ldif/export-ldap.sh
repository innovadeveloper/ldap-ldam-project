#!/bin/bash
ldapsearch -x -H ldap://localhost:389 -D "cn=admin,dc=abexa,dc=pe" -W -b "dc=abexa,dc=pe" "(objectClass=*)" > all-entries.ldif

