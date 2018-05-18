<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="input" type="java.lang.String" required="true" description="输入框"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="files、images、flash、thumb"%>
<%@ attribute name="uploadPath" type="java.lang.String" required="true" description="文件的上传路径"%>
<%@ attribute name="uploadMaxSize" type="java.lang.String" required="false" description="扩展属性，允许上传的单个文件的最大值，单位是M,0表示没有限制"%>
<%@ attribute name="uploadMimeTypes" type="java.lang.String" required="false" description="扩展属性，允许上传的文件类型,比如zip,jpg以逗号分割多个，空表示没有限制"%>
<%@ attribute name="saveRealName" type="java.lang.String" required="false" description="扩展属性，保存名称是否是文件原名 true:保存原名 false:系统随机重命名"%>

<ol id="${input}Preview"></ol>
<c:if test="${!readonly}">
<a id="${input}sc" class="btn">添加</a>
&nbsp;<a href="javascript:" onclick="${input}DelAll();" class="btn">清除</a>&nbsp;
</c:if>
<%-- <input type="button" value="开始上传" id="${input}upload-btn" /> --%>
<script type="text/javascript">
$(document).ready(function() 
{
	var files${input} = [];
	var errors${input} = [];
		var uploader${input} = new plupload.Uploader({ //实例化一个plupload上传对象
			   browse_button : "${input}sc",
			   runtimes : 'html5,html,flash,silverlight',//设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html
			   flash_swf_url : '${pageContext.request.contextPath}/static/plupload/Moxie.swf',
			   silverlight_xap_url : '${pageContext.request.contextPath}/static/plupload/Moxie.xap',
		       url : '${pageContext.request.contextPath}/uploadFile.do?type=${type}&uploadPath=${uploadPath}',//上传文件路径
	           max_file_size : '10gb',//100b, 10kb, 10mb, 1gb
	           chunk_size : '100mb',//分块大小，小于这个大小的不分块
	           unique_names : true,//生成唯一文件名
	           init:{
	       		//绑定文件添加进队列事件
	       		FilesAdded:function(uploader${input},files${input})
	       		{
	       			for(var i = 0, len = files${input}.length; i<len; i++){
	       				var file_name = files${input}[i].name; //文件名
	       				var uploadMaxSizes=files${input}[i].size/(1024*1024);
	       				var tmeidatype="${uploadMimeTypes}";
	       		if(tmeidatype!=""){
	       		if(tmeidatype.indexOf(file_name.substring(file_name.lastIndexOf('.') + 1))>-1)
	       		{
	       		}else
	       			{
	       			uploader${input}.removeFile(files${input}[i]);
	       			alert("上传文件类型不合法，只允许上传"+tmeidatype);
	       			return ;
	       			}
	       		}
	       		var tsize=${uploadMaxSize}+"";
	       		if(tsize!=""&&tsize>0){
	       		if(uploadMaxSizes>tsize)
	       			{
	       			uploader${input}.removeFile(files${input}[i]);
	       			alert("上传文件大小超过限制"+tsize+"M");
	       			return ;
	       			}
	       		}
	       			//构造html来更新UI
	       			var html = '<li id="file-' + files${input}[i].id +'"><p class="file-name">' + file_name + '</p><p class="progress"></p><div id="progress'+ files${input}[i].id+'"></div></li>';
	       			$(html).appendTo('#file-list${input}');
	       			}
	       			uploader${input}.start(); //开始上传
	       		},
	       		BeforeUpload:function(uploader${input},file)
	       		{
	       		 var tsaveName="${saveRealName}";
	       		if(tsaveName=="true"){
	       		var tsaveRealName= encodeURI(file.name);
	       		tsaveRealName=encodeURI(tsaveRealName);
	       		uploader${input}.settings.url =  (uploader${input}.settings.url).split("&savename")[0]+'&savename='+tsaveRealName; 
	       		}
	       		},
	       		UploadProgress:function(uploader${input},file)
	       		{
	       			if(file.percent!=100){
	       			$('#file-'+file.id+' .progress').css('width',file.percent + '%');//控制进度条
	       			$("#progress"+file.id).html("上传进度为：" + file.percent + "%"+" ");
	       			}else
	       			{
	       			$("#progress"+file.id).html("文件已经分块上传成功，后台合并中请稍后...");	
	       			}
	       		},
	       		FileUploaded:function(up,file,info)
	       		{
	       		  var response = $.parseJSON(info.response);
		       	     if (response.status) {
		       	         $("#${input}").val($("#${input}").val()+($("#${input}").val(response.fileUrl)==""?response.fileUrl:"|"+response.fileUrl));
		       	      $("#progress"+file.id).html("");
		       	      $("#file-list${input}").html("");
		       	      ${input}Preview();
		       	     }else
		       	    {
		       	    	 $("#file-list${input}").html("<font color='red'>"+file.name+"上传失败，请联系系统管理员。</font>");	 
		       	    }
	       		}
	       	}
	         
		});
	
		  uploader${input}.init();
		
//上传按钮
// $('#${input}upload-btn').click(function(){
// 	uploader${input}.start(); //开始上传
// });
	
}); 
function ${input}Del(obj){
	var url = $(obj).prev().attr("url");
	$("#${input}").val($("#${input}").val().replace("|"+url,"","").replace(url+"|","","").replace(url,"",""));
	${input}Preview();
}
function ${input}DelAll(){
	$("#${input}").val("");
	 $("#file-list${input}").html("");
	${input}Preview();
}
function ${input}Preview(){
	var li, urls = $("#${input}").val().split("|");
	$("#${input}Preview").children().remove();
	for (var i=0; i<urls.length; i++){
		if (urls[i]!=""){//<c:if test="${type eq 'thumb' || type eq 'images'}">
			li = "<li><img src=\""+urls[i]+"\" url=\""+urls[i]+"\" style=\"max-width:${empty maxWidth ? 200 : maxWidth}px;max-height:${empty maxHeight ? 200 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";//</c:if><c:if test="${type ne 'thumb' && type ne 'images'}">
			li = "<li><a href=\""+urls[i]+"\" url=\""+urls[i]+"\" target=\"_blank\">"+decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/")+1))+"</a>";//</c:if>
			li += "&nbsp;&nbsp;<c:if test="${!readonly}"><a href=\"javascript:\" onclick=\"${input}Del(this);\">×</a></c:if></li>";
			$("#${input}Preview").append(li);
		}
	}
	if ($("#${input}Preview").text() == ""){
		$("#${input}Preview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
	}
}

</script>
	<div class="wraper">
		<ul id="file-list${input}">
		</ul>
	</div>
