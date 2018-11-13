<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="RiskRangeMainForm.aspx.cs" Inherits="CariWeb.PS.RiskRangeMainForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    <%--风险识别范围--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-inline pd10 clearfix" id="MainColumn">
        <div class="form-group" style='<%=_type?"":"display:none"%>'>
            <label class="control-label">矿名：</label>
            <asp:DropDownList runat="server" ID="_Mine" CssClass="form-control" Width="120px" DataTextField="CoalName" DataValueField="Key"/>
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
                    <th style="width: 140px">辨识名称</th>
                    <th>描述</th>
                    <th style="width: 90px">类型</th>
                    <th style="width: 140px">开始时间</th>
                    <th style="width: 140px">结束时间</th>
                </tr>
            </thead>
            <asp:Repeater runat="server" ID="_Repeater">
                <ItemTemplate>
                    <tr>
                        <td><%#Eval("BSMC")%></td>
                        <td title='<%#Eval("MS")%>'><%#Eval("MS")%></td>
                        <td><%#Eval("LX")%></td>
                        <td><%#Eval("KSSJ")%></td>
                        <td><%#Eval("JSSJ")%></td>
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
    </script>
</asp:Content>
