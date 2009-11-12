atom_feed do |feed|
  feed.title 'sinewaveapp.com'
  feed.updated @waves.first.updated_at

  @waves.each do |wave|
    feed.entry(wave) do |entry|
      entry.title "#{wave.command}: #{wave.note}"
      entry.content wave.uri

      entry.author do |author|
        author.name(wave.user.username)
      end
    end
  end
end
