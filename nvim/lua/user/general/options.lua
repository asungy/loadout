-- Used to help construct a string representation of a list of values that
-- neovim can understand.
function list_string(list)
    local str = ""
    for i = 1, (#list - 1) do
        str = str .. list[i] .. ","
    end
    return str .. list[#list]
end

-- value for listchars
local listchars = {
    "precedes:<",
    "extends:>",
    "tab:>-",
    "trail:_",
}
listchars = list_string(listchars)

-- status line format string
local status_fmt = ""
status_fmt = status_fmt .. "%n "  -- buffer number
status_fmt = status_fmt .. "%m"   -- modified flag
status_fmt = status_fmt .. "%r"   -- readonly flag
status_fmt = status_fmt .. "%y "  -- file type
status_fmt = status_fmt .. "%F "  -- absolute full file path
status_fmt = status_fmt .. "%= "  -- separation point
status_fmt = status_fmt .. "L:%l" -- current line number
status_fmt = status_fmt .. "/%L " -- number of lines in buffer
status_fmt = status_fmt .. "C:%v" -- column number

-- winbar format string
local winbar_fmt = ""
winbar_fmt = winbar_fmt .. "%n "  -- buffer number
winbar_fmt = winbar_fmt .. "%m "  -- modified flag
winbar_fmt = winbar_fmt .. "%r"   -- readonly flag
winbar_fmt = winbar_fmt .. "%y "  -- file type
winbar_fmt = winbar_fmt .. "%f "  -- full file path

local options = {
    autoindent = true,          -- copy indent from current line when creating new line
    backup = false,             -- create backup file
    breakindent = true,         -- indent wrapped lines
    clipboard = "unnamedplus",  -- use clipboard register '+'
    cmdheight = 0,              -- number of lines used for the command line
    completeopt = {             -- show completion menu
        "menuone",
        "noselect",
    },
    confirm = true,             -- raise dialog for confirmation
    cursorline = false,         -- highlight text line of cursor
    expandtab = true,           -- use appropriate number of spaces to insert a <Tab>
    fileencoding = "utf-8",     -- encoding written to a file
    hlsearch = true,            -- highlight all matches on previous search pattern
    hidden = true,              -- do not unload abandoned buffers
    ignorecase = false,         -- ignore case in search patterns
    icon = true,                -- sets text to window title
    iconstring = "",            -- used for icon text of window
    laststatus = 2,             -- value option to select when last window will have status line
                                -- (2: always)
    list = true,                -- set list mode. useful for seeing trailing whitespaces
    listchars = listchars,      -- string used for list mode
    makeprg = "make",           -- program used for ":make" command
    matchpairs = {              -- characters that form pairs for '%' command
        "(:)",
        "[:]",
        "{:}",
    },
    menuitems = 25,             -- max number of items to use in a menu
    mouse = "a",                -- enable mouse support
    number = true,              -- display line numbers
    numberwidth = 4,            -- line number column width
    pumblend = 10,              -- pseudo-transparency for popup-menu
    pumheight = 10,             -- max number of items to show in popup-menu
    relativenumber = true,      -- show line number relative to cursor line
    scrolloff = 10,             -- min number of lines to keep above and below cursor
    shell = os.getenv("SHELL"), -- name of shell to use for :! commands
    shiftwidth = 4,             -- number of spaces to use for each step of (auto)indent
    showbreak = "+++ ",         -- string to put at start of lines that have been wrapped
    showtabline = 0,            -- when to show tabline (0: never)
    smarttab = true,            -- enable smart tab
    smartindent = true,         -- enable smart indent
    splitbelow = true,          -- splitting window will put new window below the current one
    splitright = true,          -- splitting window will put new window to right of current one
    statusline = status_fmt,    -- set status line format
    swapfile = false,           -- use swapfile for buffer
    tabstop = 4,                -- number of spaces that <Tab> counts for
    termguicolors = true,       -- enable 24-bit RGB color
    wildmenu = true,            -- enable "enhanced mode" of command-line completion
    winbar = "",        -- set winbar format
    wrap = true,                -- set text wrap
    wrapmargin = 0,             -- number of characters from window border before wrapping starts
}

-- Set vim options
for k, v in pairs(options) do
    vim.opt[k] = v
end
