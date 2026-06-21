--// TK HUB LIBRARY
--// Executor Version


local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")


local Player = Players.LocalPlayer



local Gui = Instance.new("ScreenGui")
Gui.Name="TK_HUB"
Gui.ResetOnSpawn=false
Gui.Parent=gethui and gethui() or game.CoreGui



local Main=Instance.new("Frame")
Main.Parent=Gui
Main.Size=UDim2.fromOffset(600,350)
Main.Position=UDim2.new(.5,-300,.5,-175)
Main.BackgroundColor3=Color3.fromRGB(15,15,15)
Main.ClipsDescendants=true


Instance.new("UICorner",Main).CornerRadius=
UDim.new(0,12)



-- DRAG

local drag=false
local dragStart
local startPos


Main.InputBegan:Connect(function(i)

if i.UserInputType==Enum.UserInputType.MouseButton1 then

drag=true
dragStart=i.Position
startPos=Main.Position

end

end)


UIS.InputChanged:Connect(function(i)

if drag and i.UserInputType==Enum.UserInputType.MouseMovement then

local d=i.Position-dragStart

Main.Position=
UDim2.new(
startPos.X.Scale,
startPos.X.Offset+d.X,
startPos.Y.Scale,
startPos.Y.Offset+d.Y
)

end

end)


UIS.InputEnded:Connect(function(i)

if i.UserInputType==Enum.UserInputType.MouseButton1 then
drag=false
end

end)



-- HEADER


local Header=Instance.new("Frame")
Header.Parent=Main
Header.Size=UDim2.new(1,0,0,45)
Header.BackgroundTransparency=1



local Title=Instance.new("TextLabel")
Title.Parent=Header
Title.Position=UDim2.fromOffset(15,0)
Title.Size=UDim2.new(.5,0,1,0)
Title.Text="TK HUB"
Title.TextColor3=Color3.fromRGB(255,0,0)
Title.Font=Enum.Font.GothamBold
Title.TextSize=20
Title.BackgroundTransparency=1



local Close=Instance.new("TextButton")
Close.Parent=Header
Close.Position=UDim2.new(1,-40,.5,-15)
Close.Size=UDim2.fromOffset(30,30)
Close.Text="X"
Close.BackgroundTransparency=1
Close.TextColor3=Color3.new(1,1,1)


Close.MouseButton1Click:Connect(function()
Gui:Destroy()
end)

-- MINIMIZE BUTTON

local Mini=Instance.new("TextButton")

Mini.Parent=Header

Mini.Position=
UDim2.new(1,-80,.5,-15)

Mini.Size=
UDim2.fromOffset(30,30)

Mini.Text="-"

Mini.TextColor3=
Color3.new(1,1,1)

Mini.BackgroundTransparency=1



local Open=Instance.new("ImageButton")

Open.Parent=Gui

Open.Size=
UDim2.fromOffset(55,55)

Open.Position=
UDim2.fromScale(.1,.1)

Open.Image=
"rbxassetid://88008118843799"

Open.BackgroundColor3=
Color3.fromRGB(20,20,20)

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



-- SIDEBAR


local Side=Instance.new("Frame")
Side.Parent=Main
Side.Position=UDim2.fromOffset(10,55)
Side.Size=UDim2.fromOffset(130,280)
Side.BackgroundColor3=Color3.fromRGB(25,25,25)


Instance.new("UICorner",Side)



local SideList=Instance.new("UIListLayout",Side)

SideList.Padding=
UDim.new(0,6)





-- CONTENT


local Content=Instance.new("Frame")

Content.Parent=Main

Content.Position=
UDim2.fromOffset(150,55)

Content.Size=
UDim2.new(1,-165,1,-65)

Content.BackgroundTransparency=1

Content.ClipsDescendants=true



local PageLayout=Instance.new("UIPageLayout")

PageLayout.Parent=Content

PageLayout.TweenTime=.35

PageLayout.EasingStyle=
Enum.EasingStyle.Quart




local Pages={}



function CreateTab(name)


local b=Instance.new("TextButton")

b.Parent=Side

b.Size=
UDim2.new(1,-10,0,35)

b.Text=name

b.BackgroundColor3=
Color3.fromRGB(40,40,40)

b.TextColor3=Color3.new(1,1,1)



Instance.new("UICorner",b)



local page=Instance.new("ScrollingFrame")

page.Parent=Content

page.Size=
UDim2.fromScale(1,1)

page.BackgroundColor3=
Color3.fromRGB(20,20,20)

page.AutomaticCanvasSize=
Enum.AutomaticSize.Y

page.ScrollBarThickness=3



Instance.new("UICorner",page)



local layout=Instance.new("UIListLayout",page)

layout.Padding=
UDim.new(0,8)

layout.SortOrder=
Enum.SortOrder.LayoutOrder



Pages[name]=page



b.MouseButton1Click:Connect(function()

PageLayout:JumpTo(page)

end)



return page

end






-- BUTTON


function AddButton(page,text,func)


local b=Instance.new("TextButton")

b.Parent=page

b.Size=
UDim2.new(1,-20,0,40)

b.Text=text

b.BackgroundColor3=
Color3.fromRGB(45,45,45)

b.TextColor3=
Color3.new(1,1,1)


Instance.new("UICorner",b)



b.MouseButton1Click:Connect(function()

if func then
func()
end

end)

end







-- SLIDER


function AddSlider(page,text,min,max,value,func)


local b=Instance.new("TextButton")

b.Parent=page

b.Size=
UDim2.new(1,-20,0,40)

b.Text=text.." : "..value

b.BackgroundColor3=
Color3.fromRGB(45,45,45)

b.TextColor3=
Color3.new(1,1,1)


Instance.new("UICorner",b)



local hold=false


b.MouseButton1Down:Connect(function()

hold=true

end)


UIS.InputEnded:Connect(function(i)

if i.UserInputType==Enum.UserInputType.MouseButton1 then
hold=false
end

end)


UIS.InputChanged:Connect(function(i)

if hold then


local p=
math.clamp(
(i.Position.X-b.AbsolutePosition.X)
/b.AbsoluteSize.X,
0,
1
)


value=
math.floor(
min+(max-min)*p
)


b.Text=text.." : "..value


if func then
func(value)
end


end

end)


end






-- DROPDOWN


function AddDropdown(page,text,list,func)


AddButton(page,text,function()


for _,v in pairs(list) do


AddButton(page,v,function()

if func then
func(v)
end

end)


end


end)

end






-- KEYBIND


function AddKeybind(page,text,key,func)


UIS.InputBegan:Connect(function(i)


if i.KeyCode==key then

if func then
func()
end

end


end)



AddButton(page,text.." ["..key.Name.."]")

end







-- COLOR


function AddColorPicker(page,text,func)


AddButton(page,text,function()


local c=
Color3.fromHSV(
math.random(),
1,
1
)


if func then
func(c)
end


end)

end







-- CONFIG


function SaveConfig(name,data)

writefile(
"TK_"..name..".json",
HttpService:JSONEncode(data)
)

end


function LoadConfig(name)

if isfile("TK_"..name..".json") then

return HttpService:JSONDecode(
readfile("TK_"..name..".json")
)

end

return {}

end








-- RESIZE


local Resize=Instance.new("TextButton")

Resize.Parent=Main

Resize.Size=UDim2.fromOffset(20,20)

Resize.Position=UDim2.new(1,-20,1,-20)

Resize.Text=""


local resize=false


Resize.MouseButton1Down:Connect(function()

resize=true

end)



UIS.InputEnded:Connect(function(i)

if i.UserInputType==Enum.UserInputType.MouseButton1 then
resize=false
end

end)



UIS.InputChanged:Connect(function(i)

if resize and i.UserInputType==Enum.UserInputType.MouseMovement then


Main.Size=
UDim2.fromOffset(
Main.AbsoluteSize.X+i.Delta.X,
Main.AbsoluteSize.Y+i.Delta.Y
)


end

end)






-- EXAMPLE


local Home=CreateTab("🏠 Home")

local Shop=CreateTab("🛒 Shop")

local Setting=CreateTab("⚙ Setting")



AddButton(Home,"Test",function()

print("TK HUB")

end)


AddSlider(Home,"Speed",1,100,50,function(v)

print(v)

end)



AddDropdown(Home,"Mode",
{
"Normal",
"Fast",
"Ultra"
},
function(v)

print(v)

end)



AddKeybind(Home,"Toggle UI",
Enum.KeyCode.RightShift,
function()

Main.Visible=
not Main.Visible

end)



AddColorPicker(Home,"Color",function(c)

Main.BackgroundColor3=c

end)



SaveConfig(
"Settings",
{
Speed=50
}
)



PageLayout:JumpTo(Home)
