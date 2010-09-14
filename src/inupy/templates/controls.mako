<style type="text/css">
    #inupy_control {
        text-align: center;
        width: 25%;
        padding: 2px;
        border: solid #000 1px;
        border-top: 0px;
        border-radius: 0px 0px 10px 10px;
        -moz-box-shadow: 0 1px 3px #999;
        -webkit-box-shadow: 0 1px 3px #999;
        height: 30px;
        left: 0px;
        right: 0px;
        top: -28px;
        z-index: 1000;
        position: fixed;
        margin-left: auto;
        margin-right: auto;
        background-color: #CCC;
    }

    #inupy_control {
        -webkit-transition: all 0px .5s ease-in-out;
        -moz-transition: all .5s ease-in-out;
        -o-transition: all .5s ease-in-out;
        -webkit-transition: all .5s ease-in-out;
        transition: all .5s ease-in-out;
    }

    #inupy_control:hover {
        background-color: #999;
        cursor: pointer;
        top: 0px;
    }

    .inupy_active_button, .inupy_inactive_button {
        margin: 3px 1.5px;
        padding: 1px 5px;
        color: #FFF;
        font-weight: bold;
        text-align: center;
        background: #222;
        display-inline: block;
        -moz-border-radius: 5px;
        border-radius: 5px;
        -moz-box-shadow: 0 1px 3px #999;
        -webkit-box-shadow: 0 1px 3px #999;
        text-shadow: 0 -1px 1px #222;
        border-bottom: 1px solid #222;
        cursor: pointer;
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

<div id="inupy_control">
    <span>
        <span id="inupy_logview" class="${logview_class}" title="Open LogView">
            <a href="#" onclick="ILV.show_events('ILVlogevents');return false;">Log</a>
        </span>
        <span id="inupy_profiler" class="${profiler_class}" title="Open Profiler">
            % if profiler_active:
                <a target="_blank" href="/_profiler/showall">Profile</a>
            % else:
                <a href="#">Profile</a>
            % endif
        </span>
        <span id="inupy_leak" class="${memory_class}" title="Open Memory Dump">
            % if memory_active:
                <a target="_blank" href="/_inupy/index">Memory</a>
            % else:
                <a href="#">Memory</a>
            % endif
        </span>
    </span>
</div>
