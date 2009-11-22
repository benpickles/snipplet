class Interpolator
  attr_accessor :l, :q, :s

  def initialize(params = {})
    self.l = params[:l]
    self.q = params[:q]
    self.s = params[:s]
  end

  def interpolate(uri)
    if uri =~ /%\d+/
      elems = q.split(/\s+/)
      copy = elems.dup
      uri.gsub!(/%\d+/) do |d|
        i = d.sub('%', '').to_i - 1
        copy[i] = nil
        Addressable::URI.encode(elems[i].to_s)
      end
      uri.gsub!(/%n/, Addressable::URI.encode(copy.compact.join(' ')))
    end

    uri.gsub!(/%l/, Addressable::URI.encode(l.to_s))
    uri.gsub!(/%q/, Addressable::URI.encode(q.to_s))
    uri.gsub!(/%s/, Addressable::URI.encode(s.to_s))
    uri
  end
end
