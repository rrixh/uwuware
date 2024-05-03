--- services
local players		= game:GetService("Players")
local tweenService	= game:GetService("TweenService")
local runService	= game:GetService("RunService")
local coreGui		= game:GetService("CoreGui")
local UIS			= game:GetService("UserInputService")

-- vars
local localplayer 	= players.LocalPlayer
local mouse 		= localplayer:GetMouse()
local tweenInfo 	= TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

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
function Library:Init(options)
	local options = options or {}
	options = Library:validate({
		name = "reality.new"
	}, options or {})

	local GUI = {
		CurrentTab = nil
	}

	-- Main
    local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = coreGui
	ScreenGui.Name = options.name

    local Container1 = Instance.new("Frame")
	Container1.Parent = ScreenGui
    Container1.Size = UDim2.new(0, 750, 0, 480)
	Container1.AnchorPoint = Vector2.new("0.5","0.5")
    Container1.Position = UDim2.new(0.5, -100, 0.5, -50)
    Container1.BackgroundColor3 = Color3.fromRGB(39, 39, 47) 
    Container1.BorderSizePixel = 0
	Container1.Name = "Container1"
	
	local stroke1 = Instance.new("UIStroke")
	stroke1.Thickness = 2
	stroke1.Color = Color3.fromRGB(60, 60, 70)
	stroke1.LineJoinMode = Enum.LineJoinMode.Miter
	stroke1.Parent = Container1
	stroke1.Name = "stroke1"

	local Container2 = Instance.new("Frame")
	Container2.Parent = Container1
	Container2.Size = UDim2.new(0, 740, 0, 470)
    Container2.AnchorPoint = Vector2.new(.5,.5)
	Container2.Position = UDim2.new(.5, 0, .5, 0)
    Container2.BackgroundColor3 = Color3.fromRGB(23, 23, 30) 
    Container2.BorderSizePixel = 0
	Container2.Name = "Container2"

	local Container2Line = Instance.new("Frame")
	Container2Line.Parent = Container2
	Container2Line.Size = UDim2.new(1, -4, 0, 2)
	Container2Line.Position = UDim2.new(1, -2, 0, 4)
	Container2Line.AnchorPoint = Vector2.new(1, 1)
    Container2Line.BackgroundColor3 = Color3.fromRGB(206, 115, 136) 
    Container2Line.BorderSizePixel = 0
	Container2Line.Name = "Container2Line"

	local TabContainer = Instance.new("Frame")
	TabContainer.Parent = Container2
	TabContainer.Size = UDim2.new(0, 710, 0, 29)
    TabContainer.AnchorPoint = Vector2.new(.5,.5)
	TabContainer.Position = UDim2.new(0.5,0,0.5,-203)
    TabContainer.BackgroundTransparency = 1

    TabContainer.BorderSizePixel = 0
	TabContainer.Name = "TabContainer"

	local ContainerStroke = Instance.new("UIStroke")
	ContainerStroke.Thickness = 1.25
	ContainerStroke.Color = Color3.fromRGB(59, 59, 69)
	ContainerStroke.LineJoinMode = Enum.LineJoinMode.Miter
	ContainerStroke.Parent = TabContainer
	ContainerStroke.Name = "TabStroke"

	local TabLayout = Instance.new("UIListLayout")
	TabLayout.Parent = TabContainer
	TabLayout.FillDirection = Enum.FillDirection.Horizontal
	TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	TabLayout.Padding = UDim.new(0.0, 0)
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Name = "TabLayout"

	local stroke2 = Instance.new("UIStroke")
	stroke2.Thickness = 1.25	
	stroke2.Color = Color3.fromRGB(59, 59, 69)
	stroke2.LineJoinMode = Enum.LineJoinMode.Miter
	stroke2.Parent = Container2
	stroke2.Name = "stroke2"

	local Container3 = Instance.new("Frame")
	Container3.Parent = Container2
	Container3.Size = UDim2.new(0, 710, 0, 410)
    Container3.AnchorPoint = Vector2.new(.5,.5)
	Container3.Position = UDim2.new(.5, 0, .5, 19)
    Container3.BackgroundColor3 = Color3.fromRGB(32, 32, 38) 
    Container3.BorderSizePixel = 0
	Container3.Name = "Container3"

	local stroke3 = Instance.new("UIStroke")
	stroke3.Thickness = 1.25
	stroke3.Color = Color3.fromRGB(61, 61, 76)
	stroke3.LineJoinMode = Enum.LineJoinMode.Miter
	stroke3.Parent = Container3
	stroke3.Name = "stroke3"

	function GUI:AddTab(options)
		options = Library:validate({
			name = "Preview",
		}, options or {})

		local tab = {
			Hover = false,
			Active = false
		}

		local Tab = Instance.new("Frame")
		Tab.Parent = TabContainer
		Tab.Size = UDim2.new(1, 0, 1, 0)
		Tab.BackgroundColor3 = Color3.fromRGB(61, 61, 65) 
		Tab.BorderSizePixel = 0
		Tab.Name = options.name

		local UIGradient = Instance.new("UIGradient")
		UIGradient.Transparency = NumberSequence.new{
			NumberSequenceKeypoint.new(0.00, 0.00),
			NumberSequenceKeypoint.new(0.1, 0.50),
			NumberSequenceKeypoint.new(1.00, 1)
		}
		UIGradient.Rotation = 90 -- Verticle Gradient
		UIGradient.Parent = Tab
		
		local TabText = Instance.new("TextLabel")
		TabText.Parent = Tab
		TabText.Size = UDim2.new(1, 0, 1, 0)
		TabText.BackgroundTransparency = 1
		TabText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
		TabText.Text = options.name
		TabText.TextColor3 = Color3.fromRGB(200, 200, 200)
		TabText.TextSize = 14
		TabText.TextXAlignment = Enum.TextXAlignment.Center
		TabText.Name = "TabText"

		local TabStroke = Instance.new("UIStroke")
		TabStroke.Thickness = 1
		TabStroke.Color = Color3.fromRGB(61, 61, 76)
		TabStroke.LineJoinMode = Enum.LineJoinMode.Miter
		TabStroke.Parent = Tab
		TabStroke.Name = "TabStroke"

		local TabLine = Instance.new("Frame")
		TabLine.Parent = Tab
		TabLine.Size = UDim2.new(1, -4, 0, 2)
		TabLine.Position = UDim2.new(1, -2, 1, 0)
		TabLine.AnchorPoint = Vector2.new(1, 1)
		TabLine.BackgroundColor3 = Color3.fromRGB(206, 115, 136)
		TabLine.BackgroundTransparency = 1
		TabLine.BorderSizePixel = 0
		TabLine.Name = "TabLine"

		local ContentContainer = Instance.new("Frame")
		ContentContainer.Parent = Container3
		ContentContainer.Size = UDim2.new(1,0,1,0)
		ContentContainer.AnchorPoint = Vector2.new(0,0)
		ContentContainer.Position = UDim2.new(0, 0, 0,0)
		ContentContainer.BackgroundColor3 = Color3.fromRGB(32, 32, 38) 
		ContentContainer.BorderSizePixel = 0
		ContentContainer.Active = false
		ContentContainer.Visible = false
		ContentContainer.Name = options.name
		ContentContainer.ZIndex = 2

		local LeftContainer = Instance.new("Frame")
		LeftContainer.Parent = ContentContainer
		LeftContainer.Visible = false
		LeftContainer.Size = UDim2.new(0,334,1,-5)
		LeftContainer.AnchorPoint = Vector2.new(0,0)
		LeftContainer.Position = UDim2.new(0, 10, 0,0)
		LeftContainer.BackgroundTransparency = 1
		LeftContainer.BorderSizePixel = 0
		LeftContainer.Name = "LeftContainer"
		LeftContainer.ZIndex = 2

		local RightContainer = Instance.new("Frame")
		RightContainer.Parent = ContentContainer
		RightContainer.Visible = false
		RightContainer.Size = UDim2.new(0,334,1,-5)
		RightContainer.AnchorPoint = Vector2.new(1,0)
		RightContainer.Position = UDim2.new(1, -10, 0,0)
		RightContainer.BackgroundTransparency = 1
		RightContainer.BorderSizePixel = 0
		RightContainer.Name = "RightContainer"
		RightContainer.ZIndex = 2

		-- Dynamic Tab Sizing  [ NEEDS IMPROVING ]
		do
			local tabCount = 0
			for _, tab in ipairs(TabContainer:GetChildren()) do
				if tab:IsA("Frame") then
					tabCount = tabCount + 1
				end
			end
			local finalValue = 710 / tabCount
			for _, tab in ipairs(TabContainer:GetChildren()) do
				if tab:IsA("Frame") then
					tab.Size = UDim2.new(0, finalValue, 1, 0)
				end
			end
		end

		-- Functionality
		do
			function tab:Activate()
				if not tab.Active then
					if GUI.CurrentTab ~= nil then
						tab:Deactivate()
					end

					tab.Active = true
					ContentContainer.Active = true
					ContentContainer.Visible = true
					LeftContainer.Visible = true
					RightContainer.Visible = true
					Library:tween(TabStroke, {Color = Color3.fromRGB(61, 61, 76)})
					Library:tween(TabLine, {BackgroundTransparency = 0})

					GUI.CurrentTab = Tab
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

					Library:tween(TabStroke, {Color = Color3.fromRGB(61, 61, 76)})
					Library:tween(TabLine, {BackgroundTransparency = 1})
				end
			end

			-- Logic
			Tab.MouseEnter:Connect(function()
				tab.Hover = true

				if not tab.Active then
					Library:tween(TabText, {TextColor3 = Color3.fromRGB(231, 231, 231)})
					Library:tween(TabLine, {BackgroundTransparency = 0})
				end
			end)	
		
			Tab.MouseLeave:Connect(function()
				tab.Hover = false

				if not tab.Active then
					Library:tween(TabText, {TextColor3 = Color3.fromRGB(200, 200, 200)})
					Library:tween(TabLine, {BackgroundTransparency = 1})
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

			if GUI.CurrentTab == nil then
				tab:Activate()
			end
		end

		local LeftHeight = {}
		local RightHeight = {}

		local NewPos = 0
		-- Sections
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
			Section.BackgroundColor3 = Color3.fromRGB(27, 27, 34)
			Section.Position = UDim2.new(0, 0, 0, NewPos)
			Section.BorderSizePixel = 0
			Section.Name = options.name
			Section.ZIndex = 2

			-- handle side picking
			if options.side == "Right" then
				Section.Parent = RightContainer
				table.insert(RightHeight, Section.Size.Y.Offset)
			else
				Section.Parent = LeftContainer
				table.insert(LeftHeight, Section.Size.Y.Offset)
			end

			local SectionText = Instance.new("TextLabel")
			SectionText.Parent = Section
			SectionText.Size = UDim2.new(0, 0, 0, 1)
			SectionText.Position = UDim2.new(0, 30, 0, -2)
			SectionText.AnchorPoint = Vector2.new(1,0)
			SectionText.BackgroundTransparency = 1
			SectionText.TextXAlignment = Enum.TextXAlignment.Left
			SectionText.FontFace = Font.fromId(12187362578, Enum.FontWeight.SemiBold)
			SectionText.Text = options.name
			SectionText.TextColor3 = Color3.fromRGB(200, 200, 200)
			SectionText.TextSize = 13	
			SectionText.Name = "SectionText"
			SectionText.ZIndex = 3

			local Size = SectionText.TextBounds.X + 20
			local LineSize = Size / -1

			local SectionLine = Instance.new("Frame")
			SectionLine.Parent = Section
			SectionLine.Size = UDim2.new(0, LineSize, 0, 1)
			SectionLine.Position = UDim2.new(0, 20, 0, -1)
			SectionLine.AnchorPoint = Vector2.new(1, 0)
			SectionLine.BackgroundColor3 = Color3.fromRGB(27, 27, 34)
			SectionLine.BackgroundTransparency = 0
			SectionLine.BorderSizePixel = 0
			SectionLine.Name = "SectionLine"
			SectionLine.ZIndex = 2

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Thickness = 1
			UIStroke.Color = Color3.fromRGB(49, 49, 56)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Section
			UIStroke.Name = "UIStroke"

			local SubContainer = Instance.new("Frame")
			SubContainer.Parent = Section
			SubContainer.Size = UDim2.new(0, 304, 0, 30)
			SubContainer.AnchorPoint = Vector2.new(0,0)
			SubContainer.Position = UDim2.new(0, 15, 0, 10)
			SubContainer.BackgroundColor3 = Color3.fromRGB(23, 23, 30)
			SubContainer.BackgroundTransparency = 1
			SubContainer.BorderSizePixel = 0
			SubContainer.Name = "SubContainer"
			SubContainer.ZIndex = 3
			SubContainer.Active = true

			local SectionTabLayout = Instance.new("UIListLayout")
			SectionTabLayout.Parent = SubContainer
			SectionTabLayout.FillDirection = Enum.FillDirection.Horizontal
			SectionTabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			SectionTabLayout.Padding = UDim.new(0.0, 0)
			SectionTabLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SectionTabLayout.Name = "SectionTabLayout"

			local SectionContentContainer = Instance.new("Frame")
			SectionContentContainer.Parent = Section
			SectionContentContainer.Size = UDim2.new(1,-80,1,-30)
			SectionContentContainer.AnchorPoint = Vector2.new(0,0)
			SectionContentContainer.Position = UDim2.new(0, 40, 0,15)
			SectionContentContainer.BackgroundTransparency = 1
			SectionContentContainer.BorderSizePixel = 0
			SectionContentContainer.Name = "SectionContentContainer"
			SectionContentContainer.ZIndex = 3

			local SectionContentLayout = Instance.new("UIListLayout")
			SectionContentLayout.Parent = SectionContentContainer
			SectionContentLayout.FillDirection = Enum.FillDirection.Vertical
			SectionContentLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			SectionContentLayout.Padding = UDim.new(0, 8)
			SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SectionContentLayout.Name = "ContentLayout"

			_G.TabsExist = false -- No tabs exist until section:AddTab is called

			function section:AddTab(options)
				options = Library:validate({
					name = "Preview"
				}, options or {})

				local sectiontab = {
					Hover = false,
					Active = false
				}

				local TabGUI = {
					CurrentTab = nil
				}
				
				_G.TabsExist = true

				SubContainer.BackgroundTransparency = 0
				SectionContentContainer:Destroy()

				local SectionTab = Instance.new("Frame")
				SectionTab.Parent = SubContainer
				SectionTab.Size = UDim2.new(1, 0, 1, 0)
				SectionTab.BackgroundColor3 = Color3.fromRGB(61, 61, 65) 
				SectionTab.BorderSizePixel = 0
				SectionTab.Name = options.name
				SectionTab.ZIndex = 3
		
				local UIGradient = Instance.new("UIGradient")
				UIGradient.Transparency = NumberSequence.new{
					NumberSequenceKeypoint.new(0.00, 0.20),
					NumberSequenceKeypoint.new(0.4, 0.50),
					NumberSequenceKeypoint.new(1.00, 1)
				}
				UIGradient.Rotation = 90
				UIGradient.Parent = SectionTab
				
				local SectionTabText = Instance.new("TextLabel")
				SectionTabText.Parent = SectionTab
				SectionTabText.Size = UDim2.new(1, 0, 1, 0)
				SectionTabText.BackgroundTransparency = 1
				SectionTabText.Font = Enum.Font.Code
				SectionTabText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
				SectionTabText.Text = options.name
				SectionTabText.TextColor3 = Color3.fromRGB(200, 200, 200)
				SectionTabText.TextSize = 14
				SectionTabText.TextXAlignment = Enum.TextXAlignment.Center
				SectionTabText.Name = "SectionText"
				SectionTabText.ZIndex = 3
		
				local SectionTabStroke = Instance.new("UIStroke")
				SectionTabStroke.Thickness = 1
				SectionTabStroke.Color = Color3.fromRGB(61, 61, 76)
				SectionTabStroke.LineJoinMode = Enum.LineJoinMode.Miter
				SectionTabStroke.Parent = SectionTab
				SectionTabStroke.Name = "SectionStroke"
		
				local SectionTabLine = Instance.new("Frame")
				SectionTabLine.Parent = SectionTab
				SectionTabLine.Size = UDim2.new(1, -4, 0, 2)
				SectionTabLine.Position = UDim2.new(1, -2, 1, 0)
				SectionTabLine.AnchorPoint = Vector2.new(1, 1)
				SectionTabLine.BackgroundColor3 = Color3.fromRGB(206, 115, 136)
				SectionTabLine.BackgroundTransparency = 1
				SectionTabLine.BorderSizePixel = 0
				SectionTabLine.Name = "SectionLine"
				SectionTabLine.ZIndex = 3

				-- Calculate Tab Size To Fit
				do
					local tabCount = 0
					for _, sectiontab in ipairs(SubContainer:GetChildren()) do
						if sectiontab:IsA("Frame") then
							tabCount = tabCount + 1
						end
					end
					
					local finalValue = 304 / tabCount
					for _, sectiontab in ipairs(SubContainer:GetChildren()) do
						if sectiontab:IsA("Frame") then
							sectiontab.Size = UDim2.new(0, finalValue, 1, 0)
						end
					end
				end

				local TabContentContainer = Instance.new("Frame")
				TabContentContainer.Parent = Section
				TabContentContainer.Size = UDim2.new(1,-80,1,-60)
				TabContentContainer.AnchorPoint = Vector2.new(0,0)
				TabContentContainer.Position = UDim2.new(0, 40, 0,50)
				TabContentContainer.BackgroundTransparency = 1
				TabContentContainer.BorderSizePixel = 0
				TabContentContainer.Active = false
				TabContentContainer.Visible = false
				TabContentContainer.Name = "TabContentContainer"
				TabContentContainer.ZIndex = 3

				_G.TabContentContainer = TabContentContainer

				-- Functionality
				do
					function sectiontab:Activate()
						if not sectiontab.Active then
							if TabGUI.CurrentTab ~= nil then
								sectiontab:Deactivate()
							end
					
							sectiontab.Active = true

							TabContentContainer.Active = true
							TabContentContainer.Visible = true

							Library:tween(SectionTabLine, {BackgroundTransparency = 0})
					
							TabGUI.CurrentTab = sectiontab
						end
					end

					function sectiontab:Deactivate()
						if sectiontab.Active then
					
							sectiontab.Active = false
							sectiontab.Hover = false
					
							TabContentContainer.Active = false
							TabContentContainer.Visible = false
					
							Library:tween(SectionTabLine, {BackgroundTransparency = 1})
						end
					end

					-- Logic
					SectionTab.MouseEnter:Connect(function()
						sectiontab.Hover = true

						if not sectiontab.Active then
							Library:tween(SectionTabText, {TextColor3 = Color3.fromRGB(231, 231, 231)})
							Library:tween(SectionTabLine, {BackgroundTransparency = 0})
						end
					end)
				
					SectionTab.MouseLeave:Connect(function()
						sectiontab.Hover = false

						if not sectiontab.Active then
							Library:tween(SectionTabText, {TextColor3 = Color3.fromRGB(200, 200, 200)})
							Library:tween(SectionTabLine, {BackgroundTransparency = 1})
						end
					end)

					SubContainer.MouseEnter:Connect(function()
						sectiontab.MouseInside = true
					end)
					
					SubContainer.MouseLeave:Connect(function()
						sectiontab.MouseInside = false
					end)

					UIS.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if sectiontab.Hover then
								sectiontab:Activate()
							elseif sectiontab.MouseInside then
								sectiontab:Deactivate()
							end
						end
					end)
				end

				local ContentLayout = Instance.new("UIListLayout")
				ContentLayout.Parent = TabContentContainer
				ContentLayout.FillDirection = Enum.FillDirection.Vertical
				ContentLayout.VerticalAlignment = Enum.VerticalAlignment.Top
				ContentLayout.Padding = UDim.new(0, 8)
				ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
				ContentLayout.Name = "ContentLayout"

				return section

			end -- section:AddTab

			function section:AddLabel(options)
				options = Library:validate({
					name = "Example Label"
				}, options or {})

				if _G.TabsExist == true then
					elementParent = _G.TabContentContainer
				else
					elementParent = SectionContentContainer
				end
				_G.elementparent = elementParent

				local LabelContainer = Instance.new("Frame")
				LabelContainer.Size = UDim2.new(1,0,0,15)
				LabelContainer.Parent = _G.elementparent
				LabelContainer.AnchorPoint = Vector2.new(0.5,0)
				LabelContainer.BackgroundTransparency = 1
				LabelContainer.BorderSizePixel = 0
				LabelContainer.Name = "LabelContainer"
				LabelContainer.ZIndex = 4
				
				local LabelLine = Instance.new("Frame")
				LabelLine.Parent = LabelContainer
				LabelLine.Size = UDim2.new(1,0,0,1)
				LabelLine.Position = UDim2.new(0,0,1,-1)
				LabelLine.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
				LabelLine.BorderSizePixel = 0
				LabelLine.Name = "LabelLine"
				LabelLine.ZIndex = 3

				local LabelText = Instance.new("TextLabel")
				LabelText.Position = UDim2.new(0,0,0,-4)
				LabelText.Size = UDim2.new(1,0,1,0)
				LabelText.Parent = LabelContainer
				LabelText.AnchorPoint = Vector2.new(0,0)
				LabelText.BackgroundTransparency = 1
				LabelText.BorderSizePixel = 0
				LabelText.TextXAlignment = Enum.TextXAlignment.Center
				LabelText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
				LabelText.Text = options.name
				LabelText.TextColor3 = Color3.fromRGB(200, 200, 200)
				LabelText.TextSize = 13
				LabelText.Name = options.name
				LabelText.ZIndex = 4
			end -- section:AddLabel

			function section:AddButton(options)
				options = Library:validate({
					name = "Example Button",
					callback = function() end
				}, options or {})

				local button = {}
				
				if _G.TabsExist == true then
					elementParent = _G.TabContentContainer
				else
					elementParent = SectionContentContainer
				end
				_G.elementparent = elementParent

				local ButtonContainer = Instance.new("Frame")
				ButtonContainer.Size = UDim2.new(1,0,0,20)
				ButtonContainer.Parent = _G.elementparent
				ButtonContainer.AnchorPoint = Vector2.new(0.5,0)
				ButtonContainer.BackgroundColor3 = Color3.fromRGB(39, 39, 46)
				ButtonContainer.BorderSizePixel = 0
				ButtonContainer.Name = "ButtonContainer"
				ButtonContainer.ZIndex = 4

				local ButtonText = Instance.new("TextLabel")
				ButtonText.Size = UDim2.new(1,0,1,0)
				ButtonText.Parent = ButtonContainer
				ButtonText.AnchorPoint = Vector2.new(0,0)
				ButtonText.BackgroundTransparency = 1
				ButtonText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
				ButtonText.Text = options.name
				ButtonText.TextColor3 = Color3.fromRGB(200, 200, 200)
				ButtonText.TextSize = 13
				ButtonText.Name = options.name
				ButtonText.ZIndex = 4

				local ButtonStroke = Instance.new("UIStroke")
				ButtonStroke.Parent = ButtonContainer
				ButtonStroke.Thickness = 1.5
				ButtonStroke.Color = Color3.fromRGB(18, 18, 24)
				
				-- Functionality
				do
					ButtonContainer.MouseEnter:Connect(function()
						button.Hover = true
		
						Library:tween(ButtonText, {TextColor3 = Color3.fromRGB(255, 255, 255)})
						Library:tween(ButtonStroke, {Color = Color3.fromRGB(34,34,40)})
					end)
				
					ButtonContainer.MouseLeave:Connect(function()
						button.Hover = false

						Library:tween(ButtonText, {TextColor3 = Color3.fromRGB(200, 200, 200)})
						Library:tween(ButtonStroke, {Color = Color3.fromRGB(18, 18, 24)})
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
			end -- section:AddButton

			function section:AddToggle(options)
				options = Library:validate({
					name = "Example Toggle",
					state = false,
					callback = function() end
				}, options or {})

				local toggle = {}
				toggle.state = options.state

				if _G.TabsExist then
					elementParent = _G.TabContentContainer
				else
					elementParent = SectionContentContainer
				end
				_G.elementparent = elementParent

				local ToggleContainer = Instance.new("Frame")
				ToggleContainer.Size = UDim2.new(1,0,0,15)
				ToggleContainer.Parent = _G.elementparent
				ToggleContainer.AnchorPoint = Vector2.new(0.5,0)
				ToggleContainer.BackgroundTransparency = 1
				ToggleContainer.BorderSizePixel = 0
				ToggleContainer.Name = "ToggleContainer"
				ToggleContainer.ZIndex = 4

				local ToggleBox = Instance.new("Frame")
				ToggleBox.Size = UDim2.new(0,8,0,8)
				ToggleBox.Parent = ToggleContainer
				ToggleBox.Position = UDim2.new(0, 5, 0, 4)
				ToggleBox.BackgroundColor3 = Color3.fromRGB(75, 75, 86)
				ToggleBox.BackgroundTransparency = 0
				ToggleBox.BorderSizePixel = 0
				ToggleBox.Name = "ToggleContainer"
				ToggleBox.ZIndex = 4

				local ToggleStroke = Instance.new("UIStroke")
				ToggleStroke.Parent = ToggleBox
				ToggleStroke.Thickness = 2
				ToggleStroke.Color = Color3.fromRGB(18, 18, 24)

				local ToggleText = Instance.new("TextLabel")
				ToggleText.Size = UDim2.new(1,0,1,0)
				ToggleText.Parent = ToggleContainer
				ToggleText.TextXAlignment = Enum.TextXAlignment.Left
				ToggleText.Position = UDim2.new(0, 30, 0, -1)
				ToggleText.BackgroundTransparency = 1
				ToggleText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
				ToggleText.Text = options.name
				ToggleText.TextColor3 = Color3.fromRGB(150, 150, 150)
				ToggleText.TextSize = 13
				ToggleText.Name = options.name
				ToggleText.ZIndex = 4

				-- Functionality
				do
					ToggleBox.MouseEnter:Connect(function()
						toggle.Hover = true
						if toggle.state ~= true then
							Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(206, 115, 136)})
							Library:tween(ToggleStroke, {Color = Color3.fromRGB(0,0,0)})
						end
					end)
				
					ToggleBox.MouseLeave:Connect(function()
						toggle.Hover = false
						if toggle.state ~= true then
							Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(75, 75, 86)})
							Library:tween(ToggleStroke, {Color = Color3.fromRGB(18, 18, 24)})
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
						Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(206, 115, 136)})
					else
						Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(75, 75, 86)})
					end
				end

				return section
			end -- section:AddToggle
			
			function section:AddSlider(options)
				options = Library:validate({
					name = "Example Toggle",
					min = 0,
					max = 100,
					default = nil,
					callback = function(v)
						print(v)
					end
				}, options or {})

				local slider = {
					MouseDown = false,
					Hover = false,
					Connection = nil
				}

				if _G.TabsExist then
					elementParent = _G.TabContentContainer
				else
					elementParent = SectionContentContainer
				end
				_G.elementparent = elementParent

				options.value = 0
				options.default = options.default or options.min

				local SliderContainer = Instance.new("Frame")
				SliderContainer.Size = UDim2.new(1,0,0,25)
				SliderContainer.Parent = _G.elementparent
				SliderContainer.AnchorPoint = Vector2.new(0.5,0)
				SliderContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				SliderContainer.BackgroundTransparency = 1
				SliderContainer.BorderSizePixel = 0
				SliderContainer.Name = "SliderContainer"
				SliderContainer.ZIndex = 3

				local SliderBackground = Instance.new("Frame")
				SliderBackground.Size = UDim2.new(1,-20,0,8)
				SliderBackground.Parent = SliderContainer
				SliderBackground.AnchorPoint = Vector2.new(0,0)
				SliderBackground.Position = UDim2.new(0, 11, 0, 15)
				SliderBackground.BackgroundColor3 = Color3.fromRGB(39, 39, 46)
				SliderBackground.BorderSizePixel = 0
				SliderBackground.Name = "SliderBackground"
				SliderBackground.ZIndex = 3

				local MoveSlider = Instance.new("Frame")
				MoveSlider.Size = UDim2.new(1,-50,1,0)
				MoveSlider.Parent = SliderBackground
				MoveSlider.BackgroundColor3 = Color3.fromRGB(206, 115, 136)
				MoveSlider.BorderSizePixel = 0
				MoveSlider.Name = "MoveSlider"
				MoveSlider.ZIndex = 3

				local SliderValue = Instance.new("TextLabel")
				SliderValue.Size = UDim2.new(0,10,0,10)
				SliderValue.Parent = MoveSlider
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

				local SliderText = Instance.new("TextLabel")
				SliderText.Size = UDim2.new(1,0,1,0)
				SliderText.Parent = SliderContainer
				SliderText.TextXAlignment = Enum.TextXAlignment.Left
				SliderText.Position = UDim2.new(0, 12, 0, -6)
				SliderText.BackgroundTransparency = 1
				SliderText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
				SliderText.Text = options.name
				SliderText.TextColor3 = Color3.fromRGB(150, 150, 150)
				SliderText.TextSize = 12
				SliderText.Name = options.name
				SliderText.ZIndex = 4

				-- Methods

				function slider:SetValue(v)
					if v == nil then
						local output = (mouse.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X
						local slidervalue = math.clamp(math.round(output * (options.max - options.min) + options.min), options.min, options.max)
				
						SliderValue.Text = slidervalue
						MoveSlider.Size = UDim2.fromScale((slidervalue - options.min) / (options.max - options.min), 1)
					end
					options.callback(slider:GetValue())
				end

				function slider:GetValue()
					return tonumber(SliderValue.Text)
				end

				MoveSlider.Size = UDim2.fromScale((options.default - options.min) / (options.max - options.min), 1)
				SliderValue.Text = options.default

				-- Functionality
				do
					SliderBackground.MouseEnter:Connect(function()
						slider.Hover = true
						Library:tween(SliderValue, {TextColor3 = Color3.fromRGB(255, 255, 255)})
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
							end
							slider.Connection = nil
						end
					end)
				end
				
			end -- section:AddSlider

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

				if _G.TabsExist then
					elementParent = _G.TabContentContainer
				else
					elementParent = SectionContentContainer
				end
				_G.elementparent = elementParent

				local DropdownContainer = Instance.new("Frame")
				DropdownContainer.Size = UDim2.new(1,0,0,40)
				DropdownContainer.Position = UDim2.new(0, 0, 0, 0)
				DropdownContainer.Parent = _G.elementparent
				DropdownContainer.AnchorPoint = Vector2.new(0.5,0)
				DropdownContainer.BackgroundTransparency = 1
				DropdownContainer.BorderSizePixel = 0
				DropdownContainer.Name = "DropdownContainer"
				DropdownContainer.ZIndex = 4

				local DropdownText = Instance.new("TextLabel")
				DropdownText.Size = UDim2.new(1,0,0,0)
				DropdownText.Parent = DropdownContainer
				DropdownText.Position = UDim2.new(0, 35, 0, 6)
				DropdownText.BackgroundTransparency = 1
				DropdownText.TextXAlignment = Enum.TextXAlignment.Left
				DropdownText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
				DropdownText.Text = options.name
				DropdownText.TextColor3 = Color3.fromRGB(150, 150, 150)
				DropdownText.TextSize = 13
				DropdownText.Name = options.name
				DropdownText.ZIndex = 4

				local ActiveChoice = Instance.new("Frame")
				ActiveChoice.Size = UDim2.new(1,-65,0,20)
				ActiveChoice.Position = UDim2.new(0.5, 0, 0, 15)
				ActiveChoice.Parent = DropdownContainer
				ActiveChoice.AnchorPoint = Vector2.new(0.5,0)
				ActiveChoice.BackgroundColor3 = Color3.fromRGB(39, 39, 46)
				ActiveChoice.Name = "ActiveChoice"
				ActiveChoice.ZIndex = 4

				local ActiveText = Instance.new("TextLabel")
				ActiveText.Size = UDim2.new(1,0,1,0)
				ActiveText.Parent = ActiveChoice
				ActiveText.AnchorPoint = Vector2.new(0.5,0)
				ActiveText.Position = UDim2.new(0.5, 0, 0, 0)
				ActiveText.BackgroundTransparency = 1
				ActiveText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin)
				ActiveText.Text = table.concat(dropdown.active, ", ")
				ActiveText.TextColor3 = Color3.fromRGB(200, 200, 200)
				ActiveText.TextSize = 13
				ActiveText.Name = options.name
				ActiveText.ZIndex = 4

				local DropdownStroke = Instance.new("UIStroke")
				DropdownStroke.Parent = ActiveChoice
				DropdownStroke.Thickness = 1.5
				DropdownStroke.Color = Color3.fromRGB(18, 18, 24)

				local ChoiceHolder = Instance.new("Frame")
				ChoiceHolder.Size = UDim2.new(1,0,0,0)
				ChoiceHolder.Position = UDim2.new(0.5, 0, 0, 21)
				ChoiceHolder.Parent = ActiveChoice
				ChoiceHolder.AnchorPoint = Vector2.new(0.5,0)
				ChoiceHolder.BackgroundColor3 = Color3.fromRGB(39, 39, 46)
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

					ChoiceHolder.Size = UDim2.new(1,0,0,ChoiceHolder.Size.Y.Offset + 20)

					local Choice = Instance.new("Frame")
					Choice.Size = UDim2.new(1,0,0,20)
					Choice.Parent = ChoiceHolder
					Choice.AnchorPoint = Vector2.new(0.5,0)
					Choice.BackgroundColor3 = Color3.fromRGB(39, 39, 46)
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
					ChoiceText.TextColor3 = Color3.fromRGB(150,150,150)
					ChoiceText.TextSize = 12
					ChoiceText.Name = name
					ChoiceText.ZIndex = 4

					for i, name in ipairs(dropdown.active) do -- Handle Default Choice
						if name == choice.Name then
							choice.state = true
							ActiveText.Text = table.concat(dropdown.active, ", ")
							Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(255, 255, 255)})
							options.callback(ActiveText.Text)
							break
						end
					end

					-- Choice Functionality
					do
						Choice.MouseEnter:Connect(function()
							if choice.state ~= true then
								Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(255,255,255)})
							end
							choice.Hover = true
						end)
					
						Choice.MouseLeave:Connect(function()
							if choice.state ~= true then
								Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(150, 150, 150)})
							end
							choice.Hover = false
						end)

						UIS.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								if choice.Hover == true then
									choice.state = not choice.state
									if choice.state == true then
										Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(255, 255, 255)})
										table.insert(dropdown.active, choice.Name)
										ActiveText.Text = table.concat(dropdown.active, ", ")
										options.callback(ActiveText.Text)
									else
										Library:tween(ChoiceText, {TextColor3 = Color3.fromRGB(150, 150, 150)})
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
							Library:tween(DropdownStroke, {Color = Color3.fromRGB(34,34,40)})
							Library:tween(ActiveText, {TextColor3 = Color3.fromRGB(255,255,255)})
						end
					end)
				
					ActiveChoice.MouseLeave:Connect(function()
						dropdown.Hover = false
						if dropdown.state ~= true then
							Library:tween(DropdownStroke, {Color = Color3.fromRGB(18, 18, 24)})
							Library:tween(ActiveText, {TextColor3 = Color3.fromRGB(200, 200, 200)})
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
						Library:tween(DropdownStroke, {Color = Color3.fromRGB(34,34,40)})
						Library:tween(ActiveText, {TextColor3 = Color3.fromRGB(255,255,255)})
					else
						Library:tween(DropdownStroke, {Color = Color3.fromRGB(18, 18, 24)})
						Library:tween(ActiveText, {TextColor3 = Color3.fromRGB(200,200,200)})
					end
				end

				return section
			end

			return section
		end -- tab:AddSection
		return tab
	end -- GUI:AddTab

	-- Drag GUI
	do

		local container = {
			Hover = false
		}

		-- This prevents it from dragging on elements like sliders and colorpickers.
		Container3.MouseEnter:Connect(function()
			container.Hover = true
		end)
	
		Container3.MouseLeave:Connect(function()
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

	-- Destroy GUI
	UIS.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.M then
			ScreenGui:Destroy()
		end
	end)

	return GUI
end
