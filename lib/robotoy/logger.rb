module Robotoy
  class Logger
    def self.info(message)
      puts message
    end

    def self.warn(message)
      puts "\e[33m#{message}\e[0m"
    end

    def self.error(message)
      puts "\e[31m#{message}\e[0m"
    end
  end
end
