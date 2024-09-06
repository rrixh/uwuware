local wasLoaded = true; if not game.IsLoaded(game) then wasLoaded = false; repeat task.wait() until game.IsLoaded(game) end
local spy_settings = ({...})[1] or {}
local st = tick()
local service = setmetatable({}, {__index = function(t,k) return game.GetService(game,k) end})
local decompile = decompile or disassemble or function() return "-- Decompiler not found." end
local setclipboardfunc = function(message) if setclipboard then setclipboard("-- This was generated from engospy RemoteSpy tool.\n"..tostring(message)) else print("Couldn't setclipboard.") end end
local setident = syn and syn.set_thread_identity or setidentity or setthreadcontext
local isV3 = syn and syn.toast_notification ~= nil
local lplr = service.Players.LocalPlayer
local mouse = lplr:GetMouse()
local spy = {
    VERSION = "v1.02",
    Connections = {},
    guiConnections = {},
    instances = {},
    blocked = {},
    ignored = {},
    currentTableDepth = 0,
    saveCalls = spy_settings.saveCalls or false,
    saveOnlyLastCall = spy_settings.saveCalls and false or spy_settings.saveOnlyLastCall or true,
    maxTableDepth = spy_settings.maxTableDepth or 100,
    maxCallsSaved = spy_settings.maxCallsSaved or 1000,
    minimizeBind = spy_settings.minimizeBind or Enum.KeyCode.RightAlt,
    newFunctionMethod = spy_settings.newFunctionMethod or true,
    assets = {
        RemoteEvent = "http://www.roblox.com/asset/?id=413369506",
        RemoteFunction = "http://www.roblox.com/asset/?id=413369623"
    },
    namecallmethods = {
        RemoteEvent = "FireServer",
        RemoteFunction = "InvokeServer",
        --BindableEvent = "Fire",
        --BindableFunction = "Invoke",
    },
    event = Instance.new("BindableEvent"),
    blacklistedNames = spy_settings.blacklistedNames or {},
}
shared.engospy = spy
if getgenv then getgenv().engospy = spy end
local old_namecall = nil
local old_index = nil
local is_hooking = false

function spy.newInstance(self, classname, properties) 
    local instance = Instance.new(classname)
    for i,v in next, properties do 
        instance[i] = v
    end
    spy.instances[instance.Name] = instance
    return instance
end
spy.createInstance = spy.newInstance

function spy.Destroy(self) 
    for i,v in next, spy.instances do 
        v:Destroy()
        spy.Connections[i] = nil
    end
    for i,v in next, spy.guiConnections do 
        v:Disconnect()
        spy.guiConnections[i] = nil
    end
    spy.unhook()
    spy = nil
end

local function has_unicode(str) 
    local notAllowed = ":()[]{}+_-=\\|`~,.<>/?!@#$%^&*"

    for character in string.gmatch(str, "([%z\1-\127\194-\244][\128-\191]*)") do
        if notAllowed:find(character) then
            return true
        end
    end
end

local function to_unicode(string)
    local codepoints = "utf8.char("
    
    for _i, v in utf8.codes(string) do
        codepoints = codepoints .. v .. ', '
    end
    
    return codepoints:sub(1, -3) .. ')'
end

local function format_string(str)
    local str = str:gsub("\0", "\\0"):gsub("\n", "\\n"):gsub("\r", "\\r"):gsub("\t", "\\t"):gsub("\v", "\\v"):gsub("\b", "\\b"):gsub("\f", "\\f")

    return str
end

function spy.get_path(instance) -- // Thanks to turtlespy for this code, see https://pastebin.com/raw/BDhSQqUU \\
    local name = instance.Name
    local head = (#name > 0 and '.' .. name) or "['']"
    if not instance.Parent and instance ~= game then
        return head .. " --[[ Parented to nil ]]"
    end
    if instance == game then
        return "game"
    elseif instance == workspace then
        return "workspace"
    else
        local _success, result = pcall(game.GetService, game, instance.ClassName)
        
        if _success and result then
            head = ':GetService("' .. instance.ClassName .. '")'
        elseif instance == lplr then
            head = '.LocalPlayer' 
        else    
            local nonAlphaNum = name:gsub('[%w_]', '')
            local noPunct = nonAlphaNum:gsub('[%s%p]', '')
            
            if tonumber(name:sub(1, 1)) or (#nonAlphaNum ~= 0 and #noPunct == 0) then
                head = '["' .. name:gsub('"', '\\"'):gsub('\\', '\\\\') .. '"]'
            elseif #nonAlphaNum ~= 0 and #noPunct > 0 then
                head = '[' .. to_unicode(name) .. ']'
            end
        end
    end
    return spy.get_path(instance.Parent) .. head
end

function spy.table_to_string(t) 
    spy.currentTableDepth = spy.currentTableDepth + 1
    if spy.currentTableDepth > spy.maxTableDepth+1 then
        spy.currentTableDepth = spy.currentTableDepth - 1
        return "table_over_maxTableDepth (.."..tostring(t)..")"
    end
    local returnStr = "{"
    for i,v in next, t do
        returnStr = returnStr.."\n"..(("    "):rep(spy.currentTableDepth)).."["..spy.get_real_value(i).."] = "..spy.get_real_value(v)..","
    end
    if returnStr:sub(-2) == ", " then returnStr = returnStr:sub(1, -3) end
    spy.currentTableDepth = spy.currentTableDepth - 1
    return returnStr.."\n"..(("    "):rep(spy.currentTableDepth)).."}"
end

function spy.bettergetinfo(func) 
    local info = debug.getinfo(func)
    info.func = nil 
    return info
end

function spy.get_real_value(value)
    local _t = typeof(value)
    if _t == 'Instance' then
        return spy.get_path(value)
    elseif _t == 'string' then
        local value = format_string(value)
        return '"'..value..'"'
    elseif _t == 'table' then 
        return spy.table_to_string(value)
    elseif _t == 'function' then
        if not islclosure((value)) then 
            return "newcclosure(function() end)"
        end
        if spy.newFunctionMethod then
            return "--[[function -->]] "..spy.table_to_string({upvalues = debug.getupvalues(value), constants = debug.getconstants(value), protos = debug.getprotos(value), info = spy.bettergetinfo(value)})
        end
        return "function() end"
    elseif _t == 'UDim2' or _t == 'UDim' or _t == 'Vector3' or _t == 'Vector2' or _t == 'CFrame' or _t == 'Vector2int16' or _t == 'Vector3int16' or _t == 'BrickColor' or _t == 'Color3' then
        local value = _t == 'BrickColor' and "'"..tostring(value).."'" or value
        return _t..".new("..tostring(value)..")"
    elseif _t == 'TweenInfo' then
        return "TweenInfo.new("..spy.get_real_value(value.Time)..", "..spy.get_real_value(value.EasingStyle)..", "..spy.get_real_value(value.EasingDirection)..", "..spy.get_real_value(value.RepeatCount)..", "..spy.get_real_value(value.Reverses)..", "..spy.get_real_value(value.DelayTime)..")"
    elseif _t == 'Enums' then
        return "Enum"
    elseif _t == 'Enum' then
        return "Enum."..tostring(value)
    elseif _t == 'Axes' or _t == 'Faces' then
        local returnStr = _t..".new("
        local normals = Enum.NormalId:GetEnumItems()
        for i,v in next, normals do
            if value[v.Name] then
                returnStr = returnStr..spy.get_real_value(v)..", "
            end
        end
        return returnStr:sub(1, -3)..")"
    elseif _t == 'ColorSequence' then
        local returnStr = "ColorSequence.new{"
        local keypoints = value.Keypoints
        for i,v in next, keypoints do 
            returnStr = returnStr..spy.get_real_value(v)..", "
        end
        return returnStr:sub(1, -3).."}"
    elseif _t == 'ColorSequenceKeypoint' then
        return "ColorSequenceKeypoint.new("..tostring(value.Time)..", "..spy.get_real_value(value.Value)..")"
    elseif _t == 'DockWidgetPluginGuiInfo' then -- // this was a pain to make \\
        local str = ""
        local split1 = tostring(value):split(":")
        for i,v in next, split1 do 
            str = str..v.." "
        end
        local split2 = str:split(" ") 
        local str = ""
        local reali = 0
        for i,v in next, split2 do
            if math.floor(i/2) == i/2 and v~=" " then
                reali = reali + 1
                local _v = v
                if reali == 1 then 
                    _v = "Enum.InitialDockState."..v
                end
                str = str.._v..", "
            end
        end
        return "DockWidgetPluginGuiInfo.new("..(str:sub(1, -3))..")"
    elseif _t == 'DateTime' then
		if value.UnixTimestampMillis == DateTime.now().UnixTimestampMillis then
            return "DateTime.now()"
        end
        return "DateTime.fromUnixTimestampMillis("..value.UnixTimestampMillis..")"
    elseif _t == 'FloatCurveKey' then
        return "FloatCurveKey.new("..spy.get_real_value(value.Time)..", "..spy.get_real_value(value.Value)..", "..spy.get_real_value(value.Interpolation)..")"
    elseif _t == 'NumberRange' then
        return "NumberRange.new("..spy.get_real_value(value.Min)..", "..spy.get_real_value(value.Max)..")"
    elseif _t == 'NumberSequence' then
        local returnStr = "NumberSequence.new{"
        local keypoints = value.Keypoints
        for i,v in next, keypoints do 
            returnStr = returnStr..spy.get_real_value(v)..", "
        end
        return returnStr:sub(1, -3).."}"
    elseif _t == 'NumberSequenceKeypoint' then
        return "NumberSequenceKeypoint.new("..tostring(value.Time)..", "..spy.get_real_value(value.Value)..(value.Envelope and ", "..value.Envelope or "")..")"
    elseif _t == 'PathWaypoint' then
        return "PathWaypoint.new("..spy.get_real_value(value.Position)..", "..spy.get_real_value(value.Action)..")"
    elseif _t == 'PhysicalProperties' then
        return "PhysicalProperties.new("..spy.get_real_value(value.Density)..", "..spy.get_real_value(value.Friction)..", "..spy.get_real_value(value.Elasticity)..", "..spy.get_real_value(value.FrictionWeight)..", "..spy.get_real_value(value.ElasticityWeight)..")"
    elseif _t == 'Random' then
        return "Random.new()"
    elseif _t == 'Ray' then
        return "Ray.new("..spy.get_real_value(value.Origin)..", "..spy.get_real_value(value.Direction)..")"
    elseif _t == 'RaycastParams' then
        return "--[[typeof: RaycastParams ->]] {FilterDescendantsInstances = "..spy.get_real_value(value.FilterDescendantsInstances)..", FilterType = "..spy.get_real_value(value.FilterType)..", IgnoreWater = "..spy.get_real_value(value.IgnoreWater)..", CollisionGroup = '"..spy.get_real_value(value.CollisionGroup).."'}"
    elseif _t == 'RaycastResult' then
        return "--[[typeof: RaycastResult ->]] {Distance = " ..spy.get_real_value(value.Distance)..", Instance = "..spy.get_real_value(value.Instance)..", Material = "..spy.get_real_value(value.Material)..", Position = "..spy.get_real_value(value.Position)..", Normal = "..spy.get_real_value(value.Normal).."}"
    elseif _t == 'RBXScriptConnection' then
        return "--[[typeof: RBXScriptConnection ->]] {Connected = "..spy.get_real_value(value.Connected).."}"
    elseif _t == 'RBXScriptSignal' then
        return "RBXScriptSignal"
    elseif _t == 'Rect' then
        return "Rect.new("..spy.get_real_value(value.Min)..", "..spy.get_real_value(value.Max)..")"
    elseif _t == 'Region3' then
        local cframe = value.CFrame
        local size = value.Size
        local min = spy.get_real_value((cframe * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2)).p)
        local max = spy.get_real_value((cframe * CFrame.new(size.X/2, size.Y/2, size.Z/2)).p)
        return "Region3.new("..min..", "..max..")"
    elseif _t == 'Region3int16' then
        return "Region3int16.new("..spy.get_real_value(value.Min)..", "..spy.get_real_value(value.Max)..")"
    elseif _t == 'CatalogSearchParams' then
        return "--[[typeof: CatalogSearchParams ->]] {SearchKeyword = "..spy.get_real_value(value.SearchKeyword)..", MinPrice = "..spy.get_real_value(value.MinPrice)..", MaxPrice = "..spy.get_real_value(value.MaxPrice)..", SortType = "..spy.get_real_value(value.SortType)..", CategoryFilter = "..spy.get_real_value(value.CategoryFilter)..", AssetTypes = "..spy.get_real_value(value.AssetTypes).."}"
    elseif _t == 'OverlapParams' then
        return "--[[typeof: OverlapParams ->]] {FilterDescendantsInstances = "..spy.get_real_value(value.FilterDescendantsInstances)..", FilterType = "..spy.get_real_value(value.FilterType)..", MaxParts ="..spy.get_real_value(value.MaxParts)..", CollisionGroup = "..spy.get_real_value(value.CollisionGroup).."}"
    elseif _t == 'userdata' then
        return "newproxy(true)"
    elseif value == nil then
        return "nil"
    end
    return tostring(value)
end

function spy.convert_to_code(event, args, ncm)
    local path = spy.get_real_value(event)
    if #args == 0 then 
        return path..":"..ncm.."()"
    elseif #args == 1 then
        return path..":"..ncm.."("..spy.get_real_value(args[1])..")"
    end
    

    local codestr = path..":"..ncm.."(table.unpack("
    codestr = codestr..spy.get_real_value(args)
    codestr = codestr.."))"
    return codestr
end

function spy.convert_to_code_client(event, args, ncm)
    table.insert(args, 1, lplr)

    local path = spy.get_real_value(event)
    if #args == 1 then 
        return path..":"..ncm.."("..spy.get_real_value(args[1])..")"
    elseif #args == 2 then
        return path..":"..ncm.."(".. spy.get_real_value(args[1]) .. ", " ..spy.get_real_value(args[2])..")"
    end

    local codestr = path..":"..ncm.."(table.unpack("
    codestr = codestr..spy.get_real_value(args)
    codestr = codestr.."))"
    return codestr
end

local function dragGUI(gui, dragpart)
    spawn(function()
        local dragging
        local dragInput
        local dragStart = Vector3.new(0,0,0)
        local startPos
        local function update(input)
            local delta = input.Position - dragStart
            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (delta.X), startPos.Y.Scale, startPos.Y.Offset + (delta.Y))
            service.TweenService:Create(gui, TweenInfo.new(.20), {Position = Position}):Play()
        end
        dragpart.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch and dragging == false then
                dragStart = input.Position
                local delta = (input.Position - dragStart)
                if delta.Y <= 30 then
                    startPos = gui.Position
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end
        end)
        dragpart.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        service.UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end)
end

function spy.createUILibrary()
    local api = {}
    local objects = {}
    api.objects = objects
    spy.MainGui = spy:createInstance("ScreenGui", {Name = "engospy "..tostring(spy.VERSION)})
    function spy.Minimize() 
        local isMinimizing = api.Main.Visible
        for i,v in next, spy.MainGui:GetChildren() do 
            if v == api.Icon then 
                v.Visible = isMinimizing
            elseif v == api.Main then
                v.Visible = not isMinimizing
            else
                v.Visible = false
            end
        end
    end
    spy.guiConnections[#spy.guiConnections+1] = service.UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == spy.minimizeBind then 
            spy.Minimize()
        end
    end)
    if syn then syn.protect_gui(spy.MainGui) end; spy.MainGui.Parent = (gethui and gethui() or service.CoreGui)
    api.Main = spy:createInstance("Frame", {Name = "Main", Parent = spy.MainGui, BackgroundColor3 = Color3.fromRGB(38, 38, 38), Position = UDim2.new(0.326838464, 0, 0.313684225, 0), Size = UDim2.new(0, 637, 0, 394), Draggable = true, Active = true})
    api.Topbar = spy:createInstance("Frame", {Name = "Topbar", Parent = api.Main, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1.000, Position = UDim2.new(0.230337083, 0, 0, 0), Size = UDim2.new(0, 411, 0, 46)})
    api.Sidebar = spy:createInstance("Frame", {Name = "Sidebar", Parent = api.Main, BackgroundColor3 = Color3.fromRGB(24, 24, 24), BorderSizePixel = 0, Size = UDim2.new(0, 124, 1, 0)})
    api.Title = spy:createInstance("TextLabel", {Name = "Title", Parent = api.Sidebar, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1.000, Position = UDim2.new(0.492128909, 0, 0.00581395347, 5), Size = UDim2.new(0, 84, 0, 30), Font = Enum.Font.GothamBold, Text = "engospy", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24})
    api.ButtonContainer = spy:createInstance("Frame", {Name = "ButtonContainer", Parent = api.Sidebar, BackgroundTransparency = 1.000, Position = UDim2.new(0, 0, 0, 45), Size = UDim2.new(0, 124, 1, 0)})
    api.UIListLayout = spy:createInstance("UIListLayout", {Name = "UIListLayout", Parent = api.ButtonContainer, SortOrder = Enum.SortOrder.LayoutOrder})
    api.Version = spy:createInstance("TextLabel", {Name = "Version", Parent = api.Sidebar, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1.000, Position = UDim2.new(0.5, 0, 0.99000001, -20), Size = UDim2.new(0, 31, 0, 18), Font = Enum.Font.Gotham, Text = tostring(spy.VERSION),TextColor3 = Color3.fromRGB(190, 190, 190), TextSize = 15.000, TextWrapped = false, TextXAlignment = Enum.TextXAlignment.Center})
    api.UICorner = spy:createInstance("UICorner", {Parent = api.Main, CornerRadius = UDim.new(0, 6)})
    api.Close = spy:createInstance("TextButton", {Name = "Close", Parent = api.Main, BackgroundColor3 = Color3.fromRGB(222, 48, 48), BorderSizePixel = 0, Position = UDim2.new(0.974882185, -18, 0, 0), Size = UDim2.new(0, 26, 0, 7), Text = ""})
    api.UICorner2 = spy:createInstance("UICorner", {Parent = api.Close, CornerRadius = UDim.new(0, 6)})
    api.Minimize = spy:createInstance("TextButton", {Name = "Minimize", Parent = api.Main, BackgroundColor3 = Color3.fromRGB(253, 229, 119), BorderSizePixel = 0, Position = UDim2.new(0.919937134, -18, 0, 0), Size = UDim2.new(0, 26, 0, 7), Text = ""})
    api.UICorner3 = spy:createInstance("UICorner", {Parent = api.Minimize, CornerRadius = UDim.new(0, 6)})
    api.Icon = spy:createInstance("ImageButton", {Parent = spy.MainGui, BackgroundColor3 = Color3.fromRGB(24, 24, 24), Position = UDim2.new(0.957393527, 0, 0.603157878, 0), Size = UDim2.new(0, 44, 0, 44), Visible = false, AutoButtonColor = false})
    api.IconImage = spy:createInstance("ImageLabel", {Name = "ELogo", Parent = api.Icon, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1.000, Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0.699999988, 0, 0.699999988, 0), Image = "rbxassetid://9710071559"})
    api.UICorner4 = spy:createInstance("UICorner", {Parent = api.Icon, CornerRadius = UDim.new(0, 2147483647)})
    
    api.Icon.MouseButton1Click:Connect(spy.Minimize)
    function api.createCallContainer(name) 
        local callapi = {Name = name, FullName = name.."CallContainer", Type = "CallContainer", Calls = {}}
        callapi.Button = spy:createInstance("TextButton", {Name = name, Parent = api.ButtonContainer,Size = UDim2.new(0, 124, 0, 25), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(38, 38, 38), BorderSizePixel = 0, Font = Enum.Font.Gotham, Text = name, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14})
        callapi.Background = spy:createInstance("Frame", {Name = "CallContainerBack", Parent = api.Main,ClipsDescendants = true, BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 0, Position = UDim2.new(-0.0152793899, 140, 0.0169999953, 0), Size = UDim2.new(0.784279406, 0, 0.967999995, 0), Visible = false})
        callapi.Container = spy:createInstance("ScrollingFrame", {Name = callapi.FullName, Parent = callapi.Background,ClipsDescendants = true, Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(24, 24, 24), BackgroundTransparency = 1.000, BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0.980000019, 0, 0.963999987, 0), ScrollBarThickness = 0, VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left})
        callapi.UIListLayout = spy:createInstance("UIListLayout", {Parent = callapi.Container, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3)})
        callapi.UICorner = spy:createInstance("UICorner", {Parent = callapi.Background})
        spy.guiConnections[#spy.guiConnections+1] = callapi.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            callapi.Container.CanvasSize = UDim2.new(0,0,0,callapi.UIListLayout.AbsoluteContentSize.Y)
        end)
        function callapi.open()
            for i,v in next, objects do
                if v.Type == "CallContainer" and v ~= callapi then 
                    v.Background.Visible = false
                    v.Button.BackgroundTransparency = 1
                elseif v == callapi then
                    v.Background.Visible = true
                    v.Button.BackgroundTransparency = 0
                end
            end
            for i,v in next, objects do 
                for i2,v2 in next, v.Calls do 
                    v2.OptionsContainer.Visible = false
                    for i3,v3 in next, v2.Calls do 
                        if v3.OptionsContainer then
                            v3.OptionsContainer.Visible = false
                        end
                    end
                end
            end
        end
        callapi.Button.MouseButton1Click:Connect(callapi.open)

        function callapi.createCall(remote, code) 
            local callapi2 = {Remote = remote, Calls = {}}
            for _,v in next, callapi.Calls do 
                if v.Remote == remote then
                    v.updateCall(code)
                    return v
                end
            end

            function callapi2.updateCall(newCode) 
                local newCode = newCode:gsub("\n", "")
                callapi2.Calls[#callapi2.Calls+1] = {Code = newCode}
                local text = callapi2.CallAmount.Text:gsub("x", "")
                callapi2.CallAmount.Text = "x"..tostring(tonumber(text) + 1)
                if #callapi2.Calls >= spy.maxCallsSaved then
                    return
                end
                callapi2.addNewCall(newCode)
            end

            function callapi2.addNewCall(newCode) 
                local callapi3 = {Code = newCode}
                if spy.saveCalls or spy.saveOnlyLastCall then
                    if spy.saveOnlyLastCall and #callapi2.Calls > 0 then 
                        callapi2.Calls[1].CodeLabel.Text = newCode
                        return
                    end
                    callapi3.Call = spy:createInstance("TextButton", {Name = "RemoteCall", Parent = callapi2.ChildrenContainer, AutoButtonColor = false,AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(38, 38, 38), Position = UDim2.new(-0.00993345678, 0, -0.0887730792, 0), Size = UDim2.new(0.995000005, 0, 0, 36)})
                    callapi3.UICorner = spy:createInstance("UICorner", {CornerRadius = UDim.new(0,6), Parent = callapi3.Call})
                    callapi3.SettingsButton = spy:createInstance("ImageButton", {Name = "SettingsButton", Parent = callapi3.Call,ClipsDescendants = true, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1.000, Position = UDim2.new(0.939999998, 0, 0.5, 0), Size = UDim2.new(0, 26, 0, 26), Image = "rbxassetid://2717396089", ImageColor3 = Color3.fromRGB(122, 122, 122), ScaleType = Enum.ScaleType.Fit})
                    callapi3.OptionsContainer = spy:createInstance("Frame", {Name = "OptionsContainer", Parent = spy.MainGui,ZIndex = 10, BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 1, BorderColor3 = Color3.fromRGB(38,38,38), Position = UDim2.fromOffset(7,15), Size = UDim2.new(0, 113, 0, 30), Visible = false})
                    callapi3.OptionsButtonContainer = spy:createInstance("Frame", {Name = "OptionsButtonContainer", Parent = callapi3.OptionsContainer,ZIndex = 10, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1.000, Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0.959999979, 0, 0.952903688, 0)})
                    callapi3.OptionsUIListLayout = spy:createInstance("UIListLayout", {Parent = callapi3.OptionsButtonContainer, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center})
                    callapi3.CopyButton = spy:createInstance("TextButton", {Name = "CopyLast", Parent = callapi3.OptionsButtonContainer,ZIndex = 10, BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 0, Position = UDim2.new(0.0967741907, 0, 0, 0), Size = UDim2.new(1, 0, 0, 25), Font = Enum.Font.Gotham, Text = "Copy code", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true})
                    callapi3.CallNum = spy:createInstance("TextLabel", {Name = "CallNum", Parent = callapi3.Call, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1.000, Position = UDim2.new(0, 12, 0.50000006, 0), Size = UDim2.new(0, 37, 0, 24), Font = Enum.Font.Gotham, Text = "#1", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14.000, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left})
                    callapi3.CodeContainer = spy:createInstance("ScrollingFrame", {Name = "CodeContainer", Parent = callapi3.Call,ScrollBarImageTransparency=0.75, ScrollingDirection = Enum.ScrollingDirection.XY, Active = true, AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 0, Position = UDim2.new(0.079, 0, 0.5, 0), Size = UDim2.new(0, 416, 0, 26), HorizontalScrollBarInset = Enum.ScrollBarInset.Always, ScrollBarThickness = 2.5, VerticalScrollBarInset = Enum.ScrollBarInset.Always})
                    callapi3.CodeLabel = spy:createInstance("TextLabel", {Name = "CodeLabel", Parent = callapi3.CodeContainer,AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1.000, Position = UDim2.new(0, 10, 0, 0), Size = UDim2.new(0, 771, 0, 25), Font = Enum.Font.Gotham, Text = newCode:gsub("\n",""), TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12.000, TextXAlignment = Enum.TextXAlignment.Left})
                    --callapi3.CallNum.Text = "#"..tostring(#callapi2.Calls+1)
                    callapi3.CodeContainer.CanvasSize = UDim2.new(0,callapi3.CodeLabel.AbsoluteSize.X+18,0,0)
                    spy.guiConnections[#spy.guiConnections+1] = callapi3.CodeLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() 
                        callapi3.CodeContainer.CanvasSize = UDim2.new(0,callapi3.CodeLabel.AbsoluteSize.X+18,0,0)
                    end)

                    --spy.guiConnections[#spy.guiConnections+1] = callapi3.CodeContainer.MouseEnter:Connect(function() 
                    --    callapi.Container.ScrollingEnabled = false
                    --end)

                    --spy.guiConnections[#spy.guiConnections+1] = callapi3.CodeContainer.MouseLeave:Connect(function() 
                    --    callapi.Container.ScrollingEnabled = true
                    --end)

                    function callapi3.openSettings() 
                        for i,v in next, objects do 
                            for i2,v2 in next, v.Calls do 
                                if v2.OptionsContainer ~= callapi3.OptionsContainer then
                                    v2.OptionsContainer.Visible = false
                                end
                                for i3,v3 in next, v2.Calls do 
                                    if v3.OptionsContainer and (v3.OptionsContainer ~= callapi3.OptionsContainer) then
                                        v3.OptionsContainer.Visible = false
                                    end
                                end
                            end
                        end
                        if not callapi3.OptionsContainer.Visible then
                            callapi3.OptionsContainer.Position = UDim2.fromOffset(mouse.X, mouse.Y)
                        end
                        callapi3.OptionsContainer.Visible = not callapi3.OptionsContainer.Visible
                    end

                    function callapi3.copy() 
                        callapi3.OptionsContainer.Visible = false
                        setclipboardfunc(newCode)
                    end

                    callapi3.CopyButton.MouseButton1Click:Connect(callapi3.copy)
                    callapi3.Call.MouseButton2Click:Connect(callapi3.openSettings)
                    callapi3.SettingsButton.MouseButton1Click:Connect(callapi3.openSettings)
                end
                callapi2.Calls[#callapi2.Calls + 1] = callapi3
                return callapi3
            end

            callapi2.Call = spy:createInstance("TextButton", {Name = "RemoteCall", Text="",ClipsDescendants = false, AutoButtonColor=false, Parent = callapi.Container, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(38,38,38), Position = UDim2.new(0.000436, 0,0,0), Size = UDim2.new(0.995000005, 0, 0, 36)})
            callapi2.UICorner = spy:createInstance("UICorner", {Parent = callapi2.Call, CornerRadius = UDim.new(0,6)})
            callapi2.Icon = spy:createInstance("ImageLabel", {Name = "Icon", Parent = callapi2.Call, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1.000, Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.new(0, 23, 0, 22), Image = spy.assets[remote.ClassName]})
            callapi2.Name = spy:createInstance("TextLabel", {Name = "Name", Parent = callapi2.Call, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1.000, Position = UDim2.new(0.0737449452, 0, 0.500000238, 0), Size = UDim2.new(0, 328, 0, 24), Font = Enum.Font.Gotham, Text = remote.Name, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left})
            callapi2.SettingsButton = spy:createInstance("ImageButton", {Name = "SettingsButton", Parent = callapi2.Call,ClipsDescendants = true, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1.000, Position = UDim2.new(0.939999998, 0, 0.5, 0), Size = UDim2.new(0, 26, 0, 26), Image = "rbxassetid://2717396089", ImageColor3 = Color3.fromRGB(122, 122, 122), ScaleType = Enum.ScaleType.Fit})
            callapi2.CallAmount = spy:createInstance("TextLabel", {Name = "CallAmount", Parent = callapi2.Call, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1.000, Position = UDim2.new(0.768197536, 0, 0.500000238, 0), Size = UDim2.new(0, 78, 0, 24), Font = Enum.Font.Gotham, Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right})
            callapi2.OptionsContainer = spy:createInstance("Frame", {Name = "OptionsContainer", Parent = spy.MainGui,ZIndex = 10, BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 1, BorderColor3 = Color3.fromRGB(38,38,38), Position = UDim2.fromOffset(7,15), Size = UDim2.new(0, 113, 0, 111), Visible = false})
            callapi2.OptionsButtonContainer = spy:createInstance("Frame", {Name = "OptionsButtonContainer", Parent = callapi2.OptionsContainer,ZIndex = 10, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1.000, Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0.959999979, 0, 0, 0)})
            callapi2.OptionsUIListLayout = spy:createInstance("UIListLayout", {Parent = callapi2.OptionsButtonContainer, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center})
            callapi2.CopyButton = spy:createInstance("TextButton", {Name = "CopyLast", Parent = callapi2.OptionsButtonContainer,ZIndex = 10, BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 0, Position = UDim2.new(0.0967741907, 0, 0, 0), Size = UDim2.new(1, 0, 0, 25), Font = Enum.Font.Gotham, Text = "Copy last call", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true})
            callapi2.Copy10Button = spy:createInstance("TextButton", {Name = "Copy10", Parent = callapi2.OptionsButtonContainer,ZIndex = 10, BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 0, Position = UDim2.new(0.0967741907, 0, 0, 0), Size = UDim2.new(1, 0, 0, 25), Font = Enum.Font.Gotham, Text = "Copy last x10", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true})
            callapi2.CopyAllButton = spy:createInstance("TextButton", {Name = "Copy10", Parent = callapi2.OptionsButtonContainer,ZIndex = 10, BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 0, Position = UDim2.new(0.0967741907, 0, 0, 0), Size = UDim2.new(1, 0, 0, 25), Font = Enum.Font.Gotham, Text = "Copy all", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true})
            callapi2.IgnoreButton = spy:createInstance("TextButton", {Name = "Ignore", Parent = callapi2.OptionsButtonContainer,ZIndex = 10, BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 0, Position = UDim2.new(0.0967741907, 0, 0, 0), Size = UDim2.new(1, 0, 0, 25), Font = Enum.Font.Gotham, Text = "Ignore", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true})
            callapi2.BlockButton = spy:createInstance("TextButton", {Name = "Block", Parent = callapi2.OptionsButtonContainer,ZIndex = 10, BackgroundColor3 = Color3.fromRGB(23, 23, 23), BorderSizePixel = 0, Position = UDim2.new(0.0967741907, 0, 0, 0), Size = UDim2.new(1, 0, 0, 25), Font = Enum.Font.Gotham, Text = "Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true})
            callapi2.UICorner2 = spy:createInstance("UICorner", {Parent = callapi2.OptionsButtonContainer})
            callapi2.ChildrenContainer = spy:createInstance("Frame", {Name = "CallChildren", Parent = callapi.Container,AutomaticSize = Enum.AutomaticSize.Y, Visible=false, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(38, 38, 38), BackgroundTransparency = 1.000,Position = UDim2.new(0.00436409656, 0, 0, 0),Size = UDim2.new(1, 0, -0.00600000005, 36)})
            callapi2.ChildrenUIListLayout = spy:createInstance("UIListLayout", {Parent = callapi2.ChildrenContainer, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3)})

            callapi2.OptionsButtonContainer.Size = UDim2.new(0.959999979, 0, 0, callapi2.OptionsUIListLayout.AbsoluteContentSize.Y)

            callapi2.addNewCall(code)

            function callapi2.openSettings() 
                for i,v in next, objects do 
                    for i2,v2 in next, v.Calls do 
                        if v2.OptionsContainer ~= callapi2.OptionsContainer and v2.OptionsContainer then
                            v2.OptionsContainer.Visible = false
                        end
                        for i3,v3 in next, v2.Calls do 
                            if v3.OptionsContainer ~= callapi2.OptionsContainer and v3.OptionsContainer then
                                v3.OptionsContainer.Visible = false
                            end
                        end
                    end
                end
                if not callapi2.OptionsContainer.Visible then
                    callapi2.OptionsContainer.Position = UDim2.new(0,mouse.X, 0,mouse.Y)
                end
                callapi2.OptionsContainer.Visible = not callapi2.OptionsContainer.Visible
            end

            function callapi2.copyLast() 
                callapi2.OptionsContainer.Visible = false
                if setclipboardfunc then 
                    if callapi2.Calls[#callapi2.Calls] ~= nil then
                        setclipboardfunc(callapi2.Calls[#callapi2.Calls].Code)
                    end
                end
            end

            function callapi2.copyLast10()
                callapi2.OptionsContainer.Visible = false 
                if setclipboardfunc then 
                    local str = ""
                    for i,v in next, callapi2.Calls do 
                        if i >= #callapi2.Calls-10 then 
                            str= str.."\n--Call #"..tostring(i)..":\n"..v.Code.."\n"
                        end
                    end
                    setclipboardfunc(str)
                end
            end

            function callapi2.copyAll() 
                callapi2.OptionsContainer.Visible = false 
                if setclipboardfunc then 
                    local str = ""
                    for i,v in next, callapi2.Calls do 
                        str= str.."\n--Call #"..tostring(i)..":\n"..v.Code.."\n"
                    end
                    setclipboardfunc(str)
                end
            end

            function callapi2.Block() 
                callapi2.OptionsContainer.Visible = false
                if table.find(spy.blocked, remote) then
                    table.remove(spy.blocked, table.find(spy.blocked, remote))
                    callapi2.BlockButton.Text = "Block"
                    return
                end
                callapi2.BlockButton.Text = "Unblock"
                table.insert(spy.blocked, remote)
            end

            function callapi2.Ignore() 
                callapi2.OptionsContainer.Visible = false
                if table.find(spy.ignored, remote) then
                    table.remove(spy.ignored, table.find(spy.ignored, remote))
                    callapi2.IgnoreButton.Text = "Ignore"
                    return
                end
                callapi2.IgnoreButton.Text = "Unignore"
                table.insert(spy.ignored, remote)
            end

            function callapi2.Expand() 
                if not spy.saveCalls and not spy.saveOnlyLastCall then return end
                if callapi2.ChildrenContainer.Visible then 
                    for i,v in next, callapi2.Calls do 
                        if v.OptionsContainer and v.OptionsContainer.Visible then 
                            v.OptionsContainer.Visible = false
                        end
                    end
                end
                callapi2.ChildrenContainer.Visible = not callapi2.ChildrenContainer.Visible
            end

            callapi2.Call.MouseButton2Click:Connect(callapi2.openSettings)
            callapi2.SettingsButton.MouseButton1Click:Connect(callapi2.openSettings)
            callapi2.CopyButton.MouseButton1Click:Connect(callapi2.copyLast)
            callapi2.Copy10Button.MouseButton1Click:Connect(callapi2.copyLast10)
            callapi2.CopyAllButton.MouseButton1Click:Connect(callapi2.copyAll)
            callapi2.BlockButton.MouseButton1Click:Connect(callapi2.Block)
            callapi2.IgnoreButton.MouseButton1Click:Connect(callapi2.Ignore)
            callapi2.Call.MouseButton1Click:Connect(callapi2.Expand)

            callapi.Calls[remote.Name] = callapi2
            return callapi2
        end
        objects[name.."CallContainer"] = callapi
        return callapi
    end

    api.Close.MouseButton1Click:Connect(spy.Destroy)
    api.Minimize.MouseButton1Click:Connect(spy.Minimize)
    return api
end
spy.UILibrary = spy:createUILibrary()
local tabs = {}
for i,v in next, spy.namecallmethods do 
    tabs[i] = spy.UILibrary.createCallContainer(v)
end
tabs.RemoteEventClient = spy.UILibrary.createCallContainer("FireClient")
if isV3 then
    tabs.RemoteFunctionClient = spy.UILibrary.createCallContainer("InvokeClient")
end

if not wasLoaded then spy.Minimize() end

function spy.onEventFired(event, args, ncm) 
    local codestr = spy.convert_to_code(event, args, ncm)
    tabs[event.ClassName].createCall(event, codestr)
end

function spy.onClientEventFired(event, args, ncm)
    local codestr = spy.convert_to_code_client(event, args, ncm)
    tabs.RemoteEventClient.createCall(event, codestr)
end

function spy.hook()
    is_hooking = true
    old_namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local args = {...}
        local ncm = getnamecallmethod()
        local callingscript = getcallingscript()
        if is_hooking == true and (string.lower(ncm) == "invokeserver" or string.lower(ncm) == "fireserver") and (string.find(self.ClassName, "Event") or string.find(self.ClassName, "Function")) and self~=spy.event and not table.find(spy.ignored, self) and (not table.find(spy.blacklistedNames, self.Name)) then 
            if not checkcaller() and table.find(spy.blocked, self) then return end
            spy.event.Fire(spy.event, self, args, ncm, false)
        end
        return old_namecall(self, ...)
    end));

    local OldFireServer
    OldFireServer = hookfunction(Instance.new("RemoteEvent").FireServer,function(self, ...) 
        local args = {...}
        if is_hooking and not table.find(spy.ignored, self) then
           if not checkcaller() and table.find(spy.blocked, self) then return end
           spy.event.Fire(spy.event, self, args, "FireServer", false)
        end
        return OldFireServer(self, ...)
    end)

    local OldInvokeServer
    OldInvokeServer = hookfunction(Instance.new("RemoteFunction").InvokeServer,function(self, ...) 
        local args = {...}
        if is_hooking and not table.find(spy.ignored, self) then
           if not checkcaller() and table.find(spy.blocked, self) then return end
           spy.event.Fire(spy.event, self, args, "InvokeServer", false)
        end
        return OldInvokeServer(self, ...)
    end)

    for i,v in next, game:GetDescendants() do 
        local ClassName = v.ClassName
        if ClassName == "RemoteEvent" then
            spy.Connections[#spy.Connections+1] = v.OnClientEvent:Connect(function(...)
                spy.event:Fire(v, {...}, "FireClient", true)
            end)
        end
	if isV3 and ClassName == "RemoteFunction" then 
            local func = getcallbackmember(v, "OnClientInvoke")
            local old;
            old = hookfunction(func, newcclosure(function(...)
                if is_hooking then
                    spy.event:Fire(v, {...}, "InvokeClient", true)
                end
                return old(...)
            end))
            v:GetPropertyChangedSignal("OnClientInvoke"):Connect(function()
                local func = getcallbackmember(v, "OnClientInvoke")
                local old;
                old = hookfunction(func, newcclosure(function(...)
                    if is_hooking then
                        spy.event:Fire(v, {...}, "InvokeClient", true)
                    end
                    return old(...)
                end))
            end)
        end
    end

    spy.Connections[#spy.Connections+1]= game.DescendantAdded:Connect(function(v) 
        local ClassName = v.ClassName
        if ClassName == "RemoteEvent" then
            spy.Connections[#spy.Connections+1] = v.OnClientEvent:Connect(function(...)
                spy.event:Fire(v, {...}, "FireClient", true)
            end)
        end
        if isV3 and ClassName == "RemoteFunction" then 
            local func = getcallbackmember(v, "OnClientInvoke")
            local old;
            old = hookfunction(func, newcclosure(function(...)
                if is_hooking then
                    spy.event:Fire(v, {...}, "InvokeClient", true)
                end
                return old(...)
            end))
            v:GetPropertyChangedSignal("OnClientInvoke"):Connect(function()
                local func = getcallbackmember(v, "OnClientInvoke")
                local old;
                old = hookfunction(func, newcclosure(function(...)
                    if is_hooking then
                        spy.event:Fire(v, {...}, "InvokeClient", true)
                    end
                    return old(...)
                end))
            end)
        end
    end)

    spy.event.Event:Connect(function(event, args, ncm, isClient) 
        if isClient then 
            spy.onClientEventFired(event, args, ncm)
            return
        end
        spy.onEventFired(event, args, ncm)
    end)
end

function spy.unhook()
    is_hooking = false
    for i,v in next, spy.Connections do 
        v:Disconnect()
        spy.Connections[i] = nil
    end
end

spy.hook()
--print("Started engospy in", tostring(tick()-st).."s")
