module Spree
  module PrintInvoice
    # Returns the version of the currently loaded Spree::PrintInvoice as a <tt>Gem::Version</tt>
    def self.version
      Gem::Version.new VERSION::STRING
    end

    module VERSION
      MAJOR = 3
      MINOR = 0
      TINY  = 0
      PRE   = 'alpha'

      STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
    end
  end
end