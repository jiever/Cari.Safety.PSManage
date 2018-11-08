<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="BarAnalysisHtc.aspx.cs" Inherits="CariWeb.Analysis.BarAnalysisHtc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="<%=ResolveUrl("~/Scripts/echarts/echarts.js") %>" type="text/javascript"></script>
    <script src="<%=ResolveUrl("~/Scripts/knockout-3.3.0.js") %>" type="text/javascript"></script>
    <div id="chart" style="height: 300px; width: 100%;"></div>
</asp:Content>
