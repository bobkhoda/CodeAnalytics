require_relative 'path_decomposer'

class Counter
  def initialize
    @path_decomposer = PathDecomposer.new("/trunk")
    @extention_types = @path_decomposer.get_extention_type_hash
    @lines_by_file = Hash.new("")
  end

  def output_extention_types_and_counts(filename)
    begin
      file = File.open(filename, "w+") 
      @path_decomposer.get_sorted_extention_list(@extention_types).each do |key, value|
        file << "#{key}\t#{value}\n"
      end
    rescue => error
      puts error
    ensure
      file.close
    end
  end

  def output_extention_types_and_counts_to_json(filename)
    begin
      file = File.open(filename, "w") 
      file << JSON.generate(@extention_types)
    rescue => error
      puts error
    end
  end

  def build_line_count_by_file_type(file_type)
    @path_decomposer.get_files(file_type).each do |filename|
      begin
        file = File.open(filename) {|f| @lines_by_file[filename] = f.count}
      rescue => error
        puts error
      end
    end
    @lines_by_file
  end

  def write_line_count_by_file_type(filename, file_type)
    temp_file_count_hash = build_line_count_by_file_type(file_type).sort_by {|k,v| -v}
    begin
      file = File.open(filename, "w+") 
      temp_file_count_hash.each do |key, value|
        file << "#{key}\t#{value}\n"
      end
    rescue => error
      puts error
    ensure
      file.close
    end
  end

  def get_total_file_count
    @extention_types.values.reduce(:+)
  end

  def get_files(file)
    @path_decomposer.get_files(file)
  end

  def get_all_files
    @path_decomposer.get_files
  end

  def get_all_extentions
    @path_decomposer.get_all_extentions
  end
end


counter = Counter.new
counter.output_extention_types_and_counts("test.json")
# counter.write_line_count_by_file_type("test.txt", "cfc")
puts counter.get_total_file_count

['cfc', 'cfm', 'xml'].each do |file_type|
  counter.write_line_count_by_file_type("test.txt", file_type)
end
# puts counter.get_files("cfc")
# a = counter.build_line_count_by_file_type("cfc").sort_by {|k,v| -v}
# a.each {|k,v| puts "filename: #{k} \tlines: #{v}"}
# puts counter.get_all_files
