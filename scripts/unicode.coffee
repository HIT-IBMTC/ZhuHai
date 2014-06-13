# Description:
#   Displays the corresponding unicode to user.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Notes:
#   Hubot will hear \\u([a-z0-9]{4})
#
# Author:
#   Void Main
module.exports = (robot) ->

  robot.hear /\\u([a-f0-9]{4})/i, (msg) ->
    raw = msg.match[1]
    code = String.fromCharCode(parseInt(raw, 16))
    msg.send "\\u#{raw} => #{code}"
