require 'find'
require 'json'

class PathDecomposer
  def initialize(path, exclusion_regex = /\..*\//)
    @all_path_contents_enum = Find.find(path)
    @extention_types = Hash.new(0)
    @path = path
    @exclusion_regex = exclusion_regex
    @files = []
    build_hash_of_extentions
    build_array_of_files
  end

  def get_extention_type_hash
    @extention_types.dup
  end

  def get_sorted_extention_list(hash_to_sort)
    sort_list(hash_to_sort)
  end

  def get_files(extention = "")
    extention == "" ? @files.dup : build_array_of_file_by_extention(extention)
  end

  def sort_list(hash_to_sort)
    hash_to_sort.sort_by {|k,v| -v}
  end

  def get_all_extentions
    @extention_types.keys
  end

  private

    def build_array_of_file_by_extention(extention)
      extention_regex = /^.*#{extention}$/
      temp_file_array = []
      @all_path_contents_enum.each do |directories_and_files|
        if File.file?(directories_and_files)
          temp_file_array << directories_and_files if directories_and_files =~ extention_regex
        end
      end
      temp_file_array
    end

    def build_array_of_files
      @all_path_contents_enum.each do |directories_and_files|
        if File.file?(directories_and_files)
          @files << directories_and_files
        end
      end
    end

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
end