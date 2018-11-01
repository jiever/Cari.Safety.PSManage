///弹出出口并返回ID,Name
function getChildValue(JScriptUrl,ControlID,ControlIDHidden,ModalUrl,OpenTitle,MWidth,MHeight,ParamSend)
{
  //  if(ParamSend=="")
  //  {
  //      ParamSend = "?";
  //  }
  ////  alert(JScriptUrl+"OpenPage_Info.htm?LinkName=../"+ModalUrl+ParamSend+"%26TitleName="+OpenTitle+"%26onClickSystemID="+ControlID+"%26"+Date.parse(new Date()))
  //  var getSelected=window.showModalDialog(ModalUrl+"%26TitleName="+OpenTitle+"%26onClickSystemID="+ControlID+"%26"+Date.parse(new Date()),null,"status:no;center:yes;help:no;minimize:no;maximize:no;dialogWidth:"+MWidth+"px;scroll:no;dialogHeight:"+MHeight+"px;scroll:no;edge:raised;");
  //  //var getSelected=window.showModalDialog(ModalUrl+ParamSend+"&TitleName="+OpenTitle+"&"+Date.parse(new Date()),null,"status:no;center:yes;help:no;minimize:no;maximize:no;dialogWidth:"+MWidth+"px;scroll:no;dialogHeight:"+MHeight+"px;scroll:no;edge:raised;");
  //  alert(getSelected);
  //  if (getSelected != null) {        
  //  	document.all[ControlID].value=getSelected[0];
  //  	document.all[ControlIDHidden].value=getSelected[1];
  //  }
    openDialog({
        url:getRootUrl() +'/' + ModalUrl,
        title: OpenTitle,
        height: MHeight,
        width: MWidth,
    }, function(ret) {
        $('#' + ControlID).val(ret[0]);
        $('#' + ControlIDHidden).val(ret[1]);
    });
}

///弹出出口并返回ID,Name
function getChildValue1(ControlID,ControlIDHidden,ModalUrl,OpenTitle,MWidth,MHeight,ParamSend)
{
    if(ParamSend=="")
    {
        ParamSend = "?";
    }
     // alert("../SystemManage/JScript/OpenPage_Info.htm?LinkName=../"+ModalUrl+ParamSend+"%26TitleName="+OpenTitle+"%26onClickSystemID="+ControlID+"%26"+Date.parse(new Date()))
    
    var getSelected=window.showModalDialog("../SystemManage/JScript/OpenPage_Info.htm?LinkName=../../"+ModalUrl+ParamSend+"%26TitleName="+OpenTitle+"%26onClickSystemID="+ControlID+"%26"+Date.parse(new Date()),null,"status:no;center:yes;help:no;minimize:no;maximize:no;dialogWidth:"+MWidth+"px;scroll:no;dialogHeight:"+MHeight+"px;scroll:no;edge:raised;");
	if(getSelected!=null)
	{
		document.all[ControlID].value=getSelected[0];
		document.all[ControlIDHidden].value=getSelected[1];
	}
}

///DataGrid中复选框的全部选择,用于新的无需要TextBox1的全选和单选
var IsClickFlag=false;
function SelectAllChecked()
{
   
	var count=0;
	var obj =document.getElementsByTagName("input");
	if(!IsClickFlag)
	{
		for(var j=0;j<obj.length;j++)
		{
		
			if((obj[j].type=="checkbox")&&(obj[j].id.indexOf("Selected")!=-1))
			{
				obj[j].checked=true;
				IsClickFlag=true
				ChangeAllColor(true);
			}
		}
		
	}else
	{
		for(var j=0;j<obj.length;j++)
		{
			if((obj[j].type=="checkbox")&&(obj[j].id.indexOf("Selected")!=-1))
			{
				obj[j].checked=false;
				IsClickFlag=false
				ChangeAllColor(false);
			}
		}
	}
}
//------Open a form with default size ------------------------
//TargetUrl: A form need to be open
//Type: Two type ,one is "Add" ,the other is "Modify"
//ParamString: Many parameters ,Such as &EmployeeID=cs001&EmployeeName=chenxiao
function openWin(TargetUrl,Type,ParamString,OpenTitle,SWidth,SHeight)
{
    var iHeight =SHeight;
    var iWidth =SWidth;
    var iTop = 205;
    var iLeft = 150;
    
    var sURL = TargetUrl + "?Type=" + Type + ParamString;

    openDialog({
        url:getRootUrl()+ '/' + sURL,
        title: OpenTitle,
        height: iHeight,
        width: iWidth
    });
	//window.open(sURL,OpenTitle,"height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft+",toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=no, status=no");
}


//来打开一个新的页面,共定义三种大小，默认大小模式框，小模式框，大模式框，当录入单元小于22称为小模式框，当录入框大于103时候属于大模式框，介于这两者之间属于小模式
function openWinModal(TargetUrl,Type,ParamString,OpenTitle,SWidth,SHeight)
{

    var iHeight = SHeight;
    var iWidth =SWidth;
    var iTop = 205;
    var iLeft = 150;
    var ControlID="";
    
   var modalUrl = TargetUrl+"?Type="+Type+ParamString;
   
    //var isNormalClose = window.showModalDialog("../Script/OpenPage_Info.htm?LinkName=../"+modalUrl+"%26TitleName="+OpenTitle+"%26onClickSystemID="+ControlID+"%26"+Date.parse(new Date()),null,"status:no;center:yes;help:no;minimize:no;maximize:no;dialogTop:"+iTop+"px;dialogWidth:"+iLeft+"px;dialogWidth:"+iWidth+"px;scroll:no;dialogHeight:"+iHeight+"px;scroll:no;edge:raised;");
    
    var isNormalClose = window.showModalDialog("../js/OpenPage_Info.htm?LinkName=../"+modalUrl+"%26TitleName="+OpenTitle,null,"status:no;center:yes;help:no;minimize:no;maximize:no;dialogTop:"+iTop+"px;dialogWidth:"+iLeft+"px;dialogWidth:"+iWidth+"px;scroll:no;dialogHeight:"+iHeight+"px;scroll:no;edge:raised;");
    
    if(isNormalClose!=null)
    {
    document.all("ButtonQuery").click()
    }
}
//Open a form with specical size -------------------------------------/
//TargetUrl: A form need to be open

//Type: Two type ,one is "Add" ,the other is "Modify"
//ParamString: Many parameters ,Such as &EmployeeID=cs001&EmployeeName=chenxiao
function oPenSpecWin(TargetUrl,Type,ParamString,CHeight,CWidth,CTop,CLeft)
{
	var sURL = TargetUrl+"?Type="+Type+ParamString;
	window.open(sURL,"","height="+CHeight+", width="+CWidth+", top="+CTop+", left="+CLeft+",toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
}		


function showModalSize(JScriptUrl,ModalUrl,MWidth,MHeight,OpenTitle)
		{
		    window.showModalDialog(JScriptUrl+"OpenPage_Info.htm?LinkName=../"+ModalUrl+"%26TitleName="+OpenTitle+"%26"+Date.parse(new Date()),null,"status:no;center:yes;help:no;minimize:no;maximize:no;dialogWidth:"+MWidth+"px;scroll:no;dialogHeight:"+MHeight+"px;scroll:no;edge:sunken");
				
        }
        
//------------------------------------------------------
//--原有的JSForm.js内容
		var CurrentControlID;
		function viewDisenable()
		{
			CurrentControlID.value=frames["popFrame"].document.forms[0].Employee.options(frames["popFrame"].document.forms[0].Employee.selectedIndex).text;
			document.all[CurrentControlID.id+"ID"].value=frames["popFrame"].document.forms[0].Employee.options(frames["popFrame"].document.forms[0].Employee.selectedIndex).value;
			document.all["AddList"].style.visibility='hidden';
		}
		
		function viewDisenable1()
		{
			CurrentControlID.value=frames["popFrame"].document.forms[0].Employee.options(frames["popFrame"].document.forms[0].Employee.selectedIndex).text;
			//document.all[CurrentControlID.id+"ID"].value=frames["popFrame"].document.forms[0].Employee.options(frames["popFrame"].document.forms[0].Employee.selectedIndex).value;
			document.all["AddList"].style.visibility='hidden';
		}
		
		function viewDisenablePerson()
		{
			CurrentControlID.value=frames["popFrame"].document.forms[0].Employee.options(frames["popFrame"].document.forms[0].Employee.selectedIndex).text;
			//document.all[CurrentControlID.id+"ID"].value=frames["popFrame"].document.forms[0].Employee.options(frames["popFrame"].document.forms[0].Employee.selectedIndex).value;
			document.all["AddList"].style.visibility='hidden';
		}
		
		function viewEnable(TWidth,THeight,ControlID)
		{
			CurrentControlID=ControlID;
			var rightedge=document.body.clientWidth-event.clientX;
			var bottomedge=document.body.clientHeight-event.clientY;
			if (rightedge<AddList .offsetWidth)
			AddList .style.left=document.body.scrollLeft+event.clientX-AddList .offsetWidth;
			else
			AddList .style.left=document.body.scrollLeft+event.clientX;
			if (bottomedge<AddList.offsetHeight)
			AddList.style.top=document.body.scrollTop+event.clientY-AddList.offsetHeight;
			else
			AddList.style.top=document.body.scrollTop+event.clientY;
			AddList.style.width=TWidth;
			AddList.style.height=THeight;
			AddList.style.visibility="visible"
			document.all["popFrame"].height=THeight-20;
			document.all["popFrame"].src='Safe_PersonByDepart.aspx';
			return false;
		}
		function viewEnablePerson(TWidth,THeight,ControlID,SrcPage)
		{
			CurrentControlID=ControlID;
			var rightedge=document.body.clientWidth-event.clientX;
			var bottomedge=document.body.clientHeight-event.clientY;
			if (rightedge<AddList .offsetWidth)
			AddList .style.left=document.body.scrollLeft+event.clientX-AddList .offsetWidth;
			else
			AddList .style.left=document.body.scrollLeft+event.clientX;
			if (bottomedge<AddList.offsetHeight)
			AddList.style.top=document.body.scrollTop+event.clientY-AddList.offsetHeight;
			else
			AddList.style.top=document.body.scrollTop+event.clientY;
			AddList.style.width=TWidth;
			AddList.style.height=THeight;
			AddList.style.visibility="visible"
			document.all["popFrame"].height=THeight-20;
			document.all["popFrame"].src=SrcPage;
			return false;
		}
	
		function viewEnableDiv(TWidth,THeight,ControlID,SrcPage)
		{
			CurrentControlID=ControlID;
			var rightedge=document.body.clientWidth-event.clientX;
			var bottomedge=document.body.clientHeight-event.clientY;
			if (rightedge<DateList .offsetWidth)
			DateList .style.left=document.body.scrollLeft+event.clientX-DateList .offsetWidth;
			else
			DateList .style.left=document.body.scrollLeft+event.clientX;
			if (bottomedge<DateList.offsetHeight)
			DateList.style.top=document.body.scrollTop+event.clientY-DateList.offsetHeight;
			else
			DateList.style.top=document.body.scrollTop+event.clientY;
			DateList.style.width=TWidth;
			DateList.style.height=THeight;
			DateList.style.visibility="visible"
			document.all["DatePopFrame"].height=THeight-20;
			document.all["DatePopFrame"].src=SrcPage;
			return false;
		}
	
		function viewDisenableSort()
		{
		   if(frames["popFrameSort"].document.forms[0].ThreeCodeFirstSortList.options(frames["popFrameSort"].document.forms[0].ThreeCodeFirstSortList.selectedIndex).value!='0'&&frames["popFrameSort"].document.forms[0].ThreeCodeSecondSortList.options(frames["popFrameSort"].document.forms[0].ThreeCodeSecondSortList.selectedIndex).value!=0&&frames["popFrameSort"].document.forms[0].ThreeCodeThirdSortList.options(frames["popFrameSort"].document.forms[0].ThreeCodeThirdSortList.selectedIndex).value!='0')
		   {
		  document.forms[0].ThreeCodeSortName.value=frames["popFrameSort"].document.forms[0].ThreeCodeThirdSortList.options(frames["popFrameSort"].document.forms[0].ThreeCodeThirdSortList.selectedIndex).value+"---"+frames["popFrameSort"].document.forms[0].ThreeCodeThirdSortList.options(frames["popFrameSort"].document.forms[0].ThreeCodeThirdSortList.selectedIndex).text;
			document.all["SortList"].style.visibility='hidden';
			}
			else
			{
			alert("您还没有选择类别!");
			}
		}
		//------------
		function viewCancel(DivListA)
		{ 
		document.all[DivListA.id].style.visibility='hidden';
		}
		function viewEnableSort(TWidth,THeight,ControlID,SrcPage)
		{
			CurrentControlID=ControlID;
			var rightedge=document.body.clientWidth-event.clientX;
			var bottomedge=document.body.clientHeight-event.clientY;
			if (rightedge<SortList .offsetWidth)
			SortList .style.left=document.body.scrollLeft+event.clientX-SortList .offsetWidth;
			else
			SortList .style.left=document.body.scrollLeft+event.clientX;
			if (bottomedge<SortList.offsetHeight)
			SortList.style.top=document.body.scrollTop+event.clientY-SortList.offsetHeight;
			else
			SortList.style.top=document.body.scrollTop+event.clientY;
			SortList.style.width=TWidth;
			SortList.style.height=THeight;
			SortList.style.visibility="visible"
			document.all["popFrameSort"].height=THeight-20;
			document.all["popFrameSort"].src=SrcPage;
			return false;
		}
//------------------------------------------------------
// Change color, this will be called by the mouseover event of the datagrid
function CG(obj) {
    return;
	if (event.type.toLowerCase()=="dblclick")
	{
		DblClickRow(obj);
	}
	else if(event.type.toLowerCase()=="click")
	{
		ClickRow(obj);
	}
	
	//var checkobject=obj.getElementsByTagName("input");			
	//if (checkobject(0) != null && checkobject(0) != undefined)
	//{
	//	if (event.srcElement.tagName != "input" && event.srcElement.tagName != "INPUT"){
	//		if(checkobject(0).disabled!=true)
	//		checkobject(0).checked=!checkobject(0).checked;
	//	}
	//}								
}


function ClickRow(_row)
{
	var obj =document.getElementsByTagName("input");
	var pTable = MainDataGrid;
	var count=0;
	if (pTable != null)
	{
		if(!_row.checkstatus)
		{
			_row.oldBgColor=_row.style.backgroundColor;
			_row.style.backgroundColor="#bfcadf";
			_row.checkstatus =true;
		}
		else
		{
			_row.style.backgroundColor=_row.oldBgColor;
			_row.checkstatus = false;
		}
	}
	
	for(var j=0;j<obj.length;j++)
	{
		if((obj[j].type=="checkbox")&&(obj[j].id.indexOf("Selected")!=-1))
		{
			if(obj[j].checked)
			{
				count++
			}
		}
	}

	if((pTable.rows.length-2)==count)
	{
		IsClickFlag=true
	}
}




function DblClickRow(_row)
{
	var pTable = MainDataGrid;
	if (pTable != null)
	{ 
		var rowArr = pTable.rows;
		//alert(rowArr.length)
		var rowCount = rowArr.length;
		
		for (i=0; i<rowArr.length; i++)
		{
			var tmpRow = rowArr[i];
			if (tmpRow.getAttribute("onmouseout") != null 
				&& tmpRow.getAttribute("onmouseout") != undefined)
			{
				tmpRow.style.backgroundColor="white";
				tmpRow.checkstatus = null;
			}
		}
		_row.style.backgroundColor="#DDE3FF";
		_row.checkstatus = "1";
	}
}
       
//-----------------------------------------------------        		
var oldBackgroundColor;
//
function onMouseOver(row) {
		with(row) 
		{
			
			if(style.backgroundColor != "#bfcadf")
			{
				    oldBackgroundColor = style.backgroundColor;
					style.backgroundColor='#9FBDE0';
			}
		}
}

function onMouseOut(row) {
	with(row) {
		if(style.backgroundColor != "#bfcadf")
		{
				style.backgroundColor=oldBackgroundColor;
				//style.backgroundColor='white';
		}
	}
}


	///使用YearMonthDayDownDropList自定义控件作为日期选择,解决闰年问题
		function viewDisenableDivLeap()
		{
	        
			CurrentControlID.value=frames["DatePopFrame"].document.forms[0].YearMonthDayDownDropList1_TextBoxDateTime.value;
        	document.all["DateList"].style.visibility='hidden';
		}
				
		function viewEnableDiv(TWidth,THeight,ControlID,SrcPage)
		{   
		   
			CurrentControlID=ControlID;
			var rightedge=document.body.clientWidth-event.clientX;
			var bottomedge=document.body.clientHeight-event.clientY;
			if (rightedge<DateList .offsetWidth)
			DateList .style.left=document.body.scrollLeft+event.clientX-DateList .offsetWidth;
			else
			DateList .style.left=document.body.scrollLeft+event.clientX;
			if (bottomedge<DateList.offsetHeight)
			DateList.style.top=document.body.scrollTop+event.clientY-DateList.offsetHeight;
			else
			DateList.style.top=document.body.scrollTop+event.clientY;
			DateList.style.width=TWidth;
			DateList.style.height=THeight;
			DateList.style.visibility="visible"
			document.all["DatePopFrame"].height=THeight-20;
			
			document.all["DatePopFrame"].src=SrcPage;

			return false;
		}




function ChangeAllColor(flag)
{
    //var pTable = GetParentTable(flag);
	if(flag)
	{
		for(i=0;i<MainDataGrid.rows.length-2;i++) 
		{
			MainDataGrid.rows[i+1].style.backgroundColor="#bfcadf";
			MainDataGrid.rows[i+1].checkstatus =true;

		}
	}
	else
	{
		for(i=0;i<MainDataGrid.rows.length-2;i++) 
		{
			MainDataGrid.rows[i+1].checkstatus =false;
			MainDataGrid.rows[i+1].style.backgroundColor="";
		}
	}
}
/****************************************/
