
        //---------------------------------------------
		function IsClick(CKFace)
		{
			var count=0;
			var obj =CKFace//document.getElementsByName("FaceCodeCK8");
			document.forms[0].TextBox1.value="";
			
			if(obj.length!=null)
			{
				for (var i=0;i<obj.length;i++)
				{
					if(obj[i].checked)
					{
						count++;
					}
				}
				if(count==0)
				{
					//alert('没有选中项');
					document.forms[0].TextBox1.value=""
					return false;
				}
				
				var str='(';
				
					for (var i=0;i<obj.length;i++)
					{
						if(obj[i].checked)
						{
							str += obj[i].value + ',';
						}else
						{
						
						}
					}
				document.forms[0].TextBox1.value=str.substring(0,str.length-1)+")"
			}
			else
			{
				//alert(obj.checked)
				if(obj.checked)
				{
					str= "(" + obj.value + ')';
					document.forms[0].TextBox1.value=str;
				}
				else
				{
					//alert('没有选中项');
					document.forms[0].TextBox1.value=""
					return false;
				}
			
			}
		}
		var ClickFlag=true;
		function SelectAll(CKFace)
		{
			var count=0;
			var obj =CKFace// document.getElementsByName(CKFace);
			
			//var IsNullCKFace=findObj(CKFace);
 			document.forms[0].TextBox1.value="";
			if(ClickFlag==true)
			{
				if(obj.length!=null)
				{
					for (var i=0;i<obj.length;i++)
					{
						obj[i].checked=true;
					}
					var str='(';
					for (var i=0;i<obj.length;i++)
					{
						if(obj[i].checked)
						{
							str += obj[i].value + ',';
						}else
						{
						
						}
					}
					document.forms[0].TextBox1.value=str.substring(0,str.length-1)+")"
				}
				else
				{
					obj.checked=true;
					str=obj.value;
					document.forms[0].TextBox1.value="("+str+")"
				}
				ClickFlag=false;
			}
			else
			{
				if(obj.length!=null)
				{
					for (var i=0;i<obj.length;i++)
					{
						obj[i].checked=false;
					}
					document.forms[0].TextBox1.value="";
				}
				else
				{
					obj.checked=false;
					document.forms[0].TextBox1.value="";
				}
				ClickFlag=true;
			}
		}

		function delonClick()
		{

			return false;
		} 
		function textbox1ValueChange()
		{
			document.forms[0].TextBox1.value=''
		} 

 		function findObj(theObj, theDoc)
		{
 			var p, i, foundObj;
  			if(!theDoc) theDoc = document;
  			if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  			{
    			theDoc = parent.frames[theObj.substring(p+1)].document;
    			theObj = theObj.substring(0,p);
  			}
  			if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  			for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    			foundObj = theDoc.forms[i][theObj];
  			for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    			foundObj = findObj(theObj,theDoc.layers[i].document);
  			if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  		return foundObj;
		}

		

