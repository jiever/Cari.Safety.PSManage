<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="NoSafetyActionMainForm.aspx.cs" Inherits="CariWeb.PS.NoSafetyActionMainForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    <%--不安全行为页面--%>
    <link href="../Scripts/bootstrap-multiselect.css" rel="stylesheet" type="text/css"/>
    <script src="../Scripts/bootstrap-multiselect.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-inline pd10 clearfix" id="MainColumn">
        <div class="form-group" style='<%=_type?"":"display:none"%>'>
            <label class="control-label">矿名：</label>
            <asp:DropDownList runat="server" ID="_Mine" CssClass="form-control" Width="120px" DataTextField="CoalName" DataValueField="Key"/>
        </div>
        <div class="form-group">
            <label class="control-label">时间：</label>
            <asp:TextBox runat="server" Width="120px" ID="_Start" CssClass="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'_End\')}'})"></asp:TextBox><label class="control-label">至</label>
            <asp:TextBox runat="server" Width="120px" ID="_End" CssClass="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'_Start\')}'})"></asp:TextBox>
        </div>
        <div style="text-align: right; float: right;">
            <asp:Button runat="server" ID="_RequestButton" Text="查询" OnClick="_RequestButton_Click"
                        class="btn btn-primary" data-loading-text="正在查询" />
        </div>
    </div>
    <div class="pl10 pr10" id="main_list" style="overflow-y: auto;">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th style="width: 150px">发生时间</th>
                    <th style="width: 120px">不安全人员</th>
                    <th style="width: 90px">部门</th>
                    <th style="width: 120px">工种</th>
                    <th style="width: 90px">班次</th>
                    <th style="width: 120px">检查人</th>
                    <th style="width: 200px">不安全行为描述</th>
                    <th>处理意见</th>
                    <th style="width: 120px">扣罚款情况</th>
                </tr>
            </thead>
            <asp:Repeater runat="server" ID="_Repeater">
                <ItemTemplate>
                    <tr>
                        <td><%#Eval("FSRQ")%></td>
                        <td><%#Eval("BAQXWRY")%></td>
                        <td><%#Eval("BM")%></td>
                        <td><%#Eval("GZ")%></td>
                        <td><%#Eval("BC")%></td>
                        <td><%#Eval("JCR")%></td>
                        <td><%#Eval("BAQXWMS")%></td>
                        <td><%#Eval("CLYJ")%></td>
                        <td>
                            <input type="hidden" name="StrFines" value="<%# Newtonsoft.Json.JsonConvert.SerializeObject( Eval("StrFines"))%>"/>
                            <a class="glyphicon glyphicon-edit" onclick="openDetail(this)">扣罚款情况</a>
                        </td>
                    </tr>
            </ItemTemplate>
        </asp:Repeater>
        </table>
    </div>
    <div class="panel-footer">
        <div id="kkpager"></div>
        <asp:HiddenField runat="server" ID="PageIndex" Value="1" />
        <asp:HiddenField runat="server" ID="PageTotal" />
    </div>
    <script type="text/javascript">
        $(function () {
            kkpager.generPageHtml({
                pno: $("#<%=PageIndex.ClientID%>").val(),
                mode: 'click',
                total: parseInt($("#<%=PageTotal.ClientID%>").val()) / 10 + ((parseInt($("#<%=PageTotal.ClientID%>").val()) % 10) == 0 ? 0 : 1),
                totalRecords: $("#<%=PageTotal.ClientID%>").val(),
                click: function (n) {
                    $("#<%=PageIndex.ClientID%>").val(n);
                    $("form").submit();
                }
            });
            kkpager.selectPage($("#<%=PageIndex.ClientID%>").val());
        });
        
        var koDataP = new Array();

        function openDetail(obj) {
            var hids = $(obj).closest("td");
            var childStr = hids.find("input[name='StrFines']").val();
            var jobect = JSON.parse(childStr);
            GetKOData(jobect);

            openDialog({
                url: '<%=ResolveUrl("~/PS/NoSafetyActionDetialForm.aspx")%>?',
                title: "扣罚款情况详情",
                height: 450,
                width: 700
            }, function () {
               
            });

        }
       
        function GetKOData(str) {
            koDataP = eval(str);
            return koDataP;
        }
    </script>
</asp:Content>
