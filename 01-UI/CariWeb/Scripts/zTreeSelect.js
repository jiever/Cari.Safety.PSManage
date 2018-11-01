; (function ($, window, document, undefined) {
    $.fn.zTreeSelect = function (url, opt) {
        var settings = opt || {};
        this.each(function () {
            var $this = $(this), id = $this.attr("id"), valueId = id + "Value", checkValid = settings.validate || false, formId = settings.form || "form1", callback = settings.callback;
            $this.off("click").on("click", function () {
				var selectedValue = $("#" + valueId).val();
                openDialog({ title: settings.title ? settings.title : '请选择', url: url + (url.indexOf("?") == -1 ? "?" : "&") + "selectedValue=" + selectedValue, width: settings.width ? settings.width : 520, height: settings.height ? settings.height : 500 }, function (obj) {
                    if (obj && obj.length > 0) {
                        var ids = [], names = [];
                        for (var i = 0; i < obj.length; i++) {
                            ids.push(obj[i].id);
                            names.push(obj[i].name);
                        }
                        $("#" + valueId).val(ids.join(",")).trigger("change");
                        $("#" + id).val(names.join(","));
                    } else {
                        $("#" + valueId).val("").trigger("change");
                        $("#" + id).val("");
                    }
                    if (checkValid) {
                        $("#" + formId).Validform().check(false, "#" + id);
                    }
                    if (callback && typeof (callback) == "function") {
                        callback.call(this, obj, id);
                    }

                });
            });
        })
        return this;
    }
})(jQuery, window, document);