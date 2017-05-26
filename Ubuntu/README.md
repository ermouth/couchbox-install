Компоненты
----------

 - CouchDB
 - Redis
 - Nginx
 - NodeJs
 - UFW
 - Couchbox

Порядок установки
-----------------

 1. Изменить параметры в файле *config.sh*
 2. Изменить настройки Nginx в файле *nginx.conf*
 3. Изменить настройки CouchBox в файле *couchbox.json*
 4. Загрузить файлы на сервер и запустить

``` bash
ssh root@server
cd /tmp
git clone git@gitlab.com:Couchbox/install.git couchbox_install
cd /tmp/couchbox_install
sh install.sh
```

После установки Couchbox будет доступен по адресу https://server:6984