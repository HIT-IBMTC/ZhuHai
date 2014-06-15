# Description:
#   Search a IP address in TaoBao IP Lib
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot ip <ip> - Search a IP Adreess with TaoBao IP, If 233 in a ip, you may be 233333
#
# Author:
#   liushuaikobe

TAOBAO_IP_API_URL = "http://ip.taobao.com/service/getIpInfo.php"

module.exports = (robot) ->
  robot.respond /ip (.*)/i, (msg) ->
    robot.http("#{TAOBAO_IP_API_URL}?ip=#{msg.match[1]}").get() (err, res, body) ->
      if err?
        msg.send err
        return
      if res.statusCode isnt 200
        msg.send "ʘʚʘ API状态码竟然是 #{res.statusCode}！"
      else
        data = null
        try
          data = JSON.parse(body)
          if data.code == 0
            msg.send "#{data.data.city} #{data.data.region} #{data.data.area} #{data.data.country} #{data.data.isp}"
          else
            msg.send "(ง •̀_•́)ง┻━┻  你确定给我的是一个IP而不是在逗我？！"
        catch e
          msg.send "(๑>◡<๑) 解析JSON遇到错误了!"
