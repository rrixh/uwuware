-- emojis.lua (runtime builder) --
-- usage example :
--[[ 
local e = loadstring(game:HttpGet("https://raw.githubusercontent.com/refs/heads/main/emojis.lua"))();

print(e.lollipop) -- 🍭
]]--

local HttpGet = (syn and syn.request and function(url) return syn.request({Url=url, Method="GET"}).Body end) or (http and http.request and function(url) return http.request({Url=url, Method="GET"}).Body end)
              or (request and function(url) return request({Url=url, Method="GET"}).Body end)
              or function(url) return game:HttpGet(url) end;

local UC = (utf8.char);

-- unikode sources (15.1 stable) if these bump then this parser shld still work
local SOURCES = {
  "https://unicode.org/Public/emoji/15.1/emoji-test.txt",
  "https://unicode.org/Public/emoji/15.1/emoji-sequences.txt",
  "https://unicode.org/Public/emoji/15.1/emoji-zwj-sequences.txt",
}

--helper
local function trim(s) return (s:gsub("^%s+",""):gsub("%s+$","")) end
local function lower(s) return string.lower(s or "") end

--lowerkase
local function slugify(name)
  name = lower(name)
  name = name:gsub("&","and")
  -- remove punctuation & separators
  name = name:gsub("[%s%p%c%z_]+","")
  -- specific kleanups
  name = name:gsub("globe showing europe%-%-africa","eartheuropeafrica")
  name = name:gsub("globe showing americas","earthamericas")
  name = name:gsub("globe showing asia%-%-australia","earthasiaaustralia")
  name = name:gsub("black large square","blacklargesquare")
  name = name:gsub("glowing star","glowingstar")
  return name
end

-- aliases
local function add(table, key, val)
  if key and key ~= "" and table[key] == nil then table[key] = val end
end

local E = {};

-- aliases2
local function seedAliases()
  add(E, "lollipop", UC(0x1F36D))
  add(E, "alarm", UC(0x1F6A8))
  add(E, "close", UC(0x274C))
  add(E, "robot", UC(0x1F916))
  add(E, "phone", UC(0x1F4F2))
  -- hearts common aliases
  add(E, "pinkheart", UC(0x1FA77) or "🩷")
  add(E, "orangeheart", UC(0x1F9E1))
  add(E, "yellowheart", UC(0x1F49B))
  add(E, "greenheart", UC(0x1F49A))
  add(E, "blueheart", UC(0x1F499))
  add(E, "purpleheart", UC(0x1F49C))
  add(E, "brownheart", UC(0x1F90E))
  add(E, "blackheart", UC(0x1F5A4))
  add(E, "whiteheart", UC(0x1F90D))
  add(E, "redheart", UC(0x2764)..UC(0xFE0F))
end;

seedAliases()

--parse
local function parseEmojiTest(txt)
  local currentGroup, currentSub = "", ""
  for line in string.gmatch(txt, "[^\r\n]+") do
    if line:match("^#%s*group:") then
      currentGroup = trim(line:sub(line:find(":")+1))
    elseif line:match("^#%s*subgroup:") then
      currentSub = trim(line:sub(line:find(":")+1))
    elseif not line:match("^%s*#") and line:match(";") and line:match("#") then
      -- split "codepoints ; status # emoji name"
      local left, right = line:match("^(.-);.-#(.*)$")
      if left and right then
        local cpstr = trim(left)
        local em, name = right:match("^%s*(%S+)%s+(.*)$")
        if em and name then
          name = trim(name)
          -- strip the trailing version marker if present (e.g., "E1.0 grinning face")
          name = name:gsub("^E%d+%.%d+%s+","")
          local key = slugify(name)

          -- put primary
          add(E, key, em)

          -- add a few auto-aliases
          -- Replace common words to collapse variants (face-, with -, etc.)
          local flat = key
          flat = flat:gsub("face", ""):gsub("button",""):gsub("symbol","")
          flat = flat:gsub("^%s+",""):gsub("%s+$","")
          if #flat >= 3 then add(E, flat, em) end

          -- simple heart variants
          if key:find("heart") and #key>5 then
            local short = key:gsub("sparkling","sparkles"):gsub("witharrow","arrow")
            add(E, short, em)
          end

          -- Add group/subgroup scoped aliases
          if currentGroup ~= "" then
            add(E, slugify(currentGroup..name), em)
          end
          if currentSub ~= "" then
            add(E, slugify(currentSub..name), em)
          end
        end
      end
    end
  end
end

-- Parse sequences/ZWJ files when present (format differs); keep conservative:
-- Lines look like: "1F469 200D 1F4BB ; fully-qualified     # 👩‍💻 woman technologist"
local function parseSequenceFile(txt)
  for line in string.gmatch(txt, "[^\r\n]+") do
    if line:match("^%s*#") then goto continue end
    if line:find(";") and line:find("#") then
      local left, right = line:match("^(.-);.-#(.*)$")
      if left and right then
        local em, name = right:match("^%s*(%S+)%s+(.*)$")
        if em and name then
          name = trim(name):gsub("^E%d+%.%d+%s+","")
          local key = slugify(name)
          add(E, key, em)
        end
      end
    end
    ::continue::
  end
end

-- Country flag aliases (from "flag: Country Name" lines)
local function addFlagAliasesFromEmojiTest(txt)
  for em, country in txt:gmatch("#%s*(%S+)%s+flag:%s+([%w%p%s]+)") do
    local cname = trim(country)
    -- normalize common alternates
    local base = slugify(cname)
    add(E, base, em)

    -- custom: US/USA/United States
    if cname:lower():find("united states") then
      add(E, "us", em); add(E, "usa", em); add(E, "unitedstates", em)
      add(E, "unitedstatesofamerica", em)
    end
    if cname:lower():find("united kingdom") or cname:lower():find("england") then
      add(E, "uk", em); add(E, "gb", em); add(E, "greatbritain", em); add(E, "unitedkingdom", em)
    end
    if cname:lower():find("korea") then
      if cname:lower():find("south") then add(E, "sk", em); add(E, "southkorea", em); add(E, "rok", em) end
      if cname:lower():find("north") then add(E, "nk", em); add(E, "northkorea", em); add(E, "dprk", em) end
    end
    if cname:lower():find("people%’?s republic of china") or cname:lower():find("^china") then
      add(E, "cn", em); add(E, "china", em)
    end
    if cname:lower():find("japan") then add(E, "jp", em) end
    if cname:lower():find("canada") then add(E, "ca", em) end
    if cname:lower():find("germany") then add(E, "de", em) end
    if cname:lower():find("france") then add(E, "fr", em) end
    if cname:lower():find("italy") then add(E, "it", em) end
    if cname:lower():find("spain") then add(E, "es", em) end
    if cname:lower():find("mexico") then add(E, "mx", em) end
    if cname:lower():find("brazil") then add(E, "br", em) end
    if cname:lower():find("india") then add(E, "in", em) end
    if cname:lower():find("russia") then add(E, "ru", em) end
    if cname:lower():find("australia") then add(E, "au", em) end
    if cname:lower():find("new zealand") then add(E, "nz", em) end
  end
end

-- Fetch and build
for _, url in ipairs(SOURCES) do
  local ok, body = pcall(HttpGet, url)
  if ok and body and #body > 0 then
    if url:find("emoji%-test") then
      parseEmojiTest(body)
      addFlagAliasesFromEmojiTest(body)
    else
      parseSequenceFile(body)
    end
  end
end

-- Final return (immutable-ish view)
return setmetatable({}, {
  __index = function(_, k)
    return E[lower(k)]
  end,
  __pairs = function()
    return next, E, nil
  end,
  __len = function() return #E end,
});
