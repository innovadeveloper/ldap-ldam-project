## LDAP commands (Search, Create Records)

more info :
https://www.notion.so/Setup-OpenLDAP-a48603a14c364e4a99d600fd10f0f7d7

```shell
# volcar todas las entradas de la base del directorio (ex : dc=abexa,dc=pe)
docker exec -it ldap slapcat -b "dc=abexa,dc=pe"

# volcar todas las entradas de la configuración de ldap (cn=config)
docker exec -it ldap slapcat -b "cn=config"

# (Caso 1) agregar las definiciones LDIF (esquemas, entradas de usuarios/grupos/o.u.)
docker exec -it ldap ldapadd -Y EXTERNAL -H ldapi:// -f /ldap-data/schemas/wso2is/wso2Person.ldif
    # SASL/EXTERNAL authentication started
    # SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
    # SASL SSF: 0
    # adding new entry "cn=wso2person,cn=schema,cn=config"
# (Caso 2) agregar las definiciones LDIF (esquemas, entradas de usuarios/grupos/o.u.)
docker exec -it ldap ldapadd -Y EXTERNAL -H ldapi:// -f /ldap-data/entries/backup.ldif

# busqueda con ldapsearch
# listar todos los DN de cn=config (directorio de configuraciòn de ldap)
docker exec -it ldap ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config dn

# listar todos los DN de la rama base
docker exec -it ldap ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b "dc=abexa,dc=pe" dn
``` 

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




