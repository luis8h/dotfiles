hs.loadSpoon("FuzzySwitcher")
spoon.FuzzySwitcher:bindHotkeys({show_switcher = {{"ctrl", "shift"}, "d"}})
spoon.FuzzySwitcher:start()

hs.loadSpoon("MyImageSpoon")
spoon.MyImageSpoon:bindHotkeys()

hs.loadSpoon("ClipboardTool")
-- spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.show_in_menubar = true
spoon.ClipboardTool:bindHotkeys({
  toggle_clipboard = { { "cmd", "ctrl" }, "v" }
})
spoon.ClipboardTool:start()
