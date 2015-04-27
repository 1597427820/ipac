const_bases = [16777216, 65536, 256, 1]
module.exports.ip2int = (ipv4) ->
  ips = ipv4.split /\./g
  ips.reduce ((v, seg, idx) ->
    segV = parseInt seg
    v + segV * const_bases[idx]
  ), 0
