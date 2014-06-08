# Description:
#   Let hubot take note for you while you enjoy your talking.
#   The output will be uploaded as a txt file.
#   Maybe useful in discussion.
#
# Dependencies:
#   None
#
# Configuration:
#   SLACK_TOKEN  token used to create file at slack
#
# Commands:
#   hubot take note
#   hubot summarize
#
# Author:
#   Void Main
class History
  constructor: (@robot) ->
    @cache = []
    @robot.brain.on 'loaded', =>
      if @robot.brain.data.history
        @robot.logger.info "Loading notes"
        @cache = @robot.brain.data.history

  add: (message) ->
    @cache.push message
    @robot.brain.data.history = @cache

  summarize: ->
    reply = "Here's my note:\n------------\n\n"
    reply += @entryToString(message) + '\n' for message in @cache.slice(0, -1)
    reply += "\n\n------------"
    return reply

  entryToString: (event) ->
    return '[' + event.hours + ':' + event.minutes + '] ' + event.name + ': ' + event.message

  clear: ->
    @cache = []
    @robot.brain.data.history = @cache

class HistoryEntry
  constructor: (@name, @message) ->
    @time = new Date()
    @hours = @time.getHours()
    @minutes = @time.getMinutes()
    if @minutes < 10
      @minutes = '0' + @minutes

module.exports = (robot) ->
  takingNote = false

  history = new History(robot)

  robot.hear /(.*)/i, (msg) ->
    if takingNote
      historyentry = new HistoryEntry(msg.message.user.name, msg.match[1])
      history.add historyentry

  robot.respond /take note/i, (msg) ->
    if takingNote
      msg.send "I'm listening, keep going.."
    else
      msg.send "Taking my notebook out, and, ready to go!"
      msg.send "<b>Use `summarize` command to make me stop</b>"
      takingNote = true
      history.clear()

  robot.respond /summarize/i, (msg) ->
    if takingNote
      msg.send "Ok, publishing generated notes, this may take a while.."
      summary = history.summarize()

      date = new Date()
      year = date.getFullYear()
      month = date.getMonth() + 1
      day = date.getDate()
      hour = date.getHours()
      minute = date.getMinutes()
      second = date.getSeconds()
      dateStr = year + "-" + month + "-" + day + "-" + hour + ":" + minute
      title ="Note-" + dateStr + ".txt"

      url = "https://slack.com/api/files.upload"
      fields = {
        token: process.env.SLACK_TOKEN,
        filename: title,
        content: summary,
        initial_comment : "Note taken by ZhuHai on " + dateStr
      }

      querystring = require("querystring")
      msg.http(url).post(querystring.stringify(fields)) (err,response,body) ->
        success = body["ok"]
        if success
          msg.send "Successfully uploaded note!"
        else
          msg.send "Oops..Upload failed.."

      history.clear()
      takingNote = false
    else
      msg.send "I wasn't paying attention.."
