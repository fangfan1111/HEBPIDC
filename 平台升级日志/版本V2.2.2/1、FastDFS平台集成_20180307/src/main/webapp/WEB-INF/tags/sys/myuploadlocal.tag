<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="input" type="java.lang.String" required="true" description="输入框"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="files、images、flash、thumb"%>
<%@ attribute name="uploadPath" type="java.lang.String" required="true" description="文件的上传路径"%>
<%@ attribute name="uploadMaxSize" type="java.lang.String" required="false" description="扩展属性，允许上传的单个文件的最大值，单位是M,0表示没有限制"%>
<%@ attribute name="uploadMimeTypes" type="java.lang.String" required="false" description="扩展属性，允许上传的文件类型,比如zip,jpg以逗号分割多个，空表示没有限制"%>
<%@ attribute name="saveRealName" type="java.lang.String" required="false" description="扩展属性，保存名称是否是文件原名 true:保存原名 false:系统随机重命名"%>
<%@ attribute name="isSaveLocal" type="java.lang.String" required="true" description="保存文件是否保存在指定磁盘位置，默认 false 保存在项目路径下，true 保存在指定的磁盘路径下"%>
<%@ attribute name="mychange" type="java.lang.String" required="false" description="自定义一个onchange的方法，将路径传到业务表单页面，可以ajax传到后台处理"%>
<%@ attribute name="multiSelection" type="java.lang.String" required="true" description="是否可以上传多个文件"%>
<%@ attribute name="readonly" type="java.lang.Boolean" required="false" description="是否查看模式"%>
<ol id="${input}Preview"></ol>
<c:if test="${!readonly}">
<a id="${input}sc"  class="btn btn-primary" >添加</a>
&nbsp;<a href="javascript:" onclick="${input}DelAll();" class="btn btn-primary" >清除</a>&nbsp;
</c:if>
<%-- <input type="button" value="开始上传" id="${input}upload-btn" /> --%>
<script type="text/javascript">
$(document).ready(function() 
{
	var files${input} = [];
	var errors${input} = [];
		var uploader${input} = new plupload.Uploader({ //实例化一个plupload上传对象
			   browse_button : "${input}sc",
			   runtimes : 'gears,html5,html4,flash,silverlight',//设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html
			   flash_swf_url : '${pageContext.request.contextPath}/static/plupload/Moxie.swf',
			   silverlight_xap_url : '${pageContext.request.contextPath}/static/plupload/Moxie.xap',
		       url : '${pageContext.request.contextPath}/uploadFileLocal.do?type=${type}&uploadPath=${uploadPath}&isSaveLocal=${isSaveLocal}&uploadMimeTypes=${uploadMimeTypes}',//上传文件路径
	           max_file_size : '10gb',//100b, 10kb, 10mb, 1gb
	           chunk_size : '500mb',//分块大小，小于这个大小的不分块
	           unique_names : true,//生成唯一文件名
	           init:{
	       		//绑定文件添加进队列事件
	       		FilesAdded:function(uploader${input},files${input})
	       		{
	       			var multiSelection="${multiSelection}";
	       			if(multiSelection == "false"){
		       			if($("#${input}").val() != "" && $("#${input}").val() != null) {
		       				window.top.layer.alert('只能上传一个文件', {
		       				  skin: 'layui-layer-lan' //样式类名
		       				  ,closeBtn: 0
		       				});
		       				uploader${input}.files.length = 0;
		       				return false;
		       			}	       				
	       			if (uploader${input}.files.length > 1) {
	                          window.top.layer.alert('只能上传一个文件', {
		       				  skin: 'layui-layer-lan' //样式类名
		       				  ,closeBtn: 0
		       				});
	       				uploader${input}.files.length = 0;
	       				return false;
	       				}
	       			}
	       			for(var i = 0, len = files${input}.length; i<len; i++){
	       				var file_name = files${input}[i].name; //文件名
	       				var uploadMaxSizes = files${input}[i].size/(1024*1024);
	       				var tmeidatype = "${uploadMimeTypes}";
						if(tmeidatype != "" && tmeidatype.indexOf(file_name.substring(file_name.lastIndexOf('.') + 1))==-1 ){
							uploader${input}.removeFile(files${input}[i]);
							window.top.layer.alert('上传文件类型不合法，只允许上传'+tmeidatype, {
								  skin: 'layui-layer-lan' //样式类名
								  ,closeBtn: 0
								});
							return ;
						}
						var tsize = ${uploadMaxSize}+"";
						if(tsize!="" && tsize>0){
							if(uploadMaxSizes>tsize){
								uploader${input}.removeFile(files${input}[i]);
								window.top.layer.alert('上传文件大小超过限制'+tsize+'M', {
									  skin: 'layui-layer-lan' //样式类名
									  ,closeBtn: 0
									});
								return ;
							}
						}
						//构造html来更新UI
						var html = '<li id="file-' + files${input}[i].id +'"><p class="file-name">' + file_name + '</p><p class="progress"></p><div id="progress'+ files${input}[i].id+'"></div></li>';
						$(html).appendTo('#file-list${input}');
	       			}
	       			uploader${input}.start(); //开始上传
	       		},
	       		BeforeUpload:function(uploader${input},file){
			 		var tsaveName = "${saveRealName}";
					if(tsaveName == "true"){
						var tsaveRealName = encodeURI(file.name);
						tsaveRealName = encodeURI(tsaveRealName);
						uploader${input}.settings.url =  (uploader${input}.settings.url).split("&saveName")[0]+'&saveName='+tsaveRealName+'&nameType=0';
					}else{
						var tsaveRealName = encodeURI(file.name);
						tsaveRealName = encodeURI(tsaveRealName);
						uploader${input}.settings.url =  (uploader${input}.settings.url).split("&saveName")[0]+'&saveName='+tsaveRealName+'&nameType=1';

					}
	       		}, UploadProgress:function(uploader${input},file){
	       			if(file.percent!=100){
						$('#file-'+file.id+' .progress').css('width',file.percent + '%');//控制进度条
						$("#progress"+file.id).html("上传进度为：" + file.percent + "%"+" ");
	       			}else{
	       				$("#progress"+file.id).html("文件已经分块上传成功，后台合并中请稍后...");
	       			}
	       		},
	       		FileUploaded:function(up,file,info){
					 var response = $.parseJSON(info.response);
					 if (response.status) {
						 $("#${input}").val($("#${input}").val()+($("#${input}").val(response.fileUrl)==""?response.fileUrl:","+response.fileUrl));
						$("#progress"+file.id).html("");
						$("#file-list${input}").html("");
						${input}Preview();
						var multiSelection="${multiSelection}";
						if(multiSelection == "false"){
							uploader${input}.files.length = 0;
						}
					 }else{
						 $("#file-list${input}").html("<font color='red'>"+file.name+"上传失败，请联系系统管理员。</font>");
					}
	       		}
	       	}
		});
	  uploader${input}.init();
	  ${input}Preview();
});

function ${input}Del(obj){
	var url = $(obj).prev().attr("url");
	$("#${input}").val($("#${input}").val().replace(","+url,"","").replace(url+",","","").replace(url,"",""));
	${input}Preview();
	$.ajax({
		cache: true,
        type: "POST",
        url:"${pageContext.request.contextPath}/delete.do?urls="+url,
        dataType : "json",
        success: function(data) {
	    }
	});
	<c:if test="${mychange}">
	var url = $(obj).prev().attr("url");
	onchangex(url);
    </c:if>
	/* window.location.href="${pageContext.request.contextPath}/delete.do?urls="+urls; */
}
function ${input}DelAll(){
	var urls = $("#${input}").val();
	$("#${input}").val("");
	$("#file-list${input}").html("");
	${input}Preview();
	$.ajax({
		cache: true,
        type: "POST",
        url:"${pageContext.request.contextPath}/delete.do?urls="+urls,
        dataType : "json",
        success: function(data) {
	    }
	});
	<c:if test="${mychange}">
	var urls = $("#${input}").val();
	onchangex(urls);
    </c:if>
}
function ${input}Preview(){
	var li, ids = $("#${input}").val();
    $("#${input}Preview").children().remove();
	if(ids!=''&&ids!=null){
        $.ajax({
            cache: true,
            type: "POST",
            async: false,
            url:"${pageContext.request.contextPath}/fileUrl.do?ids="+ids,
            dataType : "json",
            success: function(urls) {
                for (var i=0; i<urls.length; i++){
                    if (urls[i]!=""){
                        var file_name = decodeURIComponent(urls[i].save_path.substring(urls[i].save_path.lastIndexOf("/")+1));
                        var fileUploadType = urls[i].object_id;
                        if( fileUploadType == "FASTDFS"){
                            file_name = urls[i].file_name;
                        }
                        //==========================存在本地=========================
                        <c:if test="${isSaveLocal =='true'}">
                        <c:if test="${type eq 'thumb' || type eq 'images'}">
                        li = "<li><img src=\"${pageContext.request.contextPath}/downloadfile.do?fileName="+encodeURI(encodeURI(urls[i].file_name))+"&url="+encodeURI(encodeURI(urls[i].save_path))+"\" url=\""+urls[i].id+"\" onclick=\"Downloadfile('"+encodeURI(encodeURI(urls[i].save_path))+"','"+encodeURI(encodeURI(file_name))+"','"+fileUploadType+"','"+urls[i].file_name+"');\" style=\"max-width:${empty maxWidth ? 180 : maxWidth}px;max-height:${empty maxHeight ? 180 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";
                        </c:if>
                        <c:if test="${type ne 'thumb' && type ne 'images'}">
                        li = "<li><a href=\"javascript:\"  onclick=\"Downloadfile('"+encodeURI(encodeURI(urls[i].save_path))+"','"+encodeURI(encodeURI(file_name))+"','"+fileUploadType+"','"+urls[i].file_name+"');\" url=\""+urls[i].id+"\" >"+file_name+"</a>";
                        </c:if>
                        li += "&nbsp;&nbsp;<c:if test="${!readonly}"><a href=\"javascript:\" onclick=\"${input}Del(this);\">×</a></c:if></li>";
                        $("#${input}Preview").append(li);
                        </c:if>
                        //======================存在项目中=========================//
                        <c:if test="${isSaveLocal =='false'}">
                        <c:if test="${type eq 'thumb' || type eq 'images'}">
                        li = "<li><img  onclick=\"Downloadfile('"+encodeURI(encodeURI(urls[i].save_path))+"','"+encodeURI(encodeURI(file_name))+"','"+fileUploadType+"','"+urls[i].file_name+"');\"  src=\"${pageContext.request.contextPath}/downloadfile.do?fileName="+encodeURI(encodeURI(urls[i].file_name))+"&url="+encodeURI(encodeURI(urls[i].save_path))+"\" url=\""+urls[i].id+"\" style=\"max-width:${empty maxWidth ? 180 : maxWidth}px;max-height:${empty maxHeight ? 180 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";
                        </c:if>
                        <c:if test="${type ne 'thumb' && type ne 'images'}">
                        li = "<li><a href=\"javascript:\"   onclick=\"Downloadfile('"+encodeURI(encodeURI(urls[i].save_path))+"','"+encodeURI(encodeURI(file_name))+"','"+fileUploadType+"','"+urls[i].file_name+"');\" url=\""+urls[i].id+"\" >"+file_name+"</a>";
                        </c:if>
                        li += "&nbsp;&nbsp;<c:if test="${!readonly}"><a href=\"javascript:\" onclick=\"${input}Del(this);\">删除</a></c:if></li>";
                        $("#${input}Preview").append(li);
                        </c:if>
                    }
                }
            }
        });
	}
	if ($("#${input}Preview").text() == ""){
		$("#${input}Preview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
	}
}
function Downloadfile(url,file_name,fileUploadType,fileName){
    if( fileUploadType == "FASTDFS"){
        window.location.href = "${fns:getNginxTrackerServer()}/"+url+"?fileName="+fileName;
	}else{
        window.location.href = "${pageContext.request.contextPath}/downloadfile.do?url="+url+"&fileName="+file_name;
	}
}
</script>
<div class="wraper">
	<ul id="file-list${input}">
	</ul>
</div>
