var MainHost = '//' + location.host+'/CariWeb';

(function (w) {
    w.SelectUserTreeUrl = MainHost + '/common/UserSelectTree.aspx';
    w.DepartmentSelectTreeUrl = MainHost + '/common/DepartmentSelectTree.aspx';
    w.AreaSelectTreeUrl = MainHost + '/common/AreaSelectTree.aspx';
    w.RoleSelectTreeUrl = MainHost + '/common/RoleSelectTree.aspx';
    w.FileUploadUrl = MainHost + '/common/FileUpload.aspx';
    w.CheckTypeSelectTreeUrl = MainHost + '/common/CheckTypeSelectTree.aspx';
    w.JobSelectTreeUrl = MainHost + '/common/JobSelectTree.aspx';

    w.loadScript = function(path) {
        if (path && path == '/Scripts/jquery-uploadifive/jquery.uploadifive.min.js') {
            document.write('<script charset="gb2312" type="text/javascript" src="' + w.MainHost + path + '"></script>');
        } else {
            document.write('<script type="text/javascript" src="' + w.MainHost + path + '"></script>');
        }
    };

    w.loadCss = function(path) {
        document.write('<link rel="stylesheet" href="' + w.MainHost + path + '">');
    };

    if (w == w.parent) {
        window.toast = {
            success: function (msg) {
                $.toast({
                    heading: '',
                    text: msg,
                    icon: 'success',
                    position: 'top-right',
                    loader: false,
                    allowToastClose:false
                });
            },
            warning: function (msg) {
                $.toast({
                    heading: '',
                    text: msg,
                    icon: 'warning',
                    position: 'top-right',
                    loader: false,
                    bgColor: '#F89406',
                    allowToastClose: false
                });
            },
            error: function (msg) {
                $.toast({
                    heading: '',
                    text: msg,
                    icon: 'error',
                    position: 'top-right',
                    loader: false,
                    allowToastClose: false
                });
            }
        }
    } else {
        window.toast = window.parent.toast;
    }
    
})(window);   