-- TK HUB UI
-- Clean Version

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

local Gui = Instance.new("ScreenGui")
Gui.Name = "TK_HUB"
Gui.Parent = Player.PlayerGui


local Main = Instance.new("Frame")
Main.Parent = Gui
Main.Size = UDim2.fromOffset(600,350)
Main.Position = UDim2.new(.5,-300,.5,-175)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)


local Corner = Instance.new("UICorner",Main)
Corner.CornerRadius = UDim.new(0,12)


-- HEADER

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.Text = "TK HUB"
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20



-- SIDEBAR

local Side = Instance.new("Frame")
Side.Parent = Main
Side.Position = UDim2.fromOffset(10,60)
Side.Size = UDim2.fromOffset(130,270)
Side.BackgroundColor3 = Color3.fromRGB(25,25,25)


local sideCorner = Instance.new("UICorner",Side)


local Layout = Instance.new("UIListLayout",Side)
Layout.Padding = UDim.new(0,8)



function CreateTab(name)

	local Button = Instance.new("TextButton")
	Button.Parent = Side
	Button.Size = UDim2.new(1,-10,0,35)
	Button.Text = name
	Button.Font = Enum.Font.GothamBold
	Button.TextColor3 = Color3.new(1,1,1)
	Button.BackgroundColor3 = Color3.fromRGB(35,35,35)

	local c = Instance.new("UICorner",Button)

	return Button
end


local Home = CreateTab("🏠 Home")
local Shop = CreateTab("🛒 Shop")
local Setting = CreateTab("⚙ Setting")



-- CONTENT


local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.fromOffset(155,60)
Content.Size = UDim2.fromOffset(430,270)
Content.BackgroundColor3 = Color3.fromRGB(20,20,20)


local cc = Instance.new("UICorner",Content)



function AddButton(text)

	local b = Instance.new("TextButton")
	b.Parent = Content
	b.Size = UDim2.new(1,-20,0,40)
	b.Position = UDim2.fromOffset(10,10)
	b.Text=text
	b.TextColor3=Color3.new(1,1,1)
	b.BackgroundColor3=Color3.fromRGB(40,40,40)

	local c=Instance.new("UICorner",b)

	return b
end


AddButton("Example Button")
