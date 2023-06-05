-- For more configuration options, see: https://neovide.dev/configuration.html
if vim.g.neovide == true then
    --------------------------------------------------------------------------
    -- Options
    --------------------------------------------------------------------------

    -- Refresh rate
    vim.g.neovide_refresh_rate = 60
    -- Refresh rate when not focused
    vim.g.neovide_refresh_rate_idle = 5
    -- Transparency
    vim.g.neovide_transparency = 0.95
    -- Scroll animation length
    vim.g.neovide_scroll_animation_length = 0.30
    -- Fullscreen
    vim.g.neovide_fullscreen = true
    -- Confirm quit on unsaved changes
    vim.g.neovide_confirm_quit = true
    -- Enable profiler
    vim.g.neovide_profiler = false
    -- Cursor animation length
    vim.g.neovide_cursor_animation_length = 0.08
    -- Cursor trail
    vim.g.neovide_cursor_trail_length = 0.8
    -- Cursor antialiasing
    vim.g.neovide_cursor_antialiasing = true
    -- Unfocused cursor outline. This setting takes effect when the neovide
    -- window is unfocused, at whichthe cursor will be rendered as an outline.
    vim.g.neovide_cursor_unfocused_outline_width = 0.125
    -- Cursor effects mode:
    --   - railgun
    --   - torpedo
    --   - pixiedust
    --   - sonicboom
    --   - ripple
    --   - wireframe
    vim.g.neovide_cursor_vfx_mode = "railgun"
    -- Particle opacity
    vim.g.neovide_cursor_vfx_opacity = 150.0
    -- Particle lifetime
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.0
    -- Particle density
    vim.g.neovide_cursor_vfx_particle_density = 15.0
    -- Particle speed
    vim.g.neovide_cursor_vfx_particle_speed = 10.0
    -- Particle phase (railgun only)
    vim.g.neovide_cursor_vfx_particle_phase = 2.5
    -- Particle curl (railgun only)
    vim.g.neovide_cursor_vfx_particle_curl = 1.25
end
