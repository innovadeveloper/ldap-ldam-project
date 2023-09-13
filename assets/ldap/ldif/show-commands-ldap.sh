#!/bin/bash
echo "# filtros de entradas :
ldapsearch -x -H ldap://localhost:389 -b dc=abexa,dc=pe"
echo "# volcar la data de ldap :
slapcat"
echo "# generate password SSHA :
lappasswd -s admin"
echo "# aplicar LDIF :
ldapadd -x -H ldap://localhost:389 -D "cn=admin,dc=abexa,dc=pe" -W -f /home/admin.ldif"
echo "# cambiar la contraseña :
ldappasswd -H ldap://server_domain_or_IP -x -D "cn=admin,dc=example,dc=com" -W -S "uid=bob,ou=people,dc=example,dc=com""
echo "# exportar data :
ldapsearch -x -H ldap://localhost:389 -D "cn=admin,dc=abexa,dc=pe" -W -b "dc=abexa,dc=pe" \"(objectClass=*)\" > all-entries.ldif
#importar data :
ldapadd -x -H ldap://localhost:389 -D "cn=admin,dc=abexa,dc=pe" -W -f all-entries.ldif
"
