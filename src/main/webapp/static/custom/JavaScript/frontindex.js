function hitsCount(contentId,hits){
	$.ajax({  
	       type: "post",  
	       url: ctxfront+"/content_hits?contentId="+contentId,  
	       dataType: "json",  
	       success: function(data){
	    	   $("#" + hits).text(data);
	       }
	 });
}
/**
 * 登录
 */
function loginCsi(loginDiv,options) {
	$("#" + loginDiv).load(ctxfront + "/login_check", options);
}