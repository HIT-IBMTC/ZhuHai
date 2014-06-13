# Description:
#   Allows Hubot to roll dice
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot roll - Roll 0 ~ 99
#
# Author:
#   Dyul

module.exports = (robot) ->
  robot.respond /roll/i, (msg) ->
    msg.reply "掷出#{Math.floor(Math.random() * 100)}（0~99）"

