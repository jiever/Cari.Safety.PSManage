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
                <tr style="background: <%#Eval("Color")%>">
                    <td><%#Eval("ID")%></td>
                    <td><%#Eval("Name")%></td>
                    <td>
                        <input name="id" type="hidden" value="<%#Eval("ID")%>"/>
                        <input name="name" type="hidden" value="<%#Eval("Name")%>"/>
                        <input name="childs" type="hidden" value='<%#Eval("Childs")%>'/>
                        <a href="javascript:void(0)" class="glyphicon glyphicon-edit" onclick="openDetail(this)">查看详情</a>
                        <a href="javascript:void(0)" class="glyphicon glyphicon-edit" onclick="openKO(this)">ko</a>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <script>

        var data=new Object();
        var koDataP = new Array();

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
      
        function openKO(obj) {
            debugger 
            var hids = $(obj).closest("td");
            var childStr = hids.find("input[name='childs']").val();
            var jobect = JSON.parse(childStr);
            GetKOData(jobect);

            openDialog({
                url: '<%=ResolveUrl("~/PS/WebForm3.aspx")%>?',
                title: "ko详情",
                height: 450,
                width: 700
            }, function () {
               
            });
        }

        function GetObj() {
            return data;
        }

        function GetKOData(str) {
            koDataP = eval(str);
            return koDataP;
        }
    </script>
</asp:Content>
