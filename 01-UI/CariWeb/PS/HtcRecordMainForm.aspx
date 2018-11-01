<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="HtcRecordMainForm.aspx.cs" Inherits="CariWeb.PS.HtcRecordMainForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-inline pd10 clearfix" id="MainColumn">
        <div class="form-group">
            <label class="control-label">检查类型：</label>
            <asp:DropDownList runat="server" ID="_CheckType" CssClass="form-control" Width="120px"/>
        </div>
        <div class="form-group">
            <label class="control-label">所属专业：</label>
            <asp:DropDownList runat="server" ID="_Major" CssClass="form-control" Width="120px"/>
        </div>
        <div class="form-group">
            <label class="control-label">时间：</label>
            <asp:TextBox runat="server" Width="120px" ID="_Start" CssClass="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'_End\')}'})"></asp:TextBox>至
            <asp:TextBox runat="server" Width="120px" ID="_End" CssClass="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'_Start\')}'})"></asp:TextBox>
        </div>
        <div style="text-align: right; float: right;">
            <asp:Button runat="server" ID="_RequestButton" Text="查询" OnClick="_RequestButton_Click"
                        class="btn btn-primary" data-loading-text="正在查询" />
        </div>
    </div>
    <div class="pl10 pr10" id="main_list" style="overflow-y: auto; min-width: 1570px;">
        <table class="table table-bordered table-hover">
            <asp:Repeater runat="server" ID="_Repeater">
            <HeaderTemplate>
                <head>
                    <tr>
                        <th style="width: 90px">检查人</th>
                        <th style="width: 90px">检查时间</th>
                        <th style="width: 200px">检查类型</th>
                        <th style="width: 90px">隐患地点</th>
                        <th style="width: 90px">隐患级别</th>
                        <th style="width: 90px">隐患类型</th>
                        <th style="width: 90px">所属专业</th>
                        <th style="width: 130px">隐患内容</th>
                        <th style="width: 100px">整改落实情况</th>
                    </tr>
                </head>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%#Eval("JCR")%></td>
                    <td><%#Eval("JCSJ")%></td>
                    <td><%#Eval("JCLX")%></td>
                    <td><%#Eval("YHDD")%></td>
                    <td><%#Eval("YHJB")%></td>
                    <td><%#Eval("YHLX")%></td>
                    <td><%#Eval("SSZY")%></td>
                    <td><%#Eval("YHNR")%></td>
                    <td>
                        <a class="glyphicon glyphicon-edit" onclick="openEdit('<%#Eval("ID") %>')">编辑</a>
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
                total: parseInt($("#<%=PageTotal.ClientID%>").val()) / 20 + ((parseInt($("#<%=PageTotal.ClientID%>").val()) % 20) == 0 ? 0 : 1),
                totalRecords: $("#<%=PageTotal.ClientID%>").val(),
                click: function (n) {
                    $("#<%=PageIndex.ClientID%>").val(n);
                    $("form").submit();
                }
            });
            kkpager.selectPage($("#<%=PageIndex.ClientID%>").val());
        });
        function openEdit(id) {
            openDialog({
                url: '<%=ResolveUrl("~/AM/CasualtionBaseEditForm.aspx")%>?id=' + id,
                title: "事故维护",
                height: 450,
                width: 700
            }, function (retCode) {
                if (retCode) {
                    $("#<%=_RequestButton.ClientID%>").click();
                }
            });
        }
    </script>
</asp:Content>
