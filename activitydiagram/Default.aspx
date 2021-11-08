<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="activitydiagram._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset='utf-8'>
    <title></title>
    <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
    <script type="text/javascript" src="Jquery.SVG/raphael-master/raphael-min.js"></script>
    <script type="text/javascript" src="Jquery.SVG/underscore.js"></script>
    <script type="text/javascript" src="Jquery.SVG/js-sequence-diagrams-master/build/sequence-diagram-min.js"></script>
    <script type="text/javascript" src="Jquery.SVG/jquery.min.js"></script>
    <script type="text/javascript" src="Jquery.SVG/svginnerhtml.min.js"></script>
    <script type="text/javascript" src="Jquery.SVG/ace.js"></script>
    <link href="Style.css" rel="stylesheet" />
</head>
<body class="post">
     <div id="main">
      <section id="myactivitydiagram">
          <div><p align="center" id="creator">تهیه شده توسط محمد خانجانی</p></div>
        <table align="center" class="inner">
            <tr>
            <td class="diagram right">در صورتی که نمودار را مشاهده نکردید بدلیل مشکل در جاوا شما می باشد و احتمالا به دلیل غیر فعال بودن آن در مرورگر شماست</td>
             <td>
            <h3 class="post right">می توانید با تغییر در نوشت های زیر، خروجی را تغییر دهید</h3>
            <div class="editor-wrapper">
              <div class="editor">mohammad->zahra:salam
zahra->mohammad:salam
mohammad->ali:salam ali
ali->zahra:salam zahra
ali->mohammad:salam mohammad
mohammad->ahmad:req
ali->kamran:req
mohammad->azade:hi
              </div>
            </div>
                <select class="theme ppost right">
                    <option value="simple" selected>ساده</option>
                    <option value="hand" >دست نویس</option>
                </select>
              <a href="#" class="download right"> SVG دانلود به عنوان فایل</a>
            </td>
          </tr>
        </table>

      </section>
         </div>

    <script type="text/javascript">

        function setup_editor(div) {

            var editor_div = div.find(".editor");
            var diagram_div = div.find(".diagram");
            var theme_div = div.find(".theme");
            var download_link = div.find('.download');

            // Setup the editor diagram
            var editor = ace.edit(editor_div.get(0));
            editor.setTheme("ace/theme/crimson_editor");
            editor.getSession().setMode("ace/mode/asciidoc");
            editor.getSession().on('change', _.debounce(on_change, 100));

            download_link.click(function (ev) {
                var svg = diagram_div.find('svg')[0];
                var width = parseInt(svg.width.baseVal.value);
                var height = parseInt(svg.height.baseVal.value);
                var data = editor.getValue();
                var xml = '<?xml version="1.0" encoding="utf-8" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"><svg xmlns="http://www.w3.org/2000/svg" width="' + width + '" height="' + height + '" xmlns:xlink="http://www.w3.org/1999/xlink"><source><![CDATA[' + data + ']]></source>' + svg.innerHTML + '</svg>';

                var a = $(this);
                a.attr("download", "diagram.svg"); // TODO I could put title here
                a.attr("href", "data:image/svg+xml," + encodeURIComponent(xml));
            });

            theme_div.change(on_change);
            on_change();

            function on_change() {
                try {
                    var diagram = Diagram.parse(editor.getValue());

                    editor.getSession().setAnnotations([]);

                    // Clear out old diagram
                    diagram_div.html('');

                    var options = {
                        theme: theme_div.val(),
                        scale: 1
                    };

                    // Draw
                    diagram.drawSVG(diagram_div.get(0), options);

                } catch (err) {
                    var annotation = {
                        type: "error", // also warning and information
                        column: 0,
                        row: 0,
                        text: err.message
                    };
                    if (err instanceof Diagram.ParseError) {
                        annotation.row = err.loc.first_line - 1;
                        annotation.column = err.loc.first_column;
                    }
                    editor.getSession().setAnnotations([annotation]);
                    throw err;
                }
            }
        }

        $(document).ready(function () {
            setup_editor($('#myactivitydiagram'));
        });
    </script>

    <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-36551491-1']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
    </script>
</body>
</html>
