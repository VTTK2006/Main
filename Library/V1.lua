--// TK HUB LIBRARY
--// Executor Version


------------------------------------------------
-- SERVICES
------------------------------------------------

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer



------------------------------------------------
-- GUI
------------------------------------------------

local Gui = Instance.new("ScreenGui")

Gui.Name="TK_HUB"

Gui.ResetOnSpawn=false

Gui.Parent=gethui and gethui() or game.CoreGui



local Main=Instance.new("Frame")

Main.Parent=Gui

Main.Size=UDim2.fromOffset(600,350)

Main.Position=
UDim2.new(.5,-300,.5,-175)

Main.BackgroundColor3=
Color3.fromRGB(15,15,15)

Main.ClipsDescendants=true


Instance.new("UICorner",Main).CornerRadius=
UDim.new(0,12)





------------------------------------------------
-- DRAG SYSTEM
------------------------------------------------


local function MakeDrag(obj)


local dragging=false

local dragStart

local startPos



obj.InputBegan:Connect(function(input)

if input.UserInputType==
Enum.UserInputType.MouseButton1 then


dragging=true

dragStart=input.Position

startPos=obj.Position


end

end)



UIS.InputChanged:Connect(function(input)


if dragging and
input.UserInputType==
Enum.UserInputType.MouseMovement then



local delta=input.Position-dragStart



obj.Position=
UDim2.new(

startPos.X.Scale,

startPos.X.Offset+delta.X,

startPos.Y.Scale,

startPos.Y.Offset+delta.Y

)


end


end)



UIS.InputEnded:Connect(function(input)

if input.UserInputType==
Enum.UserInputType.MouseButton1 then

dragging=false

end


end)


end





------------------------------------------------
-- HEADER
------------------------------------------------


local Header=Instance.new("Frame")

Header.Parent=Main

Header.Size=
UDim2.new(1,0,0,45)

Header.BackgroundTransparency=1




local Title=Instance.new("TextLabel")

Title.Parent=Header

Title.Position=
UDim2.fromOffset(15,0)

Title.Size=
UDim2.new(.5,0,1,0)

Title.Text="TK HUB"

Title.TextColor3=
Color3.fromRGB(255,0,0)

Title.Font=
Enum.Font.GothamBold

Title.TextSize=20

Title.BackgroundTransparency=1





-- CLOSE


local Close=Instance.new("TextButton")

Close.Parent=Header

Close.Position=
UDim2.new(1,-40,.5,-15)

Close.Size=
UDim2.fromOffset(30,30)

Close.Text="X"

Close.BackgroundTransparency=1



Close.MouseButton1Click:Connect(function()

Gui:Destroy()

end)





-- MINIMIZE


local Mini=Instance.new("TextButton")

Mini.Parent=Header

Mini.Position=
UDim2.new(1,-80,.5,-15)

Mini.Size=
UDim2.fromOffset(30,30)

Mini.Text="-"

Mini.BackgroundTransparency=1





-- LOGO WHEN HIDE


local Open=Instance.new("ImageButton")

Open.Parent=Gui

Open.Size=
UDim2.fromOffset(55,55)

Open.Position=
UDim2.fromScale(.1,.1)

Open.Image=
"rbxassetid://88008118843799"

Open.Visible=false



Instance.new("UICorner",Open)



Mini.MouseButton1Click:Connect(function()

Main.Visible=false

Open.Visible=true

end)



Open.MouseButton1Click:Connect(function()

Main.Visible=true

Open.Visible=false

end)




MakeDrag(Main)

MakeDrag(Open)





------------------------------------------------
-- SIDEBAR
------------------------------------------------


local Side=Instance.new("Frame")

Side.Parent=Main

Side.Position=
UDim2.fromOffset(10,55)

Side.Size=
UDim2.fromOffset(130,280)

Side.BackgroundColor3=
Color3.fromRGB(25,25,25)



Instance.new("UICorner",Side)



local SideList=
Instance.new("UIListLayout",Side)

SideList.Padding=
UDim.new(0,6)





------------------------------------------------
-- CONTENT / PAGE
------------------------------------------------


local Content=Instance.new("Frame")

Content.Parent=Main

Content.Position=
UDim2.fromOffset(150,55)

Content.Size=
UDim2.new(1,-165,1,-65)

Content.BackgroundTransparency=1



local PageLayout=
Instance.new("UIPageLayout")


PageLayout.Parent=Content

PageLayout.TweenTime=.35

PageLayout.EasingStyle=
Enum.EasingStyle.Quart




local Pages={}





function CreateTab(name)


local Button=
Instance.new("TextButton")


Button.Parent=Side

Button.Size=
UDim2.new(1,-10,0,35)

Button.Text=name


Button.BackgroundColor3=
Color3.fromRGB(40,40,40)



local Page=
Instance.new("ScrollingFrame")


Page.Parent=Content

Page.Size=
UDim2.fromScale(1,1)

Page.BackgroundColor3=
Color3.fromRGB(20,20,20)

Page.AutomaticCanvasSize=
Enum.AutomaticSize.Y



Instance.new("UIListLayout",Page).Padding=
UDim.new(0,8)



Pages[name]=Page



Button.MouseButton1Click:Connect(function()

PageLayout:JumpTo(Page)

end)



return Page

end





------------------------------------------------
-- COMPONENTS
------------------------------------------------


function AddButton(page,text,func)


local b=Instance.new("TextButton")

b.Parent=page

b.Size=
UDim2.new(1,-20,0,40)

b.Text=text


b.MouseButton1Click:Connect(function()

if func then func() end

end)


end




function AddSlider(page,text,min,max,value,func)

-- slider code here

end




function AddDropdown(page,text,list,func)

-- dropdown code here

end




function AddKeybind(page,text,key,func)

-- keybind code here

end




function AddColorPicker(page,text,func)

-- color code here

end





------------------------------------------------
-- CONFIG
------------------------------------------------


function SaveConfig(name,data)

writefile(
"TK_"..name..".json",
HttpService:JSONEncode(data)
)

end






------------------------------------------------
-- RESIZE
------------------------------------------------


local Resize=
Instance.new("TextButton")


Resize.Parent=Main

Resize.Size=
UDim2.fromOffset(20,20)

Resize.Position=
UDim2.new(1,-20,1,-20)





------------------------------------------------
-- EXAMPLE
------------------------------------------------


local Home=
CreateTab("🏠 Home")


local Shop=
CreateTab("🛒 Shop")


local Setting=
CreateTab("⚙ Setting")



AddButton(
Home,
"Test",
function()

print("TK HUB")

end)



PageLayout:JumpTo(Home)
