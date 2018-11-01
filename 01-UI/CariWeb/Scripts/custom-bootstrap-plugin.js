(function($) {
    $.openDialog = function(options) {
        var settings = {
            title: '标题',
            height: 400,
            width: 500,
            url: '#',
            onClose: null
        };
        if (options) {
            $.extend(settings, options);
        }

        var modaldialog = document.getElementById("modalDialog");
        $("#myModalLabel", modaldialog).text(settings.title);
        $("#framecontent", modaldialog).css({
            height: settings.height,
            width: settings.width
        }).prop({
            src: settings.url
        });
        $(".modal-content", modaldialog).css({ margin: 'auto', width: settings.width + 30 });
        $(".modal-dialog", modaldialog).css({ width: 'auto' });
        if (settings.onClose && typeof settings.onClose === 'function') {
            modaldialog.on('hidden.bs.modal', settings.onClose);
        }

        window.top.document.modalDialog = $(modaldialog).modal('show');
    };

    
})(jQuery);