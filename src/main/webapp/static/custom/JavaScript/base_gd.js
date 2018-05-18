// JavaScript Document
	$(function(){
	$(window).scroll(function() {
		if($(window).scrollTop()>80){
			$(".nav").addClass("fixed");
			}
		else{
			$(".nav").removeClass("fixed");
		}	
		
	})
})

function TabMove(id,index,count)
{
	var defaultCss="kjy";
	var SelectCss="kjy";
	for(var n=1;n<=count;n++)
	{
		document.getElementById("Button"+id+n).className=defaultCss;
		document.getElementById("ContentBox"+id+n).style.display='';
	}
	document.getElementById("Button"+id+index).className=SelectCss;
	document.getElementById("ContentBox"+id+index).style.display='block';
}

$(function(){
	$('.main_left li').click(function(e) {
		var index=$(this).index()
        $(this).addClass('current').siblings().removeClass()
		$('.main_right ul').eq(index).show().siblings().hide()

    });
})


$(function(){
	$('.menhu-left li').click(function(e) {
		var index=$(this).index()
        $(this).addClass('menhu-current').siblings().removeClass()
		$('.main_right ul').eq(index).show().siblings().hide()

    });
	$('#demo01').flexslider({
		animation: "slide",
		direction:"horizontal",
		easing:"swing"
	});
	$('.admin').hover(function(){
		$(".admin_gnlb").toggle();
	});
})
//弹出登录框
/**$(function(){
	$(function(){
		$('.one').click(function(){
			$('.box2').show();
		});
		$('.login5 a').click(function(){
			$('.box2').hide();
		});
		$('.box').easydrag();
	});
})**/
	
	