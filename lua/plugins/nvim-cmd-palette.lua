return {
  "koenverburg/cmd-palette.nvim",
  dependencies = {
    "stevearc/dressing.nvim",
  },

  config = function()
    local palette = require 'cmd-palette'
    palette.setup {
      {
        label = '[Cpp] Switch cpp,header',
        cmd = 'ClangdSwitchSourceHeader',
      },
      {
        label = '[Cmake] Create MSBuild build setting file',
        cmd = 'TermExec cmd="cmake -S . -B build" go_back=0',
      },
      {
        label = '[Cmake] Debug Build',
        cmd = 'TermExec cmd="cmake --build build -v --config Debug" go_back=0',
      },
      {
        label = '[Cmake] Release Build',
        cmd = 'TermExec cmd="cmake --build build -v --config Release" go_back=0',
      },
      {
        label = '[Cmake] Simple Debug and Run',
        cmd = [[TermExec cmd="cmake --build build -v --config Debug; .\build\debug\program.exe" go_back=0]],
      },
      {
        label = '[Telescope] Find Files',
        cmd = 'Telescope find_files',
      },
      {
        label = '[Lsp] Find Definition',
        cmd = 'lua vim.lsp.buf.definition()',
      },
      {
        label = '[Lsp] Formating',
        cmd = 'lua vim.lsp.buf.format()',
      },
      {
        label = '[Outline] Open Outline',
        cmd = 'Outline',
      },
      {
        label = '[Trouble] Check trouble',
        cmd = 'Trouble',
      },
      {
        label = '[Cargo] cargo run',
        cmd = 'TermExec cmd="cargo run" go_back=0',
      },
      {
        label = '[Cargo] cargo run with back trace',
        cmd = 'TermExec cmd="RUST_BACKTRACE=1 cargo run" go_back=0',
      },
      {
        label = '[search] ripgrep',
        callback = function()
          require 'rgflow'.open_blank('')
        end
      },
      {
        label = '[search] all files',
        callback = require 'spectre'.open
      },
      {
        label = '[search] current file',
        callback = require 'spectre'.open_file_search
      },
    }
  end
}
