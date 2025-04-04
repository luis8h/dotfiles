return {
  -- Command to start the server (adjust if necessary)
  cmd = { "pylsp" },
  -- Filetypes to trigger this LSP configuration
  filetypes = { "python" },
  -- Define a way to detect the root of your project
  root_markers = { ".git", "pyproject.toml", "setup.py", "requirements.txt" },
  -- Your pylsp-specific settings:
  settings = {
    pylsp = {
      plugins = {
        rope_autoimport = { enabled = true },
        black = { enabled = true, line_length = 99 },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        pylint = {
          enabled = false,
          args = {
            "--max-line-length=99",
            "--disable=missing-module-docstring",
            "--disable=missing-function-docstring",
            "--disable=missing-class-docstring",
            "--disable=line-too-long",
            "--disable=import-error",
            "--disable=relative-beyond-top-level",
            "--disable=unused-argument",
          },
        },
        flake8 = {
          enabled = true,
          maxLineLength = 99,
          ignore = { "E501", "W503" },
        },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        pylsp_mypy = {
          enabled = true,
          report_progress = true,
          live_mode = true,
          overrides = {
            "--ignore-missing-imports",
            "--disable-error-code=import-untyped",
            "--explicit-package-bases",
            true,
          },
        },
        jedi_completion = { fuzzy = true },
        pyls_isort = { enabled = true },
      },
    },
  },
}

