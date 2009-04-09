require 'nokogiri'

module XSD
  module XMLParser
    ###
    # Nokogiri XML parser for soap4r.
    #
    # Nokogiri may be used as the XML parser in soap4r.  Simply require
    # 'xsd/xmlparser/nokogiri' in your soap4r applications, and soap4r
    # will use Nokogiri as it's XML parser.  No other changes should be
    # required to use Nokogiri as the XML parser.
    #
    # Example (using UW ITS Web Services):
    #
    #   require 'rubygems'
    #   gem 'soap4r'
    #   require 'xsd/xmlparser/nokogiri'
    #   require 'defaultDriver'
    #
    #   obj = AvlPortType.new
    #   obj.getLatestByRout(obj.getAgencies, 8).each do |event|
    #     ...
    #   end
    class Nokogiri < XSD::XMLParser::Parser
      def initialize host, opt = {}
        super
        @parser = ::Nokogiri::XML::SAX::Parser.new(self, @charset || 'UTF-8')
      end

      def do_parse string_or_readable
        @parser.parse(string_or_readable)
      end

      def start_element name, attrs = []
        super(name, Hash[*attrs])
      end

      def error msg
        raise ParseError.new(msg)
      end
      alias :warning :error

      def cdata_block string
        characters string
      end

      %w{ start_document end_document comment }.each do |name|
        class_eval %{ def #{name}(*args); end }
      end
      add_factory(self)
    end
  end
end
