# frozen_string_literal: true

# some classes
class SlackLogger
  def initialize(message)
    @message = message
  end

  def sending
    puts 'we are sending message to Slack'
  end
end
class EmailLogger
  def initialize(message)
    @message = message
  end

  def sending
    puts 'we are sending message to Email'
  end
end
class StorageLogger
  def initialize(message)
    @message = message
  end

  def sending
    puts 'we are sending message to some storage'
  end
end

# abstract factory
class AbstractLogging
  attr_reader :log_string
  def initialize(log_string)
    @log_string = log_string
  end

  def action
    new_log_object.sending
  end

  private

  def new_log_object
    raise 'not implemented error'
  end
end

class SlackLogging < AbstractLogging
  private

  def new_log_object
    SlackLogger.new(@log_string)
  end
end

class EmailLogging < AbstractLogging
  private

  def new_log_object
    EmailLogger.new(@log_string)
  end
end

class StorageLogging < AbstractLogging
  private

  def new_log_object
    StorageLogger.new(@log_string)
  end
end

SlackLogging.new('some error').action
EmailLogging.new('some error').action
StorageLogging.new('some error').action
