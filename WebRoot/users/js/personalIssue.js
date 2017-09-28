/* 全局变量 */
var baseUrl = "";/*项目地址*/


function getdata(){
	
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : baseUrl+"/users/login.action",  //需要访问的地址
		    data : "username="+username+"&password="+password,  //传递到后台的参数
		    success:function(data){
		    	
		    },error:function(data){
		    	
		    }
		});
	}
	
	
