require 'find'

class PathDecomposer
  def initialize(path, exclusion_regex = /\..*\//)
    @all_path_files = []
    Find.find(path) do |directories_and_files|
      if File.file?(directories_and_files) and directories_and_files !~ exclusion_regex
        @all_path_files << directories_and_files
      end
    end
  end

  def get_files_fullpath(extention = "", exculsion = "installedServices")
    matching_regex = (extention.empty?) ? /(?!.*#{exculsion}.*).*/i : /(?!.*#{exculsion}.*)^.*#{extention}$/i
    @all_path_files.find_all{|files| files =~ matching_regex}
  end

  def get_extentions
    filenames_with_extention = @all_path_files.find_all{|filename| filename.split('.').count > 1}
    filenames_with_extention.map{|filename| filename.split('.').last}.uniq
  end
end