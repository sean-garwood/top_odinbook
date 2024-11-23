module ApplicationHelper
  # TODO: load faker::simpsons stuff

  LOGGERS = %i[debug info warn error fatal unknown]
  def log_error(data, method)
    Rails.logger.error { "Failed to #{method}: #{data}" }
  end

  def my_debugger(**data)
    wrapper = "\e[1;31mDEBUG: #{data.expand}\e[0m"
    my_logger(wrapper, :debug)
  end

  def my_logger(data, method = :debug)
    return my_logger(data, :debug) unless LOGGERS.include?(method)

    LOGGERS.index(method).between?(LOGGERS.size - 3, LOGGERS.size) && log_error(data, method)

    Rails.logger.send(method) { data }
  end
end
