<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="CariPortals.aspx.cs" Inherits="CariWeb.PS.CariPortals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        table,iframe {
            height: 100%;
            width: 100%;
        }
        td {
            padding-top: 5px;
            padding-left: 5px;
            padding-right: 5px;
            padding-bottom: 5px;
        }
    </style>

    <table id="main">
        <tr>
            <td>
                <iframe name="CircleHtcFrame" id ="CircleHtcFrame" src="CircleAnalysisHtc.aspx" scrolling="no"></iframe>
            </td>
            <td>
                <iframe name="BarHtcFrame" id="BarHtcFrame" src="BarAnalysisHtc.aspx" scrolling="no"></iframe>
            </td>
        </tr>
        <tr>
            <td>
                <iframe name="BarRiskFrame" id="BarRiskFrame" src="BarAnalysisRiskLevel.aspx" scrolling="no"></iframe>
            </td>
            <td>
                <iframe name="BarAmFrame" id="BarAmFrame" src="BarAnalysisAm.aspx" scrolling="no"></iframe>
            </td>
        </tr>
    </table>
    <script>
        $(document).ready(function () {
            $("#main").height($(window).height());
        })
    </script>
</asp:Content>
