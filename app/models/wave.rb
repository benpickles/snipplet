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

  def interpolate(params = {})
    Interpolator.new(params).interpolate(uri)
  end

  def to_txt
    [command, uri, note].join(' ')
  end
end
