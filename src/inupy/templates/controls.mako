<style type="text/css">
    #dozer_control {
        text-align: center;
        width: 150px;
        padding: 2px;
        border: solid #000 1px;
        border-top: 0px;
        border-radius: 0px 0px 10px 10px;
        -moz-box-shadow: 0 1px 3px #999;
        -webkit-box-shadow: 0 1px 3px #999;
        height: 30px;
        left: 0px;
        right: 0px;
        top: -27px;
        z-index: 1000;
        position: fixed;
        margin-left: auto;
        margin-right: auto;
        background-color: #CCC;
    }

    #dozer_control {
        -webkit-transition: all 0px .5s ease-in-out;
        -moz-transition: all .5s ease-in-out;
        -o-transition: all .5s ease-in-out;
        -webkit-transition: all .5s ease-in-out;
        transition: all .5s ease-in-out;
    }

    #dozer_control:hover {
        background-color: #999;
        cursor: pointer;
        top: 0px;
    }

    .dozer_button {
        margin: 3px 1.5px;
        padding: 1px 5px;
        color: #FFF;
        font-weight: bold;
        float: left;
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

    .dozer_button a {
        color: #FFF;
        text-decoration: none;
    }

    .dozer_button a:hover {
        color: #FFCC00;
    }

    #dlv_footer th,#dlv_footer td {
        cursor: pointer;
        color: #FFCC00;
        background-color: #333;
    }

    #DLVlogevents thead th {
        cursor: pointer;
        color: #FFCC00;
        background-color: #333;
    }
</style>
<div id="dozer_control">
    <div id="dozer_logview" class="dozer_button" title="Open LogView">
        <a href="#" onclick="DLV.show_events('DLVlogevents');return false;">Log</a>
    </div>
    <div id="dozer_profiler" class="dozer_button" title="Open Profiler">
        <a target="_blank" href="/_profiler/showall">Profile</a>
    </div>
    <div id="dozer_leak" class="dozer_button" title="Open Dozer Mem">
        <a href="/_dozer/index" target="_blank">Memory</a>
    </div>
</div>
