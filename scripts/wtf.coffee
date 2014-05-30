# Description
#   When Hubot hears anyone say "What is this shit?" 
#   it responds with a relevant meme image 
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   aaronbassett

witimgs = [
    "http://i.imgur.com/g5GET.jpg",
    "http://i.imgur.com/HSSmy.jpg",
    "http://i.imgur.com/wVIkb.jpg",
    "http://i.imgur.com/a6uNS.jpg",
    "http://i.imgur.com/QDEtx.jpg",
    "http://i.imgur.com/gED5u.jpg",
    "http://i.imgur.com/u6dvm.jpg",
    "http://i.imgur.com/TEtBW.jpg",
    "http://i.imgur.com/MMqJW.jpg",
    "http://i.imgur.com/4aa9h.jpg",
    "http://i.imgur.com/b3nmR.jpg"
]

module.exports = (robot) ->
  robot.hear /(wtf|what the fuck|wth|what the hell)/i, (msg) ->
    msg.send msg.random witimgs