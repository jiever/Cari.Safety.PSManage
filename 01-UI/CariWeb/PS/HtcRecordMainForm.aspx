﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="HtcRecordMainForm.aspx.cs" Inherits="CariWeb.PS.HtcRecordMainForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
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
            <label class="control-label">检查类型：</label>
            <asp:ListBox runat="server" ID="_CheckType" DataTextField="DataName" DataValueField="DataName" SelectionMode="Multiple" CssClass="multi-select" Width="120px"/>
        </div>
        <div class="form-group">
            <label class="control-label">所属专业：</label>
            <asp:ListBox runat="server" ID="_Major" DataTextField="DataName" DataValueField="DataName" SelectionMode="Multiple" CssClass="multi-select" Width="120px"/>
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
                    <th style="width: 90px">检查人</th>
                    <th style="width: 140px">检查时间</th>
                    <th style="width: 90px">检查类型</th>
                    <th style="width: 140px">隐患地点</th>
                    <th style="width: 90px">隐患级别</th>
                    <th style="width: 90px">隐患类型</th>
                    <th style="width: 90px">所属专业</th>
                    <th>隐患内容</th>
                    <th style="width: 100px">整改落实情况</th>
                </tr>
            </thead>
            <asp:Repeater runat="server" ID="_Repeater">
                <ItemTemplate>
                    <tr style='background: <%#Eval("Color")%>'>
                        <td><%#Eval("JCR")%></td>
                        <td><%#Eval("JCSJ")%></td>
                        <td><%#Eval("JCLX")%></td>
                        <td title="<%#Eval("YHDD")%>"><%#Eval("YHDD")%></td>
                        <td><%#Eval("YHJB")%></td>
                        <td><%#Eval("YHLX")%></td>
                        <td><%#Eval("SSZY")%></td>
                        <td title="<%#Eval("YHNR")%>"><%#Eval("YHNR")%></td>
                        <td>
                            <input type="hidden" name="YHNR" value="<%#Eval("YHNR")%>"/>
                            <input type="hidden" name="YHJB" value="<%#Eval("YHJB")%>"/>
                            <input type="hidden" name="ZGSJ" value="<%#Eval("ZGSJ")%>"/>
                            <input type="hidden" name="ZGR" value="<%#Eval("ZGR")%>"/>
                            <input type="hidden" name="YHDD" value="<%#Eval("YHDD")%>"/>
                            <input type="hidden" name="FCSJ" value="<%#Eval("FCSJ")%>"/>
                            <input type="hidden" name="JCR" value="<%#Eval("JCR")%>"/>
                            <input type="hidden" name="JCLX" value="<%#Eval("JCLX")%>"/>
                            <input type="hidden" name="JCSJ" value="<%#Eval("JCSJ")%>"/>
                            <input type="hidden" name="FCR" value="<%#Eval("FCR")%>"/>
                            <input type="hidden" name="ZGQK" value="<%#Eval("ZGQK")%>"/>
                            <input type="hidden" name="ZGJG" value="<%#Eval("ZGJG")%>"/>
                            <input type="hidden" name="FCJG" value="<%#Eval("FCJG")%>"/>
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
        var data = new Object();

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
        

        function openDetail(obj) {
            var hids = $(obj).closest("td");
            hids.find("input[type='hidden']").each(function(index, item) {
                data[item.name] = item.value;
            });
            openDialog({
                url: '<%=ResolveUrl("~/PS/HtcRecordDetialForm.aspx")%>?',
                title: "详情",
                height: 240,
                width: 700
            }, function () {
               
            });

        }
       
        function GetObj() {
            return data;
        }
    </script>
</asp:Content>
