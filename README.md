#IPAC
生成根据 IP 自动识别国内外的 PAC 文件.

#安装
```shell
npm i ipac -g
```

#使用
```shell
curl http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest | grep "CN|ipv4" | ipac-tpl | ipac-pac -h zpn.so -p 8080
```

#简述
根据 apnic 的 IP 表, 计算出一个有序的数组, 从小到大, 奇数为下标连续的两个数字代表一段位于中国的 IP. 生成 PAC 文件的模板. 默认的模板采用二分策略, 判断访问的域名是否落在奇数下标上, 如果是则说明该 IP 属于中国, 否则不属于

