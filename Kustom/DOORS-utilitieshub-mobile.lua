local function toggleLollypop()
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui
screenGui.IgnoreGuiInset = true
  local removeborder = 0
local overlayAllGui = 2
local roundButton = Instance.new("ImageButton")
roundButton.Parent = screenGui
roundButton.Size = UDim2.new(0, 90, 0, 90) -- Set the size of the button
roundButton.Position = UDim2.new(1, -110, 0, 25) -- Position on the upper right (110 pixels left from the right edge, 10 pixels down from the top)
local lollypop = 17767487755
roundButton.Image = "http://www.roblox.com/asset/?id="..lollypop
roundButton.BackgroundTransparency = 1 -- Set transparency so only the image is shown
roundButton.ImageColor3 = Color3.fromRGB(255, 255, 255) -- Set image color
roundButton.ScaleType = Enum.ScaleType.Fit;
roundButton.BorderSizePixel = removeborder
roundButton.ZIndex = overlayAllGui

-- Make the button round
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0) -- Full radius to make it round
uiCorner.Parent = roundButton
 local function pushK()
    keypress(75)
  end
  roundButton.MouseButton1Click:Connect(pushK)

    -- so it wont run on non mobile devixe
    if not game:GetService("UserInputService").TouchEnabled then
    roundButton.Visible = true
    end;
  end;
  spawn(toggleLollypop);
pcall(function()
loadstring(game:HttpGet([[https://raw.githubusercontent.com/plamen6789/UtilitiesHub/main/UtilitiesGUI]],true))();end)
