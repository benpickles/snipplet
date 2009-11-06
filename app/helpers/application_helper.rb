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

  def sinewave_bookmarklet(current_user)
    href = 'javascript:'
    href << "sinewave('#{current_user.username}');" if current_user
    href << sinewave_bookmarklet_href
    href
  end

  def sinewave_bookmarklet_href
    @@sinewave_bookmarklet_href ||= begin
      file = Rails.root.join('public', 'javascripts', 'bookmarklet.js')
      js = File.read(file)
      js.gsub!("\n", ' ')
      js.squeeze!(' ')
      URI.escape(js)
    end
  end
end
