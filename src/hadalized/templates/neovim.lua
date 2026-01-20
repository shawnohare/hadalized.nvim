-- Auto-generated from hadalized v{{context.package_version}}
-- WARNING: Do not edit by hand.

-- By setting our module to nil, we clear lua's cache,
-- which means the require ahead will *always* occur.
--
-- This isn't strictly required but it can be a useful trick if you are
-- incrementally editing your config a lot and want to be sure your themes
-- changes are being picked up without restarting neovim.
--
-- Note if you're working in on your theme and have :Lushify'd the buffer,
-- your changes will be applied with or without the following line.
--
-- The performance impact of this call can be measured in the hundreds of
-- *nanoseconds* and such could be considered "production safe".
--

---@type Palette
local palette = {{context.model_dump_lua()}}

package.loaded['hadalized'] = nil
require('hadalized').load({palette = palette})

