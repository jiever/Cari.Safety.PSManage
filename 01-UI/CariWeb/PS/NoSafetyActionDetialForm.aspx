<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dialog.Master" AutoEventWireup="true" CodeBehind="NoSafetyActionDetialForm.aspx.cs" Inherits="CariWeb.PS.NoSafetyActionDetialForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../Scripts/knockout-3.3.0.js" type="text/javascript"></script>
    <div id="kobind" class="form-inline pt10">
        <ul data-bind="foreach: koData">
            <li>
                <table class="table table-bordered mb0">
                    <tr>
                        <td class="form-detail">姓名</td>
                        <td>
                            <label class="control-label" data-bind="text:XM"></label>
                        </td>
                        <td class="form-detail">职务</td>
                        <td>
                            <label class="control-label" data-bind="text:ZW"></label>
                        </td>
                        <td class="form-detail">单位</td>
                        <td>
                            <label class="control-label" data-bind="text:DW"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-detail">罚款原因</td>
                        <td>
                            <label class="control-label" data-bind="text:FKYY"></label>
                        </td>
                        <td class="form-detail">罚款单位</td>
                        <td>
                            <label class="control-label" data-bind="text:FKDW"></label>
                        </td>
                        <td class="form-detail">罚款金额</td>
                        <td>
                            <label class="control-label" data-bind="text:FKJE"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-detail">罚款时间</td>
                        <td>
                            <label class="control-label" data-bind="text:FKSJ"></label>
                        </td>
                        <td class="form-detail">经办人</td>
                        <td>
                            <label class="control-label" data-bind="text:JBR"></label>
                        </td>
                        <td class="form-detail">是否通知</td>
                        <td>
                            <label class="control-label" data-bind="text:SFTZ"></label>
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
