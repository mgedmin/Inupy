<%!

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
    return 'inherit'

%>
<style type="text/css">
    #inupy-log-container {
        width: 100%;
        position: absolute;
        top: 0;
        left: 0;
        z-index: 200000;
        margin: 0;
        padding: 0;
    }

    #ILVlogevents table {
        width: 100%;
        overflow: auto;
        color: #fff;
        background-color: rgba(51, 51, 51, 0.9);
        border-spacing: 0;
        border-collapse: collapse;
    }

    #ILVlogevents th,
    #ILVlogevents td {
        padding: 2px 6px;
        text-transform: none;
        font: 10pt/18pt sans-serif;
    }
    #ILVlogevents th {
        font-weight: bold;
    }

    #ILVlogevents tr {
        text-align: left;
        vertical-align: top;
        border-bottom: 1px solid rgba(85, 85, 85, 0.9);
    }

    #dlv_footer {
        text-align: left;
        vertical-align: top;
        border-bottom: 1px solid #555;
    }
    #dlv_footer th {
        color: #ccc;
        font-weight: normal;
    }
    #dlv_footer td {
        color: #fff;
        font-weight: bold;
    }

    #ILVlogevents thead th,
    #dlv_footer th,
    #dlv_footer td {
        cursor: pointer;
    }
</style>
<div id="inupy-log-container">
    <div id="ILVlogevents" style="display: none">
        <table>
            <thead>
                <tr>
                    <th>Time</th>
                    <th>Level</th>
                    <th>Module</th>
                    <th width="100%">Message</th>
                </tr>
            </thead>
            <tbody>
                <% prev_event = None %>
                % for event in events:
                    <% bgcolor = bg_color(event, logcolors) %>
                        <tr style="background-color: ${bgcolor}">
                            <td style="background-color: ${bgcolor}; color: #ccc; text-align: right;">${format_time(event, start, prev_event)}</td>
                            <td style="background-color: ${bgcolor}; color: #ccc;">${event.levelname}</td>
                            <td style="background-color: ${bgcolor}; color: #ccc;">${event.name}</td>
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
                                    id="${id(event)}_extra"><a href="#" onclick="ILV.show_span(${id(event)})">...</a></span>\
                                    <span id="${id(event)}" style="display:none">${last}</span>
                                % else:
                                    ${msg | h}\
                                % endif
                            </td>
                        </tr>
                    <% prev_event = event %>
                % endfor
            </tbody>
            <tfoot>
                <tr id="dlv_footer">
                    <th colspan="2">Total Time:</th>
                    <td colspan="4">${'%d' % (1000*tottime)}ms</td>
                </tr>
            </tfoot>
        </table>
    </div>
</div>
<script type="text/javascript">
var ILV = {
    // load the logged events table ui
    'show_events': function(name) {

        DV('#ILVlogevents').show('fast', function() {
            // bind the close action on the th and the bottom row of the table
            DV('#dlv_footer th,#dlv_footer td,#ILVlogevents thead th').bind('click', function () {
                DV('#ILVlogevents').hide('fast');
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
        DV('#ILVlogevents tbody tr').bind('hover', function() {
            DV(this).find('td').attr('background-color', '#666');
        });
    }
};

DV(document).ready(function() {
    ILV.bind_hover();
});

</script>
