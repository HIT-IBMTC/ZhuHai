# Description:
#   huangli for footoo modified from http://sandbox.runjs.cn/show/ydp3it7b
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot huangli
#
# Author:
#   source code form http://sandbox.runjs.cn/show/ydp3it7b modified by Dyul


`
//

/*
 * 注意：本程序中的“随机”都是伪随机概念，以当前的天为种子。
 * Dyul: 用户名也作为种子
 */

var username = "Cliff hasn't given me a name yet!!"

function setUsername(usrnm){
  username = usrnm + " at FoOTOo";
}

function random(dayseed, indexseed) {
	var n = dayseed % 23333;

  for(var i = 0; i < username.length; i++) {
    n = n + username.charCodeAt(i);
  }
	for (var i = 0; i < 100 + indexseed; i++) {
		n = n * n;
		n = n % 23333;   // 23333 是个质数
	}
	return n;
}

var iday;

var weeks = ["日","一","二","三","四","五","六"];
var directions = ["北方","东北方","东方","东南方","南方","西南方","西方","西北方"];
var activities = [
	{name:"洗澡", good:"你几天没洗澡了？",bad:"会把设计方面的灵感洗掉", weekend: true},
	{name:"锻炼一下身体", good:"预防颈椎病",bad:"能量没消耗多少，吃得却更多", weekend: true},
	{name:"重构", good:"代码质量得到提高",bad:"你很有可能会陷入泥潭"},
	{name:"使用%t", good:"你看起来更有品位",bad:"别人会觉得你在装逼"},
	{name:"打扫工位", good:"释放内存，神清气爽",bad:"你会不小心扔掉前女友送你的礼物"},
	{name:"请Cliff吃饭", good:"Cliff会送你一个锦囊",bad:"小心Cliff送你的锦囊里是块肥皂"},
  {name:"祭拜树王", good:"树王将赐予你24小时积极BUFF",bad:"树王将赐予你24小时消极BUFF"},
  {name:"祭拜彪叔", good:"彪叔会给你介绍他的另一个姐姐",bad:"彪叔分分钟教你做人"},
  {name:"端盘子", good:"不用roll了，就是你了",bad:"小心闪着肾"},
  {name:"烧水", good:"你将会灵感涌现",bad:"小心烫伤"},
  {name:"请大家撸串", good:"还需要理由吗？",bad:"被警察发现聚众淫乱"},
	{name:"在Lab包宿", good:"今晚战斗力爆满",bad:"Lab的蚊子已经饥渴难耐了", weekend: true},
	{name:"在妹子面前吹牛", good:"改善你矮穷挫的形象",bad:"会被识破", weekend: true},
	{name:"撸管", good:"避免缓冲区溢出",bad:"强撸灰飞烟灭", weekend: true},
	{name:"浏览成人网站", good:"重拾对生活的信心",bad:"你会心神不宁", weekend: true},
	{name:"命名变量\"%v\"", good:"",bad:""},
	{name:"写超过%l行的方法", good:"你的代码组织的很好，长一点没关系",bad:"你的代码将混乱不堪，你自己都看不懂"},
  {name:"去%f楼上厕所", good:"一路无堵", bad:"此楼阿姨会看上你"},
	{name:"提交代码", good:"遇到冲突的几率是最低的",bad:"你遇到的一大堆冲突会让你觉得自己是不是时间穿越了"},
	{name:"代码复审", good:"发现重要问题的几率大大增加",bad:"你什么问题都发现不了，白白浪费时间"},
	{name:"打IMBA", good:"你将有如神助",bad:"你会被yuri虐的很惨", weekend: true},
	{name:"打CS", good:"你将李总附体",bad:"你会被李总虐的很惨", weekend: true},
	{name:"修复BUG", good:"你今天对BUG的嗅觉大大提高",bad:"新产生的BUG将比修复的更多"},
	{name:"上微博", good:"今天发生的事不能错过",bad:"今天的微博充满负能量", weekend: true},
	{name:"上AB站", good:"新番更新了",bad:"满屏兄贵亮瞎你的眼", weekend: true},
	{name:"玩FlappyBird", good:"今天破纪录的几率很高",bad:"除非你想玩到把手机砸了", weekend: true},
	{name:"与Zhuhai合影", good:"Zhuhai帮你早日脱团",bad:"Zhuhai保你99", weekend: true}
];

var specials = [
	{date:20140910, type:'good', name:'向Cliff献媚', description:'虽然Cliff是个正太'},
	{date:20150214, type:'bad', name:'呆在男友身边', description:'脱团火葬场，入团保平安。'}
];

var tools = ["Emacs写程序", "Vim写程序", "Word写文档", "记事本写程序", ];

var varNames = ["ranisagay", "imagay" ,"namoemituofothisfunctionhasnobug", "duyigeshu"];

var drinks = ["水","茶","红茶","绿茶","咖啡","奶茶","可乐","鲜奶","果汁","果味汽水","运动饮料","酸奶","酒"];

var floors = ["4", "6"];


function getTodayString() {
	var d = new Date();
	var localTime = d.getTime();
	var localOffset = d.getTimezoneOffset() * 60 * 1000;
	var utc = localTime + localOffset;
	var offset = 8;
	var today = new Date(utc + 60*60*1000*offset);
	iday = today.getFullYear() * 10000 + (today.getMonth() + 1) * 100 + today.getDate();
	return "今天是" + today.getFullYear() + "年" + (today.getMonth() + 1) + "月" + today.getDate() + "日 星期" + weeks[today.getDay()] + " " + today.getHours() + ":" + today.getMinutes();
}

function star(num) {
	var result = "";
	var i = 0;
	while (i < num) {
		result += "★";
		i++;
	}
	while(i < 5) {
		result += "☆";
		i++;
	}
	return result;
} 

// 生成今日运势
function pickTodaysLuck() {
  var _activities = filter(activities);
    
	var numGood = random(iday, 98) % 3 + 2;
	var numBad = random(iday, 87) % 3 + 2;
	var eventArr = pickRandomActivity(_activities, numGood + numBad);
	
	var specialSize = pickSpecials();
	
  good = []
  bad = []

	for (var i = 0; i < numGood; i++) {
		addToGood(eventArr[i]);
	}
	
	for (var i = 0; i < numBad; i++) {
		addToBad(eventArr[numGood + i]);
	}
}

// 去掉一些不合今日的事件
function filter(activities) {
    var result = [];
   
    /*
    // 周末的话，只留下 weekend = true 的事件
    if (isWeekend()) {
        
        for (var i = 0; i < activities.length; i++) {
            if (activities[i].weekend) {
                result.push(activities[i]);
            }
        }
        
        return result;
    }
    */
    
    return activities;
}

function isWeekend() {
    return today.getDay() == 0 || today.getDay() == 6;
}

// 添加预定义事件
function pickSpecials() {
	var specialSize = [0,0];
	
	for (var i = 0; i < specials.length; i++) {
		var special = specials[i];
		
		if (iday == special.date) {
			if (special.type == 'good') {
				specialSize[0]++;
				addToGood({name: special.name, good: special.description});
			} else {
				specialSize[1]++;
				addToBad({name: special.name, bad: special.description});
			}
		}
	}
	
	return specialSize;
}

// 从 activities 中随机挑选 size 个
function pickRandomActivity(activities, size) {
	var picked_events = pickRandom(activities, size);
	
	for (var i = 0; i < picked_events.length; i++) {
		picked_events[i] = parse(picked_events[i]);
	}
	
	return picked_events;
}

// 从数组中随机挑选 size 个
function pickRandom(array, size) {
	var result = [];
	
	for (var i = 0; i < array.length; i++) {
		result.push(array[i]);
	}
	
	for (var j = 0; j < array.length - size; j++) {
		var index = random(iday, j) % result.length;
		result.splice(index, 1);
	}
	
	return result;
}

// 解析占位符并替换成随机内容
function parse(event) {
	var result = {name: event.name, good: event.good, bad: event.bad};  // clone
	
	if (result.name.indexOf('%v') != -1) {
		result.name = result.name.replace('%v', varNames[random(iday, 12) % varNames.length]);
	}
	
	if (result.name.indexOf('%t') != -1) {
		result.name = result.name.replace('%t', tools[random(iday, 11) % tools.length]);
	}
	
	if (result.name.indexOf('%l') != -1) {
		result.name = result.name.replace('%l', (random(iday, 12) % 247 + 30).toString());
	}
	
	if (result.name.indexOf('%f') != -1) {
		result.name = result.name.replace('%f', floors[random(iday, 12) % floors.length]);
	}

	return result;
}

// 添加到“宜”
var good = []

function addToGood(event) {
  good.push({"name":event.name, "description":event.good});
  return good;
}

// 添加到“不宜”
var bad = []

function addToBad(event) {
  bad.push({"name":event.name, "description":event.bad});
  return bad;
}
`

module.exports = (robot) ->
  robot.respond /huangli(.*)/i,  (msg) ->
    getHuangli robot, msg

getHuangli = (robot, msg) ->
  user = robot.brain.usersForFuzzyName(msg.message.user['name'])[0].name
  setUsername(user)

  hl = "\n*---#{user}的今日运势---*\n"
  hl += "*#{getTodayString()}*\n\n"

  pickTodaysLuck()
  hl += "*宜*\n"
  for gd in good
    hl += "\t#{gd.name}\t\t _#{gd.description}_ \n"
  hl += "*不宜*\n"
  for bd in bad
    hl += "\t#{bd.name}\t\t _#{bd.description}_ \n"
  hl += "\n"

  hl += "*座位朝向：* 面向 *#{directions[random(iday, 2) % directions.length]}* 写程序，BUG最少\n"
  hl += "*今日宜饮：* #{pickRandom(drinks,2).join('，')}\n"
  hl += "*妹子亲近指数：* #{star(random(iday, 6) % 5 + 1)}\n"

  msg.send hl
