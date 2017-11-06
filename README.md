# Fedora LXDE 1Cv8.3 XRDP server #
Установленные пакеты: 
Firefox 
WPS Office 10.1.0 
1Cv8.3.10-2650 #

Пользователи создаются в файле /root/createusers.txt вида mickey:mouse:Y где имя:пароль:входит ли в sudo, понимается только Y
Пример запуска #
docker run -d --name fedora-rdp \
           -p 3389:3389 \
           -v /home/docker/rdp/home/:/home \
           -dit --restart unless-stopped \
           a4neg/fedora-rdp:latest

Собирается командой ci/build