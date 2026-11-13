-- Picture-in-Picture (PiP) listener (16:9 aspect ratio)
local function apply_pip_rules(win)
  if not (win and win.title and string.find(win.title, "^Picture[- ]in[- ][Pp]icture$")) then
    return
  end

  local screen = hl.get_active_monitor()
  if not (screen and screen.width and screen.height) then
    return
  end

  local scale          = screen.scale or 1.0
  local monitor_height = screen.height / scale
  local monitor_width  = screen.width / scale

  -- Calcula alto (1/4 de la pantalla) y fuerza ancho en proporción 16:9 (1080p)
  local y_resize       = math.floor(math.max(180, monitor_height / 4))
  local x_resize       = math.floor(y_resize * (16 / 9))

  local offset         = math.min(monitor_width, monitor_height) * 0.03
  local move_x         = math.floor(screen.x + monitor_width - x_resize - offset)
  local move_y         = math.floor(screen.y + monitor_height - y_resize - offset)

  hl.dispatch(hl.dsp.window.float({ action = "on", window = win }))
  hl.dispatch(hl.dsp.window.pin({ action = "on", window = win }))
  hl.dispatch(hl.dsp.window.resize({ x = x_resize, y = y_resize, window = win }))
  hl.dispatch(hl.dsp.window.move({ x = move_x, y = move_y, relative = false, window = win }))
  hl.dispatch(hl.dsp.window.set_prop({ prop = "keep_aspect_ratio", value = "true", window = win }))
end

hl.on("window.open", apply_pip_rules)
hl.on("window.title", apply_pip_rules)
