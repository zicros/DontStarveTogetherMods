-- This information tells other players more about the mod
name = "Zicros' Mod"
description = "Random stuff"
author = "ZICROS"
version = "0.0.1"

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""


-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false

--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = false

--This determines whether it causes a server to be marked as modded (and shows in the mod list)
client_only_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
"zicros",
}

configuration_options = {
	{
		name = "set_infinite_lighter",
		label = "Infinite Lighter",
		options =
		{
			{description = "Enable", data = true},
			{description = "Disable", data = false}
		},
		default = true,
		hover = "Nuff Said",
	},
}
