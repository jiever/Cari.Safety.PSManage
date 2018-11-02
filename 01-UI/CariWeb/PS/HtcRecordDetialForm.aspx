<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dialog.Master" AutoEventWireup="true" CodeBehind="HtcRecordDetialForm.aspx.cs" Inherits="CariWeb.PS.HtcCorrentionDetialForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Content">
        <table class="table table-bordered mb0">
            <tr>
                <td width="100px" class="form-detail">隐患整改内容
                </td>
                <td colspan="5">
                    <asp:Label ID="YHNR" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="form-detail">隐患级别</td>
                <td>

                    <asp:Label ID="YHJB" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">整改时间</td>
                <td>

                    <asp:Label ID="ZGSJ" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">整改人</td>
                <td>
                    <asp:Label ID="ZGR" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="form-detail">隐患地点</td>
                <td>
                    <asp:Label ID="YHDD" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">复查时间</td>
                <td>
                    <asp:Label ID="FCSJ" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">检查人</td>
                <td>
                    <asp:Label ID="JCR" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="form-detail">检查类型</td>
                <td>
                    <asp:Label ID="JCLX" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">检查时间</td>
                <td>
                    <asp:Label ID="JCSJ" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">复查人</td>
                <td>
                    <asp:Label ID="FCR" runat="server" CssClass="control-label set"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="form-detail">整改情况</td>
                <td>
                    <asp:Label ID="ZGQK" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">整改结果</td>
                <td>
                    <asp:Label ID="ZGJG" runat="server" CssClass="control-label set"></asp:Label>
                </td>
                <td class="form-detail">复查结果</td>
                <td>
                    <asp:Label ID="FCJG" runat="server" CssClass="control-label set"></asp:Label>
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
