# Centos 7. Обновление ядра
--------------------------------

### Vagrantfile

Файл загружает образ из персонального публичного репозитория.
```
  config.vm.box = "Svetozar/centos-7-5"
  config.vm.box_version = "1.0"
  
```

### Packer

**/packer/centos-v2.json** - файл описания из которого собирался образ **centos-7-5**

**/packer/scripts/\*** - набор скриптов для пост сборки образа