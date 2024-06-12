local function set_theme(name)
  vim.cmd.colorscheme(name)
end

local M = {
  themes = {
    catppuccin = {
      style = { 'latte', 'frappe', 'macchiato', 'mocha' },
      activate = function(style, transparent)
        require('catppuccin').setup {
          flavour = style,
          no_italic = true,
          no_bold = true,
          no_underline = true,

          transparent_background = transparent,
        }

        set_theme 'catppuccin'
      end,
    },

    ['rose-pine'] = {
      style = { 'main', 'moon', 'dawn' },
      activate = function(style, transparent)
        require('rose-pine').setup {
          variant = style,
          styles = {
            bold = false,
            italic = false,
            transparency = transparent,
          },
        }

        set_theme 'rose-pine'
      end,
    },

    dracula = {
      style = { 'classic', 'soft' },
      activate = function(style, _)
        require('dracula').setup()

        local suffix = ''
        if style == 'soft' then
          suffix = '-soft'
        end

        set_theme('dracula' .. suffix)
      end,
    },

    github = {
      style = { 'dark', 'dark_dimmed', 'dark_default', 'light', 'light_default' },
      activate = function(style, transparent)
        require('github-theme').setup {
          options = { transparent = transparent },
        }

        set_theme('github_' .. style)
      end,
    },

    gruvbox = {
      style = { 'light', 'dark' },
      activate = function(style, _)
        vim.o.background = style
        set_theme 'gruvbox'
      end,
    },

    material = {
      style = { 'darker', 'lighter', 'oceanic', 'palenight', 'deep ocean' },
      activate = function(style, transparent)
        vim.g.material_style = style

        require('material').setup {
          disable = {
            background = transparent,
            eob_lines = true,
          },
          high_visibility = {
            lighter = true, -- Enable higher contrast text for lighter style
          },
        }

        set_theme 'material'
      end,
    },

    monokai = {
      style = { 'classic', 'octagon', 'pro', 'machine', 'ristretto', 'spectrum' },
      activate = function(style, _)
        require('monokai-pro').setup {
          filter = style,
        }

        set_theme 'monokai-pro'
      end,
    },

    nightfox = {
      style = { 'nightfox', 'dayfox', 'dawnfox', 'duskfox', 'nordfox', 'terafox', 'carbonfox' },
      activate = function(style, transparent)
        require('nightfox').setup {
          transparent = transparent,
        }

        set_theme(style)
      end,
    },

    onedark = {
      style = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' },
      activate = function(style, _)
        require('onedark').setup {
          style = style,
        }

        require('onedark').load()
      end,
    },

    tokyonight = {
      style = { 'storm', 'moon', 'night', 'day' },
      activate = function(style, transparent)
        require('tokyonight').setup {
          style = style,
          transparent = transparent,
        }

        set_theme 'tokyonight'
      end,
    },

    colorbuddy = {
      style = { 'gruvbuddy' },
      transparent = false,
      activate = function(style, _)
        require('colorbuddy').setup()

        set_theme(style)
      end,
    },
  },
}

M.activate_theme = function(theme, style)
  local entry = M.themes[theme]
  local transparent = true
  local light_styles = {
    'latte',
    'dawn',
    'day',
    'light',
    'light_default',
    'dayfox',
    'dawnfox',
    'lighter',
  }

  for _, l_style in ipairs(light_styles) do
    if l_style == style then
      transparent = false
      break
    end
  end

  entry.activate(style, transparent)

  if transparent then
    vim.opt.cursorline = false
  else
    vim.opt.cursorline = true
  end
end

return M
