# Description:
#   Chat with SimSimi
#
# Dependencies:
#   None
#
# Configuration:
#   SIMSIMI_KEY     token with SimSimi
#   SIMSIMI_FT      ft argument for SimSimi
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
      lc   : "ch",
      ft   : process.env.SIMSIMI_FT
    }

    querystring = require("querystring")
    body = querystring.stringify(fields)

    msg.http("#{url}?#{body}").get() (err,response,body) ->
      content = JSON.parse(body)
      if content.result is 100
        msg.reply content.response
      else if content.result is 401
        msg.reply "我是一个有自闭症的小朋友，不见钱不嘴开呀！\n(ノಠ益ಠ)ノ彡 ʞʃɐʇ ou 'ʎǝuoɯ ou"
      else if content.result is 509
        msg.reply "今天累了捏，睡觉去了哟，客官请明天再来～"
      else
        msg.reply "我好像出问题了：#{content.result}"
