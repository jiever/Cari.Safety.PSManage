<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="CariWeb.PS.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th style="width: 120px">id</th>
            <th style="width: 120px">name</th>
            <th>隐藏</th>
        </tr>
        </thead>
        <asp:Repeater runat="server" ID="_Repeater">
            <ItemTemplate>
                <tr>
                    <td><%#Eval("ID")%></td>
                    <td><%#Eval("Name")%></td>
                    <td>
                        <input name="id" type="hidden" value="<%#Eval("ID")%>"/>
                        <input name="name" type="hidden" value="<%#Eval("Name")%>"/>
                        <a href="javascript:void(0)" class="glyphicon glyphicon-edit" onclick="openDetail(this)">查看详情</a>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <script>

        var data=new Object();

        function openDetail(obj) {
            var hids = $(obj).closest("td");
            hids.find("input[type='hidden']").each(function(index, item) {
                data[item.name] = item.value;
            });
            openDialog({
                url: '<%=ResolveUrl("~/PS/WebForm2.aspx")%>?',
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
