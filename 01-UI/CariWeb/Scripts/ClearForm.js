
/**
* This function is to clear a form (or a container of implements such as table,tr ..).
* JK 
* formObj:the checked form
* exceptObjName:the name of whitch need not be checked;
* For example:clearForm(document.frm,"ACheckbox,BRadio,CSelect");
*/
function clearFormFun(formObj,exceptObjName)
{
if(formObj==null) formObj=document.forms[0];
if(exceptObjName==null) exceptObjName=="";
var selectObjs=formObj.getElementsByTagName("SELECT");//For Select Obj
for(var i=0;i<selectObjs.length;i++)
{
if((selectObjs[i].name=="")||(eval("/(^|,)"+selectObjs[i].name+"(,|$)/g").test(exceptObjName))) continue;
selectObjs[i].value="";
}

var inputObjs=formObj.getElementsByTagName("INPUT");//For Input Obj
for(var i=0;i<inputObjs.length;i++)
{
if((inputObjs[i].name=="")||(eval("/(^|,)"+inputObjs[i].name+"(,|$)/g").test(exceptObjName))) continue;
if(inputObjs[i].type.toUpperCase()=="TEXT")  inputObjs[i].value="";
else if((inputObjs[i].type.toUpperCase()=="RADIO")||(inputObjs[i].type.toUpperCase()=="CHECKBOX"))
inputObjs[i].checked=false;

}

var textareaObjs=formObj.getElementsByTagName("TEXTAREA");//For textarea Obj
for(var i=0;i<textareaObjs.length;i++)
{
if((textareaObjs[i].name=="")||(eval("/(^|,)"+textareaObjs[i].name+"(,|$)/g").test(exceptObjName))) continue;
textareaObjs[i].value="";
}
}