# Description:
#   You want ranks, give you ranks in slack!
#
# Dependencies:
#   None
#
# Commands:
#   hubot show rank - Shows current rank
#
# Authors:
#   Void Main
module.exports = (robot) ->
  robot.hear /(.*)/i, (msg) ->
    poster = msg.message.user.name
    if !robot.brain.data.chat_score
      robot.brain.data.chat_score = {}

    if !(poster of robot.brain.data.chat_score)
      robot.brain.data.chat_score[poster] = 0

    robot.brain.data.chat_score[poster] += 1

  robot.respond /show rank/i, (msg) ->
    arr = []
    for name, score of robot.brain.data.chat_score
      arr.push([name, score])

    arr.sort (a, b) ->
      return if a[1] >= b[1] then 1 else -1

    msg.send "话痨排行榜:"
    for index, item of arr
      msg.send "第" + (index + 1) + "名：" + item[0] + "，得分：" + item[1]