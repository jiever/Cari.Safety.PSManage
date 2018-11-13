<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dialog.Master" AutoEventWireup="true" CodeBehind="AmRecordDetailForm.aspx.cs" Inherits="CariWeb.PS.AmRecordDetailForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Content">
        <table class="table table-bordered mb0">
            <tr>
                <td width="100px" class="form-detail">姓名
                </td>
                <td>
                    <asp:Label ID="XM" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td width="100px" class="form-detail">性别
                </td>
                <td>
                    <asp:Label ID="XB" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td width="100px" class="form-detail">年龄
                </td>
                <td>
                    <asp:Label ID="NL" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="100px" class="form-detail">工种
                </td>
                <td>
                    <asp:Label ID="GZ" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td width="100px" class="form-detail">受伤程度
                </td>
                <td>
                    <asp:Label ID="SSCD" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td width="100px" class="form-detail">受伤部位
                </td>
                <td>
                    <asp:Label ID="SSBW" runat="server" CssClass="control-label set"></asp:Label>
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
            var p = top.fraMain || parent;
            var data = p.GetObj();
            var labs = $("#Content").find(".set");
            labs.each(function (index, item) {
                $(item).text(data[item.id]);
            });
        })
    </script>
</asp:Content>
