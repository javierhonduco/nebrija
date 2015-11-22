module Rae
  MAJOR = 0
  MINOR = 2
  PATCH = 2
  def self.version
    [MAJOR, MINOR, PATCH].join '.'
  end
end
