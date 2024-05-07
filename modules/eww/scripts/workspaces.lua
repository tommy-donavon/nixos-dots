#!/usr/bin/env lua

-- local trim = function(s)
--   return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
-- end

local aw = io.popen("hyprctl monitors | grep active | sed 's/()/(1)/g' | sort | awk 'NR>1{print $1}' RS='(' FS=')'")

if (aw ~= nil or aw ~= "" ) then
    ACTIVE_WORKSPACE = aw:read("*a")
    aw:close()
end

local ew = io.popen("hyprctl workspaces | grep ID | sed 's/()/(1)/g' | sort | awk 'NR>1{print $1}' RS='(' FS=')'")
if (ew~= nil or ew ~= "") then
    EXISTING_WORKSPACES = ew:read("*a")
    ew:close()
end

local box = "(box :orientation \"v\" :spacing 1 :space-evenly \"true\" "

for i = 1, #EXISTING_WORKSPACES do
    local c = EXISTING_WORKSPACES:sub(i,i)
    if tonumber(c) == tonumber(ACTIVE_WORKSPACE) then
        local btn = "(button :class \"active\" :onclick \"hyprctl dispatch workspace "..c.." \" \"\")"
        box = box .. btn
    elseif c ~= "\n" then
        local btn = "(button :class \"inactive\" :onclick \"hyprctl dispatch workspace "..c.."\" \"\")"
        box = box .. btn
    end
end

box = box .. ")"

print(box)
