local if_nil = vim.F.if_nil

local header = {
    type = "text",
    val = {
        "           ,.         ,·´'; '                 _,.,  °           , ·. ,.-·~·.,   ‘        ,.-.                        ,.-·.         ,·'´¨;.  '                          ",
        "      ;'´*´ ,'\       ,'  ';'\°         ,.·'´  ,. ,  `;\ '        /  ·'´,.-·-.,   `,'‚       /   ';\ '                    /    ;'\'       ;   ';:\           .·´¨';\   ",
        "      ;    ';::\      ;  ;::'\       .´   ;´:::::\`'´ \'\       /  .'´\:::::::'\   '\ °    ';    ;:'\      ,·'´';        ;    ;:::\     ;     ';:'\      .'´     ;:'\  ",
        "     ;      '\;'      ;  ;:::;      /   ,'::\::::::\:::\:'   ,·'  ,'::::\:;:-·-:';  ';\‚     ';   ;::;     ,'  ,''\      ';    ;::::;'    ;   ,  '·:;  .·´,.´';  ,'::;'",
        "    ,'  ,'`\   \      ;  ;:::;     ;   ;:;:-·'~^ª*';\'´    ;.   ';:::;´       ,'  ,':'\‚    ';   ';::;   ,'  ,':::'\'     ;   ;::::;    ;   ;'`.    ¨,.·´::;'  ;:::;   ",
        "    ;  ;::;'\  '\    ;  ;:::;      ;  ,.-·:*'´¨'`*´\::\ '    ';   ;::;       ,'´ .'´\::';‚    ';   ;:;  ,'  ,':::::;'    ';  ;'::::;     ;  ';::; \*´\:::::;  ,':::;‘  ",
        "   ;  ;:::;  '\  '\ ,'  ;:::;'     ;   ;\::::::::::::'\;'     ';   ':;:   ,.·´,.·´::::\;'°     ;   ;:;'´ ,'::::::;'  '   ;  ';:::';     ';  ,'::;   \::\;:·';  ;:::; ' ",
        "  ,' ,'::;'     '\   ¨ ,'\::;'      ;  ;'_\_:;:: -·^*';\      \·,   `*´,.·'´::::::;·´        ';   '´ ,·':::::;'        ';  ;::::;'    ;  ';::;     '*´  ;',·':::;‘     ",
        "  ;.'\::;        \`*´\::\; °     ';    ,  ,. -·:*'´:\:'\°     \\:¯::\:::::::;:·´            ,'   ,.'\::;·´           \*´\:::;‘    \´¨\::;          \¨\::::;            ",
        "  \:::\'          '\:::\:' '        \`*´ ¯\:::::::::::\;' '     `\:::::\;::·'´  °             \`*´\:::\;     ‘         '\::\:;'      '\::\;            \:\;·'          ",
        "    \:'             `*´'‚            \:::::\;::-·^*'´              ¯                         '\:::\;'                   `*´‘         '´¨               ¨'              ",
        "                                      `*´¯                        ‘                           `*´‘                                                                     ",
--        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
--        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
--        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
--        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
--        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
--        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
    },
    opts = {
        position = "center",
        hl = "Type",
        -- wrap = "overflow";
    },
}

--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button("n", "  > New file" , ":ene <BAR> startinsert <CR>"),
        button("g", "  > File tree", ":NvimTreeToggle<CR>"),
        button("f", "  > Find file", ":Telescope find_files<CR>"),
        button("r", "  > Recent"   , ":Telescope oldfiles<CR>"),
        button("s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        button("q", "  > Quit NVIM", ":qa<CR>"),
    },
    opts = {
        spacing = 1,
    },
}

options = {
        layout = {
            { type = "padding", val = 2 },
            header,
            { type = "padding", val = 2 },
            buttons,
        },
        opts = {
            margin = 5,
        },
    }

return { opts = options }
