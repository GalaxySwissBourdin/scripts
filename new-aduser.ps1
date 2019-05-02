$util=import-csv -delimiter ";" -path "C:\liste.csv"

foreach ($user in $util)

{
echo "salarie: $user"
$login=$user.prenom+"."+$user.nom
$mdp="Patate666"
$nom=$user.nom
$prenom=$user.prenom
$OU="OU="+$user.dept+",OU=Utilisateurs,dc=gsb,dc=intra"

echo $login
echo $mdp
echo $nom
echo $prenom
echo $OU

New-ADUser -SamAccountName $login -name "$prenom $nom" -path $OU -AccountPassword (ConvertTo-SecureString $mdp -AsPlainText -Force)

}
pause
