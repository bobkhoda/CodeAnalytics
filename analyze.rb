require_relative 'path_decomposer'
pd = PathDecomposer.new("/Stuff")
pd.output_extention_types_and_counts("test.json")
puts pd.get_total_file_count
