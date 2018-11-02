<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dialog.Master" AutoEventWireup="true" CodeBehind="NoSafetyActionDetialForm.aspx.cs" Inherits="CariWeb.PS.NoSafetyActionDetialForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Content">
        <table class="table table-bordered mb0">
            <tr>
                <td class="form-detail">姓名</td>
                <td>
                    <asp:Label ID="XM" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">职务</td>
                <td>

                    <asp:Label ID="ZW" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">单位</td>
                <td>
                    <asp:Label ID="DW" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="form-detail">罚款原因</td>
                <td>
                    <asp:Label ID="FKYY" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">罚款单位</td>
                <td>
                    <asp:Label ID="FKDW" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">罚款金额</td>
                <td>
                    <asp:Label ID="FKJE" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="form-detail">罚款时间</td>
                <td>
                    <asp:Label ID="FKSJ" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">经办人</td>
                <td>
                    <asp:Label ID="JBR" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">是否通知</td>
                <td>
                    <asp:Label ID="SFTZ" runat="server" CssClass="control-label set"></asp:Label>
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
            var data = parent.GetObj();
            console.log(data);
            var labs = $("#Content").find(".set");
            labs.each(function (index, item) {
                $(item).text(data[item.id]);
            });
        })
    </script>
</asp:Content>
