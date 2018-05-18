/**
 * 统计分析demojs
 */
$(document).ready(function() {
//	  var myurls=getRootPaths()+"/a/example/test/getjsons";
////	loading("测试...");
//	//closeTip();
//	   $.ajax({
//			url:myurls,
//			dataType:"json",
//			success:function(data){
//				$("#bintitle").val(data.title);
//				$("#bindata").val(data.data);
//				alert($("#bintitle").val());
//				alert($("#bindata").val());
//			}
//			});
	
});
/**
 * 公共方法js
 */
function getRootPaths(){  
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp  
    var curWwwPath=window.document.location.href;  
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp  
    var pathName=window.document.location.pathname;  
    var pos=curWwwPath.indexOf(pathName);  
    //获取主机地址，如： http://localhost:8083  
    var localhostPaht=curWwwPath.substring(0,pos);  
    //获取带"/"的项目名，如：/uimcardprj  
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);  
    return(localhostPaht+projectName);  
} 
var label = new Array();
var value1 = new Array();
var labtitle=new Array();
var labvau=new Array();
{
	  require(
	  [
	   'echarts',
	   'echarts/chart/bar',
	   'echarts/chart/line',
	   'echarts/chart/pie'
	  ],
	  function (ec) {//回调函数
	   //--- 折柱 ---
	   var myChart = ec.init(document.getElementById('t1'));
	   var mychartxian=ec.init(document.getElementById('t2'));
	   var mychartbing=ec.init(document.getElementById('t3'));
	   var myurl = getRootPaths()+"/a/example/test/getjson";
	   var myurls=getRootPaths()+"/a/example/test/getjsons";
	   //loading("数据加载中，请稍后...");
	   loading("数据加载中，请稍后...");
	   $.ajax({
			url:myurl,
			dataType:"json",
			success:function(data){
				closeTip();
		 		if(data=="")
  	 			{
  	 			label=[];
  	 			value1=[];
  	 			labvau=[];
  	 			alert("无数据!");
  	 			}else{
  	     	$.each(data,function(i,p){
  	     		label[i]=p['tradename'];
  	     		value1[i]=p['id'];
  	     		labvau[i]='value:'+p['id']+',name:'+p['tradename']+'';
  	     	});}
		 		//柱形图
		        myChart.setOption({
		        	title : {
		                text: '项目按行业统计(柱形图)',
		                subtext: 'demo数据',
		                textStyle:{
        		        	fontSize: 15,
        		        	fontWeight: 'bolder'
        		        } 
		            },
		            tooltip : {
		                trigger: 'axis'
		            },
		            legend: {
		                data:['项目个数']
		            },
		            grid:{x:150,y2:100},      
		 		    calculable : true, 
		            toolbox: {
		                show : true,
		                feature : {
		                    mark : {show: true},
		                    dataView : {show: true, readOnly: false},
		                    magicType : {show: true, type: ['line', 'bar']},
		                    restore : {show: true},
		                    saveAsImage : {show: true}
		                }
		            },
		            calculable : true,
		            animation : false,
		            xAxis : [
		                {
		                	 axisLabel: {
								 rotate: 25,
								 margin :5
								 },
		                    type : 'category',
		                    data : getx()
		                }
		            ],
		            yAxis : [
		                {
		                    type : 'value'
		                }
		            ],
		            series : [
		                {
		                    name:'项目个数',
		                    type:'bar',
		                    data:gety()
		                }
		            ]     
		        },true);
		        
		        //折线图
		        mychartxian.setOption({
		        	  title : {
		        	        text: '项目按行业统计(折线图 )',
		        	        subtext: 'demo数据',
		        	        textStyle:{
	        		        	fontSize: 15,
	        		        	fontWeight: 'bolder'
	        		        }
		        	    },
		        	    tooltip : {
		        	        trigger: 'axis'
		        	    },
		        	    legend: {
		        	        data:['项目个数']
		        	    },
		        	    grid:{x:150,y2:100},      
			 		    calculable : true, 
		        	    toolbox: {
		        	        show : true,
		        	        feature : {
		        	            mark : {show: true},
		        	            dataView : {show: true, readOnly: false},
		        	            magicType : {show: true, type: ['line', 'bar']},
		        	            restore : {show: true},
		        	            saveAsImage : {show: true}
		        	        }
		        	    },
		        	    calculable : true,
		        	    animation : false,
		        	    xAxis : [
		        	        {
		        	       	 axisLabel: {
								 rotate: 25,
								 margin :5
								 },
		        	            type : 'category',
		        	            boundaryGap : false,
		        	            data : getx()
		        	        }
		        	    ],
		        	    yAxis : [
		        	        {
		        	            type : 'value',
		        	        }
		        	    ],
		        	    series : [
		        	        {
		        	            name:'项目个数',
		        	            type:'line',
		        	            data:gety()
		        	        }
		        	    ]
		        
		        },true);
		        	
					window.onresize = myChart.resize;
					window.onresize =	mychartxian.resize;
				
			},//ajax执行后台
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				closeTip();
               alert("请求发生错误!");
            }
			}); 
	   
//	   $.ajax({
//			url:myurls,
//			dataType:"json",
//			success:function(data){
//				closeTip();
//		 		if(data=="")
//  	 			{
//		 		labtitle=[];
//  	 			labvau=[];
//  	 			alert("无数据!");
//  	 			}else{
//  	 				labtitle=data.title;
//  	 				labvau=data.data;
//  	 			}
		 	   //饼图
		        mychartbing.setOption({
		        	 title : {
		        	        text: '某站点用户访问来源',
		        	        subtext: '纯属虚构',
		        	        x:'center'
		        	    },
		        	    tooltip : {
		        	        trigger: 'item',
		        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
		        	    },
		        	    legend: {
		        	        orient : 'vertical',
		        	        x : 'left',
		        	        data:getlabtitle()
		        	    },
		        	    toolbox: {
		        	        show : true,
		        	        feature : {
		        	            mark : {show: false},
		        	            dataView : {show: true, readOnly: false},
		        	            magicType : {
		        	                show: false, 
		        	                type: ['pie', 'funnel'],
		        	                option: {
		        	                    funnel: {
		        	                        x: '25%',
		        	                        width: '50%',
		        	                        funnelAlign: 'left',
		        	                        max: 1548
		        	                    }
		        	                }
		        	            },
		        	            restore : {show: true},
		        	            saveAsImage : {show: true}
		        	        }
		        	    },
		        	    calculable : true,
		        	    series : [
		        	        {
		        	            name:'访问来源',
		        	            type:'pie',
		        	            radius : '55%',
		        	            center: ['50%', '60%'],
		        	            data:function (){
		     		            	return getlabvau();
		     		            }()
		        	            
		        	        }
		        	    ]
		        
		        },true);	
		      //  toolbox.refresh(); 
		        window.onresize =	mychartbing.resize;
//			},//ajax执行后台
//			error: function(XMLHttpRequest, textStatus, errorThrown) {
//				closeTip();
//               alert("请求发生错误!");
//            }
//			}); 
//			
		
	  }//会调函数
	  );
	  }
///////////////
function getx()
{
	  return label;
}
function gety()
{
	  return value1;
}

function getlabvau()
{
	var data=$("#bindata").val();
	var str=data.split(";");
	var list = [];
	for(var i=0;i<str.length;i++)
		{
		list.push({
	        	   value : str[i].split(",")[0].split(":")[1],
	        	   name : str[i].split(",")[1].split(":")[1].replace("}","")
	        	        });
		}
return list;	
}
function getlabtitle()
{
	var data=$("#bintitle").val();
	var str=data.split(",");
	var list = [];
	for(var i=0;i<str.length;i++)
		{
		list.push(str[i]);
		}
return list;	
}
