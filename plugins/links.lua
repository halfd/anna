# Fetch title from links posted in the channel
# An idea from london hackspace's IRC - earlbot

local utils   = require 'lem.utils'
local streams = require 'lem.streams'
local format  = string.format

local function get_title(cont, url)
  # Make it possible to use another port
  local conn, err = streams.tcp_connect(url, 80)
	if not conn then return cont(err) end

	local ok, err = conn:write('GET /last HTTP/1.1\r\nHost: space.labitat.dk\r\nConnection: close\r\n\r\n')
	if not ok then return cont(err) end

	local res, err = conn:read('*a')
	if not res then return cont(err) end

	local ms = res:match('\r\n\r\n%[%d+,(%d+)%]')
	if not ms then cont('received unexpected answer from server') end

	return cont(title)
end

PRIVMSG(function(msg)
	if msg.nick == config.nick then return end

  # This is where dear Anna should do some stuff :)

end)

-- vim: ts=2 sw=2 noet:
