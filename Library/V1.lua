--// TK HUB UI LIBRARY
--// Executor Version


local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")


local Player = Players.LocalPlayer



local TK = {}



-- GUI


local Gui = Instance.new("ScreenGui")
Gui.Name="TK_HUB"
Gui.Parent=game:GetService("CoreGui")



local Main = Instance.new("Frame")
Main.Parent=Gui
Main.Size=UDim2.fromOffset(600,350)
Main.Position=UDim2.new(.5,-300,.5,-175)
Main.BackgroundColor3=Color3.fromRGB(15,15,15)


Instance.new("UICorner",Main).CornerRadius=
UDim.new(0,12)



local Header = Instance.new("Frame")
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





-- DRAG


local Dragging=false
local DragStart
local StartPos


Header.InputBegan:Connect(function(i)

if i.UserInputType==Enum.UserInputType.MouseButton1 then

Dragging=true
DragStart=i.Position
StartPos=Main.Position

end

end)


UIS.InputChanged:Connect(function(i)

if Dragging and i.UserInputType==Enum.UserInputType.MouseMovement then

local d=i.Position-DragStart

Main.Position=
UDim2.new(
StartPos.X.Scale,
StartPos.X.Offset+d.X,
StartPos.Y.Scale,
StartPos.Y.Offset+d.Y
)

end

end)


UIS.InputEnded:Connect(function(i)

if i.UserInputType==Enum.UserInputType.MouseButton1 then

Dragging=false

end

end)






-- CLOSE


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







-- MINIMIZE


local Mini=Instance.new("TextButton")

Mini.Parent=Header

Mini.Position=UDim2.new(1,-80,.5,-15)

Mini.Size=UDim2.fromOffset(30,30)

Mini.Text="-"

Mini.BackgroundTransparency=1

Mini.TextColor3=Color3.new(1,1,1)




local Open=Instance.new("TextButton")

Open.Parent=Gui

Open.Size=UDim2.fromOffset(50,50)

Open.Position=UDim2.fromScale(.1,.1)

Open.Text="TK"

Open.Visible=false


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

SideList.Padding=UDim.new(0,5)






-- CONTENT


local Content=Instance.new("Frame")

Content.Parent=Main

Content.Position=UDim2.fromOffset(150,55)

Content.Size=UDim2.new(1,-165,1,-65)

Content.BackgroundTransparency=1

Content.ClipsDescendants=true



local PageLayout=Instance.new("UIPageLayout")

PageLayout.Parent=Content

PageLayout.TweenTime=.3

PageLayout.EasingStyle=Enum.EasingStyle.Quart







local Pages={}




function CreateTab(name)


local Button=Instance.new("TextButton")

Button.Parent=Side

Button.Size=UDim2.new(1,-10,0,35)

Button.Text=name

Button.BackgroundColor3=
Color3.fromRGB(40,40,40)

Button.TextColor3=Color3.new(1,1,1)



Instance.new("UICorner",Button)



local Page=Instance.new("ScrollingFrame")

Page.Parent=Content

Page.Size=UDim2.fromScale(1,1)

Page.AutomaticCanvasSize=
Enum.AutomaticSize.Y

Page.ScrollBarThickness=3

Page.ClipsDescendants=true



Instance.new("UICorner",Page)



local List=Instance.new("UIListLayout",Page)

List.Padding=UDim.new(0,8)
List.SortOrder=
Enum.SortOrder.LayoutOrder


Pages[name]=Page



Button.MouseButton1Click:Connect(function()

Home.Visible=true

end)



return Page

end







-- BUTTON


function AddButton(page,text,callback)


local b=Instance.new("TextButton")

b.Parent=page

b.Size=UDim2.new(1,-20,0,40)

b.Text=text

b.BackgroundColor3=
Color3.fromRGB(45,45,45)

b.TextColor3=Color3.new(1,1,1)


Instance.new("UICorner",b)



b.MouseButton1Click:Connect(function()

if callback then

callback()

end

end)


end







-- SLIDER


function AddSlider(page,text,min,max,value,callback)


local b=Instance.new("TextButton")

b.Parent=page

b.Size=UDim2.new(1,-20,0,45)

b.Text=text.." : "..value

b.BackgroundColor3=
Color3.fromRGB(40,40,40)

b.TextColor3=Color3.new(1,1,1)



Instance.new("UICorner",b)



local dragging=false



b.MouseButton1Down:Connect(function()

dragging=true

end)


UIS.InputEnded:Connect(function(i)

if i.UserInputType==Enum.UserInputType.MouseButton1 then

dragging=false

end

end)



UIS.InputChanged:Connect(function(i)

if dragging then


local percent=
math.clamp(
(i.Position.X-b.AbsolutePosition.X)
/b.AbsoluteSize.X,
0,
1
)


value=
math.floor(
min+(max-min)*percent
)


b.Text=text.." : "..value


if callback then

callback(value)

end


end

end)


end







-- DROPDOWN


function AddDropdown(page,text,list,callback)


local b=Instance.new("TextButton")

b.Parent=page

b.Size=UDim2.new(1,-20,0,40)

b.Text=text

b.BackgroundColor3=
Color3.fromRGB(40,40,40)

b.TextColor3=Color3.new(1,1,1)



Instance.new("UICorner",b)



b.MouseButton1Click:Connect(function()


for _,v in pairs(list) do


local o=Instance.new("TextButton")

o.Parent=page

o.Size=UDim2.new(1,-20,0,30)

o.Text=v


o.MouseButton1Click:Connect(function()

b.Text=text.." : "..v


if callback then

callback(v)

end


o:Destroy()

end)


end


end)


end







-- KEYBIND


function AddKeybind(page,text,key,callback)


UIS.InputBegan:Connect(function(i)


if i.KeyCode==key then


if callback then

callback()

end


end


end)



AddButton(page,text.." ["..key.Name.."]")

end







-- COLOR


function AddColorPicker(page,text,callback)


AddButton(page,text,function()


local c=Color3.fromHSV(
math.random(),
1,
1
)


if callback then

callback(c)

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



local resizing=false



Resize.MouseButton1Down:Connect(function()

resizing=true

end)



UIS.InputEnded:Connect(function(i)

if i.UserInputType==Enum.UserInputType.MouseButton1 then

resizing=false

end

end)



UIS.InputChanged:Connect(function(i)

if resizing and i.UserInputType==Enum.UserInputType.MouseMovement then


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



AddButton(Home,"Test Button",function()

print("Click")

end)



AddSlider(Home,"Speed",1,100,50,function(v)

print(v)

end)



AddDropdown(Home,"Mode",
{"Normal","Fast","Ultra"},
function(v)

print(v)

end)



AddKeybind(Home,"Open Menu",
Enum.KeyCode.RightShift,
function()

Main.Visible=not Main.Visible

end)



AddColorPicker(Home,"Color",function(c)

Main.BackgroundColor3=c

end)



SaveConfig(
"Settings",
{
Speed=50,
Mode="Fast"
}

)


PageLayout:JumpTo(Home)
return TK
