require_relative 'path_decomposer'
pd = PathDecomposer.new("/trunk")
pd.output_extention_types_and_counts("test.json")
