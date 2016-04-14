##### 作成環境
 - docker-machine version 0.6.0, build e27fb87
 - Docker version 1.10.3
 - docker-compose version 1.6.2

##### イメージビルド

 ```
 $ cd ${PROJECT_ROOT}/docker
 $ bin/run_docker-compose build
 ```

##### コンテナ起動
 
 ```
 $ bin/run_docker-compose up -d
 ```
 
##### webappの起動確認
 `docker ps`でしらべたwebappコンテナのnameが`bin_webapp_1`とすると
 
 ```
 $ docker exec bin_webapp_1 ps aux
 
 USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
 ...略...
www-data    30  8.3 10.6 788064 108556 ?       Sl   22:14   0:31 puma 3.4.0 (unix:///tmp/puma.sock) [data]
root        65  0.0  0.1 124520  1392 ?        Ss   22:15   0:00 nginx: master process /usr/sbin/nginx
 ...略...
 ```
 
 で、`puma`と`nginx`のプロセスが起動すれば起動完了
 
 対象のdocker hostのipアドレス(docker-machineならvmのipアドレスnativeならlocalhost)から`http://${docker_host_ip}`にアクセスしてrailsのトップページが表示されればOK
 
 webappコンテナの初回起動時に`bundle install`で`gem`をインストールするので時間がかかります。
 
 
##### *注意*
   development環境では通常controllerやmodelなどを変更してもrailsがファイルの変更を検知して、auto reloadしてくれるが、virtual box上のshared folderを経由してdocker-machineを使用している場合、ファイルの変更イベントが取れないため(shared folderの仕様らしい)その仕組を利用しているrailsのauto reloadも効かない。

   そのため、`config/environments/development.rb`で`config.file_watcher`にデフォルトで設定されている`ActiveSupport::EventedFileUpdateChecker`ではなく、polling形式でファイルの変更を検知する`ActiveSupport::FileUpdateChecker`に変更している。

   ただしdocker-machineのVMの時刻とローカルの時刻が異なっている場合(docker-machineの方が遅れている場合)ファイルの変更検知がやはりうまくいかない(変更日が未来日のファイルは異常とみなして検知対象にならないような処理になっている)ので、その場合はvirtual boxのゲストとホストの時刻同記事のズレのしきい値を低くして対応する。
  
   `docker-machine ssh`でログインして

   ```
   sudo VBoxControl guestproperty set "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold" 5000
   ```

   でゲスト、ホストとのズレが最大５秒になる


