# encoding: utf-8

require "logstash/filters/base"
require "logstash/namespace"

# This filter is meant to sort the events entering logstash
# that have the exact same timestamp by adding a sequence counter.
class LogStash::Filters::Example < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   sequence {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "sequence"
  plugin_status "beta"
  
  # Set the maximum events with the same timestamp we can sequence up 
  config :max, :validate => :number, :default => 10000  :required =>false 
  

  public
  def register #initializer
    @count = 1
  end # def register

  public
  def filter(event) #actual filtering job
	return unless filter?(event)
    event["sequence"] = @count
	@count += 1
	@count = 1 if @count == @max 
	
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Sequence
