require 'json'

class AnalyticsWriter
  def write_analytics_hash(hash, filename)
    begin
      if filename.split('.').last =~ /json/i
        file = File.open(filename, "w") 
        file << JSON.generate(hash)
      else
        file = File.open(filename, "w+") 
        (hash).each do |key, value|
          file << "#{key}\t#{value}\n"
        end
      end
    rescue => error
      puts error
    ensure
      file.close
    end
  end
end