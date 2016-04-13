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
 
 
 
