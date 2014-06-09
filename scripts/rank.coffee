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
      return if a[1] >= b[1] then -1 else 1

    rankMsg = "话痨排行榜:\n"
    for index, item of arr
      rankMsg += "第" + parseInt(parseInt(index, 10) + 1, 10) + "名：" + item[0] + "，得分：" + item[1] + "\n"
    msg.send rankMsg
