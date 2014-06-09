# Description:
#   Chat with SimSimi
#
# Dependencies:
#   None
#
# Configuration:
#   SIMSIMI_KEY     token with SimSimi
#
# Commands:
#   hubot chat - And chat with zhuhai
#
# Author:
#   VoidMain

module.exports = (robot) ->
  robot.respond /chat (.*)/i, (msg) ->
    url = "http://sandbox.api.simsimi.com/request.p"

    fields = {
      key  : process.env.SIMSIMI_KEY,
      text : msg.match[1],
      lc   : "ch"
    }

    querystring = require("querystring")
    body = querystring.stringify(fields)

    msg.http(url + "?" + body).get() (err,response,body) ->
      content = JSON.parse(body)
      msg.send content.response
