--// ADVANCED COMPONENTS


local HttpService = game:GetService("HttpService")



-- UI PAGE ANIMATION

local PageLayout = Instance.new("UIPageLayout")

PageLayout.Parent = Content

PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

PageLayout.EasingStyle = Enum.EasingStyle.Quart

PageLayout.EasingDirection = Enum.EasingDirection.Out

PageLayout.TweenTime = .35






-- SLIDER


function AddSlider(page,text,min,max,default,callback)


local Value=default



local Frame=Instance.new("Frame")

Frame.Parent=page

Frame.Size=UDim2.new(1,-20,0,60)

Frame.BackgroundColor3=
Color3.fromRGB(35,35,35)


Instance.new("UICorner",Frame)



local Label=Instance.new("TextLabel")

Label.Parent=Frame

Label.Size=UDim2.new(1,0,0,25)

Label.Text=text.." : "..Value

Label.TextColor3=Color3.new(1,1,1)

Label.BackgroundTransparency=1




local Bar=Instance.new("Frame")

Bar.Parent=Frame

Bar.Position=UDim2.fromOffset(10,35)

Bar.Size=UDim2.new(.9,0,0,8)

Bar.BackgroundColor3=
Color3.fromRGB(70,70,70)


Instance.new("UICorner",Bar)




local Fill=Instance.new("Frame")

Fill.Parent=Bar

Fill.Size=
UDim2.new(
(Value-min)/(max-min),
0,
1,
0
)

Fill.BackgroundColor3=
Color3.fromRGB(255,0,0)


Instance.new("UICorner",Fill)




Bar.InputBegan:Connect(function(input)

if input.UserInputType ==
Enum.UserInputType.MouseButton1 then


local percent =
math.clamp(
(input.Position.X-Bar.AbsolutePosition.X)
/Bar.AbsoluteSize.X,
0,
1
)


Value =
math.floor(
min+(max-min)*percent
)


Fill.Size=
UDim2.new(percent,0,1,0)


Label.Text=
text.." : "..Value


if callback then
callback(Value)
end


end


end)



end







-- DROPDOWN



function AddDropdown(page,text,list,callback)


local Open=false



local Button=Instance.new("TextButton")

Button.Parent=page

Button.Size=
UDim2.new(1,-20,0,40)

Button.Text=text

Button.BackgroundColor3=
Color3.fromRGB(40,40,40)

Button.TextColor3=
Color3.new(1,1,1)



Instance.new("UICorner",Button)



local Menu=Instance.new("Frame")

Menu.Parent=page

Menu.Size=
UDim2.new(1,-20,0,#list*35)

Menu.Visible=false

Menu.BackgroundColor3=
Color3.fromRGB(25,25,25)



local layout=Instance.new("UIListLayout",Menu)



for _,item in pairs(list) do


local Option=Instance.new("TextButton")

Option.Parent=Menu

Option.Size=
UDim2.new(1,0,0,35)

Option.Text=item

Option.TextColor3=
Color3.new(1,1,1)

Option.BackgroundColor3=
Color3.fromRGB(50,50,50)



Option.MouseButton1Click:Connect(function()

Button.Text=text.." : "..item

Menu.Visible=false


if callback then

callback(item)

end


end)


end





Button.MouseButton1Click:Connect(function()

Open=not Open

Menu.Visible=Open


end)



end







-- KEYBIND



function AddKeybind(page,text,key,callback)



local Button=Instance.new("TextButton")

Button.Parent=page

Button.Size=
UDim2.new(1,-20,0,40)

Button.Text=
text.." ["..key.Name.."]"


Button.BackgroundColor3=
Color3.fromRGB(40,40,40)

Button.TextColor3=
Color3.new(1,1,1)


Instance.new("UICorner",Button)




local Current=key



UIS.InputBegan:Connect(function(input,gp)

if gp then return end


if input.KeyCode==Current then


if callback then

callback()

end


end


end)





Button.MouseButton1Click:Connect(function()


Button.Text="Press Key..."


local con


con=UIS.InputBegan:Connect(function(input)


if input.KeyCode ~= Enum.KeyCode.Unknown then


Current=input.KeyCode


Button.Text=
text.." ["..Current.Name.."]"


con:Disconnect()


end


end)



end)



end








-- COLOR PICKER


function AddColorPicker(page,text,callback)



local Color=Color3.fromRGB(255,0,0)



local Button=Instance.new("TextButton")

Button.Parent=page

Button.Size=
UDim2.new(1,-20,0,40)

Button.Text=text

Button.BackgroundColor3=Color


Button.TextColor3=
Color3.new(1,1,1)


Instance.new("UICorner",Button)





Button.MouseButton1Click:Connect(function()


Color =
Color3.fromHSV(
math.random(),
1,
1
)


Button.BackgroundColor3=Color


if callback then

callback(Color)

end


end)


end









-- SAVE CONFIG


local Config={}



function SaveConfig(name,data)


Config[name]=data



writefile(
"TK_"..name..".json",
HttpService:JSONEncode(Config[name])
)



end





function LoadConfig(name)


if isfile("TK_"..name..".json") then


return HttpService:JSONDecode(
readfile("TK_"..name..".json")
)


end



return nil


end







-- RESIZE CORNER


local Resize=Instance.new("TextButton")

Resize.Parent=Main

Resize.Size=
UDim2.fromOffset(20,20)

Resize.Position=
UDim2.new(1,-20,1,-20)

Resize.Text=""

Resize.BackgroundColor3=
Color3.fromRGB(255,0,0)


Instance.new("UICorner",Resize)



local resizing=false

local start


Resize.MouseButton1Down:Connect(function()

resizing=true

start=Main.Size

end)



UIS.InputEnded:Connect(function(input)

if input.UserInputType==
Enum.UserInputType.MouseButton1 then

resizing=false

end

end)




UIS.InputChanged:Connect(function(input)

if resizing and input.UserInputType ==
Enum.UserInputType.MouseMovement then


Main.Size =
UDim2.fromOffset(
math.max(400,start.X.Offset+input.Delta.X),
math.max(250,start.Y.Offset+input.Delta.Y)
)


end


end)
