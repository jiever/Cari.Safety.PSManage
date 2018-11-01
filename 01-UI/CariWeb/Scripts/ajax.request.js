// 使用Ajax动态请求--主要针对aspx文件的请求
/**
 *	调用方式如下：
 *	doAjaxRequest({
		url: 'xxx.aspx',
		method: 'doAction',
		data: {
			name : '123',
			age : '22'
		}
	}, function(data){
		alert(data)
	})
 *
 *	[WebMethod]
	public static string doAction(string name, string age)
	{
		return "成功";
	}
 **/
function doAjaxRequest(args, callback) {
	//var loadIndex = clayer && clayer.load(1);
	$.ajax({
		type: 'post',
		url: args.url + "/" + args.method,
		data: JSON.stringify(args.data),
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (data) {
			try{
				callback && callback(data.d)
			} catch (e) {

			}
		},
		error: function (err) {

		},
		complete: function () {
			//clayer && clayer.close(loadIndex);
		}
	});
}