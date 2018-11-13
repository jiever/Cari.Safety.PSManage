<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dialog.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="CariWeb.PS.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Content">
        <table class="table table-bordered mb0">
            <tr>
                <td width="100px" class="form-detail">id
                </td>
                <td>
                    <label id="id" class="control-label set"></label>
                </td>
            </tr>
            <tr>
                <td width="100px" class="form-detail">name
                </td>
                <td>
                    <label id="name" class="control-label set"></label>
                </td>
            </tr>
        </table>
    </div>
    <div class="modal-footer" style="text-align: right;">
        <button class="btn btn-primary" type="button" onclick="window.parent._closeDialog()">
            关闭</button>
    </div>
    <script>
        $(function () {
            debugger 
            var data = parent.GetObj();
            var labs = $("#Content").find(".set");
            labs.each(function (index, item) {
                $(item).text(data[item.id]);
                $(item).attr("title", data[item.id]);
            });
        })
    </script>
</asp:Content>
