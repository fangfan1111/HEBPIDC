
	    
var ajaxLoadSelect = function(settings) {
    var settings = settings || {};
    var nodes = settings.nodes;
    if (!nodes) {
        return;
    }
    function deal(settings) { 
        var settings = settings || {};
        var url = settings.url || '';
        var $child = settings.child;
        $child.empty();
        settings.showDefault = settings.showDefault || true;
        if (settings.showDefault) {
            var defaultItem = settings.default || {};
            var defaultText = defaultItem.defaultText || "请选择";
            var defaultValue = defaultItem.defaultValue || "";
            $child.append("<option value='"+defaultValue+"' selected>"+defaultText+"</option>");
        }
        var json = {};
        json[settings.upkey] = settings.upcode;
        $.ajax({
            url: url,
            type: 'post',
            dataType: 'json',
            headers:headers,  
            data: json,
            success: function (data) {
                var list = data;
                var str = "";
                for (var i = 0, len = list.length; i < len; i++) {
                    var item = list[i];
                    var selected = '';
                    if (settings.selected && item[settings.value] == settings.selected) {
                        selected = ' selected';
                    }  
                    str += '<option value="'+item[settings.value]+'"'+selected+'>'+item[settings.text]+'</option>';
                }
                $child.append(str);
                settings.callback && settings.callback(settings.parent, $child);
                $child.change();
            }
        });
    }
    settings.selected = settings.selected || [];
    settings.callback = settings.callback || [];
    for (var i = 0, len = nodes.length; i < len; i++) {
        var node = nodes[i];
        var child = node;
        var newSettings = {};
        newSettings.child = node;
        newSettings.url = settings.url;
        newSettings.value = settings.value;
        newSettings.text = settings.text;
        newSettings.selected = settings.selected[i] || '';
        newSettings.default = settings.default;
        newSettings.showDefault = settings.showDefault;
        newSettings.upkey = settings.upkey;
        newSettings.upcode = settings.upcode;
        newSettings.callback = settings.callback[i];
        
        if (0 == i) {
            deal(newSettings);
        } else {
            var parent = nodes[i-1];
            newSettings.parent = parent;
            (function(settings) {
                parent.change(function() {
                    var $this = $(this);
                    settings.upcode = $this.val();
                    deal(settings);
                }).change();
            })(newSettings);
        }
    }
}