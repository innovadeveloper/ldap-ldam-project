## LDAP commands (Search, Create Records)
´´´shell
# filtros
ldapsearch -x -H ldap://localhost:389 -b dc=abexa,dc=pe
ldapsearch -x -H ldap://localhost:389 -b dc=abexa,dc=pe -D "cn=admin,dc=rahasak,dc=com" -w rahasak
# Extraer contenido de la base de datos LDAP y volcarlo en formato LDIF
slapcat
´´´


´´´shell 
# generar una clave hash segura en formato SSHA
slappasswd -s admin
> {SSHA}v8zpqmgAULvUZXE+HWiDMNRwHCDB0s2j

# crear una entrada con el siguiente valor para el usuario admin (file : admin-user.ldif)
dn: cn=admin,dc=abexa,dc=pe
objectClass: organizationalRole
objectClass: simpleSecurityObject
cn: admin
userPassword: {SSHA}v8zpqmgAULvUZXE+HWiDMNRwHCDB0s2j

# aplicar el ldif (solicitarà password de LDAP, ver 'LDAP_ADMIN_PASSWORD' de docker-compose)
ldapadd -x -H ldap://localhost:389 -D "cn=admin,dc=abexa,dc=pe" -W -f /home/admin.ldif

ldapadd -x -H ldap://localhost:389 -D "cn=admin,dc=abexa,dc=pe" -W -f /home/all-data.ldif

ldapadd -x -H ldap://localhost:389 -D "cn=admin,dc=abexa,dc=pe" -W -f all-entries.ldif

´´´
more info : https://medium.com/rahasak/deploy-ldap-directory-service-with-openldap-docker-8d9f438f1216
more info (2) : https://www.digitalocean.com/community/tutorials/how-to-change-account-passwords-on-an-openldap-server


# actualizar/modificar contraseña de registro admin
´´´shell
 > Sintaxis : ldappasswd -H ldap://server_domain_or_IP -x -D "cn=admin,dc=example,dc=com" -W -S "uid=bob,ou=people,dc=example,dc=com"
 > Ejemplo : ldappasswd -H ldap://localhost:389 -x -D "cn=admin,dc=abexa,dc=pe" -W -S "cn=admin,dc=abexa,dc=pe"
´´´


# Configuraciòn del PERFIL en LAM
- Ingresar a la siguiente URL : http://localhost:8080/
- Crear el perfil del usuario admin de LDAP para LAM -> LAM Configuration > "Edit server profiles"
- Ingresar los siguientes datos en los siguientes paneles :
    - General Settings :
        - Server Settings :
            - Server Address : ldap://192.168.1.130:389
            - Tree Suffix : dc=abexa,dc=pe
        - Security settings : 
            - List of valid users : cn=admin,dc=abexa,dc=pe
    - Account Types :
        - Active account types :
            - Users
                - LDAP suffix : ou=users,dc=abexa,dc=pe
            - Groups
                - LDAP suffix : ou=group,dc=abexa,dc=pe
# Configuraciòn del PERFIL en LAM
- Iniciamos sesión en LAM : http://localhost:8080/templates/login.php
- Ir al panel Tree View y crear las unidades organizativas (users, group) faltantes : 
    - (Navegar) http://localhost:8080/templates/tree/treeViewContainer.php
        - Click en "Create new entry here" y marcar "Generic: Organisational Unit"
            - Organisational Unit : group
            - Organisational Unit : users




