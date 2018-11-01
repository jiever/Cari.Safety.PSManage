<%@ Page Language="C#" AutoEventWireup="true" Inherits="CariWeb.Default" CodeBehind="Default.aspx.cs" %>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <link rel="icon" href="../../favicon.ico">

    <title>安全信息化综合管理系统</title>
      <script src="<%= MainHost %>/api/source/script" type="text/javascript"></script>
    <!-- Bootstrap core CSS -->
      <script>
          loadCss("/Styles/css/bootstrap.min.css");
          loadCss("/Styles/dashboard.css");
          loadCss("/Scripts/toast/jquery.toast.min.css");
          loadCss("/Scripts/pager/kkpager_blue.css");

      </script>
      <script type="text/javascript">
          loadScript("/Scripts/jquery-1.9.1.min.js");
          loadScript("/Scripts/bootstrap.min.js");
          loadScript("/Scripts/layer/layer.js");
          loadScript("/Scripts/layer.dialog.js");
          loadScript("/Scripts/ie10-viewport-bug-workaround.js");
          loadScript("/Scripts/toast/jquery.toast.min.js");
          loadScript("/Scripts/pager/kkpager.js");
          loadScript("/Scripts/validform/jquery-validate.js");
          loadScript("/Scripts/validform/jquery.miniTip.js");
      </script>
    <!-- Custom styles for this template -->
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
      <style type="text/css">
          /* === SIDEBAR MENU === */
	        .panel {
		        border: 0;
		        box-shadow: none;
	        }
	
	        .panel-default > .panel-heading {
		        background-color: #6595BC;
                border-radius:0;
	        }
	        .panel-default > .panel-heading:hover {
		        background-color: #5B86A9;
	        }
	        .panel-default > .panel-heading  a {
		        color: #FFF;
		        display: block;
		        padding: 8px 0px;
	        }
	
	        .list-group-item {
		        padding-left: 25px;
		        border: 0;
                border-radius:0!important;
		        background: #286090;
	        }
	        .list-group-item:hover {
		        background: #365167;
                padding-left: 15px;
		        transition-delay: 0s;
                transition-duration: 0.3s;
                transition-property: all;
                transition-timing-function: linear;	
	        }
	        a.list-group-item {
		        color: #FFF;
	        }

            a.list-group-item:focus{
                background: none;
            }

	        a.list-group-item:hover {
		        background: #5881A2;
		        color: #FFF;
	        }	
	
	        .solso-active {
                color:lightskyblue!important;
		        background: #385269 !important;
	        }
	
	        .list-group-item.no-border {
		        border: 0;
	        }	
	
	        .panel-group .panel + .panel {
		        margin-top: 0px;
	        }	

            a:link,	
            a:focus, 
            a:visited , 
            a:active,
            a:hover { 
		        text-decoration: none; 
	        }
/* === END SIDEBAR MENU === */
      </style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">安全生产管理信息化系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><%--<a href="#">当前用户：[<%=User.Identity.Name %>] <%=_ubll.SysDepartmentRoleName %> </a>--%></li>
            <li><a href="Logout.ashx">退出</a></li>
          </ul>
          
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="panel-group" id="accordion">
                <%--<div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse">人员档案</a>
                        </h4>
                    </div>
                    <div id="collapse" class="panel-collapse collapse">
                        <div>
                            <a href="./SecurityInfoManagement/Profile/ProfileMainForm.aspx?type=search" target="content" class="list-group-item">档案浏览</a>
                            <a href="./SecurityInfoManagement/Profile/ProfileMainForm.aspx?type=basicEdit" target="content" class="list-group-item">基本信息维护</a>
                            <a href="./SecurityInfoManagement/Profile/ProfileMainForm.aspx?type=healthEdit" target="content" class="list-group-item">职业健康信息维护</a>
				        </div>
                    </div>
                </div>--%>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">事故管理</a>
                        </h4>
                    </div>
                    <div id="collapse3" class="panel-collapse collapse">
                        <div>
                            <a href="./AM/CasualtionBaseMainForm.aspx" target="content" class="list-group-item">事故录入</a>
                            <a href="./AM/CasualtionAffirmMainForm.aspx" target="content" class="list-group-item">事故认定</a>
                            <a href="./AM/CasualtionSearch.aspx" target="content" class="list-group-item">伤亡事故登记台账</a>
                            <a href="./AM/NonCasualtionSearch.aspx" target="content" class="list-group-item">非伤亡事故登记台账</a>
                            <a href="./AM/CasualtionPersonSearch.aspx" target="content" class="list-group-item">伤害人员台帐</a>
                            <a href="./AM/Analysis/CasualtionStatistics.aspx" target="content" class="list-group-item">伤亡事故统计</a>
                            <a href="./AM/Analysis/NonCasualtionStatistics.aspx" target="content" class="list-group-item">非伤亡事故统计</a>
                            <a href="./AM/Analysis/CasualtyCircle/CircleAnalysis.aspx" target="content" class="list-group-item">伤亡事故饼状图分析</a>
                            <a href="./AM/Analysis/CasualtyBar/BarAnalysis.aspx" target="content" class="list-group-item">伤亡事故柱状图分析</a>
                            <a href="./AM/Analysis/CasualtyLine/LineAnalysis.aspx" target="content" class="list-group-item">伤亡事故折线图分析</a>
                            <a href="./AM/Analysis/NonCasualtyCircle/NonCircleAnalysis.aspx" target="content" class="list-group-item">非伤亡事故饼状图分析</a>
                            <a href="./AM/Analysis/NonCasualtyBar/NonBarAnalysis.aspx" target="content" class="list-group-item">非伤亡事故柱状图分析</a>
                            <a href="./AM/Analysis/NonCasualtyLine/NonLineAnalysis.aspx" target="content" class="list-group-item">非伤亡事故折线图分析</a>
                            <a href="./AM/CasualtionManagerForm.aspx" target="content" class="list-group-item">事故维护</a>
<%--                            <a href="./SecurityInfoManagement/GroupSecurity/MeetingTrainingSetMainForm.aspx" target="content" class="list-group-item">培训内容设置</a>--%>
<%--                            <a href="./SecurityInfoManagement/GroupSecurity/RollcallMainForm.aspx" target="content" class="list-group-item">点名</a>--%>
<%--                            <a href="./SecurityInfoManagement/GroupSecurity/WorkAssignMainForm.aspx" target="content" class="list-group-item">工作安排</a>--%>
<%--                            <a href="./SecurityInfoManagement/GroupSecurity/TrainingMainForm.aspx" target="content" class="list-group-item">班前会培训</a>--%>
				        </div>
                    </div>
                </div>
               <%-- <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">五重管理</a>
                        </h4>
                    </div>
                    <div id="collapse4" class="panel-collapse collapse">
                        <div>
                            <a href="./FIM/ProjectMainForm.aspx" target="content" class="list-group-item">五重维护</a>
                            <a href="./FIM/ProjectMonitorMainForm.aspx" target="content" class="list-group-item">项目监管</a>
                            <a href="./FIM/ProjectOffMainForm.aspx" target="content" class="list-group-item">项目销号</a>
                            <a href="./FIM/ProjectSearchMainForm.aspx" target="content" class="list-group-item">跟踪台账</a>
                            <a href="./FIM/OutlyingMainForm.aspx" target="content" class="list-group-item">边远头面</a>
				        </div>
                    </div>
                </div>--%>
               <%--<div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse41">培训管理</a>
                        </h4>
                    </div>
                    <div id="collapse41" class="panel-collapse collapse">
                        <div>
                            <a href="./TRA/RecordMainForm.aspx" target="content" class="list-group-item">培训档案</a>
                            <a href="./TRA/TeacherMainForm.aspx" target="content" class="list-group-item">师徒合同</a>
                            <a href="./TRA/GroupTrainingReviewMainForm.aspx" target="content" class="list-group-item">效果评价</a>
				        </div>
                    </div>
                </div>--%>
              <%--   <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse44">文档发布</a>
                        </h4>
                    </div>
                    <div id="collapse44" class="panel-collapse collapse">
                        <div>
                            <a href="./InformationPublish/ColumnManage.aspx" target="content" class="list-group-item">栏目管理</a>
                            <a href="./InformationPublish/InformationPublishMainOne.aspx?columnid=3F2A6DFA-6ADF-4EF4-A9EF-5F39730B0DBA" target="content" class="list-group-item">培训文档</a>
                            <a href="./InformationPublish/InformationPublishMainOne.aspx?columnid=45B7CA7C-CD9A-405F-8F09-1204DA222CB1" target="content" class="list-group-item">安全文档</a>
				        </div>
                    </div>
                </div>--%>
                <%--<div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse5">安全会议</a>
                        </h4>
                    </div>
                    <div id="collapse5" class="panel-collapse collapse">
                        <div>
                            <a href="./SecurityInfoManagement/Meeting/" target="content" class="list-group-item">计划管理</a>
                            <a href="./SecurityInfoManagement/Meeting/" target="content" class="list-group-item">周期设置</a>
                            <a href="./SecurityInfoManagement/Meeting/" target="content" class="list-group-item">我的任务</a>
                            <a href="./SecurityInfoManagement/Meeting/" target="content" class="list-group-item">文档管理</a>
                            <a href="./SecurityInfoManagement/Meeting/" target="content" class="list-group-item">会议一览</a>
                            
				        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse51">安全文化</a>
                        </h4>
                    </div>
                    <div id="collapse51" class="panel-collapse collapse">
                        <div>
                            <a href="./SecurityInfoManagement/Culture/" target="content" class="list-group-item">计划管理</a>
                            <a href="./SecurityInfoManagement/Culture/" target="content" class="list-group-item">周期设置</a>
                            <a href="./SecurityInfoManagement/Culture/" target="content" class="list-group-item">我的任务</a>
                            <a href="./SecurityInfoManagement/Culture/" target="content" class="list-group-item">文档管理</a>
                            <a href="./SecurityInfoManagement/Culture/" target="content" class="list-group-item">会议一览</a>
				        </div>
                    </div>
                <%--</div>#1#
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse42">任务管理</a>
                        </h4>
                    </div>
                    <div id="collapse42" class="panel-collapse collapse">
                        <div>
$1$                            <a href="./TKM/ScheduleMainForm.aspx" target="content" class="list-group-item">周期设置</a>#1#
                            <a href="./TKM/PlanMainForm.aspx" target="content" class="list-group-item">任务计划</a>
                            <a href="./TKM/TaskMainForm.aspx" target="content" class="list-group-item">我的任务</a>
                            <a href="./TKM/TaskSearchMainForm.aspx" target="content" class="list-group-item">任务查询</a>
                            <a href="./TKM/TaskCheckMainForm.aspx" target="content" class="list-group-item">任务报表考核</a>
				        </div>
                    </div>
                </div>--%>
                <%--<div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse43">文档管理</a>
                        </h4>
                    </div>
                    <div id="collapse43" class="panel-collapse collapse">
                        <div>
                            <a href="./SecurityInfoManagement/Training/DocMainForm.aspx" target="content" class="list-group-item">文档管理</a>
                            <a href="./SecurityInfoManagement/Training/SearchMainForm.aspx" target="content" class="list-group-item">文档浏览</a>
				        </div>
                    </div>
                </div>--%>
            </div>
        </div>
        <iframe id="content" name="content" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main" frameborder="no" style="padding: 20px; border: 0;height:100%;">
            
        </iframe>
        
      </div>
    </div>
    
    
    

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
      
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
      <script>
          var $mainFrame = $("#content");
          var _tResize;

          function resizeMainFrame() {
              var height = $(window).height() - 55;
              if (_tResize != null) {
                  clearTimeout(_tResize);
              }
              _tResize = setTimeout(function () {
                  $mainFrame.animate({ 'height': height }, 100);
              }, 500);
          }


          $(function () {
              resizeMainFrame();
              $(window).resize(resizeMainFrame);

              $("#accordion .panel-collapse a").click(function () {
                  $(".solso-active").removeClass('solso-active');
                  $(this).addClass('solso-active');
              });
          });
      </script>
  </body>
</html>
