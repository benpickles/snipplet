class Wave < ActiveRecord::Base
  belongs_to :original, :class_name => 'Wave'
  belongs_to :user
  has_many :copies, :class_name => 'Wave', :dependent => :nullify, :foreign_key => 'original_id'

  named_scope :alphabetical, :order => 'command ASC'
  named_scope :recent, :order => 'updated_at DESC'

  validates_presence_of :command, :uri, :user
  validates_uniqueness_of :command, :scope => :user_id

  attr_accessible :command, :note, :original_id, :uri

  def copy(wave)
    self.command = wave.command
    self.note = wave.note
    self.original = wave
    self.uri = wave.uri
  end

  def host
    (Addressable::URI.parse(uri).host || '').sub(/^www\./, '')
  rescue Addressable::URI::InvalidURIError
    # TODO: Fix for case when host has elements to be interpolated.
    ''
  end

  def interpolate(q, location = nil, selected = nil)
    interpolated = uri

    if interpolated =~ /%\d+/
      elems = q.split(/\s+/)
      copy = elems.dup
      interpolated.gsub!(/%\d+/) do |d|
        i = d.sub('%', '').to_i - 1
        copy[i] = nil
        Addressable::URI.encode(elems[i].to_s)
      end
      interpolated.gsub!(/%n/, Addressable::URI.encode(copy.compact.join(' ')))
    end

    interpolated.sub!(/%l/, Addressable::URI.encode(location.to_s))
    interpolated.sub!(/%q/, Addressable::URI.encode(q.to_s))
    interpolated.sub!(/%s/, Addressable::URI.encode(selected.to_s))
    interpolated
  end

  def to_txt
    [command, uri, note].join(' ')
  end
end
