// JavaScript Document
$(function(){
	var num=0
$('.web_banner ol li').click(function(e) {
	var liindex=$(this).index()
    $(this).addClass('current').siblings().removeClass()
	$('.web_banner .banner_img').animate({left:-liindex*100+'%'},500)
	num=liindex
});

$('.arr .right').click(function(e) {
    num++
	if(num>3){num=0}
	$('.web_banner ol li').eq(num).stop().addClass('current').siblings().stop().removeClass()
	$('.web_banner .banner_img').animate({left:-num*100+'%'},500)
});
$('.arr .left').click(function(e) {
    num--
	if(num<0){num=3}
	$('.web_banner ol li').eq(num).stop().addClass('current').siblings().stop().removeClass()
	$('.web_banner .banner_img').animate({left:-num*100+'%'},500)
});
timer=setInterval(autoplay,3000)
function autoplay(){
	
	num++
	if(num>3){num=0}
	$('.web_banner .banner_img').stop().animate({left:-num*100+'%'},1000)
	$('.web_banner ol li').eq(num).stop().addClass('current').siblings().stop().removeClass()
}
	$('.web_banner').hover(function(e) {
        //停止自动播放，清除定时器；
		clearInterval(timer)
    },function(e){
		clearInterval(timer)
		timer=setInterval(autoplay,3000)
    });

})