function auto_video_stereo_mode()
  local path = mp.get_property("path", "")
  local match = string.match(path, "%W3[Dd]%W")
  if not match then
    return
  end
  local stereo_mode = nil
  if string.match(path, "%W[Hh][Aa]?[Ll]?[Ff]?-? ?[Ss][Bb][Ss]%W") then
    stereo_mode = "sbs2l"
  elseif string.match(path, "%W[Hh][Aa]?[Ll]?[Ff]?-? ?[Oo][Uu]%W") then
    stereo_mode = "ab2l"
  end
  if stereo_mode then
    local option_vo = mp.get_property("options/vo")
    if string.match(option_vo, "vaapi") or string.match(option_vo, "vdpau") then
      mp.msg.info("Set vo to opengl")
      mp.set_property("options/vo", "opengl")
    end
    mp.msg.info("Set video stereo mode to " .. stereo_mode)
    mp.set_property("options/video-stereo-mode", stereo_mode)
  end
end
mp.register_event("start-file", auto_video_stereo_mode)
