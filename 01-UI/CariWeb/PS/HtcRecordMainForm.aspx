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
                    <th style="width: 120px">检查人</th>
                    <th style="width: 120px">检查时间</th>
                    <th style="width: 120px">检查类型</th>
                    <th style="width: 120px">隐患地点</th>
                    <th style="width: 120px">隐患级别</th>
                    <th style="width: 120px">隐患类型</th>
                    <th style="width: 120px">所属专业</th>
                    <th>隐患内容</th>
                    <th style="width: 120px">整改落实情况</th>
                </tr>
            </thead>
            <asp:Repeater runat="server" ID="_Repeater">
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
                total: parseInt($("#<%=PageTotal.ClientID%>").val()) / 20 + ((parseInt($("#<%=PageTotal.ClientID%>").val()) % 20) == 0 ? 0 : 1),
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
                url: '<%=ResolveUrl("~/PS/HtcCorrentionDetialForm.aspx")%>?',
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
