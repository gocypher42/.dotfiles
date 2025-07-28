local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("cpp", {
  ls.s(
    {
      trig = "main",
      name = "Main function template",
      desc = "Create a C++ main fuction",
    },
    fmt(
      "#include <iostream>\n"
        .. "\n"
        .. "int main(int agrc, char *argv[]) {{\n"
        .. "  {}\n"
        .. "  return 0;\n"
        .. "}}",
      {
        ls.i(0, 'std::cout << "Hello, world!" << std::endl;'),
      }
    )
  ),
})

ls.add_snippets("python", {
  ls.s(
    {
      trig = "main",
      name = "Main function template",
      desc = "Create a Python main fuction",
    },
    fmt(
      "def main():\n"
        .. "    {}\n"
        .. "\n"
        .. "\n"
        .. 'if __name__ == "__main__":\n'
        .. "    main()",
      {
        ls.i(0, 'print("Hello, world!")'),
      }
    )
  ),
})

ls.add_snippets("cmake", {
  ls.s(
    {
      trig = "project",
      name = "CMakeLists Base Tempate",
      desc = "Generate a default cmake template for a basic project",
    },
    fmt(
      "cmake_minimum_required(VERSION 3.15)\n"
        .. "\n"
        .. "project({}\n"
        .. "    LANGUAGES CXX\n"
        .. "    VERSION 1.0\n"
        .. ")\n"
        .. "\n"
        .. "set(CMAKE_CXX_STANDARD 20)\n"
        .. "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)\n"
        .. "set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${{CMAKE_BINARY_DIR}}/lib)\n"
        .. "set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${{CMAKE_BINARY_DIR}}/lib)\n"
        .. "set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${{CMAKE_BINARY_DIR}}/bin)\n"
        .. "\n"
        .. "include(FetchContent)\n"
        .. "\n"
        .. "FetchContent_Declare(fmt\n"
        .. "    GIT_REPOSITORY https://github.com/fmtlib/fmt.git\n"
        .. "    GIT_TAG 11.2.0\n"
        .. ")\n"
        .. "FetchContent_MakeAvailable(fmt)\n"
        .. "\n"
        .. "add_executable({} src/main.cpp)\n",
      {
        ls.i(1, "cmake-project"),
        rep(1),
      }
    )
  ),
})
