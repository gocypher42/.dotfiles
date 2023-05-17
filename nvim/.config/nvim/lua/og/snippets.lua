local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt

local function copy(args)
    print(vim.inspect(args))
    return args[1]
end
ls.add_snippets("cmake", {
    s(
        "projecttemplate",
        fmt(
            [[ 
            cmake_minimum_required(VERSION 3.25.1)

            project({})

            set(CMAKE_CXX_STANDARD 17)
            set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

            if(MSVC)
              set(CMAKE_CXX_FLAGS "${{CMAKE_CXX_FLAGS}} /W4 /WX")
            else()
              set(CMAKE_CXX_FLAGS "${{CMAKE_CXX_FLAGS}} -Wall")
            endif()

            file(GLOB SOURCE_FILES
              "src/*.cpp"
            )

            file(GLOB EXTERN_SOURCE_FILES

            )

            add_executable(${{PROJECT_NAME}} ${{SOURCE_FILES}} ${{EXTERN_SOURCE_FILES}})
            ]],
            {
                i(0),
            }
        )
    ),
}, {
    key = "cmake",
})

ls.add_snippets("cpp", {
    s(
        "apptemplate",
        fmt(
            [[ 
            #include <iostream>

            class App
            {{
            public:
              int run(int argc, char* argv[]);

            private:
            }};

            int run(int argc, char* argv[])
            {{
              // Place code here!
              std::cout << "Hello, world!" << std::endl;
              {}
              return 0;
            }};

            int main(int argc, char* argv[])
            {{
              App app;
              return app.run(argc, argv);
            }}
            ]],
            {
                i(0),
            }
        )
    ),
}, {
    key = "cpp",
})
