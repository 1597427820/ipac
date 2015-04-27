require '../lib/const'
util = require '../lib/util'
class TplCli
  constructor: (@_rs=process.stdin, @_tpl=DEFAULT_TPL) ->
    @_buf = []
    @read()
  read: () ->
    @_rs.on 'data', (chk) => @_buf.push chk
    @_rs.on 'end', @createTpl.bind @
  createTpl: () ->
    ipranges = []
    all = Buffer.concat @_buf
    iplast = all.toString().split(/\n+/g).reduce ((iplast, ln) ->
      return iplast if !ln
      vals = ln.split /\|/g
      ip = vals[3]

      ipstart = util.ip2int ip
      console.error "Parse ip value error #{ln}" if isNaN ipstart
      ipcnt = parseInt vals[4]
      console.error "Parse ip ipcnt error #{ln}" if isNaN ipcnt

      ipend = ipstart + ipcnt - 1
      if iplast + 1 < ipstart
        ipranges.push iplast
        ipranges.push ipstart
      ipend
      
    ), 0
    ipranges.push iplast
    ipranges.push 4294967040
    console.log @_tpl.replace /{{cn_ip_ranges}}/, ipranges.join ','

new TplCli
