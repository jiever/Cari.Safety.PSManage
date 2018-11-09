<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="BarAnalysisHtc.aspx.cs" Inherits="CariWeb.Analysis.BarAnalysisHtc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="<%=ResolveUrl("~/Scripts/echarts/echarts.js") %>" type="text/javascript"></script>
    <script src="<%=ResolveUrl("~/Scripts/knockout-3.3.0.js") %>" type="text/javascript"></script>
    <div id="chart" style="height: 300px; width: 100%;"></div>

    <script type="text/javascript">
        function chartOption(title, data, series) {
            var myChart = echarts.init(document.getElementById('department-chart'));

            var options = {
                title: {
                    text: title,
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },

                grid: {
                    bottom: '8%',
                    containLabel: true
                },
                legend: {
                    data: ['数量', '同比', '环比'],
                    bottom: 0
                },
                xAxis: [
                    {
                        type: 'category',
                        data: data
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: series
            };
            myChart.clear();
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(options);
        }
    </script>
</asp:Content>
