local Players = game:GetService("Players")
local vu = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--//antiafk
player.Idled:Connect(function()
	vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

--// gui
local gui = Instance.new("ScreenGui")
gui.Name = "AFK_Notice"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.Parent = player:WaitForChild("PlayerGui")

--// notif frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 560, 0, 60)
frame.Position = UDim2.new(0.5, 0, 0, -150) -- Starts above screen
frame.AnchorPoint = Vector2.new(0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(70, 90, 70)
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 0
frame.ZIndex = 10
frame.Parent = gui

--// round korners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

--//border stroke
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(180, 255, 180)
stroke.Thickness = 2
stroke.Transparency = 0.05
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = frame

--// gradient shine
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 255, 160)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}
gradient.Rotation = 45
gradient.Parent = frame

--//txt lbl
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -20, 1, -10)
label.Position = UDim2.new(0, 10, 0, 5)
label.BackgroundTransparency = 1
label.Text = "✅ Anti-Afk Executed. You can now afk without being kicked. So sybau there—— [Job Application🧾]"
label.Font = Enum.Font.GothamSemibold
label.TextSize = 18
label.TextColor3 = Color3.fromRGB(240, 255, 240)
label.TextWrapped = true
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Center
label.ClipsDescendants = false
label.ZIndex = 11
label.Parent = frame

--// Animate IN (from above to top center)
TweenService:Create(frame, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, 0, 0, -50)
}):Play()

--// remove after 10s
task.delay(10, function()
	local out = TweenService:Create(frame, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
		Position = UDim2.new(0.5, 0, 0, -120)
	})
	out:Play()
	out.Completed:Wait()
	gui:Destroy()
end)

print("anti afk enabled ✅")
