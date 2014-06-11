# Description
#   Provides today's bangumi info from bilibili
#
# Dependencies:
#   "xml2js" : "0.4.4"
#
# Configuration:
#   BANGUMI_RSS_URL : url of bangumi rss feed, currently use bilibili's feed
#
# Commands:
#   hubot bangumi <count> - Baugumi of today (with max item of count)
#
# Author:
#   Void Main

{parseString} = require("xml2js")

DAY = 1000 * 60 * 60  * 24

module.exports = (robot) ->
  robot.respond /bangumi(\s*.*)/i, (msg) ->
    msg.send "正在获取数据～"
    msg.http(process.env.BANGUMI_RSS_URL).get() (err, response, body)->
      parseString body, (err, result) ->
        now = new Date()
        bangumi_info = ""
        max = msg.match[1]
        max = parseInt(max, 10)
        if isNaN(max)
          max = 0

        for item, index in result.rss.channel[0].item
          if max == 0 || index < max
            date = new Date(item.pubDate)
            days_passed = Math.round((now.getTime() - date.getTime()) / DAY)
            if days_passed < 1
              bangumi_info += "[#{item.category}] " + item.title + " - (#{item.author})\n" + item.description + "\n" + item.pubDate + "\n" + item.link + "\n"

        if not bangumi_info.length
          msg.send "今天木有更新耶～"
        else
          msg.send bangumi_info
