class Wave < ActiveRecord::Base
  belongs_to :user

  named_scope :alphabetical, :order => 'command ASC'
  named_scope :recent, :order => 'updated_at DESC'

  validates_presence_of :command, :uri, :user
  validates_uniqueness_of :command, :scope => :user_id

  attr_accessible :command, :note, :uri

  def host
    (Addressable::URI.parse(uri).host || '').sub(/^www\./, '')
  end

  def interpolate(s)
    interpolated = uri

    if interpolated =~ /%\d+/
      elems = s.split(/\s+/)
      copy = elems.dup
      interpolated.gsub!(/%\d+/) do |d|
        i = d.sub('%', '').to_i - 1
        copy[i] = nil
        Addressable::URI.encode(elems[i].to_s)
      end
      interpolated.gsub!(/%n/, Addressable::URI.encode(copy.compact.join(' ')))
    end

    interpolated.sub!(/%s/, Addressable::URI.encode(s.to_s))
    interpolated
  end

  def to_txt
    [command, uri, note].join(' ')
  end
end
