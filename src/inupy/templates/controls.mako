<style type="text/css">
    #inupy_control {
        text-align: center;
        padding: 4px 6px 6px 6px;
        border: solid #000 1px;
        border-top: 0px;
        border-radius: 0px 0px 12px 12px;
        -moz-box-shadow: 0 1px 3px #999;
        -webkit-box-shadow: 0 1px 3px #999;
        font: 14pt sans-serif;
        height: auto;
        top: -1.4em;
        z-index: 1000;
        position: fixed;
        background-color: #CCC;
    }

    #inupy_control.inupy_align_left {
        width: auto;
        left: 0;
        right: auto;
    }

    #inupy_control.inupy_align_right {
        width: auto;
        left: auto;
        right: 0;
    }

    #inupy_control.inupy_align_center {
        width: 14em;
        left: 0;
        right: 0;
        margin-left: auto;
        margin-right: auto;
    }

    #inupy_control {
        -moz-transition: top .2s ease-in-out;
        -o-transition: top .2s ease-in-out;
        -webkit-transition: top .2s ease-in-out;
        transition: top .2s ease-in-out;
    }

    #inupy_control:hover {
        cursor: pointer;
        top: 0px;
    }

    .inupy_button {
        margin: 0;
        padding: 1px 5px;
        color: #FFF;
        font: 14pt sans-serif;
        font-weight: bold;
        text-align: center;
        background: #222;
        display-inline: block;
        -moz-border-radius: 6px;
        border-radius: 6px;
        -moz-box-shadow: 0 1px 3px #999;
        -webkit-box-shadow: 0 1px 3px #999;
        text-shadow: 0 -1px 1px #222;
        border-bottom: 1px solid #222;
        cursor: pointer;
    }

    .inupy_button + .inupy_button {
        margin-left: 1px;
    }

    .inupy_active_button a {
        color: #FFF;
        text-decoration: none;
    }

    .inupy_active_button a:hover {
        color: #FFCC00;
    }

    .inupy_inactive_button a {
        color: #CCC;
        text-decoration: none;
    }

    .inupy_inactive_button a:hover {
        color: #CCC;
    }
</style>
 <%
    logview_active = False
    logview_class = "inupy_inactive_button"
    if inupy_config['logview']:
        logview_active = True
        logview_class = "inupy_active_button"


    profiler_active = False
    profiler_class = "inupy_inactive_button"
    if inupy_config['profiler']:
        profiler_active = True
        profiler_class = "inupy_active_button"

    memory_active = False
    memory_class = "inupy_inactive_button"
    if inupy_config['memory']:
        memory_active = True
        memory_class = "inupy_active_button"
%>
<script type="text/javascript">
var InupiCtrls = {
    'move_left': function() {
        var bar = DV('#inupy_control');
        if (bar.hasClass('inupy_align_right')) {
            bar.removeClass('inupy_align_right');
            bar.addClass('inupy_align_center');
            DV('#inupy_move_right').removeClass('inupy_inactive_button');
            DV('#inupy_move_right').addClass('inupy_active_button');
        } else {
            bar.removeClass('inupy_align_center');
            bar.addClass('inupy_align_left');
            DV('#inupy_move_left').removeClass('inupy_active_button');
            DV('#inupy_move_left').addClass('inupy_inactive_button');
        }
    },
    'move_right': function() {
        var bar = DV('#inupy_control');
        if (bar.hasClass('inupy_align_left')) {
            bar.removeClass('inupy_align_left');
            bar.addClass('inupy_align_center');
            DV('#inupy_move_left').removeClass('inupy_inactive_button');
            DV('#inupy_move_left').addClass('inupy_active_button');
        } else {
            bar.removeClass('inupy_align_center');
            bar.addClass('inupy_align_right');
            DV('#inupy_move_right').removeClass('inupy_active_button');
            DV('#inupy_move_right').addClass('inupy_inactive_button');
        }
    }
}
</script>

<div id="inupy_control" class="inupy_align_center">
    <span>
        <span id="inupy_move_left" class="inupy_button inupy_active_button" title="Move left">
            <a href="#" onclick="InupiCtrls.move_left(); return false;">&lt;</a>\
</span>
        <span id="inupy_logview" class="inupy_button ${logview_class}" title="Open LogView">
            <a href="#" onclick="if (typeof ILV != 'undefined') ILV.show_events('ILVlogevents');return false;">Log</a>\
</span>
        <span id="inupy_profiler" class="inupy_button ${profiler_class}" title="Open Profiler">
            % if profiler_active:
                <a target="_blank" href="/_profiler/showall">Profile</a>\
            % else:
                <a href="#" onclick="return false;">Profile</a>\
            % endif
</span>
        <span id="inupy_leak" class="inupy_button ${memory_class}" title="Open Memory Dump">
            % if memory_active:
                <a target="_blank" href="/_inupy/index">Memory</a>\
            % else:
                <a href="#" onclick="return false;">Memory</a>\
            % endif
</span>
        <span id="inupy_move_right" class="inupy_button inupy_active_button" title="Move right">
            <a href="#" onclick="InupiCtrls.move_right(); return false;">&gt;</a>\
</span>
    </span>
</div>
