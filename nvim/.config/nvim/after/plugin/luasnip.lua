local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("cpp", {
  ls.s({
      trig = "main",
      name = "Main function template",
      desc = "Create a C++ main fuction"
    },
    fmt(
      "#include <iostream>\n" ..
      "\n" ..
      "int main(int agrc, char *argv[]) {{\n" ..
      "  {}\n" ..
      "  return 0;\n" ..
      "}}"
      ,
      {
        ls.i(0, "std::cout << \"Hello, world!\" << std::endl;"),
      })),
})

ls.add_snippets("python", {
  ls.s({
      trig = "main",
      name = "Main function template",
      desc = "Create a Python main fuction"
    },
    fmt(
      "def main():\n" ..
      "    {}\n" ..
      "\n" ..
      "\n" ..
      "if __name__ == \"__main__\":\n" ..
      "    main()"
      ,
      {
        ls.i(0, "print(\"Hello, world!\")"),
      })),
})
