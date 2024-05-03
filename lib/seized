--- services
local players		= game:GetService("Players")
local camera  		= game:GetService("Workspace").CurrentCamera
local tweenService	= game:GetService("TweenService")
local runService	= game:GetService("RunService")
local CoreGui       = game:GetService("CoreGui")
local UIS			= game:GetService("UserInputService")

-- vars
local localplayer 	= players.LocalPlayer
local mouse 		= localplayer:GetMouse()
local tweenInfo 	= TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local CurrentCamera = workspace.CurrentCamera
local wtvp 			= CurrentCamera.WorldToViewportPoint

local Library = {}

-- QOL Functions
function Library:validate(defaults, options)
	for i,v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
    return options
end

function Library:tween(object, goal, callback)
	local tween = tweenService:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

-- Main Library Start
function AddWindow(options)
    local options = options or {}
	options = Library:validate({
		name = "example"
	}, options or {})

    local menu = {}

    -----------------------------
        ---- Main Window  -----
    -----------------------------

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = CoreGui
    ScreenGui.Name = options.name

    local Container1 = Instance.new("Frame")
    Container1.Parent = ScreenGui
    Container1.Size = UDim2.new(0, 550, 0, 600)
    Container1.AnchorPoint = Vector2.new("0.5","0.5")
    Container1.Position = UDim2.new(0.5, -100, 0.5, 0)
    Container1.BorderSizePixel = 0
    Container1.Name = "Container1"

    local mousebutton = Instance.new("TextButton")
    mousebutton.Parent = Container1
    mousebutton.Size = UDim2.new(0, 1, 0, 1)
    mousebutton.BackgroundTransparency = 1
    mousebutton.TextTransparency = 1
    mousebutton.BorderSizePixel = 0
    mousebutton.Name = "mousebutton"
    mousebutton.Modal = true

    local UIGradient1 = Instance.new("UIGradient")
    UIGradient1.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(41, 49, 62)),
        ColorSequenceKeypoint.new(0.06, Color3.fromRGB(13, 18, 31)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(13, 18, 31))
    }

    UIGradient1.Rotation = 90 -- Verticle Gradient
    UIGradient1.Parent = Container1

    local UIStroke1 = Instance.new("UIStroke")
    UIStroke1.Thickness = 2
    UIStroke1.Color = Color3.fromRGB(0, 0, 0)
    UIStroke1.LineJoinMode = Enum.LineJoinMode.Miter
    UIStroke1.Parent = Container1
    UIStroke1.Name = "UIStroke1"

    -----------------------------
        ---- Top Bar  -----
    -----------------------------

    local TopBar = Instance.new("Frame")
    TopBar.Parent = Container1
    TopBar.Size = UDim2.new(1, 0, 0, 24)
    TopBar.AnchorPoint = Vector2.new(0,0)
    TopBar.BackgroundTransparency = 1
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BorderSizePixel = 0
    TopBar.Name = "TopBar"

    local TopText = Instance.new("TextLabel")
    TopText.Parent = TopBar
    TopText.Size = UDim2.new(1, 0, 1, 0)
    TopText.Position = UDim2.new(0, 10, 0, 1)
    TopText.BackgroundTransparency = 1
    TopText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
    TopText.Text = options.name
    TopText.TextColor3 = Color3.fromRGB(200, 200, 200)
    TopText.TextSize = 13
    TopText.TextXAlignment = Enum.TextXAlignment.Left
    TopText.Name = "TopText"

    -----------------------------
        -- Inner Container  --
    -----------------------------

    local InnerContainer = Instance.new("Frame")
    InnerContainer.Parent = Container1
    InnerContainer.Size = UDim2.new(1, -20, 1, -35)
    InnerContainer.AnchorPoint = Vector2.new(0.5,0.5)
    InnerContainer.Position = UDim2.new(0.5, 0, 0.5, 8)
    InnerContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InnerContainer.BackgroundTransparency = 0
    InnerContainer.BorderSizePixel = 0
    InnerContainer.Name = "InnerContainer"

    local UIGradient2 = Instance.new("UIGradient")
    UIGradient2.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(27, 30, 40)),
        ColorSequenceKeypoint.new(0.07, Color3.fromRGB(14, 17, 24)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(14, 17, 24))
    }

    UIGradient2.Rotation = 90 -- Verticle Gradient
    UIGradient2.Parent = InnerContainer

    local UIStroke2 = Instance.new("UIStroke")
    UIStroke2.Thickness = 2
    UIStroke2.Color = Color3.fromRGB(0, 0, 0)
    UIStroke2.LineJoinMode = Enum.LineJoinMode.Miter
    UIStroke2.Parent = InnerContainer
    UIStroke2.Name = "UIStroke2"

    -----------------------------
        ---- Tab Bar  -----
    -----------------------------
   
    local TabContainer = Instance.new("Frame")
	TabContainer.Parent = InnerContainer
	TabContainer.Size = UDim2.new(1, 0, 0, 25)
    TabContainer.AnchorPoint = Vector2.new(0,0)
	TabContainer.Position = UDim2.new(0,0,0,0)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Name = "TabContainer"

    local UIStroke3 = Instance.new("UIStroke")
    UIStroke3.Thickness = 2
    UIStroke3.Color = Color3.fromRGB(0, 0, 0)
    UIStroke3.LineJoinMode = Enum.LineJoinMode.Miter
    UIStroke3.Parent = TabContainer
    UIStroke3.Name = "UIStroke3"

	local TabLayout = Instance.new("UIListLayout")
	TabLayout.Parent = TabContainer
	TabLayout.FillDirection = Enum.FillDirection.Horizontal
	TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	TabLayout.Padding = UDim.new(0.01, 0)
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Name = "TabLayout"

    ----------------------------- Elements -----------------------------
    function menu:AddTab(options)
        options = Library:validate({
            name = "Example"
        }, options or {})

        local tab = {
			Hover = false,
			Active = false
		}
        
        local Tab = Instance.new("Frame")
        Tab.Parent = TabContainer
        Tab.Size = UDim2.new(0, 75, 1, 0)
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel = 0
        Tab.Name = options.name

        local ActiveLine = Instance.new("Frame")
        ActiveLine.Parent = Tab
        ActiveLine.Size = UDim2.new(1, 0, 0, 1)
        ActiveLine.AnchorPoint = Vector2.new(0,0)
        ActiveLine.Position = UDim2.new(0,0,0,0)
        ActiveLine.BackgroundColor3 = Color3.fromRGB(56, 149, 238)
        ActiveLine.BackgroundTransparency = 1
        ActiveLine.BorderSizePixel = 0
        ActiveLine.Name = "ActiveLine"

        local UIGradient3 = Instance.new("UIGradient")
        UIGradient3.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(56, 149, 238)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(36, 39, 49)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(36, 39, 49)),
        }
    
        UIGradient3.Rotation = 90 -- Verticle Gradient
        UIGradient3.Parent = Tab

        local TabText = Instance.new("TextLabel")
        TabText.Parent = Tab
        TabText.Size = UDim2.new(1, 0, 1, 0)
        TabText.BackgroundTransparency = 1
        TabText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Light)
        TabText.Text = options.name
        TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabText.TextSize = 12
        TabText.TextXAlignment = Enum.TextXAlignment.Center
        TabText.Name = "TabText"

        local UIStroke4 = Instance.new("UIStroke")
        UIStroke4.Thickness = 2
        UIStroke4.Color = Color3.fromRGB(0, 0, 0)
        UIStroke4.LineJoinMode = Enum.LineJoinMode.Miter
        UIStroke4.Parent = Tab
        UIStroke4.Name = "UIStroke4"

        local ContentContainer = Instance.new("Frame")
		ContentContainer.Parent = InnerContainer
		ContentContainer.Size = UDim2.new(1,0,1,-31)
		ContentContainer.AnchorPoint = Vector2.new(0,0)
		ContentContainer.Position = UDim2.new(0, 0, 0, 30)
        ContentContainer.Active = false
		ContentContainer.Visible = false
		ContentContainer.BackgroundTransparency = 1
		ContentContainer.BorderSizePixel = 0
		ContentContainer.Name = options.name

		local LeftContainer = Instance.new("Frame")
		LeftContainer.Parent = ContentContainer
        LeftContainer.Visible = false
		LeftContainer.Size = UDim2.new(0,257,1,0)
		LeftContainer.AnchorPoint = Vector2.new(0,0)
		LeftContainer.Position = UDim2.new(0, 0, 0,0)
		LeftContainer.BackgroundTransparency = 1
		LeftContainer.BorderSizePixel = 0
		LeftContainer.Name = "LeftContainer"

		local RightContainer = Instance.new("Frame")
		RightContainer.Parent = ContentContainer
        RightContainer.Visible = false
		RightContainer.Size = UDim2.new(0,257,1,0)
		RightContainer.AnchorPoint = Vector2.new(1,0)
		RightContainer.Position = UDim2.new(1, 0, 0,0)
		RightContainer.BackgroundTransparency = 1
		RightContainer.BorderSizePixel = 0
		RightContainer.Name = "RightContainer"

		-- Functionality
		do
			function tab:Activate()
				if not tab.Active then
					if menu.CurrentTab ~= nil then
						tab:Deactivate()
					end

					tab.Active = true
					ContentContainer.Active = true
					ContentContainer.Visible = true
					LeftContainer.Visible = true
					RightContainer.Visible = true
					Library:tween(ActiveLine, {BackgroundTransparency = 0})
                    Library:tween(Tab, {BackgroundTransparency = 0})
					menu.CurrentTab = Tab
				end
			end
			
			function tab:Deactivate()
				if tab.Active then

					tab.Active = false
					tab.Hover = false

					ContentContainer.Active = false
					ContentContainer.Visible = false

					LeftContainer.Visible = false
					RightContainer.Visible = false

					Library:tween(ActiveLine, {BackgroundTransparency = 1})
                    Library:tween(Tab, {BackgroundTransparency = 1})
				end
			end

			-- Logic
			Tab.MouseEnter:Connect(function()
				tab.Hover = true

				if not tab.Active then
					Library:tween(ActiveLine, {BackgroundTransparency = 0})
                    Library:tween(Tab, {BackgroundTransparency = 0})
				end
			end)
		
			Tab.MouseLeave:Connect(function()
				tab.Hover = false

				if not tab.Active then
					Library:tween(ActiveLine, {BackgroundTransparency = 1})
                    Library:tween(Tab, {BackgroundTransparency = 1})
				end
			end)

			TabContainer.MouseEnter:Connect(function()
				tab.MouseInside = true
			end)

			TabContainer.MouseLeave:Connect(function()
				tab.MouseInside = false
			end)

			UIS.InputBegan:Connect(function(input,gpe)
				if gpe then return end

				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if tab.Hover then
						tab:Activate()
					elseif tab.MouseInside then
						tab:Deactivate()
					end
				end
			end)

			if menu.CurrentTab == nil then
				tab:Activate()
			end
        end

        local LeftHeight = {}
		local RightHeight = {}

		local NewPos = 0

        function tab:AddSection(options)
            options = Library:validate({
				name = "Preview",
				side = "Left",
				height = "300"
			}, options or {})

            local section = {}
			-- Calculate Section Position
			do
				if options.side == "Left" then
					if LeftHeight then
						if #LeftHeight > 0 then
							NewPos = LeftHeight[1] + 30
						else
							NewPos = 15
						end
					else
						NewPos = 15
					end
				else
					if RightHeight then
						if #RightHeight > 0 then
							NewPos = RightHeight[1] + 30
						else
							NewPos = 15
						end
					else
						NewPos = 15
					end
				end
            end

            local Section = Instance.new("Frame")
			Section.Size = UDim2.new(1,0,0,options.height)
			Section.AnchorPoint = Vector2.new(0,0)
			Section.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
			Section.Position = UDim2.new(0, 0, 0, NewPos - 12)
			Section.BorderSizePixel = 0
			Section.Name = options.name
			Section.ZIndex = 2

            local UIStroke5 = Instance.new("UIStroke")
            UIStroke5.Thickness = 2
            UIStroke5.Color = Color3.fromRGB(0, 0, 0)
            UIStroke5.LineJoinMode = Enum.LineJoinMode.Miter
            UIStroke5.Parent = Section
            UIStroke5.Name = "UIStroke5"

			-- handle side picking
			if options.side == "Right" then
				Section.Parent = RightContainer
				table.insert(RightHeight, Section.Size.Y.Offset)
			else
				Section.Parent = LeftContainer
				table.insert(LeftHeight, Section.Size.Y.Offset)
			end

            local SectionBar = Instance.new("Frame")
            SectionBar.Parent = Section
            SectionBar.Size = UDim2.new(1, 0, 0, 24)
            SectionBar.BackgroundTransparency = 0
            SectionBar.BorderSizePixel = 0
            SectionBar.Name = "SectionBar"
            SectionBar.ZIndex = 2

            local HoverLine = Instance.new("Frame")
            HoverLine.Parent = SectionBar
            HoverLine.Size = UDim2.new(1, 0, 0, 1)
            HoverLine.AnchorPoint = Vector2.new(0,0)
            HoverLine.Position = UDim2.new(0,0,0,0)
            HoverLine.BackgroundColor3 = Color3.fromRGB(56, 149, 238)
            HoverLine.BackgroundTransparency = 0
            HoverLine.BorderSizePixel = 0
            HoverLine.Name = "HoverLine"
            HoverLine.ZIndex = 2

            local UIStroke6 = Instance.new("UIStroke")
            UIStroke6.Thickness = 2
            UIStroke6.Color = Color3.fromRGB(0, 0, 0)
            UIStroke6.LineJoinMode = Enum.LineJoinMode.Miter
            UIStroke6.Parent = SectionBar
            UIStroke6.Name = "UIStroke6"

            local UIGradient3 = Instance.new("UIGradient")
            UIGradient3.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(37, 47, 63)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(14, 18, 31))
            }
            UIGradient3.Rotation = 90 -- Verticle Gradient
            UIGradient3.Parent = SectionBar

            local SectionText = Instance.new("TextLabel")
            SectionText.Parent = SectionBar
            SectionText.Size = UDim2.new(1, 0, 1, 0)
            SectionText.Position = UDim2.new(0, 10, 0, 0)
            SectionText.BackgroundTransparency = 1
            SectionText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
            SectionText.Text = options.name
            SectionText.TextColor3 = Color3.fromRGB(200, 200, 200)
            SectionText.TextSize = 13
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            SectionText.Name = "SectionText"
            SectionText.ZIndex = 2

            -- Hovering
            do
                Section.MouseEnter:Connect(function()
                    Library:tween(HoverLine, {BackgroundTransparency = 0})
                end)
            
                Section.MouseLeave:Connect(function()
                    Library:tween(HoverLine, {BackgroundTransparency = 1})
                end) 
            end

            local ContentHolder = Instance.new("Frame")
            ContentHolder.Parent = Section
            ContentHolder.Size = UDim2.new(1,0,1,-53)
            ContentHolder.AnchorPoint = Vector2.new(0.5,0.5)
            ContentHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
            ContentHolder.BackgroundTransparency = 1
            ContentHolder.BorderSizePixel = 0
            ContentHolder.Name = "ContentHolder"
            ContentHolder.ZIndex = 2

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Parent = ContentHolder
            UIListLayout.FillDirection = Enum.FillDirection.Vertical
            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 8)

            local UIPadding = Instance.new("UIPadding")
            UIPadding.Parent = ContentHolder
            UIPadding.PaddingTop = UDim.new(0, 10)
            UIPadding.PaddingLeft = UDim.new(0, 15)
            UIPadding.PaddingRight = UDim.new(0, 15)
            UIPadding.PaddingBottom = UDim.new(0,10)

            function section:AddButton(options)
				options = Library:validate({
					name = "Example Button",
					callback = function()
                        print("Pressed")
                    end
				}, options or {})

				local button = {
                    Hover = false
                }

                local ButtonContainer = Instance.new("Frame")
				ButtonContainer.Size = UDim2.new(1,0,0,20)
                ButtonContainer.Parent = ContentHolder
                ButtonContainer.BackgroundTransparency = 1
				ButtonContainer.BorderSizePixel = 0
				ButtonContainer.Name = "ButtonContainer"
				ButtonContainer.ZIndex = 2

                local Button = Instance.new("Frame")
                Button.Parent = ButtonContainer
                Button.Size = UDim2.new(1, 0, 1, 0)
                Button.BackgroundColor3 = Color3.fromRGB(23, 26, 35)
                Button.BorderSizePixel = 0
                Button.Name = "Button"
                Button.ZIndex = 2

                local ButtonText = Instance.new("TextLabel")
                ButtonText.Parent = Button
                ButtonText.Size = UDim2.new(1, 0, 1, 0)
                ButtonText.BackgroundTransparency = 1
                ButtonText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Light)
                ButtonText.Text = options.name
                ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
                ButtonText.TextSize = 12
                ButtonText.TextXAlignment = Enum.TextXAlignment.Center
                ButtonText.Name = "TabText"
                ButtonText.ZIndex = 2

                local UIStroke6 = Instance.new("UIStroke")
                UIStroke6.Thickness = 2
                UIStroke6.Color = Color3.fromRGB(0, 0, 0)
                UIStroke6.LineJoinMode = Enum.LineJoinMode.Miter
                UIStroke6.Parent = Button
                UIStroke6.Name = "UIStroke4"

                -- Functionality
				do
					Button.MouseEnter:Connect(function()
						button.Hover = true
		
						Library:tween(ButtonText, {TextColor3 = Color3.fromRGB(56, 149, 238)})
					end)
				
					Button.MouseLeave:Connect(function()
						button.Hover = false

						Library:tween(ButtonText, {TextColor3 = Color3.fromRGB(255, 255, 255)})
					end)

					UIS.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if button.Hover then
								options.callback()
							end
						end
					end)
				end
                
                return section
            end

            function section:AddToggle(options)
                options = Library:validate({
					name = "Example Toggle",
                    default = false,
					callback = function(state)
                        print(state)
                    end
				}, options or {})

                local toggle = {
                    Hover = false,
                    state = options.default
                }

                local ToggleContainer = Instance.new("Frame")
				ToggleContainer.Size = UDim2.new(1,0,0,20)
                ToggleContainer.Parent = ContentHolder
                ToggleContainer.BackgroundTransparency = 1
				ToggleContainer.BorderSizePixel = 0
				ToggleContainer.Name = "ToggleContainer"
				ToggleContainer.ZIndex = 2

                local ToggleBox = Instance.new("Frame")
                ToggleBox.Parent = ToggleContainer
                ToggleBox.Size = UDim2.new(0, 10, 0, 10)
                ToggleBox.BackgroundColor3 = Color3.fromRGB(28, 31, 40)
                ToggleBox.AnchorPoint = Vector2.new(0, 0.5)
                ToggleBox.Position = UDim2.new(0, 0, 0.5, 0)
                ToggleBox.BorderSizePixel = 0
                ToggleBox.Name = "Toggle"
                ToggleBox.ZIndex = 2
                
                local UIStroke6 = Instance.new("UIStroke")
                UIStroke6.Thickness = 2
                UIStroke6.Color = Color3.fromRGB(0, 0, 0)
                UIStroke6.LineJoinMode = Enum.LineJoinMode.Miter
                UIStroke6.Parent = ToggleBox
                UIStroke6.Name = "UIStroke4"
                
                local ToggleText = Instance.new("TextLabel")
                ToggleText.Parent = ToggleContainer
                ToggleText.Size = UDim2.new(1, 0, 1, 0)
                ToggleText.Position = UDim2.new(0, 30, 0.5, -1)
                ToggleText.AnchorPoint = Vector2.new(0, 0.5)
                ToggleText.BackgroundTransparency = 1
                ToggleText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Light)
                ToggleText.Text = options.name
                ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleText.TextSize = 12
                ToggleText.TextXAlignment = Enum.TextXAlignment.Left
                ToggleText.Name = "TabText"
                ToggleText.ZIndex = 2

                -- Functionality
				do
					ToggleBox.MouseEnter:Connect(function()
						toggle.Hover = true
						if toggle.state ~= true then
							Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(56, 149, 238)})
						end
					end)
				
					ToggleBox.MouseLeave:Connect(function()
						toggle.Hover = false
						if toggle.state ~= true then
							Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(28, 31, 40)})
						end
					end)

					UIS.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if toggle.Hover then
								toggle.state = not toggle.state
								options.callback(toggle.state)
							end
						end
					end)

					if toggle.state == true then
						Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(56, 149, 238)})
					else
						Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(28, 31, 40)})
					end
				end

                return section
            end

            function section:AddSlider(options)
                options = Library:validate({
					name = "Example Toggle",
                    default = 0,
                    min = 0,
                    max = 100,
					callback = function(value)
                        print(value)
                    end
				}, options or {})

                local slider = {
					MouseDown = false,
					Hover = false,
					Connection = nil
				}

                options.value = 0
				options.default = options.default or options.min

                local SliderContainer = Instance.new("Frame")
				SliderContainer.Size = UDim2.new(1,0,0,25)
                SliderContainer.Parent = ContentHolder
                SliderContainer.BackgroundTransparency = 1
				SliderContainer.BorderSizePixel = 0
				SliderContainer.Name = "SliderContainer"
				SliderContainer.ZIndex = 2
                
                local SliderText = Instance.new("TextLabel")
                SliderText.Parent = SliderContainer
                SliderText.Size = UDim2.new(1, 0, 0.5, 0)
                SliderText.Position = UDim2.new(0, 0, 0, -4)
                SliderText.BackgroundTransparency = 1
                SliderText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Light)
                SliderText.Text = options.name
                SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderText.TextSize = 12
                SliderText.TextXAlignment = Enum.TextXAlignment.Left
                SliderText.Name = "TabText"
                SliderText.ZIndex = 2

                local SliderBackground = Instance.new("Frame")
                SliderBackground.Parent = SliderContainer
                SliderBackground.Size = UDim2.new(1, 0, 0.3, 0)
                SliderBackground.AnchorPoint = Vector2.new(0, 1)
                SliderBackground.Position = UDim2.new(0, 0, 1, -6)
                SliderBackground.BackgroundColor3 = Color3.fromRGB(28, 31, 40)
                SliderBackground.BorderSizePixel = 0
                SliderBackground.Name = "SliderBackground"
                SliderBackground.ZIndex = 2

                local SliderBar = Instance.new("Frame")
				SliderBar.Size = UDim2.new(1,-50,1,0)
				SliderBar.Parent = SliderBackground
				SliderBar.BackgroundColor3 = Color3.fromRGB(56, 149, 238)
				SliderBar.BorderSizePixel = 0
				SliderBar.Name = "SliderBar"
				SliderBar.ZIndex = 3

                local SliderValue = Instance.new("TextLabel")
				SliderValue.Size = UDim2.new(0,10,0,10)
				SliderValue.Parent = SliderBar
				SliderValue.TextXAlignment = Enum.TextXAlignment.Center
				SliderValue.Position = UDim2.new(1, -5, 0, 8)
				SliderValue.BackgroundTransparency = 1
				SliderValue.FontFace = Font.fromId(12187362578, Enum.FontWeight.ExtraBold)
				SliderValue.Text = options.value
				SliderValue.TextColor3 = Color3.fromRGB(150, 150, 150)
				SliderValue.TextSize = 13
				SliderValue.Name = options.name
				SliderValue.ZIndex = 4

                local ValueOutline = Instance.new("UIStroke")
				ValueOutline.Thickness = 1 -- Set the thickness of the outline
				ValueOutline.Color = Color3.new(0, 0, 0) -- Set the color of the outline
				ValueOutline.Parent = SliderValue

                local SliderStroke = Instance.new("UIStroke")
				SliderStroke.Parent = SliderBackground
				SliderStroke.Thickness = 1
				SliderStroke.Color = Color3.fromRGB(18, 18, 24)
            
                    
                -- Methods

				function slider:SetValue(v)
					if v == nil then
						local output = (mouse.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X
						local slidervalue = math.clamp(math.round(output * (options.max - options.min) + options.min), options.min, options.max)
				
						SliderValue.Text = slidervalue
						SliderBar.Size = UDim2.fromScale((slidervalue - options.min) / (options.max - options.min), 1)
					end
					options.callback(slider:GetValue())
				end

				function slider:GetValue()
					return tonumber(SliderValue.Text)
				end

				SliderBar.Size = UDim2.fromScale((options.default - options.min) / (options.max - options.min), 1)
				SliderValue.Text = options.default

				-- Functionality
				do
					SliderBackground.MouseEnter:Connect(function()
						slider.Hover = true
						Library:tween(SliderValue, {TextColor3 = Color3.fromRGB(56, 149, 238)})
					end)
					
					SliderBackground.MouseLeave:Connect(function()
						slider.Hover = false
						Library:tween(SliderValue, {TextColor3 = Color3.fromRGB(150, 150, 150)})
					end)
					
					UIS.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and slider.Hover then
							slider.MouseDown = true
							-- slider value
							if not slider.Connection then
								slider.Connection = runService.RenderStepped:Connect(function()
									slider:SetValue()
                                    if not slider.Hover then
                                        Library:tween(SliderValue, {TextColor3 = Color3.fromRGB(56, 149, 238)})
                                    end
								end)
							end
						end
					end)
					
					UIS.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							slider.MouseDown = false
							slider.Hover = false
							-- Stop slider value
							if slider.Connection then
								slider.Connection:Disconnect()
                                if not slider.Hover then
                                    Library:tween(SliderValue, {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end
							end
							slider.Connection = nil
						end
					end)
				end

                return section
            end

            function section:AddDropdown(options)
                options = Library:validate({
					name = "Example Dropdown",
					list = {"Example 1", "Example 2", "Example 3", "Example 4"},
					default = 1,
					callback = function(active)
						print(active)
					end
				}, options or {})

                options.default = options.default or 1

				local dropdown = {
					Hover = false,
					active = {options.list[options.default]},
					state = false
				}

                local DropdownContainer = Instance.new("Frame")
				DropdownContainer.Size = UDim2.new(1,0,0,36)
				DropdownContainer.Position = UDim2.new(0, 0, 0, 0)
				DropdownContainer.Parent = ContentHolder
				DropdownContainer.AnchorPoint = Vector2.new(0.5,0)
				DropdownContainer.BackgroundTransparency = 1
				DropdownContainer.BorderSizePixel = 0
				DropdownContainer.Name = "DropdownContainer"
				DropdownContainer.ZIndex = 4

                local DropdownText = Instance.new("TextLabel")
				DropdownText.Size = UDim2.new(1,0,0,14)
				DropdownText.Parent = DropdownContainer
                DropdownText.Position = UDim2.new(0, 0, 0, 0)
				DropdownText.BackgroundTransparency = 1
				DropdownText.TextXAlignment = Enum.TextXAlignment.Left
				DropdownText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
				DropdownText.Text = options.name
				DropdownText.TextColor3 = Color3.fromRGB(255,255,255)
				DropdownText.TextSize = 13
				DropdownText.Name = options.name
				DropdownText.ZIndex = 4

                local ActiveChoice = Instance.new("Frame")
				ActiveChoice.Size = UDim2.new(1,0,0.55,0)
				ActiveChoice.Position = UDim2.new(0, 0, 1, 0)
                ActiveChoice.AnchorPoint = Vector2.new(0,1)
				ActiveChoice.Parent = DropdownContainer
				ActiveChoice.BackgroundColor3 = Color3.fromRGB(23, 26, 35)
                ActiveChoice.BorderSizePixel = 0
				ActiveChoice.Name = "ActiveChoice"
				ActiveChoice.ZIndex = 4

                local UIStroke7 = Instance.new("UIStroke")
                UIStroke7.Thickness = 2
                UIStroke7.Color = Color3.fromRGB(0, 0, 0)
                UIStroke7.LineJoinMode = Enum.LineJoinMode.Miter
                UIStroke7.Parent = ActiveChoice
                UIStroke7.Name = "UIStroke7"

                local ActiveText = Instance.new("TextLabel")
				ActiveText.Size = UDim2.new(1,0,0,0)
				ActiveText.Parent = ActiveChoice
				ActiveText.Position = UDim2.new(0.5, 0, 0.5, 0)
                ActiveText.AnchorPoint = Vector2.new(0.5, 0.5)
				ActiveText.BackgroundTransparency = 1
				ActiveText.TextXAlignment = Enum.TextXAlignment.Center
				ActiveText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
				ActiveText.Text = "Active"
				ActiveText.TextColor3 = Color3.fromRGB(255, 255, 255)
				ActiveText.TextSize = 13
				ActiveText.Name = "DropdownText"
				ActiveText.ZIndex = 4

				local ChoiceHolder = Instance.new("Frame")
				ChoiceHolder.Size = UDim2.new(1,0,0,0)
				ChoiceHolder.Position = UDim2.new(0.5, 0, 0, 21)
				ChoiceHolder.Parent = ActiveChoice
				ChoiceHolder.AnchorPoint = Vector2.new(0.5,0)
				ChoiceHolder.BackgroundColor3 = Color3.fromRGB(23, 26, 35)
				ChoiceHolder.Visible = false
				ChoiceHolder.BorderSizePixel = 0
				ChoiceHolder.ZIndex = 4

				local ChoiceLayout = Instance.new("UIListLayout")
				ChoiceLayout.Parent = ChoiceHolder
				ChoiceLayout.SortOrder = Enum.SortOrder.LayoutOrder
				ChoiceLayout.FillDirection = Enum.FillDirection.Vertical
				ChoiceLayout.Padding = UDim.new(0, 0)
				ChoiceLayout.Name = "ChoiceLayout"

				function dropdown:AddChoice(name)
					local choice = {
						Name = name,
						Hover = false,
						state = false
					}

					if dropdown.active == choice.Name then
						choice.state = true
					end

					ChoiceHolder.Size = UDim2.new(1,0,0,ChoiceHolder.Size.Y.Offset)

					local Choice = Instance.new("Frame")
					Choice.Size = UDim2.new(1,0,0,20)
					Choice.Parent = ChoiceHolder
					Choice.AnchorPoint = Vector2.new(0.5,0)
					Choice.BackgroundColor3 = Color3.fromRGB(23, 26, 35)
					Choice.BorderSizePixel = 0
					Choice.ZIndex = 4

					local ChoiceText = Instance.new("TextLabel")
					ChoiceText.Size = UDim2.new(1,0,1,0)
					ChoiceText.Parent = Choice
					ChoiceText.AnchorPoint = Vector2.new(0.5,0)
					ChoiceText.Position = UDim2.new(0.5, 1, 0, 0)
					ChoiceText.BackgroundTransparency = 1
					ChoiceText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
					ChoiceText.Text = name
					ChoiceText.TextColor3 = Color3.fromRGB(255,255,255)
					ChoiceText.TextSize = 12
					ChoiceText.Name = name
					ChoiceText.ZIndex = 4

					for i, name in ipairs(dropdown.active) do -- Handle Default Choice
						if name == choice.Name then
							choice.state = true
							ActiveText.Text = table.concat(dropdown.active, ", ")
							Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(56, 149, 238)})
							options.callback(ActiveText.Text)
							break
						end
					end

					-- Choice Functionality
					do
						Choice.MouseEnter:Connect(function()
							if choice.state ~= true then
								Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(56, 149, 238)})
							end
							choice.Hover = true
						end)
					
						Choice.MouseLeave:Connect(function()
							if choice.state ~= true then
								Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(255,255, 255)})
							end
							choice.Hover = false
						end)

						UIS.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								if choice.Hover == true then
									choice.state = not choice.state
									if choice.state == true then
										Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(56, 149, 238)})
										table.insert(dropdown.active, choice.Name)
										ActiveText.Text = table.concat(dropdown.active, ", ")
										options.callback(ActiveText.Text)
									else
										Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(255, 255, 255)})
										for i, name in ipairs(dropdown.active) do
											if name == choice.Name then
												table.remove(dropdown.active, i)
												ActiveText.Text = table.concat(dropdown.active, ", ")
												options.callback(ActiveText.Text)
												break
											end
										end
									end
								end
							end
						end)

					end
				end -- dropdown:AddChoice

				for _,v in pairs(options.list) do
					dropdown:AddChoice(v)
				end

				-- Dropdown Functionality
				do
					ActiveChoice.MouseEnter:Connect(function()
						dropdown.Hover = true
						if dropdown.state ~= true then
							Library:tween(ActiveText, {TextColor3 = Color3.fromRGB(56, 149, 238)})
						end
					end)
				
					ActiveChoice.MouseLeave:Connect(function()
						dropdown.Hover = false
						if dropdown.state ~= true then
							Library:tween(ActiveText, {TextColor3 = Color3.fromRGB(255, 255, 255)})
						end
					end)

					UIS.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if dropdown.Hover then
								dropdown.state = not dropdown.state
								ChoiceHolder.Visible = dropdown.state
								if dropdown.state == true then
									DropdownContainer.Size = UDim2.new(1,0,0,ChoiceHolder.Size.Y.Offset + 40)
								else
									DropdownContainer.Size = UDim2.new(1,0,0,40)
								end
							end
						end
					end)

					if dropdown.state == true then
						Library:tween(ActiveText, {TextColor3 = Color3.fromRGB(56, 149, 238)})
					else
						Library:tween(ActiveText, {TextColor3 = Color3.fromRGB(255,255,255)})
					end
				end

                return section
            end

            return section
        end



        return tab
    end -- AddTab

    -- Destroy menu
	UIS.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.M then
			ScreenGui:Destroy()
		end
	end)

    -- Drag GUI
	do 

		local container = {
			Hover = false
		}

		-- This prevents it from dragging on elements like sliders and colorpickers.
		InnerContainer.MouseEnter:Connect(function()
			container.Hover = true
		end)
	
		InnerContainer.MouseLeave:Connect(function()
			container.Hover = false
		end)

		local dragging
		local dragInput
		local dragStart
		local startPos

		local function update(input)
			if container.Hover == false then
				local delta = input.Position - dragStart
				Container1.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end

		Container1.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = Container1.Position
				
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		Container1.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				dragInput = input
			end
		end)

		UIS.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)
	end

	-- Hide GUI
	local GUIToggle = true -- Variable to track visibility state

	UIS.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.RightShift then
			GUIToggle = not GUIToggle
			Container1.Visible = GUIToggle
			Container1.Active = GUIToggle
		end
	end)

    return menu
end
