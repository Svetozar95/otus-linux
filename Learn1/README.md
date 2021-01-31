# Задачи:

##### Создать свой Box на vagrantup.com с обновленном ядром
##### * Пересобрать ядро из исходников
##### ** Настроить VirtualBox Shared Folders

--------------------------------

##### Цель:Получить навыки работы с Git, Vagrant, Packer и публикацией готовых образов в Vagrant Cloud.
--------------------------------

## Создать свой Box на vagrantup.com с обновленном ядром

Бокс создан

```
  config.vm.box = "Svetozar/centos-7-5"
  config.vm.box_version = "1.0"
```
Проверку можно осуществить через загрузку [Vagrant File](https://github.com/Svetozar95/otus-linux/blob/master/Learn1/kernel-auto-update/Vagrantfile)
```
## Создадим тестовую директорию перейдем в неё
mkdir test; cd test;

## Скачаем готовый Vagrant File 
wget https://github.com/Svetozar95/otus-linux/blob/master/Learn1/kernel-auto-update/Vagrantfile

## Запустим vagrant
vagrant up

## Зайдем на серовер 
vagrant ssh


```

## * Пересобрать ядро из исходников

Для сборки ядра из исходников используем следующий способ


```
# обновляем все пакеты в ситеме после установки
sudo yum -y update

# Устанавливаем необходимое по для сборки
sudo yum groupinstall "Development Tools" -y
sudo yum install -y wget git gcc ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel 

# Скачиваем исходники нужного нам ядра. Распаковываем и переходим в папку исходников
cd /usr/src/
sudo wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.6.1.tar.gz
sudo tar -xvf linux-5.6.1.tar.gz
cd /usr/src/linux-5.6.1/

# Берем настройки текущего ядра системы
sudo cp -v  /boot/config-$(uname -r) /usr/src/linux-5.6.1/.config

# Собираем конфиг
sudo make oldconfig

# СОбираем образ и моудли. Далее - у станавливаем
sudo make bzImage
sudo make modules
sudo make
sudo make install
sudo make modules_install

# Устанавливаем версию по умолчанию
sed -i 's/.*GRUB_DEFAULT*.*/GRUB_DEFAULT=0/'  /etc/default/grub

# Обновляем Grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Удаляем старое ядро(ядра) из системы (Only for demo! Not Production!)
rm -f /boot/*3.10*

# Перезапускаем систему
sudo  shutdown -r now
```

## ** Настроить VirtualBox Shared Folders


