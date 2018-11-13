<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dialog.Master" AutoEventWireup="true" CodeBehind="YearIdentityDetailForm.aspx.cs" Inherits="CariWeb.PS.YearRecognitionDetailForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../Scripts/knockout-3.3.0.js" type="text/javascript"></script>
    <div id="kobind" class="form-inline pt10">
        <ul data-bind="foreach: koData">
            <li>
                <table class="table table-bordered table-hover">
                    <tr>
                        <td class="form-detail" style="width: 100px">风险地段</td>
                        <td>
                            <label class="control-label" data-bind="text: FXDD, attr: {title:FXDD}"></label>
                        </td>
                        <td class="form-detail" style="width: 100px">风险描述</td>
                        <td>
                            <label class="control-label" data-bind="text:FXMS, attr: {title:FXMS}"></label>
                        </td>
                        <td class="form-detail" style="width: 100px">风险类型</td>
                        <td>
                            <label class="control-label" data-bind="text:FXLX, attr: {title:FXLX}"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-detail">专业类型</td>
                        <td>
                            <label class="control-label" data-bind="text:ZYLX, attr: {title:ZYLX}"></label>
                        </td>
                        <td class="form-detail">管控措施</td>
                        <td colspan="3">
                            <label class="control-label" data-bind="text:GKCS, attr: {title:GKCS}"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-detail">负责人</td>
                        <td>
                            <label class="control-label" data-bind="text:FZR, attr: {title:FZR}"></label>
                        </td>
                        <td class="form-detail">监管人</td>
                        <td>
                            <label class="control-label" data-bind="text:JGR, attr: {title:JGR}"></label>
                        </td>
                        <td class="form-detail">监控周期</td>
                        <td>
                            <label class="control-label" data-bind="text:JKZQ, attr: {title:JKZQ}"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-detail">状态</td>
                        <td>
                            <label class="control-label" data-bind="text:ZT, attr: {title:ZT}"></label>
                        </td>
                        <td class="form-detail">灾害类型</td>
                        <td>
                            <label class="control-label" data-bind="text:ZHLX, attr: {title:ZHLX}"></label>
                        </td>
                        <td class="form-detail">可能导致事故</td>
                        <td>
                            <label class="control-label" data-bind="text:KNDZSG, attr: {title:KNDZSG}"></label>
                        </td>
                    </tr>
                </table>
            </li>
        </ul>
    </div>

    <div class="modal-footer" style="text-align: right;">
        <button class="btn btn-primary" type="button" onclick="window.parent._closeDialog()">
            关闭</button>
    </div>
    <script>
        var AppViewModel = function () {
            var p = top.fraMain || parent;
            var m = p.koDataP;
            var self = this;
            self.koData = ko.observableArray(m);
        }

        ko.applyBindings(new AppViewModel(), document.getElementById('kobind'));
    </script>
</asp:Content>
