require 'fileutils'
require 'rubygems'
require 'git'
require 'cmaker/strings'
require 'cmaker/file'

GEM_NAME = "cmaker"
MAKE_PROJECT_COMMAND = "makeproject"
GOOGLE_TEST_REPO = "https://github.com/google/googletest.git"
GOOGLE_TEST_DIR_NAME = "googletest"

class CMaker
    def self.run(command, project_name)
        case command
        when MAKE_PROJECT_COMMAND
            self.create_project(project_name)
        else
            puts GemStrings.gem_description()
        end
    end

    def self.create_project(project_name)
        if project_name == nil
            puts GemStrings.no_project_name_error()
            return
        end

        project_dir_path = project_name

        # Check for naming conflict
        if Dir.exists?(project_dir_path)
            puts "Can't create project. There's already a directory with the name \'#{project_name}\'."
            return
        end

        puts "Creating project \'#{project_name}\'..."

        # Define names and paths
        temp_dir_path = "#{project_name}/.tmp"
        executable_name = "run#{project_name}"
        test_executable_name = "run#{project_name}Tests"

        code_dir_name = project_name
        code_dir_path = "#{project_name}/#{code_dir_name}"
        test_dir_name = "#{project_name}Tests"
        test_dir_path = "#{project_name}/#{test_dir_name}"
        main_file_path = "#{project_dir_path}/main.cpp"
        test_lib_dir_path = "#{test_dir_path}/lib"

        gtest_dir_name = "lib/#{GOOGLE_TEST_DIR_NAME}"
        gtest_dir_path = "#{test_dir_path}/#{gtest_dir_name}"
        unit_test_dir_name = "tests"
        unit_test_dir_path = "#{test_dir_path}/#{unit_test_dir_name}"

        empty_test_file_name = "empty_test.cpp"
        empty_test_file_path = "#{test_dir_path}/#{unit_test_dir_name}/#{empty_test_file_name}"

        empty_header_name = "#{project_name}.h"
        empty_header_path = "#{code_dir_path}/#{empty_header_name}"
        empty_cpp_name = "#{project_name}.cpp"
        empty_cpp_file_path = "#{code_dir_path}/#{empty_cpp_name}"

        # CMake contents
        project_cmake = GemStrings.project_dir_cmake_content(project_name, executable_name, code_dir_name, test_dir_name)
        code_make = GemStrings.code_dir_cmake_content(code_dir_name, empty_header_name, empty_cpp_name)
        test_cmake = GemStrings.test_dir_cmake_content(test_dir_name, gtest_dir_name, unit_test_dir_name)
        tests_cmake = GemStrings.tests_dir_cmake_content(test_executable_name, empty_test_file_name, code_dir_name)

        # Create directories
        FileHelpers.create_directory(temp_dir_path, nil)
        FileHelpers.create_directory(project_dir_path, project_cmake)
        FileHelpers.create_directory(code_dir_path, code_make)
        FileHelpers.create_directory(test_dir_path, test_cmake)
        FileHelpers.create_directory(gtest_dir_path, nil)
        FileHelpers.create_directory(unit_test_dir_path, tests_cmake)

        # Create code files
        FileHelpers.write_string_to_file(GemStrings.main_file_content(), main_file_path)
        FileHelpers.write_string_to_file(GemStrings.empty_test_file_content(), empty_test_file_path)

        FileHelpers.write_string_to_file(GemStrings.empty_header_contents(), empty_header_path)
        FileHelpers.write_string_to_file(GemStrings.empty_cpp_contents(), empty_cpp_file_path)

        # Add google test
        puts "Adding \'Google Test\'..."

        begin
            self.add_google_test(test_lib_dir_path, temp_dir_path)
        rescue
            puts "Google Test installation failed, unable to create project"
            self.handle_fatal_error(project_dir_path)
            return
        end

        # Clean up
        FileHelpers.delete_directory(temp_dir_path)

        puts "Finished successfully"
    end

    def self.add_google_test(lib_directory, temp_dir_path)
        clone_directory = "#{temp_dir_path}/google_test_clone"
        googletest_clone_directory = "#{clone_directory}/#{GOOGLE_TEST_DIR_NAME}"

        Git.clone(GOOGLE_TEST_REPO, clone_directory)

        FileUtils.cp_r googletest_clone_directory, lib_directory
    end

    def self.handle_fatal_error(project_dir)
        FileHelpers.delete_directory(project_dir)
    end
end
