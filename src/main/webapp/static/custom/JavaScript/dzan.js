 (function($) {
    $.extend({
        tipsBox: function(options) {
            options = $.extend({
                obj: null,  //jq对象，要在那个html标签上显示
                str: "+1",  //字符串，要显示的内容;也可以传一段html，如: "<b style='font-family:Microsoft YaHei;'>+1</b>"
                startSize: "10px",  //动画开始的文字大小
                endSize: "25px",    //动画结束的文字大小
                interval: 600,  //动画时间间隔
                color: "red",    //文字颜色
                callback: function() {}    //回调函数
            }, options);
            $("body").append("<span class='num'>"+ options.str +"</span>");
            var box = $(".num");
            var left = options.obj.offset().left + options.obj.width() / 2;
            var top = options.obj.offset().top - options.obj.height();
            box.css({
                "position": "absolute",
                "left": left + "px",
                "top": top + "px",
                "z-index": 9999,
                "font-size": options.startSize,
                "line-height": options.endSize,
                "color": options.color
            });
            box.animate({
                "font-size": options.endSize,
                "opacity": "0",
                "top": top - parseInt(options.endSize) + "px"
            }, options.interval , function() {
                box.remove();
                options.callback();
            });
        }
    });
})(jQuery);
  function support(artid,type){
	  var obj = $("#"+type+'_'+artid);
  //如果已关注，改变状态取消关注
  var objclas = obj.attr("class");
  if(objclas=='tj_ul1_li3gz'){
	  type = "qxgz";
  }else if(objclas=='tj_ul1_li3'){
	  type = "gz";
  }
  var color = type=='qxgz'?'#666':'red';
  var str = type=='qxgz'?'-1':'+1';
  if(type=='zc'||type=='bzc'){
		$("#zc_"+artid).removeAttr('onclick');
		$("#bzc_"+artid).removeAttr('onclick');
  }else{
	  $("#qxgz_"+artid).removeAttr('onclick');
	  $("#gz_"+artid).removeAttr('onclick');
  }
  $.tipsBox({
		obj: obj,
		str: str,
		color:color,
        callback: function() {
        	userPraiseSave(obj,artid,type);
        }
	});
  }
  function userPraiseSave(obj,artid,type){
	  $.ajax({  
	       type: "post",  
       url: ctx+"/termssearch/userPraise/save?xtid="+artid+"&type="+type,  
       dataType: "json",  
       success: function(data){
			if(data==true){
				if(type=='zc'){
					obj.text(parseInt(obj.text())+1);
					obj.removeClass().addClass("tj_ul1_li1zc"); 
				}else if(type=='bzc'){
					obj.text(parseInt(obj.text())+1);
					obj.removeClass().addClass("tj_ul1_li2bzc"); 
				}else if(type=='gz'){
					obj.text(parseInt(obj.text())+1);
					obj.removeClass().addClass("tj_ul1_li3gz");
					$("#gz_"+artid).attr('onclick',"support('"+artid+"','gz')");
					$("#qxgz_"+artid).attr('onclick',"support('"+artid+"','qxgz')");
				}else if(type=='qxgz'){
					obj.text(parseInt(obj.text())-1);
					obj.removeClass().addClass("tj_ul1_li3"); 
					$("#gz_"+artid).attr('onclick',"support('"+artid+"','gz')");
					$("#qxgz_"+artid).attr('onclick',"support('"+artid+"','qxgz')");
				}
			}
	       }
	 });
  }