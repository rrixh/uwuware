--Dendro ESP
--Nahida#5000
--Ver 2.0

--#region Setup
--//Services\\--
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local Workspace = game:GetService("Workspace");
local CoreGui = game:GetService("CoreGui");
local Players = game:GetService("Players");

local LPlayer = Players.LocalPlayer;
local Mouse = LPlayer:GetMouse();
--//ENV Stack Declaration\\--
local Min, Max = math.min, math.max;
local Cos, Sin = math.cos, math.sin;
local Rad, PI = math.rad, math.pi;
local Unpack, TRemove = table.unpack, table.remove;

local NewV3 = Vector3.new;
local NewV2 = Vector2.new;
local NewCF = CFrame.new;

local EmptyCF = NewCF();
local Viewport, MouseUnlocker, SetupViewport, BulletSource;
--//DataModel Stack Declaration\\--
local Camera, Raycast = Workspace.CurrentCamera, Workspace.Raycast;
local ToScreenPoint = Camera.WorldToViewportPoint;
--//Events\\--
local PostRender = Instance.new("BindableEvent");
local NonNegativeTables;
--//Main\\--
local DendroESP = {
    AimbotEnabled = false;
    AimSensetivity = 4;
    PostRender = PostRender.Event;

    BulletOffset = NewCF(0, 0, -1);
    WallPenThickness = 0;
    RaycastParams = RaycastParams.new();

    PositiveColor = Color3.fromHex("#A5C739");
    NegativeColor = Color3.fromHex("#BE1E2D");
    NeutralColor = Color3.fromHex("#F7941D");

    RenderPartState = false;
    RenderModelState = false;
    RenderCharacterState = true;
};
--#endregion

--#region Functions
function DendroESP:RunOnChildren(Folder, Function)
    local Children = Folder:GetChildren();
    for _ = 1, #Children do
        Function(Children[_], _);
    end;
    return Folder.ChildAdded:Connect(function(Child)
        Function(Child);
    end);
end;

function DendroESP:GetDPI(ForceUpdate)
    SetupViewport();
    if (self.DPI and not ForceUpdate) then return self.DPI; end;
    MouseUnlocker.Visible = true;
    local StartPosition = self:GetMousePos();
    mousemoveabs(100, 100);
    mousemoveabs(100, 099);
    Mouse.Move:Wait();
    local EndPosition = self:GetMousePos();
    local DPI = math.round(1e4 / EndPosition.X) / 100;
    StartPosition =  StartPosition * DPI;
    mousemoveabs(StartPosition.X, StartPosition.Y);
    self.DPI = DPI;
    MouseUnlocker.Visible = false;
    return DPI;
end;

function DendroESP:GetMouseSensitivity()
    return UserSettings().GameSettings.MouseSensitivity;
end;

function DendroESP:ScheduleKeypress(Key, Delay)
    task.wait(Delay);
    keypress(Key);
end;

function DendroESP:AimAt(Pos)
    self.AimbotEnabled = (Pos and true);
    self.AimTarget = Pos;
end;

function DendroESP:MoveMouse(X, Y)
    local DPI = self:GetDPI();
    mousemoverel(X * DPI, Y * DPI);
end;

function DendroESP:MouseMoveTo(X, Y)
    local DPI = self:GetDPI();
    mousemoveabs(X * DPI, Y * DPI);
end;

function DendroESP:GetMousePos()
    return NewV2(Mouse.X, Mouse.Y) + GuiService:GetGuiInset();    
end;
local GetMousePos = DendroESP.GetMousePos;

local function GetModelPart(Model)
    return Model.PrimaryPart or Model:FindFirstChildWhichIsA("BasePart");
end;

local function GetRootPart(Character)
    return Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("RootPart") or GetModelPart(Character);
end;

local function GetBulletSource()
    local BulletSource = DendroESP.BulletSource;
    local BulletOffset = DendroESP.BulletOffset;
    if (not BulletSource) then return (Camera.CFrame * BulletOffset).Position; end;
    return (typeof(BulletSource) == "CFrame" and (BulletSource * BulletOffset).Position) or (BulletSource.CFrame * BulletOffset).Position;
end;
--#endregion

--#endregion

--#region Math Hell
local function GetCorners(Part)
    local CF, Size, Corners = Part.CFrame, Part.Size / 2, {};
    for X = -1, 1, 2 do for Y = -1, 1, 2 do for Z = -1, 1, 2 do
        Corners[#Corners+1] = (CF * NewCF(Size * Vector3.new(X, Y, Z))).Position;    
    end; end; end;
    return Corners;
end;

local function GetEdgesNoOverlap(Part)
    local Corners = GetCorners(Part);
    --[[ Corner Data:
        (-1, -1, -1) [1]
        (-1, -1, +1) [2]
        (-1, +1, -1) [3]
        (-1, +1, +1) [4]
        (+1, -1, -1) [5]
        (+1, -1, +1) [6]
        (+1, +1, -1) [7]
        (+1, +1, +1) [8]
    ]]
    -- Binary math haunts me everywhere I go...
    local C000, C001, C010, C011, C100, C101, C110, C111 = Unpack(Corners);
    -- This just takes turns at NOT'ing the bits at [3], [2], and [1] positions, respectively.
    -- First index is b000 << b10 every 3 tables.
    return {
        {C000, C001};
        {C000, C010};
        {C000, C100};
        {C011, C010};
        {C011, C001};
        {C011, C111};
        {C110, C111};
        {C110, C100};
        {C110, C010};
        {C101, C100};
        {C101, C111};
        {C101, C001};
    };
end;

local function GetCharacterVertices(CF)
    return  {
        -- Head
        {CF * NewCF(-0.5, 1, 0).Position, CF * NewCF(-0.5, 2, 0).Position};
        {CF * NewCF(-0.5, 2, 0).Position, CF * NewCF(0.5, 2, 0).Position};
        {CF * NewCF(0.5, 2, 0).Position,  CF * NewCF(0.5, 1, 0).Position};
        -- Right Arm
        {CF * NewCF(0.5, 1, 0).Position, CF * NewCF(2, 1, 0).Position};
        {CF * NewCF(2, 1, 0).Position,   CF * NewCF(2, -1, 0).Position};
        {CF * NewCF(2, -1, 0).Position,  CF * NewCF(1, -1, 0).Position};
        -- Feet
        {CF * NewCF(1, -1, 0).Position,  CF * NewCF(1, -3, 0).Position};
        {CF * NewCF(1, -3, 0).Position,  CF * NewCF(-1, -3, 0).Position};
        {CF * NewCF(-1, -3, 0).Position, CF * NewCF(-1, -1, 0).Position};
        -- Left Arm
        {CF * NewCF(-1, -1, 0).Position, CF * NewCF(-2, -1, 0).Position};
        {CF * NewCF(-2, -1, 0).Position, CF * NewCF(-2, 1, 0).Position};
        {CF * NewCF(-2, 1, 0).Position,  CF * NewCF(-0.5, 1, 0).Position};
    }
end;

local function GetEdges(Part)
    local Corners = GetCorners(Part);
    local Edges, Corner = {}, Corners[1];
    local C0, C1, C2 = Corners[2], Corners[3], Corners[5];

    Edges[1] = {
        {Corner, C0, (Corner - C0).Unit};
        {Corner, C1, (Corner - C1).Unit};
        {Corner, C2, (Corner - C2).Unit};
    };

    Corner, C0, C1, C2 = Corners[2], Corners[1], Corners[4], Corners[6];
    Edges[2] = {
        {Corner, C0, (Corner - C0).Unit};
        {Corner, C1, (Corner - C1).Unit};
        {Corner, C2, (Corner - C2).Unit};
    };

    Corner, C0, C1, C2 = Corners[3], Corners[1], Corners[4], Corners[7];
    Edges[3] = {
        {Corner, C0, (Corner - C0).Unit};
        {Corner, C1, (Corner - C1).Unit};
        {Corner, C2, (Corner - C2).Unit};
    };

    Corner, C0, C1, C2 = Corners[4], Corners[2], Corners[3], Corners[8];
    Edges[4] = {
        {Corner, C0, (Corner - C0).Unit};
        {Corner, C1, (Corner - C1).Unit};
        {Corner, C2, (Corner - C2).Unit};
    };

    Corner, C0, C1, C2 = Corners[5], Corners[1], Corners[6], Corners[7];
    Edges[5] = {
        {Corner, C0, (Corner - C0).Unit};
        {Corner, C1, (Corner - C1).Unit};
        {Corner, C2, (Corner - C2).Unit};
    };

    Corner, C0, C1, C2 = Corners[6], Corners[2], Corners[5], Corners[8];
    Edges[6] = {
        {Corner, C0, (Corner - C0).Unit};
        {Corner, C1, (Corner - C1).Unit};
        {Corner, C2, (Corner - C2).Unit};
    };

    Corner, C0, C1, C2 = Corners[7], Corners[3], Corners[5], Corners[8];
    Edges[7] = {
        {Corner, C0, (Corner - C0).Unit};
        {Corner, C1, (Corner - C1).Unit};
        {Corner, C2, (Corner - C2).Unit};
    };

    Corner, C0, C1, C2 = Corners[8], Corners[4], Corners[6], Corners[7];
    Edges[8] = {
        {Corner, C0, (Corner - C0).Unit};
        {Corner, C1, (Corner - C1).Unit};
        {Corner, C2, (Corner - C2).Unit};
    };
    return Edges;
end;

local InvalidPass = {[0] = true, [3] = true};
local function CheckShadow(Corner, LightSource)
    local LightDirection = (LightSource - Corner[1][1]).Unit;
    local Passes = 0;
    for _ = 1, 3 do
        local Edge = Corner[_];
        local Dot = Edge[3]:Dot(LightDirection);
        Edge[4] = Dot;
        Passes = Passes + ((Dot >= 0 and 1) or 0);
    end;
    return InvalidPass[Passes];
end;

local function RemoveConnection(Connections, P0, P1)
    for _ = 1, #Connections do
        local Connection = Connections[_];
        if (Connection[1] == P0 and Connection[2] == P1) then
            return TRemove(Connections, _);
        end;
    end;
end;

local function OldGetShadowPolygon(Part, LightSource)
    local Edges = GetEdges(Part);
    local ShadowCorners, ShadowEdges, Blacklist = {}, {}, {};

    for _ = 1, #Edges do
        local Corner = Edges[_];
        if (not Corner) then break; end;
        if (CheckShadow(Corner, LightSource)) then
            Blacklist[Corner[1][1]] = true;
        else
            ShadowCorners[#ShadowCorners+1] = Corner;
        end;
    end;

    local PointConnections, Tripoint = {}, nil;
    for _ = 1, #ShadowCorners do
        local Corner = ShadowCorners[_];
        local Start = Corner[1][1];
        for _ = 1, 3 do
            local End = Corner[_][2];
            if (not Blacklist[End] and Corner[_][4] ~= 0) then
                ShadowEdges[#ShadowEdges+1] = {Start, End};
                local StartConn, EndConn = (PointConnections[Start] or 0) + 1, (PointConnections[End] or 0) + 1;
                PointConnections[Start] = StartConn;
                PointConnections[End] = EndConn;
                if (StartConn == 3 and EndConn == 3) then
                    ShadowEdges[#ShadowEdges] = nil;
                elseif (StartConn == 3 or EndConn == 3) then
                    local Tricon = (StartConn == 3 and Start) or End;
                    if (Tripoint) then
                        RemoveConnection(ShadowEdges, Tripoint, Tricon);
                    else
                        Tripoint = Tricon;
                    end;
                end;
            end;
        end;
        Blacklist[Start] = true;
    end;

    return ShadowEdges;
end;

local function GetShadowPolygon(Part, LightSource)
    local Edges = GetEdges(Part);
    local ShadowCorners, ShadowEdges, Blacklist = {}, {}, {};

    for _ = 1, #Edges do
        local Corner = Edges[_];
        if (not Corner) then break; end;
        if (CheckShadow(Corner, LightSource)) then
            Blacklist[Corner[1][1]] = true;
        else
            ShadowCorners[#ShadowCorners+1] = Corner;
        end;
    end;

    local PointConnections, Tripoint = {}, nil;
    for _ = 1, #ShadowCorners do
        local Corner = ShadowCorners[_];
        local Start = Corner[1][1];
        for _ = 1, 3 do
            local End = Corner[_][2];
            if (not Blacklist[End] and Corner[_][4] ~= 0) then
                ShadowEdges[#ShadowEdges+1] = {Start, End};
                local StartConn, EndConn = (PointConnections[Start] or 0) + 1, (PointConnections[End] or 0) + 1;
                PointConnections[Start] = StartConn;
                PointConnections[End] = EndConn;
                if (StartConn == 3 and EndConn == 3) then
                    ShadowEdges[#ShadowEdges] = nil;
                elseif (StartConn == 3 or EndConn == 3) then
                    local Tricon = (StartConn == 3 and Start) or End;
                    if (Tripoint) then
                        RemoveConnection(ShadowEdges, Tripoint, Tricon);
                    else
                        Tripoint = Tricon;
                    end;
                end;
            end;
        end;
        Blacklist[Start] = true;
    end;
    
    local OutputTable = {};
    for _ = 1, #ShadowEdges do
        local Edge = ShadowEdges[_];
        local Start, End = Edge[1], Edge[2];
        local StartExists = OutputTable[Start];
        OutputTable[(StartExists and End) or Start] = (StartExists and Start) or End;
    end;
    return OutputTable;
end;

-- Converts lines that pass through P0 and P1 into [Ax + By + C = 0] form. This is so that we can easily get the intersection.
local function GetLineComponents(P0, P1)
    local X1, Y1, X2, Y2 = P0.X, P0.Y, P1.X, P1.Y;
    local A = Y1 - Y2;
    local B = X2 - X1;
    local C = X1 * Y2 - X2 * Y1;

    return A, B, C;
end;
-- Gets the intersection of 2 lines to determine where the angle break happens.
local function GetIntersection(L0, L1)
    local A1, B1, C1 = GetLineComponents(L0[1], L0[2]);
    local A2, B2, C2 = GetLineComponents(L1[1], L1[2]);
    local Denominator = (A1*B2-A2*B1);
    local X = (B1*C2-B2*C1)/Denominator;
    local Y = (C1*A2-C2*A1)/Denominator;
    return NewV2(X, Y);
end;

local function GetTPoint(P0, P1, T)
    return P0 * (1 - T) + P1 * T;
end;

local function V3ToV2(Vector, ...)
    return NewV2(Vector.X, Vector.Y), ...;
end;
--#endregion

--#region Custom Drawing Library Implementation
--Recycles Drawing tables because Synapse sucks at garbage collection.
local Drawings = {};
local function CreateDrawing(Type)
    if (not Drawings[Type]) then Drawings[Type] = {Count = 0}; end;
    local DrawingTable = Drawings[Type];
    local Count = DrawingTable.Count + 1;
    local Component = DrawingTable[Count];
    DrawingTable.Count = Count;
    if (Component) then return Component; end;
    Component = Drawing.new(Type);
    DrawingTable[Count] = Component;
    return Component;
end;
Drawing.new("Line"):Remove();

local function DrawLine(P0, P1, Color, Thickness, Transparency, Is2D)
    if (not Is2D) then
        local Start = ToScreenPoint(Camera, P0);
        local End = ToScreenPoint(Camera, P1);
        P0, P1 = V3ToV2(Start), V3ToV2(End);
    end;

    local Line = CreateDrawing("Line");
    Line.Color = Color;
    Line.From, Line.To = P0, P1;
    Line.Visible = true;
    Line.Thickness = Thickness;
    Line.Transparency = 1 - Transparency;
    return Line;
end;

local function DrawRadialHitbox(self)
    local RadialHitbox = self.RadialHitbox;
    if (RadialHitbox == 0) then return; end;
    if (RadialHitbox == true) then
        RadialHitbox = (self.Max2DPoint - self.Min2DPoint).Magnitude / 2;
    end;
    local Color, Transparency = self.CurrentColor, self.Opacity;
    local Center = (self.RadiusOnCrosshair and self.CrosshairCenter2D) or self.Center2D;
    local MPos = DendroESP.MousePos;
    local Radial = CreateDrawing("Circle");
    Radial.Thickness = 1;
    Radial.Position = Center;
    Radial.Radius = RadialHitbox;
    Radial.Color = Color;
    Radial.Transparency = Transparency;
    Radial.Visible = true;
    self.MouseInRadius = (MPos - Center).Magnitude <= RadialHitbox;
end;

local function DrawText(self)
    local Text = self.Text;
    if (not self.TextEnabled or Text == "") then return; end;
    local TextAlignment, Font, Size = self.TextAlignment, self.Font, self.TextSize;
    local TextOutlineVisible, TextOutlineColor = self.TextOutlineVisible, self.TextOutlineColor;
    if (Size == 0) then
        Size = (self.MaxX - self.MinX) / 10;
    end;
    local TextDrawing = CreateDrawing("Text");
    TextDrawing.Visible = true;
    TextDrawing.Text, TextDrawing.Font, TextDrawing.Size, TextDrawing.Color = Text, Font, Size, self.CurrentColor;
    TextDrawing.Outline, TextDrawing.OutlineColor = TextOutlineVisible, TextOutlineColor;
    local TextPadding = self.TextPadding;
    if (TextAlignment == Enum.TextXAlignment.Center) then
        TextDrawing.Center = true;
        TextDrawing.Position = NewV2(
            (self.MinX + self.MaxX) / 2 + TextPadding.X,
            self.MaxY + TextPadding.Y
        );
    elseif (TextAlignment == Enum.TextXAlignment.Right) then
        local TextBounds = TextDrawing.TextBounds;
        TextDrawing.Center = true;
        TextDrawing.Position = NewV2(
            self.MaxX - TextBounds.X / 2 - TextPadding.X,
            self.MaxY + TextPadding.Y
        );
    else
        TextDrawing.Center = false;
        TextDrawing.Position = NewV2(
            self.MinX + TextPadding.X,
            self.MaxY + TextPadding.Y
        );
    end;
    return TextDrawing;
end;

local function DrawTracer(self)
    if (not self.TracerEnabled) then return; end;
    if (not self.NegativeTrace and self.CurrentState == "Negative") then return; end;
    local P0 = DendroESP.TracerSource;
    local P1 = NewV2(self.Center2D.X, self.Max2DPoint.Y);
    local Line = CreateDrawing("Line");
    Line.From, Line.To = P0, P1;
    Line.Color = self.CurrentColor;
    Line.Transparency = self.Opacity;
    Line.Thickness = self.Thickness;
    Line.Visible = true;
end;

local function DrawHealth(self)
    if (not self.HealthEnabled) then return; end;
    local Humanoid = self.Instance:FindFirstChildOfClass("Humanoid");
    local Health, MaxHealth = (Humanoid and Humanoid.Health or self.Health), (Humanoid and Humanoid.MaxHealth or self.MaxHealth);
    if (Health >= MaxHealth or Health <= 0) then return; end;
    local HealthBarSize, HealthBarThickness = self.HealthBarSize, self.HealthBarThickness;
    local MinX, MaxX, MinY = self.MinX, self.MaxX, self.MinY;
    local Padding = self.HealthBarPadding;
    HealthBarSize = ((HealthBarSize == 0 and MaxX - MinX) or HealthBarSize) / 2;

    local HealthBar, MaxHealthBar = CreateDrawing("Line"), CreateDrawing("Line");
    HealthBar.Thickness, MaxHealthBar.Thickness = HealthBarThickness, HealthBarThickness;
    HealthBar.Color = self.PositiveColor or self.PositiveFillColor;
    MaxHealthBar.Color = self.NegativeColor or self.NegativeFillColor;
    local Midpoint = (MinX + MaxX) / 2;
    local BarStart, BarEnd, BarY = Midpoint - HealthBarSize, Midpoint + HealthBarSize, MinY - Padding - HealthBarThickness / 2;
    local HealthPoint = NewV2(BarStart + HealthBarSize * 2 * Health / MaxHealth, BarY);
    BarStart, BarEnd = NewV2(BarStart, BarY), NewV2(BarEnd, BarY);
    HealthBar.From = BarStart;
    MaxHealthBar.From = BarEnd;
    HealthBar.To, MaxHealthBar.To = HealthPoint, HealthPoint;
    HealthBar.Visible, MaxHealthBar.Visible = true, true;
end;

local function DrawLineOnRadius(Center, Radian, R0, R1, Color, Thickness)
    local XComponent, YComponent = Cos(Radian), Sin(Radian);
    local Line = CreateDrawing("Line");
    Line.Color, Line.Thickness = Color, Thickness;
    Line.From = Center + NewV2(XComponent * R0, YComponent * R0);
    Line.To = Center + NewV2(XComponent * R1, YComponent * R1);
    Line.Visible = true;
    return Line;
end;

local function DrawCrosshair(self, Center)
    if (not self.CrosshairEnabled) then return; end;
    Center = V3ToV2(ToScreenPoint(Camera, Center));

    local Color = self.CurrentColor;
    local CenterDot = CreateDrawing("Circle");
    CenterDot.Filled = true;
    CenterDot.Thickness = 0;
    CenterDot.Radius = 4;
    CenterDot.Color = Color;
    CenterDot.Position = Center;
    CenterDot.Visible = true;
    local OuterRadius = CreateDrawing("Circle");
    OuterRadius.Radius = 11;
    OuterRadius.Thickness = 3;
    OuterRadius.Color = Color;
    OuterRadius.Position = Center;
    OuterRadius.Visible = true;
    local Rotation = Rad(self.CrosshairRotation);
    DrawLineOnRadius(Center, Rotation, 5, 15, Color, 3);
    DrawLineOnRadius(Center, Rotation + PI * 0.5, 5, 15, Color, 3);
    DrawLineOnRadius(Center, Rotation + PI, 5, 15, Color, 3);
    DrawLineOnRadius(Center, Rotation + PI * 1.5, 5, 15, Color, 3);
    self.CrosshairRotation = self.CrosshairRotation + self.CrosshairRotationSpeed;
end;
--#endregion

--#region Framework
local WallPenRaycast;
WallPenRaycast = function(P0, P1, Target, PassCount)
    PassCount = PassCount or 0;
    local Delta = (P1 - P0);
    if (Delta.Magnitude > 5e3) then return "Negative"; end;--Target is too far.
    local RaycastParams = DendroESP.RaycastParams;
    local Cast = Raycast(Workspace, P0, Delta, RaycastParams);
    --If it hit nothing, and it's the first pass, return "Positive".
    --If it's not the first pass, return "Neutral".
    if (not Cast) then return (PassCount == 0 and "Positive") or "Neutral"; end;
    if (Cast.Instance == Target or Cast.Instance:IsDescendantOf(Target)) then
        return (PassCount == 0 and "Positive") or "Neutral";
        --If the hit instance is part of the character, then return "Positive" if it's the first pass.
        --If it's not the first pass, return "Neutral".
    end;
    local WallPenThickness = DendroESP.WallPenThickness;
    if (WallPenThickness == 0) then return "Negative"; end;
    Delta = Delta.Unit;
    local P2 = Cast.Position + Delta * WallPenThickness;
    Cast = Raycast(Workspace, P2, -Delta, RaycastParams);
    if (not Cast or PassCount >= 5) then return "Negative"; end;
    return WallPenRaycast(Cast.Position, P1, Target, PassCount + 1);
end;

local function PreparePart(self)
    local Part = self.Part;
    local PartCF = Part.CFrame;
    local Bone = Part:FindFirstChildOfClass("Bone");
    if (Bone) then PartCF = Bone.TransformedWorldCFrame; end;
    PartCF = PartCF * self.Offset3D;
    local Corners = GetCorners({CFrame = PartCF, Size = Part.Size});

    local _ = Corners[1];
    local _, OnScreen = ToScreenPoint(Camera, Corners[1]);
    local MinX, MaxX, MinY, MaxY = _.X, _.X, _.Y, _.Y;
    local OffsetX, OffsetY = self.Offset2D.X, self.Offset2D.Y;
    for _ = 2, #Corners do
        local Corner, COScreen = ToScreenPoint(Camera, Corners[_]);
        local X, Y = Corner.X + OffsetX, Corner.Y + OffsetY;
        MinX = (MinX > X and X) or MinX;
        MaxX = (MaxX < X and X) or MaxX;
        MinY = (MinY > Y and Y) or MinY;
        MaxY = (MaxY < Y and Y) or MaxY;
        OnScreen = OnScreen or COScreen;
    end;
    self.OnScreen = OnScreen;
    self.Min2DPoint, self.Max2DPoint = NewV2(MinX, MinY), NewV2(MaxX, MaxY);
    self.Center2D = NewV2(MaxX + MinX, MaxY + MinY) / 2;
    self.MinX, self.MinY, self.MaxX, self.MaxY = MinX, MinY, MaxX, MaxY;
    self.CFrame = PartCF;
    self.CrosshairCenter3D = (PartCF * self.CrosshairOffset).Position;
    self.CrosshairCenter2D, self.CrosshairOnScreen = ToScreenPoint(Camera, self.CrosshairCenter3D);
    self.CrosshairCenter2D = V3ToV2(self.CrosshairCenter2D);
    if (not self.RenderState) then
        self.CurrentState = "Positive";
        self.CurrentColor = self.PositiveColor;
        return true;
    end;

    local RenderState = WallPenRaycast(BulletSource, Part.Position, Part);
    self.CurrentState = RenderState;
    self.CurrentColor = self[RenderState.."Color"];
    if (RenderState ~= "Negative") then NonNegativeTables[#NonNegativeTables+1] = (OnScreen and self) or nil; end;
    return true;
end;

local function PrepareModel(self)
    local Model = self.Model or self.Character;
    local ModelCF, ModelSize = Model:GetBoundingBox();
    local Bone = Model:FindFirstChildOfClass("Bone");
    if (Bone) then ModelCF = Bone.TransformedWorldCFrame; end;
    ModelCF = ModelCF * self.Offset3D;
    local Corners = GetCorners({CFrame = ModelCF, Size = ModelSize});
    self.ModelCF, self.ModelSize = ModelCF, ModelSize;
    self.CFrame = ModelCF;

    local _ = Corners[1];
    local _, OnScreen = ToScreenPoint(Camera, Corners[1]);
    local MinX, MaxX, MinY, MaxY = _.X, _.X, _.Y, _.Y;
    local OffsetX, OffsetY = self.Offset2D.X, self.Offset2D.Y;
    for _ = 2, #Corners do
        local Corner, COScreen = ToScreenPoint(Camera, Corners[_]);
        local X, Y = Corner.X + OffsetX, Corner.Y + OffsetY;
        MinX = (MinX > X and X) or MinX;
        MaxX = (MaxX < X and X) or MaxX;
        MinY = (MinY > Y and Y) or MinY;
        MaxY = (MaxY < Y and Y) or MaxY;
        OnScreen = OnScreen or COScreen;
    end;
    self.OnScreen = OnScreen;
    self.Min2DPoint, self.Max2DPoint = NewV2(MinX, MinY), NewV2(MaxX, MaxY);
    self.Center2D = NewV2(MaxX + MinX, MaxY + MinY) / 2;
    self.MinX, self.MinY, self.MaxX, self.MaxY = MinX, MinY, MaxX, MaxY;
    self.CrosshairCenter3D = (ModelCF * self.CrosshairOffset).Position;
    self.CrosshairCenter2D, self.CrosshairOnScreen = ToScreenPoint(Camera, self.CrosshairCenter3D);
    self.CrosshairCenter2D = V3ToV2(self.CrosshairCenter2D);
    if (not self.RenderState) then
        self.CurrentState = "Positive";
        self.CurrentColor = self.PositiveColor;
        return true;
    end;

    local RenderState = WallPenRaycast(BulletSource, ModelCF.Position, Model);
    self.CurrentState = RenderState;
    self.CurrentColor = self[RenderState.."Color"];
    if (RenderState ~= "Negative") then NonNegativeTables[#NonNegativeTables+1] = (OnScreen and self) or nil; end;
    return true;
end;

local function PrepareCharacter(self)
    local Character = self.Character;
    local RootPart = GetRootPart(Character);
    local CharacterCF = (RootPart and RootPart.CFrame);
    if (not RootPart) then return; end;
    local Bone = RootPart:FindFirstChildOfClass("Bone");
    if (Bone) then CharacterCF = Bone.TransformedWorldCFrame; end;
    CharacterCF = CharacterCF * self.Offset3D;
    local Corners = GetCorners({CFrame = CharacterCF - Vector3.new(0, 0.5, 0), Size = Vector3.new(4, 5, 1)});
    self.RootPart, self.CharacterCF, self.CharacterVertices = RootPart, CharacterCF, Corners;
    self.CFrame = CharacterCF;

    local _, OnScreen = ToScreenPoint(Camera, Corners[1]);
    local MinX, MaxX, MinY, MaxY = _.X, _.X, _.Y, _.Y;
    local OffsetX, OffsetY = self.Offset2D.X, self.Offset2D.Y;
    for _ = 2, #Corners do
        local Corner, COScreen = ToScreenPoint(Camera, Corners[_]);
        local X, Y = Corner.X + OffsetX, Corner.Y + OffsetY;
        MinX = (MinX > X and X) or MinX;
        MaxX = (MaxX < X and X) or MaxX;
        MinY = (MinY > Y and Y) or MinY;
        MaxY = (MaxY < Y and Y) or MaxY;
        OnScreen = OnScreen or COScreen;
    end;
    self.OnScreen = OnScreen;
    self.Min2DPoint, self.Max2DPoint = NewV2(MinX, MinY), NewV2(MaxX, MaxY);
    self.Center2D = NewV2(MaxX + MinX, MaxY + MinY) / 2;
    self.MinX, self.MinY, self.MaxX, self.MaxY = MinX, MinY, MaxX, MaxY;
    self.CrosshairCenter3D = (CharacterCF * self.CrosshairOffset).Position;
    self.CrosshairCenter2D, self.CrosshairOnScreen = ToScreenPoint(Camera, self.CrosshairCenter3D);
    self.CrosshairCenter2D = V3ToV2(self.CrosshairCenter2D);
    if (not self.RenderState) then
        self.CurrentState = "Positive";
        self.CurrentColor = self.PositiveColor;
        return true;
    end;

    local RenderState = WallPenRaycast(BulletSource, CharacterCF.Position, Character);
    self.CurrentState = RenderState;
    self.CurrentColor = self[RenderState.."Color"];
    if (RenderState ~= "Negative") then NonNegativeTables[#NonNegativeTables+1] = (OnScreen and self) or nil; end;
    return true;
end;
--#endregion

--#region Initiation
local ESPs = {
    BoundingBox = {ModelFlag = true};
    Orthogonal = {ModelFlag = true};
    Highlight = {ModelFlag = true};
    Outline = {ModelFlag = true};
    Vertex = {ModelFlag = true};
    Shadow = {};
};
local RenderingTables = {};
DendroESP.RenderingTables = RenderingTables;
local function Render(self)
    if (not self.Enabled) then return; end;
    if (not self.Instance or not self.Instance.Parent) then self:Destroy(); end;
    self:Prepare();
    DrawTracer(self);
    if (not self.OnScreen and self.Type ~= "Orthogonal") then return; end;
    if (self.RenderBoundingBox) then ESPs.BoundingBox.Render(self); end;
    self:MRender();
    if (not self.OnScreen) then return; end;
    DrawCrosshair(self, self.CrosshairCenter3D);
    DrawRadialHitbox(self);
    DrawHealth(self);
    DrawText(self);
end;
local function RemoveRenderingTable(RenderingTable)
    RenderingTables[RenderingTable.Instance] = nil;
    RenderingTable.Enabled = false;
    if (RenderingTable.Highlight) then
        RenderingTable.Highlight:Destroy();
        RenderingTable.Highlight = nil;
    end;
    if (RenderingTable.ReplicaDict) then
        for _, Replica in pairs(RenderingTable.ReplicaDict) do
            Replica:Destroy();
            RenderingTable[_] = nil;
        end;
    end;
    local Connections = RenderingTable.Connections;
    if (Connections) then
        for _ = 1, #Connections do
            Connections[_]:Disconnect();
            Connections[_] = nil;
        end;
    end;
end;
local function CreateRenderingTable(Instance, Type)
    if (RenderingTables[Instance]) then return RenderingTables[Instance]; end;
    local RenderingTable = {
        Enabled = true;
        Thickness = 1;
        Opacity = 1;
        Offset3D = NewCF();
        Offset2D = NewV2();

        PositiveColor = DendroESP.PositiveColor;
        NegativeColor = DendroESP.NegativeColor;
        NeutralColor = DendroESP.NeutralColor;
        RenderState = DendroESP["Render"..Type.."State"];

        CrosshairOffset = NewCF(0, 2, 0);
        CrosshairRotation = 45;
        CrosshairRotationSpeed = 0.25;
        CrosshairEnabled = false;

        Text = "";
        TextSize = 16;
        TextAlignment = Enum.TextXAlignment.Left;
        TextOutlineVisible = false;
        TextOutlineColor = Color3.new();
        Font = Drawing.Fonts.Monospace;
        TextPadding = NewV2(0, 6);
        TextEnabled = false;

        TracerEnabled = false;
        NegativeTrace = false;

        Health = 0;
        MaxHealth = 100;
        HealthBarSize = 0;
        HealthBarThickness = 2;
        HealthBarPadding = 6;
        HealthEnabled = false;

        RadialHitbox = 0;
        MouseInRadius = false;
        RadiusOnCrosshair = false;

        Type = Type;
        [Type] = Instance;
        Instance = Instance;
        Render = Render;
        Destroy = RemoveRenderingTable;
    };
    RenderingTables[Instance] = RenderingTable;
    return RenderingTable;
end;
--#endregion

--#region ESP Modes

--#region BoundingBox
function ESPs.BoundingBox:Render()
    local Thicknes, Opacity, Color = self.Thickness, self.Opacity, self.CurrentColor;
    local Box = CreateDrawing("Square");
    Box.Thickness = Thicknes;
    Box.Size = self.Max2DPoint - self.Min2DPoint;
    Box.Position = self.Min2DPoint;
    Box.Color = Color;
    Box.Visible = true;
    Box.Transparency = Opacity;
end;
--#endregion
--#region Vertex
function ESPs.Vertex.RenderPart(Part, Thickness, Transparency, Color)
    if (type(Part) ~= "table" and not Part:IsA("BasePart")) then return; end;
    local Edges = GetEdgesNoOverlap(Part);

    for _ = 1, #Edges do
        local Edge = Edges[_];
        DrawLine(Edge[1], Edge[2], Color, Thickness, Transparency);
    end;
end;

function ESPs.Vertex:Render()
    local Thickness, Transparency, Color = self.Thickness, 1 - self.Opacity, self.CurrentColor;
    if (self.Type == "Part") then
        ESPs.Vertex.RenderPart(self.Part, Thickness, Transparency, Color);
    elseif (self.Type == "Character") then
        local Parts = self.Instance[self.RenderDescendants and "GetDescendants" or "GetChildren"](self.Instance);
        local RenderPart = ESPs.Vertex.RenderPart;
        for _ = 1, #Parts do
            RenderPart(Parts[_], Thickness, Transparency, Color);
        end;
    else
        local Model = self.Model;
        local Psuedopart = {Model:GetBoundingBox()};
        Psuedopart.CFrame, Psuedopart.Size = Psuedopart[1], Psuedopart[2];
        ESPs.Vertex.RenderPart(Psuedopart, Thickness, Transparency, Color);
    end;
end;
--#endregion
--#region Outline
function ESPs.Outline.OldRenderPart(Part, Thickness, Transparency, Color)
    if (type(Part) ~= "table" and not Part:IsA("BasePart")) then return; end;
    local Edges = GetShadowPolygon(Part, Camera.CFrame.Position);

    for _ = 1, #Edges do
        local Edge = Edges[_];
        DrawLine(Edge[1], Edge[2], Color, Thickness, Transparency);
    end;
end;

function ESPs.Outline.RenderPart(Part, Thickness, Transparency, Color)
    if (type(Part) ~= "table" and not Part:IsA("BasePart")) then return; end;
    local Edges = GetShadowPolygon(Part, Camera.CFrame.Position);

    for Start, End in pairs(Edges) do
        if (Start == 0) then continue; end;
        DrawLine(Start, End, Color, Thickness, Transparency);
    end;
    if (true) then return; end;
    local Start, End = next(Edges);
    for _ = 1, 6 do
        if (not End) then break; end;
        DrawLine(Start, End, Color, Thickness, Transparency);
        Start = End;
        End = Edges[Start];
        if (Start == Edges[0]) then break; end;
    end;
end;

function ESPs.Outline:Render()
    local Thickness, Transparency, Color = self.Thickness, 1 - self.Opacity, self.CurrentColor;
    if (self.Type == "Part") then
        ESPs.Outline.RenderPart(self.Part, Thickness, Transparency, Color);
    elseif (self.Type == "Character") then
        local Parts = self.Instance[self.RenderDescendants and "GetDescendants" or "GetChildren"](self.Instance);
        local RenderPart = ESPs.Outline.RenderPart;
        for _ = 1, #Parts do
            RenderPart(Parts[_], Thickness, Transparency, Color);
        end;
    else
        local Model = self.Model;
        local Psuedopart = {Model:GetBoundingBox()};
        Psuedopart.CFrame, Psuedopart.Size = Psuedopart[1], Psuedopart[2];
        ESPs.Outline.RenderPart(Psuedopart, Thickness, Transparency, Color);
    end;
end;
--#endregion
--#region Shadow
local function ProjectPoint(Point, Source)
    local Direction = (Point - Source).Unit * 5000;
    local Raycast = Raycast(Workspace, Source, Direction, DendroESP.RaycastParams);
    return (Raycast and Raycast.Position) or Source + Direction;
end;

local function ProjectLine(Line, Source)
    Line[1] = ProjectPoint(Line[1], Source);
    Line[2] = ProjectPoint(Line[2], Source);
    return Line;
end;

local function ToScreenLine(Line)
    Line[1] = V3ToV2(ToScreenPoint(Camera, Line[1]));
    Line[2] = V3ToV2(ToScreenPoint(Camera, Line[2]));
end;

function ESPs.Shadow.RenderEdges(Edges, Color, Thickness, Transparency)
    for _ = 1, #Edges do
        local Edge3D = Edges[_];
        local StartLine, EndLine = {Edge3D[1], GetTPoint(Edge3D[1], Edge3D[2], 0.01)}, {Edge3D[2], GetTPoint(Edge3D[1], Edge3D[2], 0.99)};
        ProjectLine(StartLine, BulletSource); ProjectLine(EndLine, BulletSource);
        ToScreenLine(StartLine); ToScreenLine(EndLine);
        local Midpoint = GetIntersection(StartLine, EndLine);
        local Distance, MaxDistance = 
        math.max((StartLine[1] - Midpoint).Magnitude, (EndLine[1] - Midpoint).Magnitude),
        (StartLine[1] - EndLine[1]).Magnitude;

        if (Distance >= MaxDistance) then
            DrawLine(StartLine[1], EndLine[1], Color, Thickness, Transparency, true);
        else
            DrawLine(StartLine[1], Midpoint, Color, Thickness, Transparency, true);
            DrawLine(Midpoint, EndLine[1], Color, Thickness, Transparency, true);
        end;
    end;
end;

function ESPs.Shadow:Render()
    local Thickness, Transparency, Color = self.Thickness, 1 - self.Opacity, self.CurrentColor;
    local Source = ((self.Part and self.Part.CFrame) or self.CharacterCF).Position;
    if (Raycast(Workspace, BulletSource, (Source - BulletSource), DendroESP.RaycastParams)) then
        return ESPs.Outline.Render(self);
    end;
    if (self.Type == "Part") then
        local Edges = GetShadowPolygon(self.Part, BulletSource);
        ESPs.Shadow.RenderEdges(Edges, Color, Thickness, Transparency);
    else
        local Edges = GetCharacterVertices(self.CharacterCF);
        ESPs.Shadow.RenderEdges(Edges, Color, Thickness, Transparency);
    end;
end;
--#endregion
--#region Orthogonal
SetupViewport = function()
    if (Viewport) then return; end;
    local Parent = Instance.new("ScreenGui", CoreGui);
    Parent.Name = "DendroESP";
    Parent.IgnoreGuiInset = true;
    Viewport = Instance.new("ViewportFrame", Parent);
    Viewport.Name = "DendroOrthogonalESP";
    Viewport.Size = UDim2.new(1, 0, 1, 0);
    Viewport.Position = UDim2.new(0.5, 0, 0.5, 0);
    Viewport.AnchorPoint = NewV2(0.5, 0.5);
    Viewport.BackgroundTransparency = 1;
    
    MouseUnlocker = Instance.new("TextButton", Parent);
    MouseUnlocker.Size = UDim2.new(1, 0, 1, 0);
    MouseUnlocker.Position = UDim2.new(0.5, 0, 0.5, 0);
    MouseUnlocker.AnchorPoint = NewV2(0.5, 0.5);
    MouseUnlocker.Text = "";
    MouseUnlocker.BorderSizePixel = 0;
    MouseUnlocker.Visible = false;

    Parent.Enabled = true;
    Parent.Parent = CoreGui;
end;

local function AddOrthogonalPart(Source, ReplicaDict)
    local Replica = Source:Clone();
    Replica:ClearAllChildren();
    Replica.Parent = Viewport;
    ReplicaDict[Source] = Replica;
end;

local function SetupOrthogonalESP(self)
    if (self.ReplicaDict) then return self.ReplicaDict; end;
    SetupViewport();
    self.Material = Enum.Material.Metal;
    self.Opacity = 0.5;
    local ReplicaDict, Connections = {}, {};
    self.ReplicaDict = ReplicaDict;
    self.Connections = Connections;
    if (self.Type == "Part") then
        AddOrthogonalPart(self.Part, ReplicaDict);
    else
        local Descendants = self.Instance:GetDescendants();
        for _ = 1, #Descendants do
            local Descendant = Descendants[_];
            if (not Descendant:IsA("BasePart")) then continue; end;
            AddOrthogonalPart(Descendant, ReplicaDict);
        end;
        self.Instance.DescendantAdded:Connect(function(Descendant)
            if (not Descendant:IsA("BasePart")) then return; end;
            task.wait(1);
            AddOrthogonalPart(Descendant, ReplicaDict);
        end);
    end;
    return ReplicaDict;
end

function ESPs.Orthogonal:Render()
    local ReplicaDict = SetupOrthogonalESP(self);
    local Transparency, Color, Material = 1 - self.Opacity, self.CurrentColor, self.Material;
    for Source, Replica in pairs(ReplicaDict) do
        if (not Source.Parent) then
            Replica:Destroy();
            ReplicaDict[Source] = nil;
            continue;
        end;
        Replica.CFrame = Source.CFrame;
        Replica.Size = Source.Size;
        Replica.Transparency = math.max(Transparency, Source.Transparency);
        Replica.Color = Color;
        Replica.Material = Material;
    end;
end;
--#endregion
--#region Highlight
local function SetupHighlightESP(self)
    if (self.Highlight) then return self.Highlight; end;
    SetupViewport();
    self.FillOpacity = 0.5;
    local Highlight = Instance.new("Highlight", Viewport);
    Highlight.Adornee = self.Instance;
    self.Highlight = Highlight;
    return Highlight;
end;

function ESPs.Highlight:Render()
    local Highlight = SetupHighlightESP(self);
    local Transparency, FillTransparency, Color = 1 - self.Opacity, 1 - self.FillOpacity, self.CurrentColor;
    Highlight.OutlineColor = Color;
    Highlight.FillColor = Color;
    Highlight.OutlineTransparency = Transparency;
    Highlight.FillTransparency = FillTransparency;
    Highlight.Adornee = self.Instance;
    Highlight.Parent = nil;
    Highlight.Parent = Viewport;
end;
--#endregion
--#endregion

--#region Add Functions
function DendroESP:AddPart(Part, Mode)
    assert(self == DendroESP, "Expected a self call (:) instead of (.)");
    assert(Part:IsA("BasePart"), "Expected a part for argument #1.");
    local Mode = ESPs[Mode];
    assert(Mode, "Invalid ESP Mode.");

    local RenderingTable = CreateRenderingTable(Part, "Part");
    RenderingTable.Mode = Mode;
    RenderingTable.Prepare = PreparePart;
    RenderingTable.MRender = Mode.Render;
    return RenderingTable;
end;

function DendroESP:AddModel(Model, Mode)
    assert(self == DendroESP, "Expected a self call (:) instead of (.)");
    assert(Model:IsA("Model"), "Expected a model for argument #1.");
    local Mode = ESPs[Mode];
    assert(Mode, "Invalid ESP Mode.");
    assert(Mode.ModelFlag, "This ESP Mode isn't available for models.");

    local RenderingTable = CreateRenderingTable(Model, "Model");
    RenderingTable.Mode = Mode;
    RenderingTable.Prepare = PrepareModel;
    RenderingTable.MRender = Mode.Render;
    RenderingTable.RenderDescendants = (Mode == "Vertex" or Mode == "Outline");
    return RenderingTable;
end;

function DendroESP:AddCharacter(Character, Mode)
    assert(self == DendroESP, "Expected a self call (:) instead of (.)");
    assert(Character:IsA("Model"), "Expected a character model for argument #1.");
    local Mode = ESPs[Mode];
    assert(Mode, "Invalid ESP Mode.");

    local RenderingTable = CreateRenderingTable(Character, "Character");
    RenderingTable.Mode = Mode;
    RenderingTable.Prepare = PrepareCharacter;
    RenderingTable.MRender = Mode.Render;
    return RenderingTable;
end;

function DendroESP:BasicCharacterSystem()
    LPlayer.CharacterAdded:Connect(function(Character)
        DendroESP.RaycastParams.FilterDescendantsInstances = {Character};
        DendroESP.BulletSource = Character.Head;
    end);
    DendroESP.RaycastParams.FilterDescendantsInstances = {LPlayer.Character};
    DendroESP.BulletSource = LPlayer.Character.Head;
end;

function DendroESP:ClearESP()
    for _ = 1, #RenderingTables do
        RenderingTables[_]:Destroy();
    end;
end;
--#endregion

--#region ESP & Aimbot
if (_G.DendroESP) then _G.DendroESP:ClearESP(); end;
if (_G.DendroESPConnection) then _G.DendroESPConnection:Disconnect(); end;
if (CoreGui:FindFirstChild("DendroESP")) then CoreGui.DendroESP:Destroy(); end;
SetupViewport();
DendroESP.MousePos = GetMousePos();
_G.DendroESP = DendroESP;
_G.DendroESPConnection = RunService.RenderStepped:Connect(function()
    --//Preparing\\--
    local MousePos = GetMousePos();
    DendroESP.MousePos = MousePos;
    NonNegativeTables = {};
    Camera = Workspace.CurrentCamera;
    BulletSource = GetBulletSource();
    DendroESP.TracerSource = NewV2(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y);
    --//Rendering\\--
    if (Viewport) then Viewport.CurrentCamera = Camera; end;
    for _, RenderingTable in pairs(RenderingTables) do
        RenderingTable:Render();
    end;
    --//Firing Event\\--
    PostRender:Fire(NonNegativeTables);
    --//Clearing Unused Drawings\\--
    for _, Drawings in pairs(Drawings) do
        for Idx = Drawings.Count + 1, #Drawings do
            Drawings[Idx].Visible = false;
        end;
        Drawings.Count = 0;
    end;
    --//Aimbot\\--
    if (not DendroESP.AimbotEnabled) then return; end;
    local AimTarget = DendroESP.AimTarget;
    if (not AimTarget) then return; end;
    local Delta = AimTarget - MousePos;
    local Distance = Delta.Magnitude;
    local Sensitivity = DendroESP:GetMouseSensitivity() * DendroESP.AimSensetivity;
    Delta = Delta.Unit;
    if (Distance <= 10) then
        Delta = Delta / Sensitivity * 0.25 * Distance;
    elseif (Distance <= 2) then
        return;
    else
        Delta = Delta * Distance / Sensitivity;
    end;
    mousemoverel(Delta.X, Delta.Y);
end);
--#endregion

return DendroESP;
