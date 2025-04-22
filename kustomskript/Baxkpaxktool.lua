-- BAXKPAXK TOOL KOUNTER
-- getgenv().ToggleButton = (true) -- true/false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "baxkpaxktool"
ScreenGui.ResetOnSpawn = false

getgenv().toolgui = game.CoreGui:FindFirstChild("baxkpaxktool")

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Active = true

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 3
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "🎒 Baxkpaxk Tool Stealer"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

local SearchBox = Instance.new("TextBox", MainFrame)
SearchBox.Size = UDim2.new(1, -20, 0, 30)
SearchBox.Position = UDim2.new(0, 10, 0, 40)
SearchBox.PlaceholderText = "🔎 Live Username Lookup"
SearchBox.Text = ""
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 14
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SearchBox.ClearTextOnFocus = false
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 6)

local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, -20, 1, -110)
ScrollFrame.Position = UDim2.new(0, 10, 0, 75)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 255)

local UIListLayout = Instance.new("UIListLayout", ScrollFrame)
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local WarningLabel = Instance.new("TextLabel", MainFrame)
WarningLabel.Size = UDim2.new(1, 0, 0, 20)
WarningLabel.Position = UDim2.new(0, 0, 1, -25)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = "⚠️ NOT ALL TOOLS/GEARS ARE FE ⚠️\nlulaslollipop 🍭"
WarningLabel.Font = Enum.Font.Gotham
WarningLabel.TextSize = 12
WarningLabel.TextColor3 = Color3.fromRGB(255, 150, 150)

local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "❌"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(1, 0)

local Dragging, DragStart, StartPos
local function Update(input)
    local delta = input.Position - DragStart
    MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging or input.UserInputType == Enum.UserInputType.Touch and Dragging then
        Update(input)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
warn("destroying", ScreenGui.Name)
    ScreenGui:Destroy()
  end)

local function UpdateBackpackList()
    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local searchText = SearchBox.Text:lower()
    if searchText:match("^%s*$") then return end;

    for _, player in pairs(Players:GetPlayers()) do
        local nameMatch = player.Name:lower():find(searchText) or player.DisplayName:lower():find(searchText)
        local backpack = player:FindFirstChildOfClass("Backpack")
        
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    local toolMatch = tool.Name:lower():find(searchText)
                    if nameMatch or toolMatch then
                        local ToolFrame = Instance.new("Frame", ScrollFrame)
                        ToolFrame.Size = UDim2.new(1, 0, 0, 30)
                        ToolFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        
local ToolLabel = Instance.new("TextLabel", ToolFrame)
ToolLabel.Size = UDim2.new(0.7, 0, 1, 0)
local Tool = (tool.Name)
ToolLabel.Text = ("🔧 "..Tool.." 👤 "..player.Name)
                        ToolLabel.Font = Enum.Font.Gotham
                        ToolLabel.TextSize = 14
                        ToolLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ToolLabel.BackgroundTransparency = 1

                        local GetButton = Instance.new("TextButton", ToolFrame)
                        GetButton.Size = UDim2.new(0.3, 0, 1, 0)
                        GetButton.Position = UDim2.new(0.7, 0, 0, 0)
                        GetButton.Text = "🎁 Get"
                        GetButton.Font = Enum.Font.GothamBold
                        GetButton.TextSize = 14
                        GetButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                        GetButton.TextColor3 = Color3.fromRGB(255, 255, 255)

                        GetButton.MouseButton1Click:Connect(function()
  tool.Parent = LocalPlayer.Backpack
                        end)
                    end
                end
            end
        end
    end
end

SearchBox:GetPropertyChangedSignal("Text"):connect(UpdateBackpackList)

task.spawn(function()
    while ScreenGui.Parent do
        Stroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        task.wait(0.1)
    end
end)

----

if(getgenv().ToggleButton)then
getgenv().ButtonSetup = {
  Kustomization = {
    Owner = "lulaslollipop 🍭",
    ButtonName = "Toggle Baxkpaxk GUI",
LoopScript = false, -- true/false
 TurboLoop = false, -- true/false
  Loop_WaitTime = 0.000001,
 ButtonType = "img", -- "Default" or "Image"
ImageID = 121733900595826,
ImageButtonSize = 55,
DisabledKolor = Color3.new(1, 0, 0), --  red
    EnabledKolor = Color3.new(0, 1, 0), --  green
    DisabledText = "❌",
    EnabledText = "✅",
  },
  Properties = {
    Draggable = true, -- true/false
    Position = UDim2.new(0.5, 264, 0.5, -77), -- where the button starts
    KornerRoundness = 12,
    ButtonOutline = false,
 OutlineKolor = Color3.new(1, 1, 1), -- white
    OutlineThickness = 1,
  TextColor = Color3.new(1, 1, 1) -- white
  },
  Skript = function()
local bkpk = game.CoreGui:FindFirstChild("baxkpaxktool")
bkpk.Enabled = not bkpk.Enabled
end}
-- loads the button (required)
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrixh/uwuware/refs/heads/main/kustomskript/KustomizableButton-V3"))();
end;
