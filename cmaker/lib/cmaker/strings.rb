class GemStrings
    def self.gem_description()
        return "Usage:\n\n\t$ #{GEM_NAME} COMMAND\n\n" \
               "Commands:\n\n\t+ #{MAKE_PROJECT_COMMAND} [NAME]\t" \
               "Creates a C++ project integrated with CMake and Google Test"
    end

    def self.no_project_name_error()
        return "Please supply a name for the project, like so:\n\n" \
               "\t$ #{GEM_NAME} #{MAKE_PROJECT_COMMAND} [NAME]"
    end

    def self.project_dir_cmake_content(project_name, executable_name, code_dir_name, test_dir_name)
        return "cmake_minimum_required(VERSION 3.6)\n" \
               "project(#{project_name})\n\n" \
               "set(CMAKE_CXX_FLAGS \"${CMAKE_CXX_FLAGS} -std=c++11\")\n\n" \
               "set(SOURCE_FILES main.cpp)\n" \
               "add_executable(#{executable_name} ${SOURCE_FILES})\n\n" \
               "include_directories(#{code_dir_name})\n\n" \
               "add_subdirectory(#{code_dir_name})\n" \
               "add_subdirectory(#{test_dir_name})\n\n" \
               "target_link_libraries(#{executable_name} #{code_dir_name})\n"
    end

    def self.code_dir_cmake_content(dir_name, header_file_name, cpp_file_name)
        return "project(#{dir_name})\n\n" \
               "add_library(#{dir_name} #{header_file_name} #{cpp_file_name})\n"
    end

    def self.test_dir_cmake_content(dir_name, gtest_dir_name, tests_dir_name)
        return "project(#{dir_name})\n\n" \
               "add_subdirectory(#{gtest_dir_name})\n" \
               "add_subdirectory(#{tests_dir_name})\n"
    end

    def self.tests_dir_cmake_content(test_executable_name, empty_test_file_name, code_dir_name)
        return "include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})\n\n" \
               "add_executable(#{test_executable_name} #{empty_test_file_name})\n\n" \
               "target_link_libraries(#{test_executable_name} gtest gtest_main)\n" \
               "target_link_libraries(#{test_executable_name} #{code_dir_name})\n"
    end

    def self.main_file_content()
        return "#include <iostream>\n\n" \
               "int main() {\n" \
               "\tstd::cout << \"Hello, World!\" << std::endl;\n" \
               "\treturn 0;\n" \
               "}\n" 
    end

    def self.empty_test_file_content()
        return "#include \"gtest/gtest.h\"\n\n" \
               "TEST(test_functionality, test_pass) {\n" \
               "\tEXPECT_EQ(1, 1);\n" \
               "}\n"
    end

    def self.empty_header_contents()
        return ""
        # return "#ifndef "EMPTYPROJECT"_"MYPROJECT"_H\n"
    end

    def self.empty_cpp_contents()
        return ""
        # return "#include \"" + empty_header_name + "\"\n"
    end
end
