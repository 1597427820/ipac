global.DEFAULT_TPL = '''
  var proxy = "PROXY {{proxy_server}}; DIRECT;";
  var direct = "DIRECT;";
  var cnIps = [{{cn_ip_ranges}}];
  var bases = [16777216,65536,256,1];
  function ip2int(ip) {
    return ip.split(/\\./g).reduce(function(v, seg, idx) {
      return v + parseInt(seg) * bases[idx];
    }, 0);
  }
  function detect(ip) {
    aIp = ip2int(ip);
    var l=0, r=cnIps.length;
    while(l+1<r) {
      m = Math.floor((l + r) / 2);
      mIp = cnIps[m];
      if(aIp < mIp) {
        r = m;
      } else if(aIp == mIp) {
        l = m;
        break;
      } else {
        l = m;
      }
    }
    if(l&1) return true;
    return false;
  }
  function FindProxyForURL(url, host) {
    if (!isResolvable(host)) 
      return proxy;
    var is = detect(dnsResolve(host));
    if(is) return direct;
    return proxy;
  }
  '''