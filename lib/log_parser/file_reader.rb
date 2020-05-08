# frozen_string_literal: true
module LogParser
  class FileReader
    class FileNotFound < RuntimeError
    end

    class InvalidFilename < RuntimeError
    end

    def read(filepath)
      raise InvalidFilename if filepath.nil?

      File.open(filepath, 'r') do |file|
        file.each do |line|
          yield line.strip
        end
      end
    rescue Errno::ENOENT
      raise FileNotFound
    end
  end
end
