--// TK HUB LIBRARY - CLEAN VERSION

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

-- Khởi tạo giao diện chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TK_HUB_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or game.CoreGui

-- Tạo khung Main
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.fromOffset(600, 350)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Màu tối hơn, sang trọng hơn
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- 

-----------------------------------------------------------
-- CÁC HÀM HỖ TRỢ (UI UTILITIES)
-----------------------------------------------------------

-- Hàm tạo bo góc nhanh
local function AddCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

-- Hàm kéo thả menu
local function MakeDraggable(uiObject)
    local drag, dragStart, startPos
    
    uiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            dragStart = input.Position
            startPos = uiObject.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if drag and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            uiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = false
        end
    end)
end

MakeDraggable(MainFrame)

-----------------------------------------------------------
-- THIẾT KẾ GIAO DIỆN (UI COMPONENTS)
-----------------------------------------------------------

-- 1. Header (Tiêu đề)
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Position = UDim2.fromOffset(15, 0)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Text = "TK HUB - Dashboard"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- 2. Sidebar (Danh mục)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Position = UDim2.fromOffset(10, 55)
Sidebar.Size = UDim2.fromOffset(130, 280)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AddCorner(Sidebar)

local ListLayout = Instance.new("UIListLayout", Sidebar)
ListLayout.Padding = UDim.new(0, 5)

-- 3. Content (Nội dung)
local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Position = UDim2.fromOffset(150, 55)
ContentContainer.Size = UDim2.new(1, -165, 1, -65)
ContentContainer.BackgroundTransparency = 1

local PageLayout = Instance.new("UIPageLayout", ContentContainer)
PageLayout.TweenTime = 0.3

-----------------------------------------------------------
-- HỆ THỐNG TAB VÀ CONTROLS
-----------------------------------------------------------

function CreateTab(name)
    local TabButton = Instance.new("TextButton", Sidebar)
    TabButton.Size = UDim2.new(1, -10, 0, 35)
    TabButton.Text = name
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.TextColor3 = Color3.new(1, 1, 1)
    AddCorner(TabButton)

    local Page = Instance.new("ScrollingFrame", ContentContainer)
    Page.Size = UDim2.fromScale(1, 1)
    Page.BackgroundTransparency = 1
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    TabButton.MouseButton1Click:Connect(function()
        PageLayout:JumpTo(Page)
    end)
    
    return Page
end

-- 

--// VÍ DỤ SỬ DỤNG
local HomeTab = CreateTab("🏠 Home")

-- Hàm thêm nút bấm
function AddButton(page, text, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    AddCorner(btn)
    btn.MouseButton1Click:Connect(callback or function() end)
end

AddButton(HomeTab, "Click Me!", function()
    print("Button Pressed!")
end)
