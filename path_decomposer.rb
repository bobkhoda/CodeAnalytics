require 'find'
require 'json'

class PathDecomposer
  def initialize(path, exclusion_regex = /\..*\//)
    @all_path_contents_enum = Find.find(path)
    @path_map = {}
    @extention_types = Hash.new(0)
    @path = path
    @exclusion_regex = exclusion_regex
    build_hash_of_extentions
  end

  def output_extention_types_and_counts(filename)
    begin
      file = File.open(filename, "w+") 
      get_sorted_extention_list.each do |key, value|
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

  def get_total_file_count
    @extention_types.values.reduce(:+)
  end

  private

    def build_hash_of_extentions
      @all_path_contents_enum.each do |directories_and_files|
        if File.file?(directories_and_files)
          filename = directories_and_files
          build_hash_of_extentions_and_count(filename)
        end
      end
    end

    def build_hash_of_extentions_and_count(filename)
      file_parts = filename.split(".")
      if filename !~ @exclusion_regex
        if file_parts.length > 1
          extention = file_parts.last
          @extention_types[:"#{extention}"] += 1
        else 
          @extention_types[:"no_extention"] += 1    
        end
      end
    end

    def get_sorted_extention_list
      @extention_types.sort_by {|k,v| -v}
    end

end