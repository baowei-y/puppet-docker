# docker

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview
```
这是一个仅提供ubuntu14.04安装docker服务的模块
请先下载新颁布的稳定内核文件到模块的files/kernel/trusty目录中，链接如下：
http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0.9-wily/linux-headers-4.0.9-040009-generic_4.0.9-040009.201507212131_amd64.deb
http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0.9-wily/linux-headers-4.0.9-040009_4.0.9-040009.201507212131_all.deb
http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0.9-wily/linux-image-4.0.9-040009-generic_4.0.9-040009.201507212131_amd64.deb
```
## Usage
升级内核，并安装docker，并启动服务
```
node 'node.bw-y.com' {
  class { '::docker': }
}
```
## Reference
### Classes

* docker:           : 主参数类
* docker::pre:      : 安装docker前的准备工作
* docker::install   : 安装docker
* docker::config    : 配置docker
* docker::service   : 管理docker服务状态

### Parameters

#### `kernel_update`
是否更新内核到4.0.9，有效值true(是)/false(否)。  默认值: true

#### `docker_opts`
docker服务启动提供的参数，有效参数参考`docker daemon --help`。  默认值：'-s overlay --log-driver=none'

#### `service_enable`
docker服务开机启动，有效值true(启动)/false(不启动)。   默认值：true

#### `service_ensure`
docker服务当前状态，有效值running/stopped。    默认值：running

## Limitations
1、此模块目前仅支持系统： `ubuntu_server_14.04 x86_64 LTS`
2、由于众所周知的原因，安装docker需要使用国内的daocloud提供的源，因此，这里模块使用了daocloud的apt-key和apt repo，模板文件参考模块templates目录，调用参考docker::install
