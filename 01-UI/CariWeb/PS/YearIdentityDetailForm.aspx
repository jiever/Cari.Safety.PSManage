<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dialog.Master" AutoEventWireup="true" CodeBehind="YearIdentityDetailForm.aspx.cs" Inherits="CariWeb.PS.YearRecognitionDetailForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Content">
        <table class="table table-bordered mb0">
            <tr>
                <td class="form-detail">风险地段</td>
                <td>

                    <asp:Label ID="FXDD" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">FXMS</td>
                <td>

                    <asp:Label ID="FXMS" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">FXLX</td>
                <td>
                    <asp:Label ID="FXLX" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="form-detail">管控措施</td>
                <td>
                    <asp:Label ID="GKCS" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="form-detail">负责人</td>
                <td>
                    <asp:Label ID="FZR" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">JGR</td>
                <td>
                    <asp:Label ID="JGR" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">JKZQ</td>
                <td>
                    <asp:Label ID="JKZQ" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="form-detail">ZT</td>
                <td>
                    <asp:Label ID="ZT" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">ZHLX</td>
                <td>
                    <asp:Label ID="ZHLX" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">KNDZSG</td>
                <td>
                    <asp:Label ID="KNDZSG" runat="server" CssClass="control-label set"></asp:Label>
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
            var labs = $("#Content").find(".set");
            labs.each(function (index, item) {
                $(item).text(data[item.id]);
            });
        })
    </script>
</asp:Content>
