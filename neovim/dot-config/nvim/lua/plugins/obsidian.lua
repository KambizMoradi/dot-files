return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "notes",
				path = "~/Documents/Obsidian/wisdom",
			},
		},
		daily_notes = {
			folder = "daily",
		},
		-- Other options...
		note_id_func = function(title)
			-- If title is given, use it directly as the filename (slugified)
			return title and title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower() or tostring(os.time())
		end,
		note_frontmatter_func = function(note)
			-- Customize frontmatter (optional)
			return {
				title = note.title,
				created = os.date("%Y-%m-%d-%H-%M-%S"),
				tags = note.tags,
			}
		end,
	},
	keys = {
		{ "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open in Obsidian" },
		{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Note" },
		{ "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick Switch" },
		{ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search Notes" },
		{ "<leader>of", "<cmd>ObsidianFollowLink<CR>", desc = "Follow Link" },
		{ "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
		{ "<leader>od", "<cmd>ObsidianToday<CR>", desc = "Today" },
		{ "<leader>oy", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday" },
		{ "<leader>om", "<cmd>ObsidianTomorrow<CR>", desc = "Tomorrow" },
		{ "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert Template" },
		{ "<leader>op", "<cmd>ObsidianPasteImg<CR>", desc = "Paste Image" },
		{ "<leader>ow", "<cmd>ObsidianWorkspace<CR>", desc = "Switch Workspace" },
		{ "<leader>ol", ":ObsidianLink<CR>", mode = "v", desc = "Link Selection" },
		{ "<leader>oL", ":ObsidianLinkNew<CR>", mode = "v", desc = "Link & New Note" },
	},
}
