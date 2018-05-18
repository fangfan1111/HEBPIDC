$(document).ready(function(){
	var length=$('.big-box').children().length;
	var suij=length-1
	var random_bg=Math.floor(Math.random()*suij+1);
    var bg='url(${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_'+random_bg+'.jpg)';
	var num=100
	var cli=0
	var windowWidth = $(window).width()+17;
	var length=$('.big-box').children().length;
	$(".big-box").width(windowWidth * length); 
	$(".big-box li").width(windowWidth);
	$('.oneimg img').attr('src','${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_'+random_bg+'.jpg')

	var timer=null
	timer=setInterval(autoplay,4000)
	
	function autoplay(){
		cli++
		num++
		if(cli>length-1){cli=0}

	    $('.big-box li').eq(cli).css({zIndex:num}).hide().fadeIn();
		}
		
	
	
	
	
});