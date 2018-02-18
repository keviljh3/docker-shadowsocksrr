## ShadowsocksRR docker images.
PS：由于 ShadowsocksR 停止更新，所以此镜像是由后继项目 [ShadowsocksRR](https://github.com/shadowsocksrr/shadowsocksr) 构建（SSRR 完全兼容 SSR）
### 包括的版本：
因为 SSRR 更新缓慢，且一直处于新 dev 分支的代码提交状态，没有必要也无法区分版本。而陆续提交的代码也在不断的进行扩展（例如新增了混淆协议），所以会基于开发中的分支构建镜像。
* akkariiin/dev([Dockerfile](https://github.com/Hentioe/docker-shadowsocksrr/blob/master/Dockerfile))

### 简单启动

```` bash
docker run -ti -d -e TZ=Asia/Shanghai --restart=always --net=host \
--env PASSWORD=${YOUR_PASSWROD} \
--env SERVER_PORT=443 \
--env OBFS=tls1.2_ticket_auth \
--name ssrr -d bluerain/shadowsocksrr
````

解释：上面启动的容器传递了三个变量，分别是密码、端口和混淆方式。由于是 TLS 为了更合理，所以端口变量值为了 443，至于容器的端口映射无关紧要（所以建议直接 --net=host）。

### 默认参数

````
SERVER_ADDR=0.0.0.0
SERVER_PORT=80
PASSWORD=sample123
METHOD=none
PROTOCOL=auth_chain_d
OBFS=http_simple
````

如果不传递变量，所有值会存在默认参数（你可以什么都不改，但千万别不重置密码）。当然，这些默认参数未必合理或者说适合你当前的环境（因为默认参数是按我的习惯配置的）。  
例如我和大多数人都不同，我从来不用 TLS 混淆，我用 HTTP。以前使用 SS + OBFS 也好还是 SSR 也好，都是如此。
