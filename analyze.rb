# require_relative 'path_decomposer'
# pd = PathDecomposer.new("/Stuff/builder")
# pd.output_extention_types_and_counts("test.json")
# puts pd.get_total_file_count

require 'find'
all_path_contents = Find.find('/stuff') {|stuff| puts stuff}
puts all_path_contents {|stuff| puts stuff}