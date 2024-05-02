# Проектная работа
# Тема: Автоматизация установки и настройки серверов: резервного копирования, мониторинга, логирования, баз данных, с помощью vagrant и ansible

***Веб проект с развертыванием нескольких виртуальных машин***

Проект состоит из 5 виртуальных машин: zabbix, inetrout, postgres, backup, rsyslog

IP-адресация ВМ </br>
zabbix - 192.168.50.11 </br>
inetrout - 192.168.50.15 </br>
postgres - 192.168.50.10 </br>
backup - 192.168.50.13 </br>
rsyslog - 192.168.50.12 </br>

В системе используется вымышленное доменное имя PRO.RU

Посмотреть скриншоты по конечной настройке в веб интерфесе каждой системы можно <a href="https://github.com/movik242/project/tree/main/inetrout/inetrout/files/site">здесь</a>, либо после установки по адресу https://192.168.50.15  

Inetrout - шлюз, на сервере настроен iptables, для остальные ВМ выход в сеть интернет настроен через этот шлюз.

Postgres - база данных, при развертывании устанавливается и настраиваться база данных zabbix. Для подключения и настройки, можно воспользоваться pgadmin:

логин pgadmin: movik242@pro.ru </br>
пароль pgadmin: movik242 </br>
имя БД: zabbix </br>
логин БД: zabbix </br>
пароль БД: admin </br>

Zabbix - система по сбору метрик, для подключения к БД используются следующие данные:

имя БД: zabbix </br>
логин БД: zabbix </br>
пароль БД: admin </br>
логин для zabbix: Admin </br>
пароль zabbix: zabbix </br>

Rsyslog - система по сбору логов, представлена в виде веб интерфейса loganalyzer:

имя БД loganalyzer: loganalyzer </br>
логин БД loganalyzer: logan </br>
пароль БД loganalyzer: admin </br>
Username шаг 6: <Ваш пользователь> </br>
Password шаг 6: <Ваш пароль> </br>
Source Type шаг 7 : MYSQL natuve </br>
Имя БД шаг 7: rsyslog </br>
Имя таблицы шаг 7: SystemEvents (ВАЖНО: первые буквы заглавные) </br>
User БД: rsyslog </br>
пароль БД: admin </br>

Backup - система бекапа, в каждой ВМ настроен сервис и таймер для бекапа папки etc (для примера), по аналогии в файл сервиса можно добавить другие папки и файлы

Войти на сервер по ssh можно только через сервер inetrout - шлюз. Вход на сервер backup организован по ssh по ключу под borg (пример: ssh borg@backup) </br>
В ВМ backup создается диск LVM объемом 5Гб и монтируется в папку /opt/backup/
Чтобы создать первый бэкап, требуется зайти, на каждую ВМ и выполнить следующие команды (для каждой ВМ свой путь бэкапа)

      sudo borg init -e none borg@backup:/opt/backup/inetrout (либо zabbix, либо rsyslogsrv, или др.)
      sudo borg create -C zstd borg@backup:/opt/backup/inetrout::etc-$(date +%%Y%%m%%d_%%H%%M%%S) /etc


Алертинг настраивается в системе zabbix, далее на скриншотах показана настройка и результат

![image](https://github.com/movik242/project/assets/143793993/17bb0bc3-b6c2-40fa-9182-63feca4000d5)


![image](https://github.com/movik242/project/assets/143793993/b6135aea-f4fe-4757-a555-230a04ef39e6)

При отключении сети, сработал алерт на Ping

![image](https://github.com/movik242/project/assets/143793993/41d5efaf-9c7e-406b-89f3-508c47a2bec6)


![image](https://github.com/movik242/project/assets/143793993/e8896eb3-2d53-4733-862a-049a21a1adb9)

