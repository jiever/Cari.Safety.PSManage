<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="AmRecordMainForm.aspx.cs" Inherits="CariWeb.PS.AmRecordMainForm" %>
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
            <label class="control-label">部门：</label>
            <asp:ListBox runat="server" ID="_Dept" DataTextField="DataName" DataValueField="DataName" SelectionMode="Multiple" CssClass="multi-select" Width="120px"/>
        </div>
        <div class="form-group">
            <label class="control-label">事故等级：</label>
            <asp:ListBox runat="server" ID="_AmLevel" DataTextField="DataName" DataValueField="DataName" SelectionMode="Multiple" CssClass="multi-select" Width="120px"/>
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
                    <th style="width: 120px">责任部门</th>
                    <th style="width: 150px">事故发生地点</th>
                    <th>事故描述</th>
                    <th style="width: 120px">事故级别</th>
                    <th style="width: 120px">事故发生时间</th>
                    <th>事故紧急措施</th>
                    <th style="width: 120px">伤员情况</th>
                </tr>
            </thead>
            <asp:Repeater runat="server" ID="_Repeater">
                <ItemTemplate>
                    <tr>
                        <td><%#Eval("SGZRBM")%></td>
                        <td><%#Eval("SGFSDD")%></td>
                        <td><%#Eval("SGMS")%></td>
                        <td><%#Eval("SGJB")%></td>
                        <td><%#Eval("SGFSSJ")%></td>
                        <td><%#Eval("SGJJCS")%></td>
                        <td><%#Eval("SSZY")%></td>
                        <td>
                            <input type="hidden" name="XM" value="<%#Eval("XM")%>"/>
                            <input type="hidden" name="XB" value="<%#Eval("XB")%>"/>
                            <input type="hidden" name="NL" value="<%#Eval("NL")%>"/>
                            <input type="hidden" name="GZ" value="<%#Eval("GZ")%>"/>
                            <input type="hidden" name="SSCD" value="<%#Eval("SSCD")%>"/>
                            <input type="hidden" name="SSBW" value="<%#Eval("SSBW")%>"/>
                            <a class="glyphicon glyphicon-edit" onclick="openDetail(this)">查看详情</a>
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
        
        var data=new Object();

        function openDetail(obj) {
            var hids = $(obj).closest("td");
            hids.find("input[type='hidden']").each(function(index, item) {
                data[item.name] = item.value;
            });
            openDialog({
                url: '<%=ResolveUrl("~/PS/AmRecordDetailForm.aspx")%>?',
                title: "详情",
                height: 450,
                width: 700
            }, function () {
               
            });

        }
       
        function GetObj() {
            return data;
        }
    </script>
</asp:Content>
