return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  config = function()
    local jdtls = require('jdtls')
    local jdtls_pkg = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
    local uname = (vim.uv or vim.loop).os_uname().sysname
    local config_folder = uname == 'Darwin' and 'config_mac'
      or uname == 'Windows_NT' and 'config_win'
      or 'config_linux'

    local function find_java_home(version)
      local candidates = {
        vim.fn.trim(vim.fn.system('JENV_VERSION=' .. version .. ' jenv prefix 2>/dev/null')),
        vim.fn.trim(vim.fn.system('/usr/libexec/java_home -v ' .. version .. ' 2>/dev/null')),
        '/usr/lib/jvm/java-' .. version .. '-openjdk-amd64',
        '/usr/lib/jvm/java-' .. version .. '-openjdk',
        '/usr/lib/jvm/temurin-' .. version,
        vim.fn.expand('~/.sdkman/candidates/java/') .. version .. '.0-tem',
        '/opt/homebrew/opt/openjdk@' .. version,
        '/usr/local/opt/openjdk@' .. version,
      }
      for _, path in ipairs(candidates) do
        if path and path ~= '' and vim.fn.isdirectory(path .. '/bin') == 1 then
          return path
        end
      end
      return nil
    end

    local java21_home = find_java_home('21')
    local java17_home = find_java_home('17')

    assert(java21_home, 'Java 21 not found — jdtls requires it to run')
    vim.env.JAVA_HOME = java21_home

    local launcher_jar = vim.fn.glob(jdtls_pkg .. '/plugins/org.eclipse.equinox.launcher_*.jar')
    assert(launcher_jar ~= '', 'Equinox launcher jar not found — is jdtls installed via Mason?')

    local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/workspace/'
      .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

    local config = {
      -- Build the cmd manually so we have full control — no double flags
      cmd = {
        java21_home .. '/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.level=ALL',
        '-Xmx2g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', launcher_jar,
        '-configuration', jdtls_pkg .. '/' .. config_folder,
        '-data', workspace_dir,
      },

      root_dir = require('jdtls.setup').find_root({
        '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'
      }),

      settings = {
        java = {
          configuration = {
            runtimes = vim.tbl_filter(function(r) return r.path ~= nil end, {
              { name = 'JavaSE-21', path = java21_home },
              { name = 'JavaSE-17', path = java17_home, default = true },
            }),
          },
        },
      },
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = function()
        jdtls.start_or_attach(config)
      end,
    })
  end,
}
