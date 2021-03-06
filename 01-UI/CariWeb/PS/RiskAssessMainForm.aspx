﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="RiskAssessMainForm.aspx.cs" Inherits="CariWeb.PS.RiskAssessMainForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
   <%-- 风险评估--%>
    <link href="../Scripts/bootstrap-multiselect.css" rel="stylesheet" type="text/css"/>
    <script src="../Scripts/bootstrap-multiselect.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        $(function() {
            $('.multi-select').multiselect({
                includeSelectAllOption: true,
                selectAllText: '全部',
                nonSelectedText: '-- 请选择 --',
                numberDisplayed: 2,
                nSelectedText: '项已选',
                allSelectedText: '全选',
                onChange: function () {
                }
            });
        })
    </script>
    <div class="form-inline pd10 clearfix" id="MainColumn">
        <div class="form-group" style='<%=_type?"":"display:none"%>'>
            <label class="control-label">矿名：</label>
            <asp:DropDownList runat="server" ID="_Mine" CssClass="form-control" Width="120px" DataTextField="CoalName" DataValueField="Key"/>
        </div>
        <div class="form-group">
            <label class="control-label">年份：</label>
            <asp:TextBox runat="server" Width="120px" ID="_Year" CssClass="form-control" onClick="WdatePicker({dateFmt:'yyyy'})"></asp:TextBox>
        </div>
        <div class="form-group">
            <label class="control-label">风险类型：</label>
            <asp:ListBox runat="server" ID="_FXLX" DataTextField="DataName" DataValueField="DataName" SelectionMode="Multiple" CssClass="multi-select" Width="120px"/>
        </div>
        <div class="form-group">
            <label class="control-label">专业类型：</label>
            <asp:ListBox runat="server" ID="_ZYLX" DataTextField="DataName" DataValueField="DataName" SelectionMode="Multiple" CssClass="multi-select" Width="120px"/>
        </div>
        <div class="form-group">
            <label class="control-label">责任人：</label>
            <asp:TextBox runat="server" ID="_ZRR" Width="120px" CssClass="form-control"></asp:TextBox>
        </div>
        <div style="text-align: right; float: right;">
            <asp:Button runat="server" ID="_RequestButton" Text="查询" OnClick="_RequestButton_Click"
                        class="btn btn-primary" data-loading-text="正在查询" />
        </div>
    </div>
    <div class="pl10 pr10" id="main_list">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th style="width: 60px">年度</th>
                    <th style="width: 120px">风险来源</th>
                    <th style="width: 140px">风险地点</th>
                    <th style="width: 200px">风险描述</th>
                    <th style="width: 90px">风险类型</th>
                    <th style="width: 90px">专业类型</th>
                    <th style="width: 90px">灾害类型</th>
                    <th style="width: 140px">可能导致事故</th>
                    <th style="width: 200px">管理措施</th>
                    <th style="width: 90px">责任人</th>
                    <th style="width: 90px">风险级别</th>
                </tr>
            </thead>
            <asp:Repeater runat="server" ID="_Repeater">
                <ItemTemplate>
                    <tr>
                        <td><%#Eval("ND")%></td>
                        <td title="<%#Eval("FXLY")%>"><%#Eval("FXLY")%></td>
                        <td title="<%#Eval("FXDD")%>"><%#Eval("FXDD")%></td>
                        <td title="<%#Eval("FXMS")%>"><%#Eval("FXMS")%></td>
                        <td><%#Eval("FXLX")%></td>
                        <td><%#Eval("ZYLX")%></td>
                        <td><%#Eval("ZHLX")%></td>
                        <td title="<%#Eval("KNDZSG")%>"><%#Eval("KNDZSG")%></td>
                        <td title="<%#Eval("GLCS")%>"><%#Eval("GLCS")%></td>
                        <td><%#Eval("ZRR")%></td>
                        <td><%#Eval("FXJB")%></td>
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
        </script>
</asp:Content>
