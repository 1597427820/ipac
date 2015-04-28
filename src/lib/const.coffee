global.DEFAULT_TPL = '''
  var proxy = 'PROXY {{proxy_server}}; DIRECT;';
  var direct = 'DIRECT;';
  var localIps = [167772160,184549376,2851995648,2852061184,2886729728,2887778304,3232235520,3232301056,4026531840,4194304000];
  var cnIps = [{{cn_ip_ranges}}];
  var bases = [16777216,65536,256,1];
  function ip2int(ip) {
    return ip.split(/\\./g).reduce(function(v, seg, idx) {
      return v + parseInt(seg) * bases[idx];
    }, 0);
  }
  function detectLocal(ip) {
    aIp = ip2int(ip);
    for(var i=0; i<4; ++i) {
      var lo = localIps[2*i];
      var hi = localIps[2*i+1];
      if (aIp >= lo && aIp < hi)
        return true;
    }
    return false
  }
  function detectCN(ip) {
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
    if (isPlainHostName(host))
      return direct;
    if (!isResolvable(host))
      return direct;
    var ip = dnsResolve(host);
    if (detectLocal(ip))
      return direct;
    if (detectCN(ip))
      return direct;
    return proxy;
  }
  '''