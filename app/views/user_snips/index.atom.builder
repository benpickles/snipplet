atom_feed(:root_url => user_snips_url(@user.username)) do |feed|
  feed.title "snipplet.it/#{@user.username}"
  feed.updated @snips.first.updated_at

  @snips.each do |snip|
    feed.entry(snip) do |entry|
      entry.title "#{snip.command}: #{snip.note}"
      entry.content snip.uri

      entry.author do |author|
        author.name(@user.username)
      end
    end
  end
end
