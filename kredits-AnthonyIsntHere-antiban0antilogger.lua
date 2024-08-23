 -- Gui to Lua
 -- Version: 3.2

 -- instanxes:

 local ScreenGui = Instance.new("ScreenGui")
 local Frame = Instance.new("Frame")
 local UICorner = Instance.new("UICorner")
 local UIGradient = Instance.new("UIGradient")
 local TextLabel = Instance.new("TextLabel")
 local UICorner_2 = Instance.new("UICorner")
 local TextLabel_2 = Instance.new("TextLabel")
 local UICorner_3 = Instance.new("UICorner")
 local TextButton = Instance.new("TextButton")
 local UICorner_4 = Instance.new("UICorner")
 local TextButton_2 = Instance.new("TextButton")
 local UICorner_5 = Instance.new("UICorner")

 --Properties:

 ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
 ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

 Frame.Parent = ScreenGui
 Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
 Frame.BackgroundTransparency = 0.120
 Frame.Position = UDim2.new(0.354000002, 0, 0.316000015, 0)
 Frame.Size = UDim2.new(0, 445, 0, 252)

 UICorner.Parent = Frame

 UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(4, 4, 4)), ColorSequenceKeypoint.new(0.49, Color3.fromRGB(12, 4, 20)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(12, 4, 20))}
 UIGradient.Parent = Frame

 TextLabel.Parent = Frame
 TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 TextLabel.BackgroundTransparency = 0.600
 TextLabel.Position = UDim2.new(0.00224719103, 0, 0, 0)
 TextLabel.Size = UDim2.new(0, 443, 0, 27)
 TextLabel.Font = Enum.Font.SourceSans
 TextLabel.Text = "Warning"
 TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
 TextLabel.TextScaled = true
 TextLabel.TextSize = 14.000
 TextLabel.TextWrapped = true

 UICorner_2.Parent = TextLabel

 TextLabel_2.Parent = Frame
 TextLabel_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 TextLabel_2.BackgroundTransparency = 0.600
 TextLabel_2.Position = UDim2.new(0.0269662924, 0, 0.162698418, 0)
 TextLabel_2.Size = UDim2.new(0, 421, 0, 115)
 TextLabel_2.Font = Enum.Font.SourceSans
 TextLabel_2.Text = "u are exekuting anti-ban/anti-logger meaning that Roblox's system wont be able to detekt your messages so u kant be banned for anything u say. are u sure u want to exekute it?"
 TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
 TextLabel_2.TextScaled = true
 TextLabel_2.TextSize = 14.000
 TextLabel_2.TextWrapped = true

 UICorner_3.Parent = TextLabel_2

 TextButton.Parent = Frame
 TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 TextButton.BackgroundTransparency = 0.600
 TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
 TextButton.Position = UDim2.new(0.287640452, 0, 0.658730209, 0)
 TextButton.Size = UDim2.new(0, 189, 0, 34)
 TextButton.Font = Enum.Font.SourceSans
 TextButton.Text = "Enable"
 TextButton.TextColor3 = Color3.fromRGB(0, 194, 45)
 TextButton.TextSize = 14.000

 UICorner_4.Parent = TextButton

 TextButton_2.Parent = Frame
 TextButton_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 TextButton_2.BackgroundTransparency = 0.600
 TextButton_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
 TextButton_2.Position = UDim2.new(0.280898869, 0, 0.821428478, 0)
 TextButton_2.Size = UDim2.new(0, 194, 0, 32)
 TextButton_2.Font = Enum.Font.SourceSans
 TextButton_2.Text = "Klose"
 TextButton_2.TextColor3 = Color3.fromRGB(203, 0, 0)
 TextButton_2.TextSize = 14.000

 UICorner_5.Parent = TextButton_2

 -- Scripts:

 local function CPNQ_fake_script() -- TextButton.LocalScript 
   local script = Instance.new('LocalScript', TextButton)

   script.Parent.MouseButton1Click:Connect(function()
     -- This basically makes roblox unable to log your chat messages sent in-game. Meaning if you get reported for saying something bad, you won't get banned!
     -- Store in autoexec folder
     -- Credits: AnthonyIsntHere and ArianBlaack

   --[[
     Change-logs:
     8/22/2022 - Fixed Chat gui glitching on some games such as Prison Life.
     9/30/2022 - Fixed chat gui glitching AGAIN... (added better checks too)
     10/10/2022 - Added gethui() function and fix for Synapse v3.
     11/11/2022 - Idk what happened but it stopped working... I fixed it though.
   ]]--

     local ACL_LoadTime = tick()

     local ChatChanged = false
     local OldSetting = nil
     local WhitelistedCoreTypes = {
       "Chat",
       "All",
       Enum.CoreGuiType.Chat,
       Enum.CoreGuiType.All
     }

     local StarterGui = game:GetService("StarterGui")

     local FixCore = function(x)
       local CoreHook; CoreHook = hookmetamethod(x, "__namecall", function(self, ...)
         local Method = getnamecallmethod()
         local Arguments = {...}

         if self == x and Method == "SetCoreGuiEnabled" and not checkcaller() then
           local CoreType = Arguments[1]
           local Enabled = Arguments[2]

           if table.find(WhitelistedCoreTypes, CoreType) and not Enabled then
             if CoreType == ("Chat" or Enum.CoreGuiType.Chat) then
               OldSetting = Enabled
             end
             ChatChanged = true
           end
         end

         return CoreHook(self, ...)
       end)

       x.CoreGuiChangedSignal:Connect(function(Type)
         if table.find(WhitelistedCoreTypes, Type) and ChatChanged then
           task.wait()
           if not StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat) then
             x:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
           end
           wait(1)
           if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat) then
             x:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, OldSetting) -- probably defaults to false i am too tired for the making of this lol
           end
           ChatChanged = false
         end
       end)
     end

     if StarterGui then
       FixCore(StarterGui)
       if not StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat) then
         StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
       end
     else
       local Connection; Connection = game.ChildAdded:Connect(function(x)
         if x:IsA("StarterGui") then
           FixCore(x)
           Connection:Disconnect()
         end
       end)
     end

     if not game:IsLoaded() then
       game.Loaded:wait()
     end

     local CoreGui = game:GetService("CoreGui")
     local TweenService = game:GetService("TweenService")
     local Players = game:GetService("Players")

     local Player = Players.LocalPlayer

     local PlayerGui = Player:FindFirstChildWhichIsA("PlayerGui") do
       if not PlayerGui then
         repeat task.wait() until Player:FindFirstChildWhichIsA("PlayerGui")
         PlayerGui = Player:FindFirstChildWhichIsA("PlayerGui")
       end
     end

     local Notify = function(_Title, _Text , Time)
print(_Title)
print(_Text)
print(Time)
     end

     local Tween = function(Object, Time, Style, Direction, Property)
       return TweenService:Create(Object, TweenInfo.new(Time, Enum.EasingStyle[Style], Enum.EasingDirection[Direction]), Property)
     end

     local ACLWarning = Instance.new("ScreenGui")
     local Background = Instance.new("Frame")
     local Top = Instance.new("Frame")
     local Exit = Instance.new("TextButton")
     local UICorner = Instance.new("UICorner")
     local WarningLbl = Instance.new("TextLabel")
     local Loading = Instance.new("Frame")
     local Bar = Instance.new("Frame")
     local WarningBackground = Instance.new("Frame")
     local WarningFrame = Instance.new("Frame")
     local Despair = Instance.new("TextLabel")
     local UIListLayout = Instance.new("UIListLayout")
     local Reason_1 = Instance.new("TextLabel")
     local Reason_2 = Instance.new("TextLabel")
     local Trollge = Instance.new("ImageLabel")
     local UIPadding = Instance.new("UIPadding")

     local MakeGuiThread = coroutine.wrap(function()
       if syn then
         if gethui then
           gethui(ACLwarning)
         else
           syn.protect_gui(ACLWarning)
         end
       end

       ACLWarning.Name = "ACL Warning"
       ACLWarning.Parent = CoreGui
       ACLWarning.Enabled = false
       ACLWarning.DisplayOrder = -2147483648

       Background.Name = "Background"
       Background.Parent = ACLWarning
       Background.AnchorPoint = Vector2.new(0.5, 0.5)
       Background.BackgroundColor3 = Color3.fromRGB(21, 0, 0)
       Background.BorderSizePixel = 0
       Background.Position = UDim2.new(0.5, 0, 0.5, 0)
       Background.Size = UDim2.new(0.300000012, 0, 0.5, 0)

       Top.Name = "Top"
       Top.Parent = Background
       Top.AnchorPoint = Vector2.new(0.5, 0.5)
       Top.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
       Top.BorderSizePixel = 0
       Top.Position = UDim2.new(0.5, 0, 0.100000001, 0)
       Top.Size = UDim2.new(0.899999976, 0, 0.100000001, 0)

       Exit.Name = "Exit"
       Exit.Parent = Top
       Exit.AnchorPoint = Vector2.new(0.5, 0.5)
       Exit.BackgroundColor3 = Color3.fromRGB(38, 0, 0)
       Exit.Position = UDim2.new(0.949999988, 0, 0.5, 0)
       Exit.Size = UDim2.new(0.100000001, -6, 1, -9)
       Exit.Visible = false
       Exit.Font = Enum.Font.Arcade
       Exit.Text = "X"
       Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
       Exit.TextScaled = true
       Exit.TextSize = 14.000
       Exit.TextWrapped = true

       UICorner.CornerRadius = UDim.new(0.200000003, 0)
       UICorner.Parent = Exit

       WarningLbl.Name = "WarningLbl"
       WarningLbl.Parent = Top
       WarningLbl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
       WarningLbl.BackgroundTransparency = 1.000
       WarningLbl.Position = UDim2.new(0, 17, 0, 0)
       WarningLbl.Size = UDim2.new(0.5, 0, 1, 0)
       WarningLbl.Font = Enum.Font.Arcade
       WarningLbl.Text = "Warning!"
       WarningLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
       WarningLbl.TextScaled = true
       WarningLbl.TextSize = 14.000
       WarningLbl.TextWrapped = true
       WarningLbl.TextXAlignment = Enum.TextXAlignment.Left

       Loading.Name = "Loading"
       Loading.Parent = Top
       Loading.AnchorPoint = Vector2.new(0.5, 0.5)
       Loading.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
       Loading.BorderSizePixel = 0
       Loading.Position = UDim2.new(0.699999988, 0, 0.5, 0)
       Loading.Size = UDim2.new(0.349999994, 0, 0.0199999996, 0)

       Bar.Name = "Bar"
       Bar.Parent = Loading
       Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
       Bar.BorderSizePixel = 0
       Bar.Size = UDim2.new(0, 0, 1, 0)

       WarningBackground.Name = "WarningBackground"
       WarningBackground.Parent = Background
       WarningBackground.AnchorPoint = Vector2.new(0.5, 0.5)
       WarningBackground.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
       WarningBackground.BorderSizePixel = 0
       WarningBackground.Position = UDim2.new(0.5, 0, 0.550000012, 0)
       WarningBackground.Size = UDim2.new(0.899999976, 0, 0.800000012, 0)

       WarningFrame.Name = "WarningFrame"
       WarningFrame.Parent = WarningBackground
       WarningFrame.AnchorPoint = Vector2.new(0.5, 0.5)
       WarningFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
       WarningFrame.BorderSizePixel = 0
       WarningFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
       WarningFrame.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)

       Despair.Name = "Despair"
       Despair.Parent = WarningFrame
       Despair.AnchorPoint = Vector2.new(0.5, 0.5)
       Despair.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
       Despair.BackgroundTransparency = 1.000
       Despair.BorderColor3 = Color3.fromRGB(27, 42, 53)
       Despair.BorderSizePixel = 0
       Despair.Position = UDim2.new(0.5, 0, 0.100000001, 0)
       Despair.Size = UDim2.new(0.949999988, 0, 0.119999997, 0)
       Despair.Font = Enum.Font.Oswald
       Despair.Text = "anti-logger will not work here stupid!"
       Despair.TextColor3 = Color3.fromRGB(255, 255, 255)
       Despair.TextScaled = true
       Despair.TextSize = 50.000
       Despair.TextWrapped = true
       Despair.TextYAlignment = Enum.TextYAlignment.Top

       UIListLayout.Parent = WarningFrame
       UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
       UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
       UIListLayout.Padding = UDim.new(0, 15)

       Reason_1.Name = "Reason_1"
       Reason_1.Parent = WarningFrame
       Reason_1.AnchorPoint = Vector2.new(0.5, 0.5)
       Reason_1.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
       Reason_1.BackgroundTransparency = 1.000
       Reason_1.BorderColor3 = Color3.fromRGB(27, 42, 53)
       Reason_1.BorderSizePixel = 0
       Reason_1.Position = UDim2.new(0.5, 0, 0.100000001, 0)
       Reason_1.Size = UDim2.new(0.949999988, 0, 0.100000001, 0)
       Reason_1.Visible = false
       Reason_1.Font = Enum.Font.Oswald
       Reason_1.Text = "-xhat module was not found"
       Reason_1.TextColor3 = Color3.fromRGB(255, 0, 0)
       Reason_1.TextScaled = true
       Reason_1.TextSize = 50.000
       Reason_1.TextWrapped = true
       Reason_1.TextYAlignment = Enum.TextYAlignment.Top

       Reason_2.Name = "Reason_2"
       Reason_2.Parent = WarningFrame
       Reason_2.AnchorPoint = Vector2.new(0.5, 0.5)
       Reason_2.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
       Reason_2.BackgroundTransparency = 1.000
       Reason_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
       Reason_2.BorderSizePixel = 0
       Reason_2.Position = UDim2.new(0.5, 0, 0.100000001, 0)
       Reason_2.Size = UDim2.new(0.949999988, 0, 0.100000001, 0)
       Reason_2.Visible = false
       Reason_2.Font = Enum.Font.Oswald
       Reason_2.Text = "-MessagePosted funktion is invalid"
       Reason_2.TextColor3 = Color3.fromRGB(255, 0, 0)
       Reason_2.TextScaled = true
       Reason_2.TextSize = 50.000
       Reason_2.TextWrapped = true
       Reason_2.TextYAlignment = Enum.TextYAlignment.Top

       Trollge.Name = "Trollge"
       Trollge.Parent = WarningFrame
       Trollge.AnchorPoint = Vector2.new(0.5, 0.5)
       Trollge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
       Trollge.BackgroundTransparency = 1.000
       Trollge.Position = UDim2.new(0.5, 0, 0.670000017, 0)
       Trollge.Size = UDim2.new(0.449999988, 0, 0.5, 0)
       Trollge.Image = "rbxassetid://10104834800"

       UIPadding.Parent = WarningFrame
       UIPadding.PaddingTop = UDim.new(0, 10)

       Exit.MouseButton1Click:Connect(function()
         local UpTween = Tween(Background, .2, "Quint", "Out", {Position = UDim2.new(0.5, 0, 0.45, 0)})
         local DownTween = Tween(Background, 1, "Quad", "Out", {Position = UDim2.new(0.5, 0, 2, 0)})
         UpTween:Play()
         UpTween.Completed:wait()
         DownTween:Play()
         DownTween.Completed:wait()
         ACLWarning:Destroy()
       end)
     end)()

     local ExitCooldown = function()
       wait(.5)
       local Tween = Tween(Bar, 3, "Quad", "InOut", {Size = UDim2.new(1, 0, 1, 0)})
       Tween:Play()
       Tween.Completed:wait()
       Loading:Destroy()
       Exit.Visible = true
     end

     local PlayerScripts = Player:WaitForChild("PlayerScripts")
     local ChatMain = PlayerScripts:FindFirstChild("ChatMain", true) or false

     if not ChatMain then
       local Timer = tick()
       repeat
         task.wait()
       until PlayerScripts:FindFirstChild("ChatMain", true) or tick() > (Timer + 3)
       ChatMain = PlayerScripts:FindFirstChild("ChatMain", true)
       if not ChatMain then
         ACLWarning.Enabled = true
         Reason_1.Visible = true
         ExitCooldown()
         return
       end
     end

     local PostMessage = require(ChatMain).MessagePosted

     if not PostMessage then
       ACLWarning.Enabled = true
       Reason_2.Visible = true
       ExitCooldown()
       return
     end

     local MessageEvent = Instance.new("BindableEvent")
     local OldFunctionHook
     OldFunctionHook = hookfunction(PostMessage.fire, function(self, Message)
       if not checkcaller() and self == PostMessage then
         MessageEvent:Fire(Message)
         return
       end
       return OldFunctionHook(self, Message)
     end)

     if setfflag then
       setfflag("AbuseReportScreenshot", "False")
       setfflag("AbuseReportScreenshotPercentage", "0")
     end

     ChatFixToggle = false
     task.spawn(function()
       wait(1)
       ACLWarning:Destroy()
     end)
     if OldSetting then
       StarterGui:SetCoreGuiEnabled(CoreGuiSettings[1], CoreGuiSettings[2])
     end
     Notify("🍭lulas anti-ban", "ANTI XHATLOGGER AND SKREENSHOT LOADED!", 15)
     print(string.format("Anti XHAT Logger has loaded in %s sekonds.", tostring(tick() - ACL_LoadTime):sub(1, 4)))
     wait(0.3)
     script.Parent.Parent:TweenPosition(UDim2.new(0.355, 0,1.291, 0), "Out", "Quint",1,true)
     wait(0.9)
     local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/FD2Team/archive/main/notificationtest"))();
     local Notify = AkaliNotif.Notify;
     Notify({
       Description = "Anti ban/anti xhatlogger has been ran.";
       Duration = 5;

     });
   end)
 end
 coroutine.wrap(CPNQ_fake_script)()
 local function OZEERJ_fake_script() -- TextButton_2.LocalScript 
   local script = Instance.new('LocalScript', TextButton_2)

   script.Parent.MouseButton1Click:Connect(function()
   script.Parent.Parent:TweenPosition(UDim2.new(0.355, 0,1.291, 0), "Out", "Quint",1,true)
   wait(0.9)
     script.Parent.Parent.Parent:Destroy()
     end)
 end
 coroutine.wrap(OZEERJ_fake_script)()
 local function ELJBIKO_fake_script() -- Frame.LocalScript 
   local script = Instance.new('LocalScript', Frame)

   script.Parent.Position = UDim2.new(0.355, 0,-1.291, 0)

   script.Parent:TweenPosition(UDim2.new(0.354, 0,0.316, 0), "Out", "Quint",1,true)


 end
 coroutine.wrap(ELJBIKO_fake_script)()
