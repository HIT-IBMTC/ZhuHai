# Description
#   Start a voting
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot start vote topic : choice1, choice2, ...
#   hubot vote 1, 2, 3, ...
#   hubot show choices
#   hubot show vote - show current voting result
#   hubot end vote
#
# Notes:
#   None
#
# Author:
#   Dyul

class Voting
  constructor: (@robot) ->
    @topic = ""
    @choices = []
    @robot.brain.on "loaded", =>
      if @robot.brain.data.voting?
        @robot.logger.info "loading votes"
        @topic = @robot.brain.data.voting.topic
        @choices = @robot.brain.data.voting.choices
      else
        @robot.logger.info "newing votes"
        @robot.brain.data.voting = {}

  build: (@topic, @choices) ->
    @robot.brain.data.voting.topic = @topic
    @robot.brain.data.voting.choices = @choices

  showChoices: (msg, showResult = no, result = null) ->
    response = ""
    response += @topic + '\n'
    for choice, i in @choices
      response += "#{i+1}. \t#{choice.str}"
      if showResult and result?
        response += "\t[#{result[i]}]"
      response += "\n"
    msg.send response


  showResult: (msg) ->
    result = (choice.voters.length for choice in @choices)
    @showChoices msg, yes, result


  vote: (msg, voter, votes) ->
    if !@validVotes(votes)
      msg.reply "无效的投票!"
    else
      response = "投给了选项 "
      for vote, i in votes
        response += vote + 1
        response += ", " unless i == votes.length - 1
        unless voter in @choices[vote].voters
          @choices[vote].voters.push voter
      @robot.brain.data.voting.choices = @choices
      msg.reply response

  validVotes: (votes) ->
    for vote in votes
      if vote < 0 or vote > @choices.length - 1
        return false
    return true


  end: () ->
    delete @robot.brain.data.voting.topic
    delete @robot.brain.data.voting.choices


module.exports = (robot) ->
  isVoting = false
  noVotingError = "( ⊙ o ⊙ )没有正在进行中的投票"

  voting = new Voting(robot)

  robot.respond /start vote (.+)(:|：)(.+)/i, (msg) ->
    if isVoting
      msg.send "某个投票正在进行中..."
    else
      topic = msg.match[1].trim()
      if '，' in msg.match[3]
        tmp = msg.match[3].split('，')
      else
        tmp = msg.match[3].split(',')
      choices = ({str:choice.trim(), voters:[]} for choice in tmp)
      voting.build(topic, choices)

      sponsor = robot.brain.usersForFuzzyName(msg.message.user['name'])[0].name
      msg.send "@channel @#{sponsor}发起了一个投票，请使用`vote`来投票"
      voting.showChoices(msg)
      isVoting = true

  robot.respond /vote ([\d ,]+)/i, (msg) ->
    if !isVoting
      msg.send noVotingError
    else
      tmp = msg.match[1].split(',')
      votes = (parseInt(t.trim(), 10)-1 for t in tmp)
      voter = robot.brain.usersForFuzzyName(msg.message.user['name'])[0].name
      voting.vote(msg, voter, votes)

  robot.respond /show (choice|choices)/i, (msg) ->
    if !isVoting
      msg.send noVotingError
    else
      voting.showChoices(msg)

  robot.respond /show (vote|votes)/i, (msg) ->
    if !isVoting
      msg.send noVotingError
    else
      voting.showResult(msg)

  robot.respond /end vote/i, (msg) ->
    if !isVoting
      msg.send noVotingError
    else
      msg.send "---------------投票结果---------------"
      voting.showResult(msg)
      voting.end()
      isVoting = false






