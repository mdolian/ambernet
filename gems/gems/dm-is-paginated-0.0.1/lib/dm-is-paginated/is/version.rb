module DataMapper
  module Is
    module Paginated
      VERSION_MAJOR = 0
      VERSION_MINOR = 0
      VERSION_TINY  = 1
      VERSION_REV   = nil

      VERSION = [
        VERSION_MAJOR, 
        VERSION_MINOR, 
        VERSION_TINY
      ].join('.')  + (VERSION_REV ? ".#{VERSION_REV}" : "")
    end
  end
end