<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Page.Master" AutoEventWireup="true" CodeBehind="CircleAnalysisHtc.aspx.cs" Inherits="CariWeb.Analysis.CircleAnalysisHtc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<script src="~/Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>--%>
    <script src="<%=ResolveUrl("~/Scripts/echarts/echarts.js") %>" type="text/javascript"></script>
    <script src="<%=ResolveUrl("~/Scripts/knockout-3.3.0.js") %>" type="text/javascript"></script>
    
    <div id="chart" style="height: 300px; width: 100%;"></div>
    
    <script>
        var myChart = echarts.init(document.getElementById('chart'));

        $(function() {
            var url =  "<%=ResolveUrl("~/Analysis/CircleAnalysisHtc.aspx?type=data") %>";
            $.post(url,
                "",
                function (ret) {
                    if (ret && ret.length > 0) {
                        var arr = new Array();
                        for (var i = 0; i < ret.length; i++) {
                            arr.push(ret[i].name);
                        }
                        chartOption("隐患分布图", ret, arr);
                    }
                },
                'json');
        });
        function chartOption(title, data, legend) {
            var options = {
                title: {
                    text: title,
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    data: legend,
                    bottom:0
                },
                series: [
                    {
                        name: title,
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '60%'],
                        data: data, // [{ value: 1548, name: '搜索引擎' }]
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            }
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(options);
        }

    </script>

</asp:Content>
