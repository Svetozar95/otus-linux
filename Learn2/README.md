# Задачи:

##### Домашнее задание, основное
* Работа с mdadm
* добавить в Vagrantfile еще дисков
* сломать/починить raid
* собрать R0/R5/R10 на выбор
* прописать собранный рейд в конф, чтобы рейд собирался при загрузке
* создать GPT раздел и 5 партиций

##### * Задания со звездочкой
* доп. задание - Vagrantfile, который сразу собирает систему с подключенным рейдом
** перенесети работающую систему с одним диском на RAID 1. Даунтайм на загрузку с нового диска предполагается. В качестве проверики принимается вывод команды lsblk до и после и описание хода решения (можно воспользовать утилитой Script).
Критерии оценки: Статус "Принято" ставится при выполнении следующего условия:
- сдан Vagrantfile и скрипт для сборки, который можно запустить на поднятом образе

--------------------------------

## Выполняем задание

##### Подготовим Vagrant файл для использования
```
mkdir -p vagrant/home2
cd vagrant/home2
## скачиваем вагрант файл из первой лекции (начального стенда)
wget  https://raw.githubusercontent.com/Svetozar95/otus-linux/master/Vagrantfile
```


В соответсвии с методичеким ууказания добавим ещё дисков в нашу тестовую среду. Добавим пару, почему нет....

```
 :sata5 => {
                    :dfile => './sata5.vdi',
                    :size => 250, # Megabytes
                    :port => 5
                }, 
 :sata6 => {
                    :dfile => './sata6.vdi',
                    :size => 250, # Megabytes
                    :port => 6
                }                
```

Запустим наш тестовый стенд и поптаемся выполнить задание

```
#windows wsl 2.0 + vagrant.exe
vagrant.exe up

#Linux
vagrant up
```

Станем root для удобства работы
```
[vagrant@localhost ~]$ sudo bash
[root@localhost vagrant]#
```

Доустановим софт, который не установился из секции  в дефолтном Vagrant файле
```
[root@localhost vagrant]# yum install -y mdadm smartmontools hdparm gdisk
```

Посмотрим, все ли дсики на месте
```
[root@localhost vagrant]# lshw -short | grep disk
/0/100/1.1/0.0.0    /dev/sda   disk        42GB VBOX HARDDISK
/0/100/d/0          /dev/sdb   disk        262MB VBOX HARDDISK
/0/100/d/1          /dev/sdc   disk        262MB VBOX HARDDISK
/0/100/d/2          /dev/sdd   disk        262MB VBOX HARDDISK
/0/100/d/3          /dev/sde   disk        262MB VBOX HARDDISK
/0/100/d/4          /dev/sdf   disk        262MB VBOX HARDDISK
/0/100/d/5          /dev/sdg   disk        262MB VBOX HARDDISK
```

Занулим на всāкий слуùай суперблоки:
```[root@localhost vagrant]$ mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}```

Создадим Raid 6
```
[root@localhost vagrant]# mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f}
mdadm: layout defaults to left-symmetric
mdadm: layout defaults to left-symmetric
mdadm: chunk size defaults to 512K
mdadm: size set to 253952K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.

```

Убедимся что рейд создан корректно

```
[root@localhost vagrant]# cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4]
md0 : active raid6 sdf[4] sde[3] sdd[2] sdc[1] sdb[0]
      761856 blocks super 1.2 level 6, 512k chunk, algorithm 2 [5/5] [UUUUU]
      ```



