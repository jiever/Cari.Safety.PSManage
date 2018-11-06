<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dialog.Master" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="CariWeb.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <script src="../Scripts/knockout-3.3.0.js" type="text/javascript"></script>
    
    <div id="kobind" class="form-inline pt10">
        <ul data-bind="foreach: koData">
            <li>
                <table class="table table-hover table-bordered">
                    <tr>
                        <td style="width: 100px" class="form-detail">ID</td>
                        <td>
                            <label class="control-label" data-bind="text:ID"></label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px" class="form-detail">Name</td>
                        <td>
                            <label class="control-label" data-bind="text:Name"></label>
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
        var AppViewModel= function () {
            var m = parent.koDataP;
            var self = this;
            self.koData = ko.observableArray(m);
        }

        ko.applyBindings(new AppViewModel(), document.getElementById('kobind'));
    </script>
</asp:Content>
