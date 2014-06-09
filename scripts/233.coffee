# Description
#   233 for footoo
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot 233 - 2333333333
#
# Author:
#   aaronbassett

imgs = [
  "http://ftzhuhai.qiniudn.com/cto.jpg",
  "http://ftzhuhai.qiniudn.com/df.jpg",
  "http://ftzhuhai.qiniudn.com/lz.jpg",
  "http://ftzhuhai.qiniudn.com/ctl.jpg"
]

module.exports = (robot) ->
  robot.hear /233(3)*/i, (msg) ->
    msg.send (msg.random imgs)+"#.png"
