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
#   ab9

module.exports = (robot) ->
  robot.respond /roll/i, (msg) ->
    msg.reply report [rollOne(100)]

report = (results) ->
  if results?
    switch results.length
      when 0
        " didn't roll any dice."
      when 1
        " 掷出#{results[0]}（0~99）"

roll = (dice, sides) ->
  rollOne(sides) for i in [0...dice]

rollOne = (sides) ->
  Math.floor(Math.random() * sides)
