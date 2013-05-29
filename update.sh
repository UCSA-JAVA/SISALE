#/bin/bash
git pull https://github.com/UCSA-JAVA/SISALE.git master
git add *
echo 'Introduzca un comentario para el commit, debe ser distinto a ACTUALIZACION'
read var
git commit -m "'".$var."''"
git push -u origin master
