<style type="text/css">
    #inupy_control {
        text-align: center;
        padding: 6px 3px;
        border: 1px solid #555;
        border-top: 0px;
        font: 14pt sans-serif;
        height: auto;
        top: -1.5em;
        z-index: 1000;
        position: fixed;
        background-color: rgba(51, 51, 51, 0.97);
        -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
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
        width: 13em;
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
        padding: 0;
    }
    .inupy_button a {
        padding: 4px 8px;
        color: #fff;
        font: 10pt/18pt sans-serif;
        text-align: center;
        cursor: pointer;
    }

    .inupy_button + .inupy_button {
        margin-left: 1px;
    }

    .inupy_active_button a {
        color: #FFF;
        text-decoration: none;
        font-weight: bold;
    }

    .inupy_active_button a:hover {
        background-color: #555;
    }

    .inupy_inactive_button a:hover {
        background-color: #383838;
    }

    .inupy_inactive_button a {
        color: #ccc;
        text-decoration: none;
    }

    .inupy_inactive_button a:hover {
        color: #ccc;
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
