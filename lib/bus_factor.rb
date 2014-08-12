require 'bus_factor/version'
require 'json'
require 'bundler'
require 'rest-client'
Bundler.require :all

module BusFactor
  class << self
    Result = Struct.new(:name, :emails) do
      def to_s(length_chars: 2, spec_chars:15)
        fs = "%#{length_chars}s, %#{spec_chars}s: %s"
        format(
          fs,
          emails.length,
          name,
          emails.join(', ')
        )
      end
    end

    # TODO: how often updated?
    def worst
      sorted_specs.map do |spec|
        Result.new(
          spec.name,
          owners_of(spec).map { |o| o['email'] }
        )
      end
    end

    def sorted_specs
      specs = Bundler.locked_gems.specs.map(&:__materialize__)
      specs.sort_by do |spec|
        owners_of(spec).length
      end
      specs
    end

    def owners_of(geem)
      geem = geem.name if geem.respond_to? :name
      owner_cache[geem]
    end

    def owner_cache
      @owner_cache ||= Hash.new do |hash, key|
        uri = "https://rubygems.org/api/v1/gems/#{key}/owners.json"
        hash[key] = JSON.parse(RestClient.get uri)
      end
    end
  end
end
