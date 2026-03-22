-- ╔══════════════════════════════════════════════╗
-- ║          LYNX LIBRARY  v4.0.0               ║
-- ║    Premium Visuals | PC + Mobile            ║
-- ╚══════════════════════════════════════════════╝

local LynxLib   = {}
LynxLib.__index = LynxLib

-- ══════════════════
--  SERVICES
-- ══════════════════
local TS  = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS  = game:GetService("RunService")
local PLS = game:GetService("Players")
local LP  = PLS.LocalPlayer

-- ══════════════════
--  COLORS (Refined Purple Theme)
-- ══════════════════
local C = {
    MainBG      = Color3.fromRGB(13, 11, 22),
    SidebarBG   = Color3.fromRGB(18, 14, 28),
    TopbarBG    = Color3.fromRGB(15, 12, 24),
    ContentBG   = Color3.fromRGB(15, 12, 24),
    TabActive   = Color3.fromRGB(60, 25, 95),
    Purple      = Color3.fromRGB(138, 43, 226),
    PurpleL     = Color3.fromRGB(168, 85, 247),
    White       = Color3.fromRGB(255, 255, 255),
    DimText     = Color3.fromRGB(160, 150, 180),
    Stroke      = Color3.fromRGB(35, 28, 55),
    Red         = Color3.fromRGB(220, 55, 55),
    Element     = Color3.fromRGB(22, 18, 35),
    SectionLine = Color3.fromRGB(138, 43, 226),
}

-- ══════════════════
--  UTILS
-- ══════════════════
local function TW(o, p, t, s, d)
    if not o or not o.Parent then return end
    TS:Create(o, TweenInfo.new(t or .2, s or Enum.EasingStyle.Quart, d or Enum.EasingDirection.Out), p):Play()
end
local function N(cls, props, ch)
    local o = Instance.new(cls)
    for k,v in pairs(props or {}) do if k~="Parent" then o[k]=v end end
    for _,c in ipairs(ch or {}) do c.Parent=o end
    if props and props.Parent then o.Parent=props.Parent end
    return o
end
local function CR(p,r)  return N("UICorner",{CornerRadius=UDim.new(0,r or 8),Parent=p}) end
local function STR(p,c,t,tr) return N("UIStroke",{Color=c or C.Stroke,Thickness=t or 1,Transparency=tr or 0,Parent=p}) end
local function PAD(p,a,b,l,r) return N("UIPadding",{PaddingTop=UDim.new(0,a or 6),PaddingBottom=UDim.new(0,b or 6),PaddingLeft=UDim.new(0,l or 10),PaddingRight=UDim.new(0,r or 10),Parent=p}) end

-- ══════════════════
--  DRAG SYSTEM
-- ══════════════════
local _dragTarget, _dragStartM, _dragStartP, _dragMoved
UIS.InputChanged:Connect(function(i)
    if not _dragTarget or not _dragTarget.Parent then return end
    if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
    local dx, dy = i.Position.X - _dragStartM.X, i.Position.Y - _dragStartM.Y
    if not _dragMoved then if math.abs(dx) < 6 and math.abs(dy) < 6 then return end; _dragMoved = true end
    _dragTarget.Position = UDim2.new(0, _dragStartP.X + dx, 0, _dragStartP.Y + dy)
end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then _dragTarget=nil end end)
local function Draggable(win, handle)
    handle.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            _dragTarget=win; _dragStartM=Vector2.new(i.Position.X, i.Position.Y); _dragStartP=Vector2.new(win.AbsolutePosition.X, win.AbsolutePosition.Y); _dragMoved=false
        end
    end)
end

-- ══════════════════════════════════════════════════════════
--  MAKE WINDOW
-- ══════════════════════════════════════════════════════════
function LynxLib:MakeWindow(opts)
    opts=opts or {}
    local GUI=N("ScreenGui",{Name="LynxScripts",IgnoreGuiInset=true,ResetOnSpawn=false,Parent=LP:WaitForChild("PlayerGui")})
    local Main=N("Frame",{Position=UDim2.new(0.5,-300,0.5,-200),Size=UDim2.new(0,600,0,380),BackgroundColor3=C.MainBG,Parent=GUI})
    CR(Main,12); STR(Main,C.Purple,1.5,0.4)
    
    -- TOPBAR
    local Topbar=N("Frame",{Size=UDim2.new(1,0,0,44),BackgroundColor3=C.TopbarBG,ZIndex=3,Parent=Main})
    CR(Topbar,12); N("Frame",{Position=UDim2.new(0,0,0.6,0),Size=UDim2.new(1,0,0.4,0),BackgroundColor3=C.TopbarBG,BorderSizePixel=0,Parent=Topbar})
    
    -- "LynxScritps" branding
    N("TextLabel",{Position=UDim2.new(0,14,0.5,-10),Size=UDim2.new(0,120,0,20),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=18,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,RichText=true,Text='Lyn<font color="rgb(138,43,226)">x</font>Scritps',ZIndex=5,Parent=Topbar})
    
    local DragZone=N("TextButton",{Position=UDim2.new(0,140,0,0),Size=UDim2.new(1,-240,1,0),BackgroundTransparency=1,Text="",ZIndex=4,Parent=Topbar})
    Draggable(Main, DragZone)
    
    -- Circular Controls (Matching screenshot vibe)
    local Close=N("TextButton",{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-12,0.5,0),Size=UDim2.new(0,24,0,24),BackgroundColor3=C.Red,Text="✕",Font=Enum.Font.GothamBold,TextColor3=C.White,TextSize=10,ZIndex=5,Parent=Topbar})
    CR(Close,12); Close.Activated:Connect(function() GUI:Destroy() end)
    local Min=N("TextButton",{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-42,0.5,0),Size=UDim2.new(0,24,0,24),BackgroundColor3=C.TabActive,Text="−",Font=Enum.Font.GothamBold,TextColor3=C.White,TextSize=14,ZIndex=5,Parent=Topbar})
    CR(Min,12); Min.Activated:Connect(function() Main.Visible=not Main.Visible end)

    -- BODY
    local Body=N("Frame",{Position=UDim2.new(0,0,0,44),Size=UDim2.new(1,0,1,-44),BackgroundTransparency=1,Parent=Main})
    local Sidebar=N("Frame",{Size=UDim2.new(0,165,1,0),BackgroundColor3=C.SidebarBG,Parent=Body})
    CR(Sidebar,12);	N("Frame",{Position=UDim2.new(0,160,0,0),Size=UDim2.new(0,5,1,0),BackgroundColor3=C.SidebarBG,BorderSizePixel=0,Parent=Sidebar})
    STR(Sidebar,C.Stroke); PAD(Sidebar,10,12,10,10)
    
    local TabScroll=N("ScrollingFrame",{Size=UDim2.new(1,0,1,-60),BackgroundTransparency=1,ScrollBarThickness=0,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Parent=Sidebar})
    N("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,Parent=TabScroll})

    -- USER PROFILE
    local User=N("Frame",{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,0,1,0),Size=UDim2.new(1,0,0,50),BackgroundColor3=C.Element,Parent=Sidebar})
    CR(User,25); PAD(User,0,0,8,8)
    local Avatar=N("ImageLabel",{Position=UDim2.new(0,0,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundColor3=C.SidebarBG,Parent=User})
    CR(Avatar,16); STR(Avatar,C.Purple,1)
    task.spawn(function() Avatar.Image = PLS:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100) end)
    N("TextLabel",{Position=UDim2.new(0,38,0.5,-12),Size=UDim2.new(1,-40,0,14),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.White,Text=LP.DisplayName,TextXAlignment=Enum.TextXAlignment.Left,Parent=User})
    N("TextLabel",{Position=UDim2.new(0,38,0.5,0),Size=UDim2.new(1,-40,0,14),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.DimText,Text="@"..LP.Name,TextXAlignment=Enum.TextXAlignment.Left,Parent=User})

    -- CONTENT
    local Content=N("Frame",{Position=UDim2.new(0,170,0,6),Size=UDim2.new(1,-176,1,-12),BackgroundColor3=C.ContentBG,Parent=Body})
    CR(Content,12); STR(Content,C.Stroke,1,0.5)
    local ContentScroll=N("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ScrollBarThickness=2,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Parent=Content})
    N("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=ContentScroll})
    PAD(ContentScroll, 12,12,12,12)

    local Win = { _tabs={}, _btns={}, _active=nil }
    
    function Win:MakeTab(o4)
        local tName=o4[1] or "Tab"; local tIcon=o4[2] or "rbxassetid://10723407389"
        local TB=N("TextButton",{Size=UDim2.new(1,0,0,40),BackgroundColor3=C.SidebarBG,BackgroundTransparency=1,Text="",AutoButtonColor=false,Parent=TabScroll})
        CR(TB,10)
        local Icon=N("ImageLabel",{Position=UDim2.new(0,8,0.5,-10),Size=UDim2.new(0,20,0,20),BackgroundTransparency=1,Image=tIcon,ImageColor3=C.DimText,Parent=TB})
        local Text=N("TextLabel",{Position=UDim2.new(0,36,0,0),Size=UDim2.new(1,-40,1,0),BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=12,TextColor3=C.DimText,Text=tName,TextXAlignment=Enum.TextXAlignment.Left,Parent=TB})
        
        local Holder=N("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false,Parent=ContentScroll})
        N("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=Holder})
        
        local TabObj = { _holder = Holder }
        function TabObj:AddSection(nm)
            local S=N("Frame",{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,Parent=Holder})
            local L=N("TextLabel",{Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=0,BackgroundColor3=C.SidebarBG,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.PurpleL,Text="  "..nm.."  ",Parent=S})
            CR(L,4); STR(L,C.Purple,1,0.5)
            return S
        end
        function TabObj:AddButton(nm, cb)
            local B=N("TextButton",{Size=UDim2.new(1,0,0,44),BackgroundColor3=C.Element,Text="",AutoButtonColor=false,Parent=Holder})
            CR(B,10); STR(B,C.Stroke)
            N("TextLabel",{Position=UDim2.new(0,14,0,0),Size=UDim2.new(1,-50,1,0),BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=14,TextColor3=C.White,Text=nm,TextXAlignment=Enum.TextXAlignment.Left,Parent=B})
            local Arrow=N("ImageLabel",{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,24,0,24),BackgroundTransparency=1,Image="rbxassetid://15113922617",ImageColor3=C.PurpleL,Parent=B})
            B.MouseEnter:Connect(function() TW(B,{BackgroundColor3=C.TabActive},.12) end)
            B.MouseLeave:Connect(function() TW(B,{BackgroundColor3=C.Element},.12) end)
            B.Activated:Connect(cb or function()end)
            return B
        end
        function TabObj:AddToggle(nm, def, cb)
            local st=def; local T=N("TextButton",{Size=UDim2.new(1,0,0,44),BackgroundColor3=C.Element,Text="",AutoButtonColor=false,Parent=Holder})
            CR(T,10); STR(T,C.Stroke)
            N("TextLabel",{Position=UDim2.new(0,14,0,0),Size=UDim2.new(1,-80,1,0),BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=14,TextColor3=C.White,Text=nm,TextXAlignment=Enum.TextXAlignment.Left,Parent=T})
            local Track=N("Frame",{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,40,0,20),BackgroundColor3=st and C.Purple or C.SidebarBG,Parent=T})
            CR(Track,10); local Knob=N("Frame",{Position=st and UDim2.new(0,22,0,2) or UDim2.new(0,2,0,2),Size=UDim2.new(0,16,0,16),BackgroundColor3=C.White,Parent=Track}) CR(Knob,8)
            T.Activated:Connect(function() st=not st; TW(Track,{BackgroundColor3=st and C.Purple or C.SidebarBG},.2); TW(Knob,{Position=st and UDim2.new(0,22,0,2) or UDim2.new(0,2,0,2)},.2); pcall(cb,st) end)
            return T
        end
        
        local function Select()
            for i,v in ipairs(Win._btns) do 
                TW(v,{BackgroundTransparency=1},.15); TW(v:FindFirstChildWhichIsA("TextLabel"),{TextColor3=C.DimText},.15)
                TW(v:FindFirstChildWhichIsA("ImageLabel"),{ImageColor3=C.DimText},.15); Win._tabs[i]._holder.Visible=false 
            end
            TW(TB,{BackgroundTransparency=0,BackgroundColor3=C.TabActive},.15)
            TW(Text,{TextColor3=C.White},.15); TW(Icon,{ImageColor3=C.White},.15)
            Holder.Visible=true; Win._active=TabObj
        end
        table.insert(Win._tabs, TabObj); table.insert(Win._btns, TB)
        TB.Activated:Connect(Select); if #Win._tabs==1 then Select() end
        return TabObj
    end
    
    function LynxLib:Notify(o)
        local Notif=N("Frame",{AnchorPoint=Vector2.new(0.5,0),Position=UDim2.new(0.5,0,0,-100),Size=UDim2.new(0,280,0,50),BackgroundColor3=C.SidebarBG,Parent=GUI})
        CR(Notif,10); STR(Notif,C.Purple,1)
        N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=C.White,Text=o.Description or "",Parent=Notif})
        TW(Notif,{Position=UDim2.new(0.5,0,0,20)},.4); task.delay(3,function() TW(Notif,{Position=UDim2.new(0.5,0,0,-100)},.4); task.delay(.5,function() Notif:Destroy() end) end)
    end

    return Win
end

-- ═══════════════════════════════════════════════
--  STANDALONE EXECUTION
--  Este bloco garante que o menu abra sozinho se você 
--  apenas executar o link do GitHub.
-- ═══════════════════════════════════════════════

local function LoadMenu()
    local Win = LynxLib:MakeWindow({
        SubTitle = "v4.0.0 | Premium Visuals"
    })

    local Geral = Win:MakeTab({ "Geral", "rbxassetid://10723407389" })
    Geral:AddSection("Navegação")
    Geral:AddButton("Home", function() print("Home Clicked") end)
    Geral:AddButton("Menu", function() print("Menu Clicked") end)
    Geral:AddButton("Sidebar", function() print("Sidebar Clicked") end)
    Geral:AddButton("Layout", function() print("Layout Clicked") end)

    local Usuario = Win:MakeTab({ "Usuário", "rbxassetid://10747373176" })
    local Sistema = Win:MakeTab({ "Sistema", "rbxassetid://10709819149" })
    local Combate = Win:MakeTab({ "Combate", "rbxassetid://10709752906" })

    LynxLib:Notify({ Description = "LynxScripts Carregado com Sucesso!" })
end

-- Se o script for executado diretamente (sem ser via require/loadstring capturando o retorno)
-- ou se você quiser que ele abra sempre por padrão:
task.spawn(function()
    if not game:IsLoaded() then game.Loaded:Wait() end
    LoadMenu()
end)

return LynxLib
