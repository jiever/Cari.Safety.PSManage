﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="YearIdentityMainFrom.aspx.cs" Inherits="CariWeb.PS.YearIdentityMainFrom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
   <%-- 年度辨识管理--%>
    <link href="../Scripts/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bootstrap-multiselect.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-inline pd10 clearfix" id="MainColumn">
        <div class="form-group" style='<%=_type?"": "display:none"%>'>
            <label class="control-label">矿名：</label>
            <asp:DropDownList runat="server" ID="_Mine" CssClass="form-control" Width="120px" DataTextField="CoalName" DataValueField="Key" />
        </div>
        <div class="form-group">
            <label class="control-label">年份：</label>
            <asp:TextBox runat="server" Width="80px" ID="_Year" CssClass="form-control" onClick="WdatePicker({dateFmt:'yyyy'})"></asp:TextBox>
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
                    <th style="width: 60px">年度</th>
                    <th style="width: 90px">风险数量</th>
                    <th style="width: 90px">主持人</th>
                    <th style="width: 90px">记录人</th>
                    <th>备注</th>
                    <th style="width: 90px">详情</th>
                </tr>
            </thead>
            <asp:Repeater runat="server" ID="_Repeater">
                <ItemTemplate>
                    <tr>
                        <td><%#Eval("ND")%></td>
                        <td><%#Eval("FXSL")%></td>
                        <td><%#Eval("ZCR")%></td>
                        <td><%#Eval("JLR")%></td>
                        <td title='<%#Eval("BZ")%>'><%#Eval("BZ")%></td>
                        <td>
                            <input type="hidden" name="XQList" value='<%#Eval("StrLstYearIdentityRisks")%>' />
                            <a href="javascript:void(0)" class="glyphicon glyphicon-edit" onclick="openDetail(this)">查看详情</a>
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
            var childStr = hids.find("input[name='XQList']").val();
            console.log(childStr)
            var jobect = JSON.parse(childStr);
            GetKOData(jobect);

            openDialog({
                url: '<%=ResolveUrl("~/PS/YearIdentityDetailForm.aspx")%>',
                title: "详情",
                height: 450,
                width: 1000
            }, function () {

            });

        }
        function GetKOData(str) {
            koDataP = eval(str);
            return koDataP;
        }
    </script>
</asp:Content>
