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
#   Dyul

imgs = [
  "http://footoozhuhai.qiniudn.com/yen.jpg",
  "http://footoozhuhai.qiniudn.com/dofy.jpg",
  "http://footoozhuhai.qiniudn.com/qiu.jpg",
  "http://footoozhuhai.qiniudn.com/huan.png",
  "http://footoozhuhai.qiniudn.com/doublekill.png",
  "http://footoozhuhai.qiniudn.com/zlb.jpg",
  "http://footoozhuhai.qiniudn.com/doublelong.png",
  "http://footoozhuhai.qiniudn.com/lzinred.png",
  "http://footoozhuhai.qiniudn.com/shuaishuai.png",
  "http://footoozhuhai.qiniudn.com/sobighuan.png",
]

module.exports = (robot) ->
  robot.hear /233(3)*/i, (msg) ->
    msg.send (msg.random imgs)+"#.png"
