module ApplicationHelper
  def google_analytics_javascript
    return unless Rails.env.production?
    %|<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-117680-12");
pageTracker._trackPageview();
} catch(err) {}</script>|
  end
end
