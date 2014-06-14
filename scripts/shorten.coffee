# Description:
#   Shorten a URL with goo.gl
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot shorten|expand <url> - Shorten or expand a URL with goo.gl
#
# Author:
#   liushuaikobe

GOO_API_URL = "https://www.googleapis.com/urlshortener/v1/url"
GOO_API_KEY = "AIzaSyB_25BgAl79ek-TuWWs985QzlL74-tABTQ"

module.exports = (robot) ->
  robot.respond /shorten (.*)/i, (msg) ->
    options = JSON.stringify({
      longUrl: msg.match[1],
      key: GOO_API_KEY
    })
    robot.http(GOO_API_URL).header("Content-Type", "application/json").post(options) (err, res, body) ->
      if err?
        msg.send err
        return
      if res.statusCode isnt 200
        msg.send "API状态码竟然是 #{res.statusCode}！"
      else
        data = null
        try
          data = JSON.parse(body)
          msg.send data.id
        catch e
          msg.send "解析JSON遇到错误了! :("

  robot.respond /expand (.*)/i, (msg) ->
    parms = "?shortUrl=" + msg.match[1] + "&key=" + GOO_API_KEY
    robot.http(GOO_API_URL + parms).header("Content-Type", "application/json").get() (err, res, body) ->
      if err?
        msg.send err
        return
      if res.statusCode isnt 200
        msg.send "API状态码竟然是 #{res.statusCode}！"
      else
        data = null
        try
          data = JSON.parse(body)
          msg.send data.longUrl + " | status: #{data.status}"
        catch e
          msg.send "解析JSON遇到错误了! :("
