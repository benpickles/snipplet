atom_feed do |feed|
  feed.title 'snipplet.it'
  feed.updated @snips.first.updated_at

  @snips.each do |snip|
    feed.entry(snip) do |entry|
      entry.title "#{snip.command}: #{snip.note}"
      entry.content snip.uri

      entry.author do |author|
        author.name(snip.user.username)
      end
    end
  end
end
