# Vault
## Decrypt a single secret
```
echo '$ANSIBLE_VAULT;1.1;AES256
62303333633932333833363837376365366465636466373433326630663634376461666135633039
6266383335653333616263316230326164353632383161310a306437653362383436643565336663
62643037376439306431343935656132643964343766653465373933363262376565353561326231
3432343937313639630a343131303535633737313563623337636163383739393933373663396665
62323734353634356462326237373931623735663739323064393133386366333230' | ansible-vault decrypt /dev/stdin --output=/dev/stderr > /dev/null
```