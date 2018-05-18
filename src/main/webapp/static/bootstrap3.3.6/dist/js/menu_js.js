// JavaScript Document
$(document).ready(function(){                          

	var index=0;
	var length=$('#nav-menu ul').children().length;
	var maxWidth=$('.navbar-nav').children().length*95;
	$("#nav-menu ul").css("width",maxWidth);
	var i=1;
	function slideFront(){
		
		if(index >= 0 && index < length-4) {
			$("#nav-menu ul").animate({ "left": "-=95px" },200)
			++index;
		}
		if(i<0 || i>length-4){
			return false;
		}						  
		i++;
	}

	function slideNext(){
		if(index >= 1 ) {
			$("#nav-menu ul").animate({ "left": "+=95px" },200)
			--index;
		}
		if(i<2 || i>length+4){
			return false;
		}
		
		i--;
	}
	$(".rightbutton").click(function(){
		slideNext();
	});
	
	$(".leftbutton").click(function(){
		slideFront();
	});
	
});


