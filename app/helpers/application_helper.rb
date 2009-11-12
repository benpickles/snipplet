require 'digest/md5'

module ApplicationHelper
  def bookmarklet(user, text = "sinewave/#{user.username}")
    href = 'javascript:'
    href << "sinewave('#{user.username}');" if user
    href << bookmarklet_href

    link_to(text, href, :class => 'bookmarklet')
  end

  def bookmarklet_href
    @@bookmarklet_href ||= begin
      file = Rails.root.join('public', 'javascripts', 'bookmarklet.min.js')
      js = File.read(file)
      js.strip!
      URI.escape(js)
    end
  end

  def copy_wave_button(wave)
    return unless current_user
    button_to('Copy to my waves', copy_wave_path(wave)) if wave.user != current_user
  end

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

  def gravatar_tag(user)
    return if user.email.blank?
    image_tag(gravatar_url(user.email), :alt => '', :class => 'gravatar')
  end

  def gravatar_url(email)
    hash = Digest::MD5.hexdigest(email.downcase)
    "http://www.gravatar.com/avatar/#{hash}?s=24"
  end
end
