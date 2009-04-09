require 'builder'
module Merb
  module PaginationHelper
    # Given a page count and the current page, we generate a set of pagination
    # links.
    # 
    # * We use an inner and outer window into a list of links. For a set of 
    # 20 pages with the current page being 10:
    # outer_window:
    #   1 2  ..... 19 20
    # inner_window
    #   5 6 7 8 9 10 11 12 13 14
    #
    # This is totally adjustable, or can be turned off by giving the 
    # :inner_window setting a value of nil.
    #
    # * Options
    # :class => <em>css_class</em::
    #    The CSS class to be given to the paginator div.
    #    Defaults to 'paginated'
    # :prev_label => <em>text_for_previous_link</em>::
    #    Defaults to '&laquo; Previous '
    # :next_labe => <em>text_for_next_link</em>::
    #    Defaults to ' Next &raquo;'
    # :left_cut_label => <em>text_for_cut</em>::
    #    Used when the page numbers need to be cut off to prevent the set of
    #    pagination links from being too long.
    #    Defaults to '&larr;'
    # :right_cut_label => <em>text_for_cut</em>::
    #    Same as :left_cut_label but for the right side of numbers.
    #    Defaults to '&rarr;'
    # :outer_window => <em>number_of_pages</em>::
    #    Sets the number of pages to include in the outer 'window'
    #    Defaults to 2
    # :inner_window => <em>number_of_pages</em>::
    #    Sets the number of pags to include in the inner 'window'
    #    Defaults to 10
    # :default_css => <em>use_paginator_provided_css</em>
    #    Use the default CSS provided by the paginator. If you want to do
    #    your own custom styling of the paginator from scratch, set this to 
    #    false.
    #    Defaults to true
    # :page_param => <em>name_of_page_paramiter</em>
    #    Sets the name of the paramiter the paginator uses to return what
    #    page is being requested.
    #    Defaults to 'page'
    # :url => <em>url_for_links</em>
    #    Provides the base url to use in the page navigation links.
    #    Defaults to ''
    def paginate(current_page, page_count, options = {})
      options.reverse_merge!({
        :class           => 'paginated',
        :prev_label      => '&laquo; Previous ',
        :next_label      => ' Next &raquo;',
        :left_cut_label  => '&larr;',
        :right_cut_label => '&rarr;',
        :outer_window    => 2,
        :inner_window    => 10,
        :default_css     => true,
        :page_param      => 'page',
        :url             => ''
      })
      url = options.delete :url
      url << (url.include?('?') ? '&' : '?') << options[:page_param]
      
      pages = { 
        :all => (1 .. page_count).to_a, 
        :left => [], 
        :center => [], 
        :right => [] 
      }
      
      # Only worry about using our 'windows' if the page count is less then 
      # our windows combined.
      if options[:inner_window].nil? or ((options[:outer_window] *2) + options[:inner_window] + 2) >= page_count
        pages[:center] = pages[:all]
      else
        pages[:left] = pages[:all][0, options[:outer_window]]
        pages[:right] = pages[:all][page_count - options[:outer_window], options[:outer_window]]
        pages[:center] = case current_page
        # allow the inner 'window' to shift to right when close to the left edge
        # Ex: 1 2 [3] 4 5 6 7 8 9 ... 20
        when -infinity .. (options[:inner_window] / 2) +3
          pages[:all][options[:outer_window], options[:inner_window]] + 
            [options[:right_cut_label]]
        # allow the inner 'window' to shift left when close to the right edge
        # Ex: 1 2 ... 12 13 14 15 16 [17] 18 19 20
        when (page_count - (options[:inner_window] / 2.0).ceil) -1 .. infinity
          [options[:left_cut_label]] +
            pages[:all][page_count - options[:inner_window] - options[:outer_window], options[:inner_window]]
        # Display the unshifed window
        # ex: 1 2 ... 5 6 7 [8] 9 10 11 ... 19 20
        else
          [options[:left_cut_label]] + 
            pages[:all][current_page - (options[:inner_window] / 2) -1, options[:inner_window]] +
            [options[:right_cut_label]]
        end
      end
      
      Builder::XmlMarkup.new.div(:class => options[:class]) do |b|
        b.style {|s| s << %Q{
          div.#{options[:class]} ul, div.#{options[:class]} ul li {
            display: inline;
            padding: 2px;
          }  
        } } if options[:default_css]
        b << (current_page <= 1 ? options[:prev_label] : %Q{<a href="#{url}=#{current_page -1}">#{options[:prev_label]}</a>})
        
        b.ul do
          [pages[:left], pages[:center], pages[:right]].each do |p|
            p.each do |page_number|
              case page_number
              when String
                b.li(:class=>'more_marker') {|li| li << page_number}
              when current_page
                b.li(page_number, :class=>'current_page')
              else
                b.li { b.a(page_number, :href=>"#{url}=#{page_number}") }
              end
            end
          end
        end
        
        b << (current_page >= page_count ? options[:next_label] : %Q{<a href="#{url}=#{current_page +1}">#{options[:next_label]}</a>})
      end
    end
    private
      def infinity; 1.0/0; end
  end
end