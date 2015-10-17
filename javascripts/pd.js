Date.prototype.format = function(fmt)
{ //author: meizz
    var o = {
        "M+" : this.getMonth()+1,                 //月份
        "d+" : this.getDate(),                    //日
        "h+" : this.getHours(),                   //小时

        "m+" : this.getMinutes(),                 //分
        "s+" : this.getSeconds(),                 //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S"  : this.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
}

function prettyDate ( timeObj ) {
    var language="zh";
    var nation={
        week:function (){
            switch (language){
                case "en":return "week";
                case "zh":return "周";
            }
        },
        month:function (){
            switch (language){
                case "en":return "month";
                case "zh":return "月";
            }
        },
        year:function (){
            switch (language){
                case "en":return "year";
                case "zh":return "年";
            }
        },
        days:function (){
            switch (language){
                case "en":return "days";
                case "zh":return "天";
            }
        },
        Yesterday:function (){
            switch (language){
                case "en":return "Yesterday";
                case "zh":return "昨天";
            }
        },
        Today:function (){
            switch (language){
                case "en":return "Today";
                case "zh":return "今天";
            }
        }
    };
  function setToStartOfDay( timeObject ) {
    return new Date(timeObject.getUTCFullYear(), timeObject.getUTCMonth(), timeObject.getUTCDate(), 0, 0, 0, 0);
  }
  function pluralize(count, singular, plural) {
    return count + " " + ( (count == 1) ? singular : (plural || singular + "s") );
  }

  var date = timeObj,
    today = setToStartOfDay( new Date() ),
    start_of_the_day = setToStartOfDay( date ),
    day_diff = Math.floor( ( (today - start_of_the_day) / 1000) / 86400);

  if ( isNaN(day_diff) || day_diff < 0 )
    return;

  return day_diff == 0 && nation.Today() ||
    day_diff == 1 && nation.Yesterday() ||
    day_diff < 7 && day_diff + nation.days()+" 以前" ||
    day_diff < 31 && pluralize(Math.round( day_diff / 7 ), nation.week()) + " 以前" ||
    day_diff < 366 && pluralize( Math.round( day_diff / 7 / 4 ), nation.month()) + " 以前" ||
    day_diff >= 366 && pluralize( Math.round( day_diff / 7 / 4 / 12 ), nation.year()) + " 以前";
}

$(function(){

  $("body").keyup(function(event) {

		if($(".left > a").length == 1 && event.which == 37) 
			location.replace($(".left >a").attr("href"));
		else if($(".right > a").length == 1 && event.which == 39)
			location.replace($(".right >a").attr("href"));
	});

});
