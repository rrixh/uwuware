-->> BASIK UI LIB KODE <<--
--[[ xhangelog: 
sep26,2025 - added vars.kounter
]]--

local _cloneref = rawget(getfenv(), "cloneref")
local function S(name)
    local svc = game:GetService(name)
    return _cloneref and _cloneref(svc) or svc
end

--// Services
local Players = S("Players")
local LP      = Players.LocalPlayer
local UIS     = S("UserInputService")
local RS      = S("RunService")
local TS      = S("TweenService")

--// Config
local cfg = {
    tapMovePx      = 100,     -- (14) max movement to still count as a tap
    minPressMs     = 40,      -- (80) min press time before we accept as a click
    scrollCooldown = 0.30,    -- delay after a scroll before we accept taps
    pressColor     = Color3.fromRGB(36,36,44),
    frameColor     = Color3.fromRGB(28,28,36),
    bgColor        = Color3.fromRGB(18,18,22),
    onGreen        = Color3.fromRGB(46,204,113),
    offGray        = Color3.fromRGB(70,70,78),
    textColor      = Color3.fromRGB(235,235,235),
};

-- appealing text kolors / gradients
local KolorMap = {
    -- bright solids
    red     = {solid = Color3.fromRGB(255, 95,  95)},
    blue    = {solid = Color3.fromRGB( 95, 185,255)},
    yellow  = {solid = Color3.fromRGB(255, 240,105)},
    green   = {solid = Color3.fromRGB( 90, 235,145)},
    orange  = {solid = Color3.fromRGB(255, 185, 85)},
    purple  = {solid = Color3.fromRGB(195, 135,255)},
    cyan    = {solid = Color3.fromRGB( 85, 235,210)},
    magenta = {solid = Color3.fromRGB(250, 105,205)},
    pink    = {solid = Color3.fromRGB(255, 145,205)},
    white   = {solid = Color3.fromRGB(255,255,255)},
    gray    = {solid = Color3.fromRGB(210,210,210)},
    grey    = {solid = Color3.fromRGB(210,210,210)},

    -- metallics (brighter mids/highs)
    gold = {grad = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(205,160, 35)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255,235,120)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,215, 80)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255,248,170)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(190,150, 32)),
    }},
    silver = {grad = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(220,220,230)),
        ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.65, Color3.fromRGB(215,215,225)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(240,240,250)),
    }},
    bronze = {grad = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(185,115, 65)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(225,160, 95)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(165,100, 60)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(230,170,105)),
    }},

    -- brighter rainbow
    rainbow = {grad = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,  40,  40)),
        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 180,  40)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 245,  55)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB( 55, 255,  80)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB( 55, 155, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(120,  55, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(190,  55, 255)),
    }},
};

-- (keep your KolorMap as-is)

-- remove stroke + soften shine
local function killChildrenOf(inst, classNames)
    for _,c in ipairs(inst:GetChildren()) do
        for __,cn in ipairs(classNames) do
            if c.ClassName == cn or c.Name == cn then c:Destroy() break end
        end
    end
end

local function applyLabelColor(lbl, colorName)
    -- nuke prior styling
    killChildrenOf(lbl, {"UIGradient","UIStroke","ShineOverlay"})

    -- default text (no stroke by default = no blur)
    lbl.TextTransparency = 0
    lbl.TextColor3 = Color3.fromRGB(235,235,235)

    if not colorName or colorName == "" then return end

    local spec = KolorMap[tostring(colorName):lower()]
    if not spec then return end

    -- SOLID
    if spec.solid then
        lbl.TextColor3 = spec.solid
        return
    end

    -- GRADIENT (rainbow/metallic)
    local base = Instance.new("UIGradient")
    base.Color = spec.grad
    -- gentle vertical fade to keep edges readable (very subtle)
    base.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0.00, 0.03),
        NumberSequenceKeypoint.new(1.00, 0.08),
    }
    base.Parent = lbl

    -- Subtle moving shine (much softer than before)
    local shine = Instance.new("TextLabel")
    shine.Name = "ShineOverlay"
    shine.BackgroundTransparency = 1
    shine.Size = UDim2.new(1,0,1,0)
    shine.Position = UDim2.new(0,0,0,0)
    shine.Text = lbl.Text
    shine.Font = lbl.Font
    shine.TextSize = lbl.TextSize
    shine.TextXAlignment = lbl.TextXAlignment
    shine.TextYAlignment = lbl.TextYAlignment
    shine.TextTransparency = 0.25      -- soft overall
    shine.TextColor3 = Color3.fromRGB(255,255,255)
    shine.ZIndex = (lbl.ZIndex or 1) + 1
    shine.Parent = lbl

    local tint = ({
        gold   = Color3.fromRGB(255,245,210),
        bronze = Color3.fromRGB(255,225,200),
        silver = Color3.fromRGB(255,255,255),
    })[tostring(colorName):lower()] or Color3.fromRGB(255,255,255)

    local shineGrad = Instance.new("UIGradient")
    shineGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, tint),
        ColorSequenceKeypoint.new(1, tint),
    }
    -- narrower band + higher transparency -> no glare
    shineGrad.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0.00, 0.98),
        NumberSequenceKeypoint.new(0.46, 0.85),
        NumberSequenceKeypoint.new(0.50, 0.55), -- brightest point (still soft)
        NumberSequenceKeypoint.new(0.54, 0.85),
        NumberSequenceKeypoint.new(1.00, 0.98),
    }
    shineGrad.Parent = shine

    -- slower sweep so it feels premium, not flashy
    task.spawn(function()
        local t = -1
        while shine.Parent == lbl do
            t = t + 0.016
            local off = (t % 2.4) - 1.2  -- -1.2 .. +1.2 (slower)
            shineGrad.Offset = Vector2.new(off, 0)
            task.wait(0.033)
        end
    end)
local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(0,0,0)
stroke.Transparency = 0.9   -- nearly invisible; no glow
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
stroke.Parent = lbl
end;

--// Aliases (table #2)
local vars = {
    btn="btn", button="btn", Button="btn", Btn="btn",
    switch="switch", switxh="switch", Switch="switch", Switxh="switch",
    loop="loop", tog="loop", toggle="loop",
    txt="txt", textbox="txt", text="txt", Textbox="txt",
    list="list", dropdown="list", List="list", Dropdown="list",
    Dropdownlist="list", dropdownlist="list", DropdownList="list",

    -- kounter + aliases
    kounter="kounter",
    kount="kounter",
    range="kounter",
    dualshift="kounter",
    dual="kounter",
    updown="kounter",
    modulator="kounter",
    skale="kounter",
    scale="kounter",
    Scale="kounter",
    Skale="kounter",
    Updown="kounter",
    UpDown="kounter",
    Modulator="kounter",
    Range="kounter",

label = "label", Label = "label", section = "label", Section = "label", newsection = "label",newsektion="label", NewSection="label", NewSektion="label",divider = "label", Divider = "label", separator = "label", Separator="label",
}

--// State / helpers
local UI, Root, Top, Title, Line, Scroll, Arrows, NotifFrame
local conns, loops = {}, {}
local function track(c) table.insert(conns, c); return c end
local function tidyConn(c) if c and c.Disconnect then pcall(function() c:Disconnect() end) end end
local function tween(i,t,props) TS:Create(i, TweenInfo.new(t,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), props):Play() end
local function round(i,r) local u=Instance.new("UICorner"); u.CornerRadius=UDim.new(0,r or 10); u.Parent=i end
local function now() return tick() end

--// Notifications (bottom-right corner)
local function rnote(msg, dur)
    dur = tonumber(dur) or 2
    local b=Instance.new("TextLabel")
    b.BackgroundColor3=Color3.fromRGB(25,25,30)
    b.TextColor3=Color3.fromRGB(255,255,255)
    b.Font=Enum.Font.Gotham; b.TextSize=14; b.TextWrapped=true
    b.Text=tostring(msg); b.Size=UDim2.new(0,280,0,28)
    b.BackgroundTransparency=1; b.TextTransparency=1
    b.Parent=NotifFrame; round(b,8)
    local pad=Instance.new("UIPadding",b)
    pad.PaddingTop=UDim.new(0,6); pad.PaddingBottom=UDim.new(0,6); pad.PaddingLeft=UDim.new(0,8); pad.PaddingRight=UDim.new(0,8)
    b.AutomaticSize=Enum.AutomaticSize.Y
    tween(b,0.18,{TextTransparency=0, BackgroundTransparency=0.1})
    task.delay(dur, function()
        tween(b,0.22,{TextTransparency=1, BackgroundTransparency=1})
        task.wait(0.24); b:Destroy()
    end)
end

--// Tap-guard
local lastScrollAt = 0
local active = { on=false, startedAt=0, startPos=Vector2.zero, moved=0, scrolled=false }

local function markScrolled()
    lastScrollAt = now()
    if active.on then active.scrolled = true end
end

local function beginTouch(io)
    active.on = true
    active.startedAt = now()
    active.startPos = io and io.Position or Vector2.zero
    active.moved = 0
    active.scrolled = false
end

local function updateTouch(io)
    if not active.on or not io then return end
    local d = (io.Position - active.startPos).Magnitude
    if d > active.moved then active.moved = d end
end

local function endTouch()
    if not active.on then return false end
    local ok =  (now() - active.startedAt) >= (cfg.minPressMs/1000)
             and active.moved <= cfg.tapMovePx
             and (not active.scrolled)
             and (now() - lastScrollAt) >= cfg.scrollCooldown
    active.on = false
    return ok
end

local function guardClick(guiObject, onActivate, feedbackFrame)
    local base = feedbackFrame and feedbackFrame.BackgroundColor3
    local pressed = false
    local function setPressed(on)
        if not feedbackFrame then return end
        if on and not pressed then feedbackFrame.BackgroundColor3 = cfg.pressColor; pressed = true
        elseif (not on) and pressed then feedbackFrame.BackgroundColor3 = base; pressed = false end
    end

    track(guiObject.InputBegan:Connect(function(io)
        if not io or not io.UserInputType then return end
        if io.UserInputType==Enum.UserInputType.Touch or io.UserInputType==Enum.UserInputType.MouseButton1 then
            beginTouch(io); setPressed(true)
        end
    end))

    track(guiObject.InputChanged:Connect(function(io)
        if not io or not io.UserInputType then return end
        if io.UserInputType==Enum.UserInputType.Touch or io.UserInputType==Enum.UserInputType.MouseMovement then
            updateTouch(io)
            if active.moved > cfg.tapMovePx or (now()-lastScrollAt) < cfg.scrollCooldown then
                setPressed(false)
            end
        end
    end))

    track(guiObject.InputEnded:Connect(function(io)
        if not io or not io.UserInputType then return end
        if io.UserInputType==Enum.UserInputType.Touch or io.UserInputType==Enum.UserInputType.MouseButton1 then
            local ok = endTouch()
            if ok then task.delay(0.06,function() setPressed(false) end); onActivate()
            else setPressed(false) end
        end
    end))
end

--// Build UI once
local built=false
local function ensureUI()
    if built then return end
    built=true

    UI = Instance.new("ScreenGui")
    UI.Name="SGX_UI"; UI.ResetOnSpawn=false
    UI.IgnoreGuiInset=true
    UI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    UI.Parent = LP:WaitForChild("PlayerGui")

    Root = Instance.new("Frame")
    Root.Size = UDim2.new(0,340,0,260)
    Root.Position = UDim2.new(0,18,0.5,-130)
    Root.BackgroundColor3 = cfg.bgColor
    Root.Active = true; Root.Draggable = true
    Root.Parent = UI
    round(Root,14)

    Top = Instance.new("Frame")
    Top.BackgroundTransparency=1; Top.Size=UDim2.new(1,-16,0,36); Top.Position=UDim2.new(0,8,0,6)
    Top.Parent = Root

    Title = Instance.new("TextLabel")
    Title.Text="SGX"; Title.Font=Enum.Font.GothamBold; Title.TextSize=20
    Title.TextColor3=Color3.fromRGB(255,255,255)
    Title.BackgroundTransparency=1
    Title.Size=UDim2.new(1,-88,1,0)
    Title.TextXAlignment=Enum.TextXAlignment.Left
    Title.Parent=Top

    local function makeTopBtn(txt,x)
        local b=Instance.new("TextButton")
        b.Size=UDim2.new(0,32,0,28); b.Position=UDim2.new(0,x,0.5,-14)
        b.BackgroundColor3=Color3.fromRGB(28,28,36)
        b.TextColor3=Color3.fromRGB(230,230,230)
        b.Font=Enum.Font.GothamBold; b.TextSize=14; b.Text=txt
        b.AutoButtonColor=true; b.Parent=Top; round(b,8)
        return b
    end
    local MinBtn=makeTopBtn("–", 260)
    local CloseBtn=makeTopBtn("X", 296)

    Line = Instance.new("Frame")
    Line.Size=UDim2.new(1,-16,0,1); Line.Position=UDim2.new(0,8,0,44)
    Line.BackgroundColor3=Color3.fromRGB(60,60,70); Line.BorderSizePixel=0
    Line.Parent=Root

    Scroll = Instance.new("ScrollingFrame")
    Scroll.Size=UDim2.new(1,-16,1,-90)  -- room for arrows
    Scroll.Position=UDim2.new(0,8,0,52)
    Scroll.CanvasSize=UDim2.new(0,0,0,0)
    Scroll.ScrollBarThickness=4
    Scroll.BackgroundTransparency=1
    Scroll.Active=true; Scroll.ScrollingEnabled=true
    Scroll.Parent=Root

    local L = Instance.new("UIListLayout")
    L.Padding=UDim.new(0,8); L.SortOrder=Enum.SortOrder.LayoutOrder; L.Parent=Scroll
    track(L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0,0,0,L.AbsoluteContentSize.Y+16)
    end))
    track(Scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(markScrolled))

    Arrows = Instance.new("Frame")
    Arrows.Size=UDim2.new(1,-16,0,30)
    Arrows.Position=UDim2.new(0,8,1,-36)
    Arrows.BackgroundTransparency=1
    Arrows.Parent=Root

    local function makeArrow(txt, right)
        local f=Instance.new("TextButton")
        f.Size=UDim2.new(0.5,-4,1,0)
        f.Position = right and UDim2.new(0.5,4,0,0) or UDim2.new(0,0,0,0)
        f.Text=txt; f.Font=Enum.Font.GothamBold; f.TextSize=16
        f.TextColor3=Color3.fromRGB(240,240,240)
        f.BackgroundColor3=cfg.frameColor; f.AutoButtonColor=true
        f.Parent=Arrows; round(f,8)
        return f
    end
    local UpBtn   = makeArrow("▲", false)
    local DownBtn = makeArrow("▼", true)

    local function attachAutoScroll(btn, direction)
        local hold=false
        local baseStep,accel,maxStep = 12,1.08,64
        local step=baseStep
        local function tickScroll()
            while hold do
                local cur = Scroll.CanvasPosition
                local newY = math.max(0, cur.Y + direction * step)
                Scroll.CanvasPosition = Vector2.new(cur.X, newY)
                step = math.min(maxStep, math.floor(step * accel))
                task.wait(0.03)
            end
            step=baseStep
        end
        guardClick(btn, function()
            local cur = Scroll.CanvasPosition
            local newY = math.max(0, cur.Y + direction * 60)
            Scroll.CanvasPosition = Vector2.new(cur.X, newY)
        end, btn)
        track(btn.InputBegan:Connect(function(io)
            if io.UserInputType==Enum.UserInputType.Touch or io.UserInputType==Enum.UserInputType.MouseButton1 then
                hold=true; task.spawn(tickScroll)
            end
        end))
        track(btn.InputEnded:Connect(function(io)
            if io.UserInputType==Enum.UserInputType.Touch or io.UserInputType==Enum.UserInputType.MouseButton1 then
                hold=false
            end
        end))
    end
    attachAutoScroll(UpBtn,-1)
    attachAutoScroll(DownBtn,1)

    -- Min/Close
    local minimized=false
    guardClick(MinBtn,function()
        minimized = not minimized
        Scroll.Visible = not minimized
        Line.Visible   = not minimized
        Arrows.Visible = not minimized
        Root.Size = minimized and UDim2.new(0,340,0,56) or UDim2.new(0,340,0,260)
    end, MinBtn)

    guardClick(CloseBtn,function()
        for i=#loops,1,-1 do tidyConn(loops[i]); loops[i]=nil end
        for i=#conns,1,-1 do tidyConn(conns[i]); conns[i]=nil end
        if UI then UI:Destroy() end
    end, CloseBtn)

    -- Notifs root (bottom-right corner)
    NotifFrame = Instance.new("Frame")
    NotifFrame.Name = "Notifs"
    NotifFrame.AnchorPoint = Vector2.new(1,1)
    NotifFrame.Position = UDim2.new(1,-20, 1,-20)
    NotifFrame.Size = UDim2.new(0,300, 0, 0)
    NotifFrame.BackgroundTransparency = 1
    NotifFrame.Parent = UI
    local NL=Instance.new("UIListLayout")
    NL.Padding=UDim.new(0,6)
    NL.VerticalAlignment=Enum.VerticalAlignment.Bottom
    NL.HorizontalAlignment=Enum.HorizontalAlignment.Right
    NL.Parent=NotifFrame
end

--// Utils (table #3)
local utils = {}
function utils.fokus(tb)
    return { connect=function(_,fn)
        if tb and typeof(tb)=="Instance" and tb:IsA("TextBox") and typeof(fn)=="function" then
            return tb.FocusLost:Connect(function(enter) fn(enter) end)
        end
        return {Disconnect=function()end}
    end }
end
function utils.gpcs(inst, prop)
    prop = prop or "Text"
    if inst and inst.GetPropertyChangedSignal then
        return inst:GetPropertyChangedSignal(prop)
    end
    return {Connect=function() return {Disconnect=function()end} end}
end

--// Builders
local function row(h)
    local f=Instance.new("Frame")
    f.Size=UDim2.new(1,-16,0,h or 36)
    f.Position=UDim2.new(0,8,0,0)
    f.BackgroundColor3=cfg.frameColor
    f.Parent=Scroll
    round(f,10)
    local pad=Instance.new("UIPadding",f)
    pad.PaddingTop=UDim.new(0,4); pad.PaddingBottom=UDim.new(0,4); pad.PaddingLeft=UDim.new(0,6); pad.PaddingRight=UDim.new(0,6)
    return f
end

local function makeButton(label)
    local r=row(36)
    local b=Instance.new("TextButton")
    b.BackgroundTransparency=1; b.AutoButtonColor=true
    b.Size=UDim2.new(1,0,1,0)
    b.Text=label; b.Font=Enum.Font.Gotham; b.TextSize=15; b.TextColor3=cfg.textColor
    b.Parent=r
    return r,b
end

local function makeSwitch(label)
    local r=row(42)
    local txt=Instance.new("TextLabel")
    txt.BackgroundTransparency=1; txt.Size=UDim2.new(1,-70,1,0)
    txt.TextXAlignment=Enum.TextXAlignment.Left; txt.Font=Enum.Font.Gotham; txt.TextSize=15
    txt.TextColor3=cfg.textColor; txt.Text=label; txt.Parent=r

    local knob=Instance.new("Frame")
    knob.Size=UDim2.new(0,52,0,26); knob.Position=UDim2.new(1,-58,0.5,-13)
    knob.BackgroundColor3=cfg.offGray; knob.Parent=r; round(knob,13)

    local dot=Instance.new("Frame")
    dot.Size=UDim2.new(0,22,0,22); dot.Position=UDim2.new(0,2,0,2)
    dot.BackgroundColor3=Color3.fromRGB(210,210,210); dot.Parent=knob; round(dot,11)

    local hit=Instance.new("TextButton")
    hit.BackgroundTransparency=1; hit.Text=""; hit.AutoButtonColor=false; hit.Size=UDim2.new(1,0,1,0); hit.Parent=r

    return r,knob,dot,hit
end

local function makeLoop(label)
    local r=row(42)
    local txt=Instance.new("TextLabel")
    txt.BackgroundTransparency=1; txt.Size=UDim2.new(1,-50,1,0)
    txt.TextXAlignment=Enum.TextXAlignment.Left; txt.Font=Enum.Font.Gotham; txt.TextSize=15
    txt.TextColor3=cfg.textColor; txt.Text=label; txt.Parent=r

    local ring=Instance.new("Frame")
    ring.Size=UDim2.new(0,22,0,22); ring.Position=UDim2.new(1,-28,0.5,-11)
    ring.BackgroundColor3=Color3.fromRGB(50,50,58); ring.Parent=r; round(ring,11)

    local fill=Instance.new("Frame")
    fill.Size=UDim2.new(0,0,1,0); fill.BackgroundColor3=cfg.onGreen; fill.Parent=ring; round(fill,11)

    local hit=Instance.new("TextButton")
    hit.BackgroundTransparency=1; hit.Text=""; hit.AutoButtonColor=false; hit.Size=UDim2.new(1,0,1,0); hit.Parent=r

    return r,ring,fill,hit
end

local function makeTextBox(placeholder)
    local r=row(38)
    local tb=Instance.new("TextBox")
    tb.BackgroundTransparency=1; tb.Size=UDim2.new(1,-40,1,0); tb.Position=UDim2.new(0,6,0,0)
    tb.Font=Enum.Font.Gotham; tb.TextSize=15; tb.PlaceholderText=placeholder or "enter text"
    tb.Text=""; tb.TextColor3=cfg.textColor; tb.ClearTextOnFocus=false
    tb.Parent=r

    local clearBtn=Instance.new("TextButton")
    clearBtn.Size=UDim2.new(0,28,0,28); clearBtn.Position=UDim2.new(1,-32,0.5,-14)
    clearBtn.BackgroundColor3=Color3.fromRGB(200,40,40)
    clearBtn.TextColor3=Color3.fromRGB(255,255,255)
    clearBtn.Font=Enum.Font.GothamBold; clearBtn.TextSize=16; clearBtn.Text="X"
    clearBtn.AutoButtonColor=true; clearBtn.Parent=r; round(clearBtn,8)

    guardClick(clearBtn,function() tb.Text=""; tb:ReleaseFocus() end, clearBtn)
    return tb,r
end

local function makeDropdown(label, itemsProvider, onSelect)
    local headerRow=row(42)
    local headerBtn=Instance.new("TextButton")
    headerBtn.BackgroundTransparency=1; headerBtn.Size=UDim2.new(1,0,1,0)
    headerBtn.Text=label.."  ▼"; headerBtn.TextXAlignment=Enum.TextXAlignment.Left
    headerBtn.Font=Enum.Font.Gotham; headerBtn.TextSize=15; headerBtn.TextColor3=cfg.textColor
    headerBtn.AutoButtonColor=true; headerBtn.Parent=headerRow

    local listFrame=Instance.new("Frame")
    listFrame.Size=UDim2.new(1,-16,0,0); listFrame.BackgroundColor3=Color3.fromRGB(24,24,30)
    listFrame.Visible=false; listFrame.Parent=Scroll; round(listFrame,10)
    local pad=Instance.new("UIPadding",listFrame)
    pad.PaddingTop=UDim.new(0,6); pad.PaddingBottom=UDim.new(0,6); pad.PaddingLeft=UDim.new(0,6); pad.PaddingRight=UDim.new(0,6)
    local uiList=Instance.new("UIListLayout"); uiList.Padding=UDim.new(0,6); uiList.Parent=listFrame

    local function rebuild()
        for _,c in ipairs(listFrame:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        local items={}
        if type(itemsProvider)=="function" then
            local ok,data=pcall(itemsProvider); if ok and type(data)=="table" then items=data end
        elseif type(itemsProvider)=="table" then
            items = itemsProvider
        end

        local isPlayers=(#items>0 and typeof(items[1])=="Instance" and items[1]:IsA("Player"))

        for _,entry in ipairs(items) do
            local display=isPlayers and ("@"..entry.Name.." | "..entry.DisplayName) or tostring(entry)
            local item=Instance.new("TextButton")
            item.Size=UDim2.new(1,-12,0,30)
            item.BackgroundColor3=Color3.fromRGB(34,34,42)
            item.TextColor3=Color3.fromRGB(240,240,240)
            item.Font=Enum.Font.Gotham; item.TextSize=14; item.Text=display
            item.AutoButtonColor=true; item.Parent=listFrame; round(item,8)

            guardClick(item,function()
                if type(onSelect)=="function" then
                    onSelect(isPlayers and entry or display)
                end
            end,item)
        end
        listFrame.Size=UDim2.new(1,-16,0, uiList.AbsoluteContentSize.Y+12)
    end

    track(uiList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if listFrame.Visible then
            listFrame.Size = UDim2.new(1,-16,0, uiList.AbsoluteContentSize.Y+12)
        end
    end))

    guardClick(headerBtn,function()
        listFrame.Visible = not listFrame.Visible
        headerBtn.Text = label .. (listFrame.Visible and "  ▲" or "  ▼")
        if listFrame.Visible then rebuild() end
    end, headerRow)

    return {frame=listFrame, header=headerBtn, refresh=rebuild}
end;

-- thin separator row the layout kan measure reliably
local function makeSeparator()
    local r = row(10)
    r.BackgroundTransparency = 1
    local line = Instance.new("Frame")
    line.BorderSizePixel = 0
    line.BackgroundColor3 = Color3.fromRGB(60,60,70)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.Parent = r
    return r
end;
-- end separator--

-- centered label with color/gradient + tight underline in SAME row
local function makeLabel(text, font, colorName)
    local r = row(36)
    r.BackgroundTransparency = 1

    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 1, -8)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.TextYAlignment = Enum.TextYAlignment.Center
    lbl.Font = (typeof(font) == "EnumItem" and font)
            or (typeof(font) == "string" and Enum.Font[font])
            or Enum.Font.GothamBold
    lbl.TextSize = 18
    lbl.Text = tostring(text or "")
    lbl.ZIndex = 2
    lbl.Parent = r

    applyLabelColor(lbl, colorName)

    -- underline (tight, but not touching)
    local line = Instance.new("Frame")
    line.BorderSizePixel = 0
    line.BackgroundColor3 = Color3.fromRGB(72,72,82)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 1, -4)
    line.ZIndex = 1
    line.Parent = r

    return lbl, r
end;

-- === kounter (tap vs hold fixed) ===
local function makeKounter(label, stepAmount, startValue, onChange)
    local step = tonumber(stepAmount) or 1
    local val  = tonumber(startValue) or 0
    local cb   = type(onChange)=="function" and onChange or function() end

    local r = row(42)

    -- left "Label: value"
    local txt = Instance.new("TextLabel")
    txt.BackgroundTransparency = 1
    txt.Size = UDim2.new(1,-130,1,0)
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Font = Enum.Font.Gotham
    txt.TextSize = 15
    txt.TextColor3 = cfg.textColor
    txt.Text = tostring(label) .. ": " .. tostring(val)
    txt.Parent = r

    -- right button wrap
    local wrap = Instance.new("Frame")
    wrap.Size = UDim2.new(0,118,0,30)
    wrap.Position = UDim2.new(1,-122,0.5,-15)
    wrap.BackgroundTransparency = 1
    wrap.Parent = r

    local RED   = Color3.fromRGB(190, 60, 60)   -- medium red
    local GREEN = Color3.fromRGB( 60,170, 90)   -- medium green

    local function mkBtn(text, xoff, bg)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0,56,1,0)
        b.Position = UDim2.new(0,xoff,0,0)
        b.BackgroundColor3 = bg
        b.TextColor3 = Color3.fromRGB(235,235,235)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 16
        b.Text = text
        b.AutoButtonColor = true
        b.Parent = wrap
        round(b,8)
        return b
    end

    local minus = mkBtn("-", 0,  RED)
    local plus  = mkBtn("+", 62, GREEN)

    local function refresh()
        txt.Text = tostring(label) .. ": " .. tostring(val)
    end
    local function set(newVal)
        val = tonumber(newVal) or val
        refresh()
        local ok,err = pcall(cb, val)
        if not ok then rnote("err: "..tostring(err), 2) end
    end

    -- tap vs hold logic
    local holdThreshold = .10  -- sekonds to qualify as hold
    local RS = game:GetService("RunService")

    local function bindTapHold(btn, sign)
        local pressing = false
        local pressedAt = 0
        local holdStarted = false
        local holdConn

        local function stopHold()
            if holdConn then holdConn:Disconnect(); holdConn=nil end
            holdStarted = false
        end

        btn.InputBegan:Connect(function(io)
            if io.UserInputType ~= Enum.UserInputType.MouseButton1
               and io.UserInputType ~= Enum.UserInputType.Touch then return end

            pressing = true
            pressedAt = os.clock()
            holdStarted = false

            -- arm a delayed check that starts the hold after threshold
            task.delay(holdThreshold, function()
                if pressing and not holdStarted then
                    holdStarted = true
                    -- start repeating with acceleration
                    local started = os.clock()
                    local last    = os.clock()
                    stopHold()
                    holdConn = RS.RenderStepped:Connect(function()
                        if not pressing then stopHold(); return end
                        local now = os.clock()
                        local age = now - started
                        local dt  = now - last
                        local interval = (age < 0.35) and 0.35 or (age < 1.0 and 0.12 or 0.04)
                        if dt >= interval then
                            last = now
                            set(val + sign * step)
                        end
                    end)
                end
            end)
        end)

        btn.InputEnded:Connect(function(io)
            if io.UserInputType ~= Enum.UserInputType.MouseButton1
               and io.UserInputType ~= Enum.UserInputType.Touch then return end

            local wasPressing = pressing
            pressing = false

            -- if released before threshold and hold never started -> single tap
            if wasPressing and not holdStarted then
                if (os.clock() - pressedAt) < holdThreshold then
                    set(val + sign * step)
                end
            end

            stopHold()
        end)
    end

    -- bind buttons (– decreases, + increases)
    bindTapHold(minus, -1)
    bindTapHold(plus,  1)

    -- fire once with startValue
    local ok,err = pcall(cb, val)
    if not ok then rnote("err: "..tostring(err), 2) end

    return r
end;

--// Title setter
local function AddTitle(t) ensureUI(); Title.Text=tostring(t) end

--// Loop resolver
local function resolveMode(s)
    s=tostring(s or "loop"):lower()
    if s=="renderstepped" or s=="render" or s=="prerender" then return "render"
    elseif s=="heartbeat" then return "heartbeat"
    elseif s=="stepped" then return "stepped"
    else return "thread" end
end

--// Builder entry
-- NEW signature supports 4 args
local function Build(kind, label, a, b, c)
    ensureUI()
    local k=tostring(kind or ""):lower()
    for alias,target in pairs(vars) do if alias:lower()==k then kind=target break end end
    local function runAny(v) if type(v)=="function" then local ok,e=pcall(v); if not ok then rnote("err: "..tostring(e),2) end end end

    if kind=="btn" then
        local r,b = makeButton(label)
        guardClick(b, function() runAny(a) end, r)
        return b

    elseif kind=="switch" then
        local r,knob,dot,hit=makeSwitch(label)
        local on=false
        guardClick(hit,function()
            on=not on
            tween(dot,0.16,{Position=on and UDim2.new(1,-24,0,2) or UDim2.new(0,2,0,2)})
            tween(knob,0.16,{BackgroundColor3=on and cfg.onGreen or cfg.offGray})
            if on then runAny(a) else runAny(b) end
        end,r)
        return r

    elseif kind=="loop" then
        local r,ring,fill,hit = makeLoop(label)
        local on=false
        local mode=resolveMode(b)
        local conn,flag,threadRunning=nil,false,false
        local function setFill(v) local w=math.floor(22*math.clamp(v,0,1)); tween(fill,0.16,{Size=UDim2.new(0,w,1,0)}) end
        local function startLoop()
            if mode=="thread" then
                flag=true; if threadRunning then return end; threadRunning=true
                task.spawn(function()
                    while flag do runAny(a); task.wait() end
                    threadRunning=false
                end)
            elseif mode=="render" then
                conn=RS.RenderStepped:Connect(function() runAny(a) end); table.insert(loops,conn)
            elseif mode=="stepped" then
                conn=RS.Stepped:Connect(function() runAny(a) end); table.insert(loops,conn)
            else
                conn=RS.Heartbeat:Connect(function() runAny(a) end); table.insert(loops,conn)
            end
        end
        local function stopLoop()
            if mode=="thread" then flag=false
            else if conn then tidyConn(conn); conn=nil end end
        end
        guardClick(hit, function()
            on = not on
            if on then setFill(1); startLoop() else setFill(0); stopLoop() end
        end, r)
        return r

    elseif kind=="txt" then
        local tb=select(1,makeTextBox(label)); return tb

    elseif kind=="list" then
        return makeDropdown(label, a, b)

    elseif kind=="kounter" then
        -- a=stepAmount, b=startValue, c=callback
        return makeKounter(label, a, b, c)

    elseif kind=="label" then
   return select(2, makeLabel(label, a,b))
-- a=font,b=kolor

    end
end;

-- Public API (table #1)
local API = {}
function API:Title(t) AddTitle(t) end

-- notif supports both Kontent.notif("msg", dur) and Kontent:notif("msg", dur)
function API.notif(...)
    local a,b = ...
    local msg, dur
    if type(a) == "table" then
        -- called with colon: self, msg, dur
        msg, dur = b, select(3, ...)
    else
        -- called with dot: msg, dur
        msg, dur = a, b
    end
    rnote(msg, dur)
end

-- label supports both Kontent.label("text") and Kontent:label("text")
function API.label(...)
    local a = {...}
    local text, font, colorName
    if type(a[1]) == "table" then
        text, font, colorName = a[2], a[3], a[4]
    else
        text, font, colorName = a[1], a[2], a[3]
    end
    ensureUI()
    return makeLabel(text, font, colorName)
end;

-- allow 4 args (label + 3 extra)
setmetatable(API, {
    __call = function(self, kind, label, a, b, c)
        return Build(kind, label, a, b, c)
    end
})
API[1]=API;

--//
return {API,vars,utils};
