local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local function copy(args)
    print(vim.inspect(args))
    return args[1]
end

ls.add_snippets("cpp", {
    s(
        "apptemplate",
        fmta(
            [[
        #include <<iostream>>

        class <1> 
        {
        private:
        public:
          static void run() 
          {
            // Place code here!
            std::cout <<<< "Hello, world!" <<<< std::endl;
            <2>
          };
        };

        int main() 
        {
          <3>::run();
          return 0;
        }
        ]],
            {
                i(1, "App"),
                i(0),
                f(copy, 1),
            }
        )
    ),
}, {
    key = "cpp",
})
