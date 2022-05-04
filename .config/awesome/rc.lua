-- ---------------------------------------------------------

--[[

    My Personal AwesomeWM rc.lua Config File
          Julian Orchard <hello@julianorchard.co.uk>

--]]

-- ---------------------------------------------------------

-- Libraries
  pcall(require, "luarocks.loader")

  local gears         = require("gears")
  local awful         = require("awful")
                        require("awful.autofocus")
  local wibox         = require("wibox")
  local beautiful     = require("beautiful")
  local naughty       = require("naughty")
  local lain          = require("lain")
  local menubar       = require("menubar")
  local hotkeys_popup = require("awful.hotkeys_popup")
                        require("awful.hotkeys_popup.keys")

-- ---------------------------------------------------------

-- Error Handling

  if awesome.startup_errors then
    naughty.notify {
      preset = naughty.config.presets.critical,
      title = "An not-so-Awesome error occured, on startup...",
      text = awesome.startup_errors
    }
  end

  do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
      if in_error then return end
      in_error = true
      naughty.notify {
        preset = naughty.config.presets.critical,
        title = "An not-so-Awesome error has occured.",
        text = tostring(err)
      }
      in_error = false
    end)
  end

-- ---------------------------------------------------------

-- Variables

   -- Keys  
    local altkey         = "Mod1"
    local modkey         = "Mod4"
  -- Applications
    local terminal       = "kitty"
    local browser        = os.getenv("BROWSER") or "firefox"
    local editor         = os.getenv("EDITOR") or "nvim" or "vim"
    local editor_cmd     = terminal .. " -e " .. "nvim" or terminal .. " -e " .. "vim"
  -- Load Theme
    beautiful.init(gears.filesystem.get_configuration_dir() .. "tilde/theme.lua")
    --  local cycle_prev     = true  -- cycle with only the previously 
    --  focused client or all https://github.com/lcpz/awesome-copycats/issues/274
  -- Tag Names
    awful.util.tagnames = { 
      "一", 
      "二", 
      "三", 
      "四", 
      "五" 
    }
  -- Layouts + Order
    awful.layout.layouts = {
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.fair,
        awful.layout.suit.floating,
    }


-- ---------------------------------------------------------

-- WI Button Stuff
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

-- Tasklist Button Stuff
local tasklist_buttons = gears.table.join(
     awful.button({ }, 1, function(c)
         if c == client.focus then
             c.minimized = true
         else
             c:emit_signal("request::activate", "tasklist", { raise = true })
         end
     end),
     awful.button({ }, 3, function()
         awful.menu.client_list({ theme = { width = 250 } })
     end),
     awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
     awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

-- This is where they initialize the theme
--beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))

-- Create a wibox for each screen and add it?>?>??>
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)


-- ---------------------------------------------------------

-- Bindings

  -- Mouse 
    root.buttons(gears.table.join(
      awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
      awful.button({ }, 4, awful.tag.viewnext),
      awful.button({ }, 5, awful.tag.viewprev)
    ))

  -- Keys
  globalkeys = gears.table.join(

    -- Show Help, Ctrl + Mod + Alt + H
      awful.key({ modkey, altkey, "Control" }, "h", hotkeys_popup.show_help,
                {description="show help", group="awesome"}),

    -- Unmount JUSB
      awful.key({ modkey, altkey, "Control" }, "u", function() 
        awful.util.spawn("udiskie-umount /run/media/ju/JUSB")
      end,
          {description = "pog", group="hotkeys"}),

    -- Screenshot, Screenshot Button
      awful.key({ }, "Print", function () 
        capture_folder = os.getenv("HOME") .. "/Images/captures/"
        -- Format: 2022-04-09_00-18-53.png
        capture_file = os.date("%Y-%m-%d_%H-%M-%S.png")
        awful.util.spawn("scrot -f " .. capture_folder .. capture_file)
        -- Notify
        naughty.notify {
          preset = naughty.config.presets.low,
          title = "Screenshot Captured!",
          text = "Your screenshot is saved as " .. capture_file
        }
      end,
      {description = "take a screenshot", group = "hotkeys"}),

    -- Screen Locker, Mod + L
      awful.key({ modkey }, "l", function () awful.spawn.with_shell("i3lock-fancy -p") end,
                {description = "lock screen", group = "hotkeys"}),

    -- Brightness, 
        -- Brightness Button (+/-5), 
        -- Alt + Brightness Button (+/-2)
      awful.key({ }, "XF86MonBrightnessUp", function () os.execute("light -A 10") end,
                {description = "+10%", group = "hotkeys"}),
      awful.key({ }, "XF86MonBrightnessDown", function () os.execute("light -U 10") end,
                {description = "-10%", group = "hotkeys"}),
      awful.key({ altkey }, "XF86MonBrightnessUp", function () os.execute("light -A 2") end,
                {description = "+10%", group = "hotkeys"}),
      awful.key({ altkey }, "XF86MonBrightnessDown", function () os.execute("light -U 2") end,
                {description = "-10%", group = "hotkeys"}),

    -- Tag Cycling, Alt + Left/Right
      awful.key({ altkey }, "Left",   awful.tag.viewprev,
                {description = "view previous", group = "tag"}),
      awful.key({ altkey }, "Right",  awful.tag.viewnext,
                {description = "view next", group = "tag"}),

    -- CYCLE Window Focus, Alt + J/K
      -- awful.key({ altkey }, "j", function () awful.client.focus.byidx( 1) end,
      --           {description = "focus next by index", group = "client"}),
      -- awful.key({ altkey }, "k", function () awful.client.focus.byidx(-1) end,
      --           {description = "focus previous by index", group = "client"}),

    -- Directional Window Focus, Alt + H,J,K,L
      awful.key({ altkey }, "j", 
          function()
              awful.client.focus.global_bydirection("down")
              if client.focus then client.focus:raise() end
          end,
          {description = "focus down", group = "client"}),
      awful.key({ altkey }, "k",
          function()
              awful.client.focus.global_bydirection("up")
              if client.focus then client.focus:raise() end
          end,
          {description = "focus up", group = "client"}),
      awful.key({ altkey }, "h",
          function()
              awful.client.focus.global_bydirection("left")
              if client.focus then client.focus:raise() end
          end,
          {description = "focus left", group = "client"}),
      awful.key({ altkey }, "l",
          function()
              awful.client.focus.global_bydirection("right")
              if client.focus then client.focus:raise() end
          end,
          {description = "focus right", group = "client"}),

    -- Increase/Decrease Window Size, Alt + Mod + H/L
      awful.key({ modkey, altkey }, "l", function () awful.tag.incmwfact( 0.05) end,
                {description = "increase master width factor", group = "layout"}),
      awful.key({ modkey, altkey }, "h", function () awful.tag.incmwfact(-0.05) end,
                {description = "decrease master width factor", group = "layout"}),

    -- Increase/Decrease Number of Columns, Mod + {Shift} + C
      awful.key({ modkey }, "c", function () awful.tag.incncol(1, nil, true) end,
                {description = "increase the number of columns", group = "layout"}),
      awful.key({ modkey, "Shift" }, "c", function () awful.tag.incncol(-1, nil, true) end,
                {description = "decrease the number of columns", group = "layout"}),

    -- Cycle Through Layouts
      awful.key({ altkey }, "space", function () awful.layout.inc(1) end,
                {description = "select next", group = "layout"}),
      awful.key({ altkey, "Shift"   }, "space", function () awful.layout.inc(-1) end,
                {description = "select previous", group = "layout"}),

    -- Swap Window Positions, Alt + Shift + J/K
      awful.key({ altkey, "Shift" }, "j", function () awful.client.swap.byidx(1) end,
                {description = "swap with next client by index", group = "client"}),
      awful.key({ altkey, "Shift" }, "k", function () awful.client.swap.byidx(-1) end,
                {description = "swap with previous client by index", group = "client"}),

    -- Toggle Wibox (Bar), Alt + T
      awful.key({ altkey }, "t", function ()
        for s in screen do
          s.mywibox.visible = not s.mywibox.visible
          if s.mybottomwibox then
            s.mybottomwibox.visible = not s.mybottomwibox.visible
          end
        end
      end,
      {description = "toggle wibox", group = "awesome"}),

    -- Increase/Decrease Gaps, Alt + {Shift} + G
      awful.key({ altkey }, "g", function () lain.util.useless_gaps_resize(5) end,
                 {description = "increment useless gaps", group = "tag"}),
      awful.key({ altkey, "Shift" }, "g", function () lain.util.useless_gaps_resize(-5) end,
                 {description = "decrement useless gaps", group = "tag"}),

    -- Add/Rename/Delete Tags (Desktops), Alt + Shift + {Ctrl} + N/D
      awful.key({ altkey, "Shift" }, "n", function () lain.util.add_tag() end,
                 {description = "add new tag", group = "tag"}),
      awful.key({ altkey, "Shift", "Control" }, "n", function () lain.util.rename_tag() end,
                 {description = "rename tag", group = "tag"}),
      awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
                 {description = "delete tag", group = "tag"}),

    -- Launch Terminal, Alt + Enter
      awful.key({ altkey }, "Return", function () awful.spawn(terminal) end,
                {description = "open a terminal", group = "launcher"}),

    -- App Prompt, Mod + Alt + Enter
      awful.key({ modkey, altkey }, "Return", function () awful.screen.focused().mypromptbox:run() end,
                {description = "run prompt", group = "launcher"}),

    -- Restart Awesome, Alt + Shift + R
      awful.key({ altkey, "Shift" }, "r", awesome.restart,
                {description = "reload awesome", group = "awesome"}),

    -- Quit Awesome, Alt + Shift + Q
      awful.key({ modkey, "Shift" }, "q", awesome.quit,
                {description = "quit awesome", group = "awesome"}),

    -- Dropdown application
      awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end,
                {description = "dropdown application", group = "launcher"}),

      -- Widgets popups
      awful.key({ altkey, }, "c", function () if beautiful.cal then beautiful.cal.show(7) end end,
                {description = "show calendar", group = "widgets"}),
      awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
                {description = "show filesystem", group = "widgets"}),
      awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
                {description = "show weather", group = "widgets"}),

    -- Audio Keys, Using XF86 Audio Buttons
      -- Raise Volume 1%
        awful.key({ }, "XF86AudioRaiseVolume",
        function ()
          os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
          beautiful.volume.update()
        end,
        {description = "volume up", group = "hotkeys"}),
      -- Lower Volume 1%
        awful.key({ }, "XF86AudioLowerVolume",
        function ()
          os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
          beautiful.volume.update()
        end,
        {description = "volume down", group = "hotkeys"}),
      -- Raise Volume 10%
        awful.key({ altkey }, "XF86AudioRaiseVolume",
        function ()
          os.execute(string.format("amixer -q set %s 10%%+", beautiful.volume.channel))
          beautiful.volume.update()
        end,
        {description = "volume up", group = "hotkeys"}),
      -- Lower Volume 10%
        awful.key({ altkey }, "XF86AudioLowerVolume",
        function ()
          os.execute(string.format("amixer -q set %s 10%%-", beautiful.volume.channel))
          beautiful.volume.update()
        end,
        {description = "volume down", group = "hotkeys"}),

      -- Toggle Mute
        awful.key({ }, "XF86AudioMute",
        function ()
          os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
          beautiful.volume.update()
        end,
        {description = "toggle mute", group = "hotkeys"})

  )

  -- Client Bindings (Impacting Current Window Only?)
  clientkeys = gears.table.join(
       awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client,
                 {description = "magnify client", group = "client"}),
      awful.key({ modkey,           }, "f",
          function (c)
              c.fullscreen = not c.fullscreen
              c:raise()
          end,
          {description = "toggle fullscreen", group = "client"}),
          
    -- Close Active Window, Alt + Q
      awful.key({ altkey }, "q", function (c) c:kill() end,
                {description = "close", group = "client"}),

    -- Float Active Window, Mod + Shift + Enter
      awful.key({ modkey, "Shift" }, "Return",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),

    -- Make Active Window Main, Ctrl + Mod + Enter
      awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),

    -- Keep Active Window On Top, Mod + T
      awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end,
                {description = "toggle keep on top", group = "client"})
  )

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ altkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ altkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ altkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     callback = awful.client.setslave,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { 
      size = 16, 
      position = "bottom" 
    }) : setup {
      { -- Left
        { -- Title Text
          align  = "center",
          widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
      },
      { -- Middle
        layout  = wibox.layout.fixed.horizontal
      },
      { -- Right
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton    (c),
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    }
end)

-- ---------------------------------------------------------

-- Autostart

  -- Picom
    awful.util.spawn("picom")
    awful.util.spawn("udiskie")

-- ---------------------------------------------------------
