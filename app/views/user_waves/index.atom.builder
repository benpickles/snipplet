atom_feed(:root_url => user_waves_url(@user.username)) do |feed|
  feed.title "sinewaveapp.com/#{@user.username}"
  feed.updated @waves.first.updated_at

  @waves.each do |wave|
    feed.entry(wave) do |entry|
      entry.title "#{wave.command}: #{wave.note}"
      entry.content wave.uri

      entry.author do |author|
        author.name(@user.username)
      end
    end
  end
end
