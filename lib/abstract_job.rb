module Ambernet
  class AbstractJob
    def self.queue
      name.underscore.to_sym
    end

    def self.enqueue(*args)
      Resque.enqueue(self, *args)
    end
  end
end