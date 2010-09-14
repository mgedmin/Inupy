<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>${self.title()}</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    ${self.styles()}
</head>
<body>
    ${next.body()}
    ${self.javascript()}
</body>
</html>
<%def name="title()">Inupy - Profiler</%def>

<%def name="styles()">
    <link href="/_profiler/media/css/profile.css" media="screen" rel="Stylesheet" type="text/css" />
</%def>

<%def name="javascript()">
    <!-- The JS for the jQuery replacement DV is replaced via the controller code at runtime -->
    <script type="text/javascript" charset="utf-8">inupy_js</script>
</%def>
