--resp = http.get("https://raw.githubusercontent.com/wallaceg09/CC-Reactor/cleanup/reactor.lua")
function get_github_content(username, project, branch, file)
    local url = string.format("https://raw.githubusercontent.com/%s/%s/%s/%s", username, project, branch, file)
    local resp = http.get(url)
    return resp.readAll()
end

function update_file(content, filename)
	local bkup_filename = string.format("%s.%s", filename, "bkup")
	fs.move(filename, bkup_filename)
	local new_file = fs.open(filename, "w")
	new_file.write(content, filename)
	new_file.close()
	fs.delete(bkup_filename)
end

local username = "wallaceg09"
local repo = "CC-Reactor"
local branch = "cleanup"

pull_reactor_files_text = get_github_content(
    username,
    repo,
    branch,
    "pull_reactor_files.lua"
)
 
reactor_text = get_github_content(
    username,
    repo,
    branch,
    "reactor.lua"
)

reactor_gui_text = get_github_content(
    username,
    repo,
    branch,
    "reactor_gui.lua"
)

update_file(pull_reactor_files_text, "pull_reactor_files.lua")
update_file(reactor_text, "reactor.lua")
update_file(reactor_gui_text, "reactor_gui.lua")