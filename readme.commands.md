## Pasos
Definir la entrada

```
dn: cn=customperson,cn=schema,cn=config
objectClass: olcSchemaConfig
cn: customperson
olcAttributeTypes: ( 1.3.6.1.4.1.37505.1.150
        NAME 'miNombre'
        EQUALITY caseIgnoreMatch
        SUBSTR caseIgnoreSubstringsMatch
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcAttributeTypes: ( 1.3.6.1.4.1.37505.1.151
        NAME 'miApellido'
        EQUALITY caseIgnoreMatch
        SUBSTR caseIgnoreSubstringsMatch
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcObjectClasses: ( 1.3.6.1.4.1.37505.1.6
    NAME 'customperson'
    DESC 'customperson'
    SUP inetOrgPerson
    STRUCTURAL
    MAY  ( miNombre $ miApellido )
 )
```

Ejecutar el comando ldapadd 

```
docker exec -it ldap slapcat -b "dc=abexa,dc=pe"
docker exec -it ldap slapcat -b "dc=abexa,dc=pe"
docker exec -it ldap slapcat -b "cn=config"
docker exec -it ldap ldapadd -Y EXTERNAL -H ldapi:// -f /ldap-data/schemas/custom/person.ldif
docker exec -it ldap slapcat -b "cn=config"
```

## revisar la configuración
```
docker exec -it ldap slapcat -b "cn=config"
        
        dn: cn={9}customperson,cn=schema,cn=config
        objectClass: olcSchemaConfig
        cn: {9}customperson

```

## Agregar un parámetro más

Se crea el fichero ldif que contenga los nuevos atributos, tener en cuenta ya haber identificado el número del cn{XX}

```ldif
dn: cn={9}customperson,cn=schema,cn=config
changetype: modify
add: olcAttributeTypes
olcAttributeTypes: ( 1.3.6.1.4.1.37505.1.153
        NAME 'miCalle'
        EQUALITY caseIgnoreMatch
        SUBSTR caseIgnoreSubstringsMatch
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )

dn: cn={9}customperson,cn=schema,cn=config
changetype: modify
replace: olcObjectClasses
olcObjectClasses: ( 1.3.6.1.4.1.37505.1.6
    NAME 'customperson'
    DESC 'customperson'
    SUP inetOrgPerson
    STRUCTURAL
    MAY  ( miNombre $ miApellido $ miDistrito $ miCalle)
 )
```

docker exec -it my_ldap ldapmodify -Y EXTERNAL -H ldapi:/// -f /ldap-data/schemas/custom/update_person_full_3.ldif