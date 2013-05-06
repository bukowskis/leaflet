require 'positify'
require 'leaflet/configuration'

module Leaflet
  class Collection < Array

    PartialCollectionCannotBePaginated = Class.new(StandardError)

    # ––––––––––––––
    # Initialization
    # ––––––––––––––

    def initialize(*args)
      if args.size == 1
        # An Array was passed in. "Convert" it to a Collection.
        replace args.shift

      elsif args.size == 2
        # Someone is building a custom Paginator, let's fetch the data.
        options = args.pop
        records = Array(args.shift)
        replace records
        @current_page  = options[:page]
        @per_page      = options[:per_page]
        @total_entries = options[:total] || self.size

      else
        raise ArgumentError
      end
    end

    def paginate(options = {})
      raise PartialCollectionCannotBePaginated unless complete?
      preliminary = self.class.new [], options.merge!(total: self.size)
      result = self.class.new self[preliminary.offset, preliminary.per_page].to_a, options
    end

    # –––––––––––––––––––––––
    # Public Instance Getters
    # –––––––––––––––––––––––

    def total_entries
      (@total_entries ||= self.size).to_i.abs
    end
    alias :total_count :total_entries  # Kaminari

    def per_page
      Positify.it(max: Leaflet.config.max_per_page) {
        @per_page ||= Leaflet.config.default_per_page
      }
    end
    alias :limit_value :per_page  # Kaminari

    def current_page
      Positify.it(max: total_pages) {
        @current_page ||= 1
      }
    end

    # ––––––––––––––––––––
    # Public Class Getters
    # ––––––––––––––––––––

    def offset
      (current_page - 1) * per_page
    end
    alias :offset_value :offset  # Kaminari

    def total_pages
      Positify.it {
        total_entries.zero? ? 1 : (total_entries / per_page.to_f).ceil
      }
    end

    def inspect
      result = ['#<Collection with']
      result << (complete? ? "#{self.size} records" : "#{self.size}/#{total_entries} records")
      result << "on page #{current_page}/#{total_pages} (#{per_page} per page): #{self.to_a}>"
      result.join(' ')
    end

    def previous_page
      current_page > 1 ? (current_page - 1) : nil
    end

    def next_page
      current_page < total_pages ? (current_page + 1) : nil
    end

    def first_page?
      current_page == 1
    end

    def last_page?
      current_page == total_pages
    end

    def as_json(options = {})
      { 
        total_entries: total_entries,
        total_count: total_count,
        per_page: per_page,
        limit_value: limit_value,
        current_page: current_page,
        offset: offset,
        offset_value: offset_value,
        total_pages: total_pages,
        records: self.to_a
      }
    end

    private

    # ––––––––––––––––––––––
    # Internal Class Getters
    # ––––––––––––––––––––––

    def complete?
      self.size == total_entries
    end

  end
end
