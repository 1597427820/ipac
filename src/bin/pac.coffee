yargs = require 'yargs'
  .option 'h',
    alias: 'host'
    demand: true
    describe: 'Host of your proxy server'
    type: 'string'
  .option 'p',
    alias: 'port'
    demand: true
    describe: 'Port of your proxy server'
    type: 'string'

class PacCli
  constructor: (@host, @port, @_rs=process.stdin) ->
    @_buf = []
    @read()
  read: () ->
    @_rs.on 'data', (chk) => @_buf.push chk
    @_rs.on 'end', @createPac.bind @
  createPac: () ->
    tpl = Buffer.concat(@_buf).toString()
    console.log tpl.replace /{{proxy_server}}/, "#{@host}:#{@port}"


PacCli.run = (argv) ->
  new PacCli argv.host, argv.port

PacCli.run yargs.argv
