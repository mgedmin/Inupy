<%!
import time
converter = time.localtime
def format_time(record, start, prev_record=None):
    if prev_record:
        delta_from_prev = (record.created - prev_record.created) * 1000
        return '%+dms' % delta_from_prev
    else:
        time_from_start = (record.created - start) * 1000
        return '%+dms' % time_from_start

def bg_color(event, log_colors):
    if event.name in log_colors:
        return log_colors[event.name]
    for key in log_colors:
        if event.name.startswith(key):
            return log_colors[key]
    return '#fff'
%>
<style type="text/css">
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
<div style="width: 100%; position: absolute; top:0; left: 0; z-index: 200000; font-size:11px;">
    <div id="DLVlogevents" style="display:none;">
        <table style="width: 100%; overflow: auto; background-color: #ddd;padding:2px;">
            <thead>
                <tr>
                    <th>Time</th>
                    <th>Level</th>
                    <th>Module</th>
                    <th>Message</th>
                </tr>
            </thead>
            <tbody>
                <% prev_event = None %>
                % for event in events:
                    <% bgcolor = bg_color(event, logcolors) %>
                        <tr style="text-align: left; vertical-align: top; border-bottom: 1px solid #333; background-color: ${bgcolor}; color: #222;">
                            <td style="background-color: ${bgcolor}; text-align: right;">${format_time(event, start, prev_event)}</td>
                            <td style="background-color: ${bgcolor};">${event.levelname}</td>
                            <td style="background-color: ${bgcolor};">${event.name}</td>
                            <td style="background-color: ${bgcolor};" width="100%">\
                                <%
                                    msg = event.getMessage()
                                    length_limit = 130
                                    if len(msg) > length_limit:
                                        use_split = True
                                        first = msg[:length_limit]
                                        last = msg[length_limit:]
                                    else:
                                        use_split = False
                                        parts = None
                                %>
                                % if use_split:
                                    <span class="dlv_message_link">${first}</span>\
                                    <span style="display:inline;"
                                    id="${id(event)}_extra"><a href="#" onclick="DLV.show_span(${id(event)})">...</a></span>\
                                    <span id="${id(event)}" style="display:none">${last}</span>
                                % else:
                                    ${msg | h}\
                                % endif
                            </td>
                        </tr>
                    <% prev_event = event %>
                % endfor
                <tr style="text-align: left; vertical-align: top; border-bottom: 1px solid #333; background-color: #eee; color: #222;" id="dlv_footer">
                    <th colspan="2">Total Time:</th>
                    <td colspan="4">${'%d' % (1000*tottime)}ms</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">
DV(document).ready(function() {
    DLV.bind_hover();

});

var DLV = {
    // load the logged events table ui
    'show_events':  function(name) {

        DV('#DLVlogevents').show('slow', function() {
            // bind the close action on the th and the bottom row of the table
            DV('#dlv_footer th,#dlv_footer td,#DLVlogevents thead th').bind('click', function () {
                DV('#DLVlogevents').hide();
            });
        });

        return false;
    },
    
    // expand the log message span for a specific log event
    'show_span': function(name) {
        var name_id = "#" + name;
        var extra_name = name_id + "_extra";
        DV(extra_name).remove();
        DV(name_id).show();
    },

    'bind_hover': function() {
        DV('#DLVlogevents tbody tr').bind('hover', function() {
            DV(this).find('td').attr('background-color', '#666');
        });
    }
};
</script>
