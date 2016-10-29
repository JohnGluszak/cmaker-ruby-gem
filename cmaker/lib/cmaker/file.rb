require 'fileutils'

class FileHelpers
    def self.create_directory(directory_path, cmake_string)
        FileUtils.mkpath directory_path

        if cmake_string.nil? == false
            cmake_file_path = "#{directory_path}/CMakeLists.txt"
            self.write_string_to_file(cmake_string, cmake_file_path)
        end
    end

    def self.delete_directory(directory_path)
        FileUtils.rm_r(directory_path)
    end

    def self.write_string_to_file(file_content, file_path)
        cmake = File.new(file_path, "w")
        cmake.puts(file_content)
        cmake.close
    end
end
