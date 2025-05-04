-- getgenv().Keybind = "q" -- replace the letter "q" with the keybind u need

local keybind = getgenv().Keybind;

getgenv().press = function(key)
key = key or getgenv().Keybind;
vim = game:service"VirtualInputManager"
vim:SendKeyEvent(true, Enum.KeyCode[key], false, game)
task.wait(.000000001)
vim:SendKeyEvent(false, Enum.KeyCode[key], false, game)
end

-- KUSTOM BUTTON --
getgenv().ButtonSetup = {
  Kustomization = {
    Owner = "lulaslollipop 🍭",
    ButtonName = getgenv().ButtonName or keybind.." Tool",
LoopScript = false, -- true/false
 TurboLoop = false, -- true/false
  Loop_WaitTime = 0.000001,
 ButtonType = "default", -- "Default" or "Image"
ImageID = 124622552375747,
ImageButtonSize = 65,
DisabledKolor = Color3.new(1, 0, 0), --  red
    EnabledKolor = Color3.new(0, 1, 0), --  green
    DisabledText = "❌",
    EnabledText = "✅",
  },
  Properties = {
    Draggable = true, -- true or false
    Position = UDim2.new(0.5, 0, 0.5, 0), -- where the button starts
    KornerRoundness = 12,
    ButtonOutline = true,
 OutlineKolor = Color3.new(1, 1, 1), -- white
    OutlineThickness = 1,
  TextColor = Color3.new(1, 1, 1) -- white
  },
  Skript = function()
press(keybind or "Space")
end}
-- loads the button (required)
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrixh/uwuware/refs/heads/main/kustomskript/KustomizableButton-V3"))();
