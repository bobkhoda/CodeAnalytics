require_relative 'path_decomposer'
require_relative 'analytics_writer'

class Analyzer
  def initialize
    @path_decomposer = PathDecomposer.new('/stuff')
    @files_fullpath = @path_decomposer.get_files_fullpath
    @extentions = @path_decomposer.get_extentions
  end

  def build_line_count_by_file_type(file_type)
    lines_by_file = Hash.new(0)
    @path_decomposer.get_files_fullpath(file_type).each do |filename|
      begin
        file = File.open(filename) {|f| lines_by_file[filename] = f.count}
      rescue => error
        puts error
      end
    end
    lines_by_file
  end

  def build_extention_count(filenames = @files_fullpath)
    extention_types = Hash.new(0)
    filenames.each do |filename|
      file_parts = filename.split(".")
      file_parts.length > 1 ? extention_types[:"#{file_parts.last}"] += 1 : extention_types[:"no_extention"] += 1
    end
    extention_types
  end

  def get_total_file_count
    @files_fullpath.count
  end

  def sort_hash(hash_to_sort)
    hash_to_sort.sort_by {|k,v| -v}
  end
end

pd = PathDecomposer.new('/stuff')
an = Analyzer.new
aw = AnalyticsWriter.new
# puts pd.get_files_fullpath
puts pd.get_extentions
# puts an.build_extention_count
aw.write_analytics_hash(an.build_line_count_by_file_type('cfc'), 'test.txt')
