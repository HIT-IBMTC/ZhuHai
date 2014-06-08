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
    "https://www.dropbox.com/s/um9wukrq484q35f/cto.jpg",
    "https://www.dropbox.com/s/e4lynr3p124r5qt/df.jpg",
    "https://www.dropbox.com/s/mp9unloe7f4grse/ctl.jpg",
    "https://www.dropbox.com/s/wb8fzyjrapdplap/lz.jpg"
]

module.exports = (robot) ->
  robot.respond /233(3)*/i, (msg) ->
    msg.send msg.random imgs
