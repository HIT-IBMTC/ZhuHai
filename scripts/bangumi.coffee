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
#   hubot bangumi - Baugumi of today
#
# Author:
#   Void Main

{parseString} = require("xml2js")

DAY = 1000 * 60 * 60  * 24

module.exports = (robot) ->
  robot.respond /bangumi/i, (msg) ->
    msg.http(process.env.BANGUMI_RSS_URL).get() (err, response, body)->
      parseString body, (err, result) ->
        now = new Date()
        has_bangumi = false
        for item in result.rss.channel[0].item
          date = new Date(item.pubDate)
          days_passed = Math.round((now.getTime() - date.getTime()) / DAY)
          if days_passed < 1
            has_bangumi = true
            msg.send "[#{item.category}] " + item.title + " - (#{item.author})\n" + item.description + "\n" + item.pubDate + "\n" + item.link

        if not has_bangumi
          msg.send "今天木有更新耶～"
