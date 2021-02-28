# Домашнее задание
на имеющемся образе
/dev/mapper/VolGroup00-LogVol00 38G 738M 37G 2% /

* уменьшить том под / до 8G
* выделить том под /home
* выделить том под /var
* /var - сделать в mirror
* /home - сделать том для снэпшотов
* прописать монтирование в fstab
* попробовать с разными опциями и разными файловыми системами ( на выбор)
* - сгенерить файлы в /home/
* - снять снэпшот
* - удалить часть файлов
* - восстановится со снэпшота
* - залоггировать работу можно с помощью утилиты script

* *на нашей куче дисков попробовать поставить btrfs/zfs - с кешем, снэпшотами - разметить здесь каталог /opt

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