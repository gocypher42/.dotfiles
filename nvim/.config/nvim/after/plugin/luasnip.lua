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
      [[
      #include <iostream>

      int main(int agrc, char *argv[]) {{
        {}
        return 0;
      }}
      ]],
      {
        ls.i(0, 'std::cout << "Hello, world!" << std::endl;'),
      }
    )
  ),
})

ls.add_snippets("javascript", {
  ls.s(
    {
      trig = "oglog",
      name = "Logging snip",
      desc = "Logging snip",
    },
    fmt(
      [[console.log("=== [OG] ===> {}")]],
      {
        ls.i(0),
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
      [[
      def main():
          {}


      if __name__ == "__main__":
          main()
      ]],
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
      [[
      cmake_minimum_required(VERSION 3.15)

      project(
        {}
        LANGUAGES CXX
        VERSION 1.0
      )

      set(CMAKE_CXX_STANDARD 20)
      set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
      set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${{CMAKE_BINARY_DIR}}/lib)
      set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${{CMAKE_BINARY_DIR}}/lib)
      set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${{CMAKE_BINARY_DIR}}/bin)

      include(FetchContent)

      FetchContent_Declare(
        fmt
        GIT_REPOSITORY https://github.com/fmtlib/fmt.git
        GIT_TAG 11.2.0
      )
      FetchContent_MakeAvailable(fmt)

      add_executable({} src/main.cpp{})
      ]],
      {
        ls.i(1, "project_name"),
        rep(1),
        ls.i(0)
      }
    )
  ),
})
