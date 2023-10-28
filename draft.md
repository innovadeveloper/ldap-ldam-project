# comandos de hv

docker exec -it vaultserver vault login -address=http://127.0.0.1:8200 hvs.CAESIMdPDh1yfqC1elF_VdQu_oNvzZF9OeqocOndgi3SpHDpGh4KHGh2cy4yWUVPUHJ6dGpxVUpldWlycENDbFRURXM
docker exec -it vaultserver vault login -address=http://127.0.0.1:8200 hvs.HJKVj9n2d4YVpofzJ3uviONp


Listar polìticas


docker exec -it vaultserver vault 

docker exec -it vaultserver vault policy list

Seteo de polìticas
docker exec -it vaultserver vault write auth/ldap/groups/developers policies=admin,root

Login con LDAP
docker exec -it vaultserver vault login -method=ldap username=kbaltazar password=kbaltazar

Ver informaciòn de polìtica 
docker exec -it vaultserver vault policy read xtu-mobile-setup-webapi
