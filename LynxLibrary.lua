-- ╔══════════════════════════════════════════════╗
-- ║          LYNX LIBRARY  v3.0.0               ║
-- ║    Purple & Black | PC + Mobile             ║
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
--  MOBILE DETECT
-- ══════════════════
local function Mobile()
    return UIS.TouchEnabled and not UIS.MouseEnabled
end
local function VPS()
    return workspace.CurrentCamera.ViewportSize
end

-- ══════════════════
--  COLORS
-- ══════════════════
local C = {
    BG          = Color3.fromRGB(11,  9, 17),
    SideBG      = Color3.fromRGB(15, 12, 23),
    TopBG       = Color3.fromRGB(13, 10, 20),
    ContBG      = Color3.fromRGB(13, 10, 20),
    Elem        = Color3.fromRGB(21, 17, 33),
    ElemH       = Color3.fromRGB(29, 23, 45),
    ElemA       = Color3.fromRGB(38, 28, 60),
    Stroke      = Color3.fromRGB(44, 32, 70),
    Purple      = Color3.fromRGB(138, 43,226),
    PurpleL     = Color3.fromRGB(168, 85,247),
    PurpleD     = Color3.fromRGB(80,  18,150),
    PurpleDim   = Color3.fromRGB(52,  26, 88),
    White       = Color3.fromRGB(238,232,255),
    Dim         = Color3.fromRGB(148,138,174),
    Faint       = Color3.fromRGB(72,  65,100),
    Red         = Color3.fromRGB(210, 45, 45),
    RedH        = Color3.fromRGB(255, 65, 65),
    TgOff       = Color3.fromRGB(30,  23, 50),
    Black       = Color3.fromRGB(0,0,0),
    DropBG      = Color3.fromRGB(16,  12, 26),
    DropItem    = Color3.fromRGB(22,  17, 36),
    DropHov     = Color3.fromRGB(30,  23, 50),
    NotifBG     = Color3.fromRGB(14,  11, 22),
    UserBG      = Color3.fromRGB(17,  13, 27),
    SectionLine = Color3.fromRGB(44,  33, 70),
}

-- ══════════════════
--  ICONS  (redzlib Lucide pack — 500+ icons)
-- ══════════════════
local ICONS = {
    ["accessibility"]="rbxassetid://10709751939",["activity"]="rbxassetid://10709752035",
    ["airvent"]="rbxassetid://10709752131",["airplay"]="rbxassetid://10709752254",
    ["alarmcheck"]="rbxassetid://10709752405",["alarmclock"]="rbxassetid://10709752630",
    ["alarmclockoff"]="rbxassetid://10709752508",["alarmminus"]="rbxassetid://10709752732",
    ["alarmplus"]="rbxassetid://10709752825",["album"]="rbxassetid://10709752906",
    ["alertcircle"]="rbxassetid://10709752996",["alertoctagon"]="rbxassetid://10709753064",
    ["alerttriangle"]="rbxassetid://10709753149",["aligncenter"]="rbxassetid://10709753570",
    ["anchor"]="rbxassetid://10709761530",["angry"]="rbxassetid://10709761629",
    ["annoyed"]="rbxassetid://10709761722",["aperture"]="rbxassetid://10709761813",
    ["apple"]="rbxassetid://10709761889",["archive"]="rbxassetid://10709762233",
    ["archiverestore"]="rbxassetid://10709762058",["armchair"]="rbxassetid://10709762327",
    ["arrowbigdown"]="rbxassetid://10747796644",["arrowbigleft"]="rbxassetid://10709762574",
    ["arrowbigright"]="rbxassetid://10709762727",["arrowbigup"]="rbxassetid://10709762879",
    ["arrowdown"]="rbxassetid://10709767827",["arrowdowncircle"]="rbxassetid://10709763034",
    ["arrowdownleft"]="rbxassetid://10709767656",["arrowdownright"]="rbxassetid://10709767750",
    ["arrowleft"]="rbxassetid://10709768114",["arrowleftcircle"]="rbxassetid://10709767936",
    ["arrowleftright"]="rbxassetid://10709768019",["arrowright"]="rbxassetid://10709768347",
    ["arrowrightcircle"]="rbxassetid://10709768226",["arrowup"]="rbxassetid://10709768939",
    ["arrowupcircle"]="rbxassetid://10709768432",["arrowupdown"]="rbxassetid://10709768538",
    ["arrowupleft"]="rbxassetid://10709768661",["arrowupright"]="rbxassetid://10709768787",
    ["asterisk"]="rbxassetid://10709769095",["atsign"]="rbxassetid://10709769286",
    ["award"]="rbxassetid://10709769406",["axe"]="rbxassetid://10709769508",
    ["baby"]="rbxassetid://10709769732",["backpack"]="rbxassetid://10709769841",
    ["banana"]="rbxassetid://10709770005",["banknote"]="rbxassetid://10709770178",
    ["barchart"]="rbxassetid://10709773755",["barchart2"]="rbxassetid://10709770317",
    ["barchart3"]="rbxassetid://10709770431",["barchart4"]="rbxassetid://10709770560",
    ["barcode"]="rbxassetid://10747360675",["bath"]="rbxassetid://10709773963",
    ["battery"]="rbxassetid://10709774640",["batterycharging"]="rbxassetid://10709774068",
    ["batteryfull"]="rbxassetid://10709774206",["batterylow"]="rbxassetid://10709774370",
    ["batterymedium"]="rbxassetid://10709774513",["beaker"]="rbxassetid://10709774756",
    ["bed"]="rbxassetid://10709775036",["beer"]="rbxassetid://10709775167",
    ["bell"]="rbxassetid://10709775704",["bellminus"]="rbxassetid://10709775241",
    ["belloff"]="rbxassetid://10709775320",["bellplus"]="rbxassetid://10709775448",
    ["bellring"]="rbxassetid://10709775560",["bike"]="rbxassetid://10709775894",
    ["binary"]="rbxassetid://10709776050",["bitcoin"]="rbxassetid://10709776126",
    ["bluetooth"]="rbxassetid://10709776655",["bluetoothoff"]="rbxassetid://10709776344",
    ["bomb"]="rbxassetid://10709781460",["bone"]="rbxassetid://10709781605",
    ["book"]="rbxassetid://10709781824",["bookopen"]="rbxassetid://10709781717",
    ["bookmark"]="rbxassetid://10709782154",["bot"]="rbxassetid://10709782230",
    ["box"]="rbxassetid://10709782497",["boxes"]="rbxassetid://10709782582",
    ["briefcase"]="rbxassetid://10709782662",["brush"]="rbxassetid://10709782758",
    ["bug"]="rbxassetid://10709782845",["building"]="rbxassetid://10709783051",
    ["building2"]="rbxassetid://10709782939",["bus"]="rbxassetid://10709783137",
    ["cake"]="rbxassetid://10709783217",["calculator"]="rbxassetid://10709783311",
    ["calendar"]="rbxassetid://10709789505",["calendarcheck"]="rbxassetid://10709783474",
    ["calendarclock"]="rbxassetid://10709783577",["calendardays"]="rbxassetid://10709783673",
    ["calendarminus"]="rbxassetid://10709783959",["calendaroff"]="rbxassetid://10709788784",
    ["calendarplus"]="rbxassetid://10709788937",["camera"]="rbxassetid://10709789686",
    ["cameraoff"]="rbxassetid://10747822677",["car"]="rbxassetid://10709789810",
    ["check"]="rbxassetid://10709790644",["checkcircle"]="rbxassetid://10709790387",
    ["checksquare"]="rbxassetid://10709790537",["chefhat"]="rbxassetid://10709790757",
    ["chevrondown"]="rbxassetid://10709790948",["chevronleft"]="rbxassetid://10709791281",
    ["chevronright"]="rbxassetid://10709791437",["chevronup"]="rbxassetid://10709791523",
    ["circle"]="rbxassetid://10709798174",["clipboard"]="rbxassetid://10709799288",
    ["clock"]="rbxassetid://10709805144",["cloud"]="rbxassetid://10709806740",
    ["clouddrizzle"]="rbxassetid://10709805371",["cloudlightning"]="rbxassetid://10709805727",
    ["cloudrain"]="rbxassetid://10709806277",["cloudsnow"]="rbxassetid://10709806374",
    ["cloudy"]="rbxassetid://10709806859",["code"]="rbxassetid://10709810463",
    ["code2"]="rbxassetid://10709807111",["coffee"]="rbxassetid://10709810814",
    ["cog"]="rbxassetid://10709810948",["coins"]="rbxassetid://10709811110",
    ["command"]="rbxassetid://10709811365",["compass"]="rbxassetid://10709811445",
    ["component"]="rbxassetid://10709811595",["contact"]="rbxassetid://10709811834",
    ["copy"]="rbxassetid://10709812159",["cpu"]="rbxassetid://10709813383",
    ["crosshair"]="rbxassetid://10709818534",["crown"]="rbxassetid://10709818626",
    ["database"]="rbxassetid://10709818996",["delete"]="rbxassetid://10709819059",
    ["diamond"]="rbxassetid://10709819149",["disc"]="rbxassetid://10723343537",
    ["dollarsign"]="rbxassetid://10723343958",["download"]="rbxassetid://10723344270",
    ["downloadcloud"]="rbxassetid://10723344088",["droplet"]="rbxassetid://10723344432",
    ["edit"]="rbxassetid://10734883598",["edit2"]="rbxassetid://10723344885",
    ["edit3"]="rbxassetid://10723345088",["eraser"]="rbxassetid://10723346158",
    ["expand"]="rbxassetid://10723346553",["eye"]="rbxassetid://10723346959",
    ["eyeoff"]="rbxassetid://10723346871",["factory"]="rbxassetid://10723347051",
    ["fan"]="rbxassetid://10723354359",["fastforward"]="rbxassetid://10723354521",
    ["feather"]="rbxassetid://10723354671",["file"]="rbxassetid://10723374641",
    ["film"]="rbxassetid://10723374981",["filter"]="rbxassetid://10723375128",
    ["fingerprint"]="rbxassetid://10723375250",["flag"]="rbxassetid://10723375890",
    ["flame"]="rbxassetid://10723376114",["flashlight"]="rbxassetid://10723376471",
    ["folder"]="rbxassetid://10723387563",["folderopen"]="rbxassetid://10723386277",
    ["folderplus"]="rbxassetid://10723386531",["forward"]="rbxassetid://10723388016",
    ["frown"]="rbxassetid://10723394681",["gamepad"]="rbxassetid://10723395457",
    ["gamepad2"]="rbxassetid://10723395215",["gauge"]="rbxassetid://10723395708",
    ["gem"]="rbxassetid://10723396000",["ghost"]="rbxassetid://10723396107",
    ["gift"]="rbxassetid://10723396402",["globe"]="rbxassetid://10723404337",
    ["globe2"]="rbxassetid://10723398002",["graduationcap"]="rbxassetid://10723404691",
    ["grid"]="rbxassetid://10723404936",["hammer"]="rbxassetid://10723405360",
    ["hand"]="rbxassetid://10723405649",["harddrive"]="rbxassetid://10723405749",
    ["hash"]="rbxassetid://10723405975",["headphones"]="rbxassetid://10723406165",
    ["heart"]="rbxassetid://10723406885",["heartoff"]="rbxassetid://10723406662",
    ["helpcircle"]="rbxassetid://10723406988",["hexagon"]="rbxassetid://10723407092",
    ["history"]="rbxassetid://10723407335",["home"]="rbxassetid://10723407389",
    ["hourglass"]="rbxassetid://10723407498",["image"]="rbxassetid://10723415040",
    ["info"]="rbxassetid://10723415903",["joystick"]="rbxassetid://10723416527",
    ["key"]="rbxassetid://10723416652",["keyboard"]="rbxassetid://10723416765",
    ["landmark"]="rbxassetid://10723417608",["languages"]="rbxassetid://10723417703",
    ["laptop"]="rbxassetid://10723423881",["laugh"]="rbxassetid://10723424372",
    ["layers"]="rbxassetid://10723424505",["layout"]="rbxassetid://10723425376",
    ["layoutdashboard"]="rbxassetid://10723424646",["leaf"]="rbxassetid://10723425539",
    ["library"]="rbxassetid://10723425615",["lightbulb"]="rbxassetid://10723425852",
    ["linechart"]="rbxassetid://10723426393",["link"]="rbxassetid://10723426722",
    ["list"]="rbxassetid://10723433811",["listordered"]="rbxassetid://10723427199",
    ["loader"]="rbxassetid://10723434070",["lock"]="rbxassetid://10723434711",
    ["login"]="rbxassetid://10723434830",["logout"]="rbxassetid://10723434906",
    ["magnet"]="rbxassetid://10723435069",["mail"]="rbxassetid://10734885430",
    ["mailopen"]="rbxassetid://10723435342",["map"]="rbxassetid://10734886202",
    ["mappin"]="rbxassetid://10734886004",["maximize"]="rbxassetid://10734886735",
    ["maximize2"]="rbxassetid://10734886496",["medal"]="rbxassetid://10734887072",
    ["megaphone"]="rbxassetid://10734887454",["menu"]="rbxassetid://10734887784",
    ["messagecircle"]="rbxassetid://10734888000",["messagesquare"]="rbxassetid://10734888228",
    ["mic"]="rbxassetid://10734888864",["micoff"]="rbxassetid://10734888646",
    ["microscope"]="rbxassetid://10734889106",["minimize"]="rbxassetid://10734895698",
    ["minimize2"]="rbxassetid://10734895530",["minus"]="rbxassetid://10734896206",
    ["minuscircle"]="rbxassetid://10734895856",["monitor"]="rbxassetid://10734896881",
    ["moon"]="rbxassetid://10734897102",["move"]="rbxassetid://10734900011",
    ["music"]="rbxassetid://10734905958",["music2"]="rbxassetid://10734900215",
    ["navigation"]="rbxassetid://10734906744",["network"]="rbxassetid://10734906975",
    ["newspaper"]="rbxassetid://10734907168",["octagon"]="rbxassetid://10734907361",
    ["package"]="rbxassetid://10734909540",["packageopen"]="rbxassetid://10734908793",
    ["paintbrush"]="rbxassetid://10734910187",["palette"]="rbxassetid://10734910430",
    ["paperclip"]="rbxassetid://10734910927",["pause"]="rbxassetid://10734919336",
    ["pencil"]="rbxassetid://10734919691",["percent"]="rbxassetid://10734919919",
    ["phone"]="rbxassetid://10734921524",["phonecall"]="rbxassetid://10734920305",
    ["piechart"]="rbxassetid://10734921727",["pin"]="rbxassetid://10734922324",
    ["pizza"]="rbxassetid://10734922774",["plane"]="rbxassetid://10734922971",
    ["play"]="rbxassetid://10734923549",["playcircle"]="rbxassetid://10734923214",
    ["plus"]="rbxassetid://10734924532",["pluscircle"]="rbxassetid://10734923868",
    ["podcast"]="rbxassetid://10734929553",["power"]="rbxassetid://10734930466",
    ["poweroff"]="rbxassetid://10734930257",["printer"]="rbxassetid://10734930632",
    ["puzzle"]="rbxassetid://10734930886",["quote"]="rbxassetid://10734931234",
    ["radio"]="rbxassetid://10734931596",["recycle"]="rbxassetid://10734932295",
    ["redo"]="rbxassetid://10734932822",["refreshccw"]="rbxassetid://10734933056",
    ["refreshcw"]="rbxassetid://10734933222",["refresh"]="rbxassetid://10734933222",
    ["repeat"]="rbxassetid://10734933966",["reply"]="rbxassetid://10734934252",
    ["rewind"]="rbxassetid://10734934347",["rocket"]="rbxassetid://10734934585",
    ["rotateccw"]="rbxassetid://10734940376",["rotatecw"]="rbxassetid://10734940654",
    ["rss"]="rbxassetid://10734940825",["ruler"]="rbxassetid://10734941018",
    ["save"]="rbxassetid://10734941499",["scale"]="rbxassetid://10734941912",
    ["scan"]="rbxassetid://10734942565",["scissors"]="rbxassetid://10734942778",
    ["screenshare"]="rbxassetid://10734943193",["search"]="rbxassetid://10734943674",
    ["send"]="rbxassetid://10734943902",["server"]="rbxassetid://10734949856",
    ["settings"]="rbxassetid://10734950309",["settings2"]="rbxassetid://10734950020",
    ["share"]="rbxassetid://10734950813",["share2"]="rbxassetid://10734950553",
    ["shield"]="rbxassetid://10734951847",["shieldalert"]="rbxassetid://10734951173",
    ["shieldcheck"]="rbxassetid://10734951367",["shieldoff"]="rbxassetid://10734951684",
    ["shoppingbag"]="rbxassetid://10734952273",["shoppingcart"]="rbxassetid://10734952479",
    ["shuffle"]="rbxassetid://10734953451",["sidebar"]="rbxassetid://10734954301",
    ["signal"]="rbxassetid://10734961133",["signalhigh"]="rbxassetid://10734954807",
    ["siren"]="rbxassetid://10734961284",["skipback"]="rbxassetid://10734961526",
    ["skipforward"]="rbxassetid://10734961809",["skull"]="rbxassetid://10734962068",
    ["slash"]="rbxassetid://10734962600",["sliders"]="rbxassetid://10734963400",
    ["smartphone"]="rbxassetid://10734963940",["smile"]="rbxassetid://10734964441",
    ["snowflake"]="rbxassetid://10734964600",["sortasc"]="rbxassetid://10734965115",
    ["sortdesc"]="rbxassetid://10734965287",["speaker"]="rbxassetid://10734965419",
    ["star"]="rbxassetid://10734966248",["starhalf"]="rbxassetid://10734965897",
    ["staroff"]="rbxassetid://10734966097",["stethoscope"]="rbxassetid://10734966384",
    ["stopcircle"]="rbxassetid://10734972621",["sun"]="rbxassetid://10734974297",
    ["sunrise"]="rbxassetid://10734974522",["sunset"]="rbxassetid://10734974689",
    ["sword"]="rbxassetid://10734975486",["swords"]="rbxassetid://10734975692",
    ["table"]="rbxassetid://10734976230",["tablet"]="rbxassetid://10734976394",
    ["tag"]="rbxassetid://10734976528",["tags"]="rbxassetid://10734976739",
    ["target"]="rbxassetid://10734977012",["terminal"]="rbxassetid://10734982144",
    ["thermometer"]="rbxassetid://10734983134",["thumbsdown"]="rbxassetid://10734983359",
    ["thumbsup"]="rbxassetid://10734983629",["ticket"]="rbxassetid://10734983868",
    ["timer"]="rbxassetid://10734984606",["timeroff"]="rbxassetid://10734984138",
    ["toggleleft"]="rbxassetid://10734984834",["toggleright"]="rbxassetid://10734985040",
    ["tornado"]="rbxassetid://10734985247",["train"]="rbxassetid://10747362105",
    ["trash"]="rbxassetid://10747362393",["trash2"]="rbxassetid://10747362241",
    ["trendingup"]="rbxassetid://10747363465",["trendingdown"]="rbxassetid://10747363205",
    ["triangle"]="rbxassetid://10747363621",["trophy"]="rbxassetid://10747363809",
    ["truck"]="rbxassetid://10747364031",["tv"]="rbxassetid://10747364593",
    ["umbrella"]="rbxassetid://10747364971",["undo"]="rbxassetid://10747365484",
    ["unlock"]="rbxassetid://10747366027",["upload"]="rbxassetid://10747366434",
    ["uploadcloud"]="rbxassetid://10747366266",["user"]="rbxassetid://10747373176",
    ["usercheck"]="rbxassetid://10747371901",["usercog"]="rbxassetid://10747372167",
    ["userminus"]="rbxassetid://10747372346",["userplus"]="rbxassetid://10747372702",
    ["userx"]="rbxassetid://10747372992",["users"]="rbxassetid://10747373426",
    ["utensils"]="rbxassetid://10747373821",["verified"]="rbxassetid://10747374131",
    ["video"]="rbxassetid://10747374938",["videooff"]="rbxassetid://10747374721",
    ["voicemail"]="rbxassetid://10747375281",["volume"]="rbxassetid://10747376008",
    ["volume1"]="rbxassetid://10747375450",["volume2"]="rbxassetid://10747375679",
    ["volumex"]="rbxassetid://10747375880",["wallet"]="rbxassetid://10747376205",
    ["wand"]="rbxassetid://10747376565",["watch"]="rbxassetid://10747376722",
    ["waves"]="rbxassetid://10747376931",["webcam"]="rbxassetid://10747381992",
    ["wifi"]="rbxassetid://10747382504",["wifioff"]="rbxassetid://10747382268",
    ["wind"]="rbxassetid://10747382750",["wrench"]="rbxassetid://10747383470",
    ["x"]="rbxassetid://10747384394",["xcircle"]="rbxassetid://10747383819",
    ["xsquare"]="rbxassetid://10747384217",["zoomin"]="rbxassetid://10747384552",
    ["zoomout"]="rbxassetid://10747384679",
}

-- ══════════════════
--  STATE
-- ══════════════════
LynxLib.Flags      = {}
LynxLib.Connection = {}
LynxLib.Info       = { Version = "3.0.0" }
LynxLib.Save       = { Theme = "Default" }

for _, n in ipairs({"FlagsChanged","ThemeChanged","ThemeChanging","FileSaved","OptionAdded"}) do
    local e = { _cbs = {} }
    function e:Connect(f)
        table.insert(self._cbs, f)
        return {
            Disconnect = function() for i,v in ipairs(self._cbs) do if v==f then table.remove(self._cbs,i) break end end end,
            Fire = function(_,...) f(...) end,
        }
    end
    function e:Once(f) local c; c=self:Connect(function(...) f(...);c:Disconnect() end); return c end
    function e:_fire(...) for _,f in ipairs(self._cbs) do pcall(f,...) end end
    LynxLib.Connection[n] = e
end

-- ══════════════════
--  UTILS
-- ══════════════════
local function TW(o, p, t, s, d)
    if not o or not o.Parent then return end
    TS:Create(o, TweenInfo.new(t or .2, s or Enum.EasingStyle.Quart, d or Enum.EasingDirection.Out), p):Play()
end
local function SP(o, p, t)
    TW(o, p, t or .3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end
local function N(cls, props, ch)
    local o = Instance.new(cls)
    for k,v in pairs(props or {}) do if k~="Parent" then o[k]=v end end
    for _,c in ipairs(ch or {}) do c.Parent=o end
    if props and props.Parent then o.Parent=props.Parent end
    return o
end
local function CR(p,r)  return N("UICorner",{CornerRadius=UDim.new(0,r or 6),Parent=p}) end
local function STR(p,c,t) return N("UIStroke",{Color=c or C.Stroke,Thickness=t or 1,Parent=p}) end
local function PAD(p,a,b,l,r) return N("UIPadding",{PaddingTop=UDim.new(0,a or 6),PaddingBottom=UDim.new(0,b or 6),PaddingLeft=UDim.new(0,l or 10),PaddingRight=UDim.new(0,r or 10),Parent=p}) end
local function LL(p,gap) return N("UIListLayout",{Padding=UDim.new(0,gap or 0),SortOrder=Enum.SortOrder.LayoutOrder,Parent=p}) end

-- ══════════════════
--  DRAG SYSTEM
--  Estado global único — evita múltiplas conexões brigando
-- ══════════════════
local _dragTarget  = nil   -- qual frame está sendo arrastado agora
local _dragStartM  = nil   -- posição do mouse no inicio do drag
local _dragStartP  = nil   -- posição absoluta do frame no inicio do drag
local _dragMoved   = false -- passou do threshold?
local DRAG_THRESH  = 6     -- pixels minimos pra considerar drag (evita tp ao clicar)

-- Uma única conexão global pra mover
UIS.InputChanged:Connect(function(i)
    if not _dragTarget then return end
    if i.UserInputType ~= Enum.UserInputType.MouseMovement
    and i.UserInputType ~= Enum.UserInputType.Touch then return end

    local dx = i.Position.X - _dragStartM.X
    local dy = i.Position.Y - _dragStartM.Y

    if not _dragMoved then
        if math.abs(dx) < DRAG_THRESH and math.abs(dy) < DRAG_THRESH then return end
        _dragMoved = true
    end

    local v   = VPS()
    local abs = _dragTarget.AbsoluteSize
    local nx  = math.clamp(_dragStartP.X + dx, 0, v.X - abs.X)
    local ny  = math.clamp(_dragStartP.Y + dy, 0, v.Y - abs.Y)
    _dragTarget.Position = UDim2.new(0, nx, 0, ny)
end)

-- Uma única conexão global pra soltar
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        _dragTarget = nil
        _dragMoved  = false
    end
end)

-- Registra um frame como arrastável pelo handle
local function Draggable(win, handle)
    handle = handle or win
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            -- captura posição absoluta em pixels (funciona com Scale E Offset)
            _dragTarget = win
            _dragStartM = Vector2.new(i.Position.X, i.Position.Y)
            _dragStartP = Vector2.new(win.AbsolutePosition.X, win.AbsolutePosition.Y)
            _dragMoved  = false
        end
    end)
end

-- ══════════════════
--  GetIcon
-- ══════════════════
function LynxLib:GetIcon(n)
    if not n then return ICONS.star end
    if type(n)=="string" and n:find("rbxassetid://") then return n end
    n = n:lower()
    if ICONS[n] then return ICONS[n] end
    for k,v in pairs(ICONS) do if k:find(n,1,true) then return v end end
    return ICONS.star
end

-- ══════════════════════════════════════════════════════════
--  NOTIFY
-- ══════════════════════════════════════════════════════════
local notifHolder
local NCOLS = {Info=Color3.fromRGB(80,130,255),Success=Color3.fromRGB(50,200,90),Warning=Color3.fromRGB(240,175,40),Error=Color3.fromRGB(220,55,55)}

function LynxLib:Notify(o)
    o = o or {}
    local acc = NCOLS[o.Type or "Info"] or NCOLS.Info
    if not notifHolder then
        local sg = N("ScreenGui",{Name="LynxNotif",IgnoreGuiInset=true,ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=LP:WaitForChild("PlayerGui")})
        notifHolder = N("Frame",{Name="H",AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,-14,1,-14),Size=UDim2.new(0,300,1,-28),BackgroundTransparency=1,Parent=sg})
        N("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Bottom,Padding=UDim.new(0,8),Parent=notifHolder})
    end

    local card = N("Frame",{Size=UDim2.new(1,0,0,70),BackgroundColor3=C.NotifBG,BackgroundTransparency=0.1,ClipsDescendants=true,Parent=notifHolder})
    CR(card,9); STR(card,C.Stroke)
    N("Frame",{Size=UDim2.new(0,3,1,0),BackgroundColor3=acc,Parent=card})
    local ib = N("Frame",{Position=UDim2.new(0,14,0.5,-12),Size=UDim2.new(0,24,0,24),BackgroundColor3=Color3.new(acc.R*.18,acc.G*.18,acc.B*.18),ZIndex=2,Parent=card})
    CR(ib,6)
    N("TextLabel",{Position=UDim2.new(0,48,0,10),Size=UDim2.new(1,-58,0,18),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=C.White,Text=o.Title or "Notification",TextXAlignment=Enum.TextXAlignment.Left,ZIndex=2,Parent=card})
    N("TextLabel",{Position=UDim2.new(0,48,0,29),Size=UDim2.new(1,-58,0,26),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.Dim,Text=o.Description or "",TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=2,Parent=card})
    local bar = N("Frame",{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,0,1,0),Size=UDim2.new(1,0,0,2),BackgroundColor3=acc,ZIndex=2,Parent=card})

    card.Position = UDim2.new(0,320,0,0)
    SP(card,{Position=UDim2.new(0,0,0,0)},.4)
    local nr={}
    function nr:Remove()
        TW(card,{Position=UDim2.new(0,320,0,0),BackgroundTransparency=1},.25)
        task.delay(.3,function() pcall(function() card:Destroy() end) end)
    end
    local dur = o.Duration or 5
    if dur>0 then
        TW(bar,{Size=UDim2.new(0,0,0,2)},dur,Enum.EasingStyle.Linear)
        task.delay(dur,function() nr:Remove() end)
    end
    return nr
end

-- ══════════════════════════════════════════════════════════
--  MAKE WINDOW
-- ══════════════════════════════════════════════════════════
function LynxLib:MakeWindow(opts)
    opts = opts or {}
    local subtitle   = opts.SubTitle or ""
    local saveFolder = opts.SaveFolder or false
    local mob        = Mobile()
    local vp         = VPS()

    -- ── Sizing ─────────────────────────────────────
    --  PC:     500 × 340,  sidebar 155
    --  Mobile: (screen-20) × (screen-60), sidebar 115
    local W, H, SW
    if mob then
        W  = math.min(vp.X - 20, 380)
        H  = math.min(vp.Y - 60, 440)
        SW = 115
    else
        W, H, SW = 500, 340, 155
    end

    -- Load saved flags
    if saveFolder then
        pcall(function()
            local d = game:GetService("HttpService"):JSONDecode(readfile(saveFolder))
            if d then for k,v in pairs(d) do LynxLib.Flags[k]=v end end
        end)
    end

    -- ── ScreenGui ──────────────────────────────────
    local GUI = N("ScreenGui",{
        Name="LynxLibrary", IgnoreGuiInset=true,
        ResetOnSpawn=false, ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
        Parent=LP:WaitForChild("PlayerGui"),
    })

    -- Start position: center (absolute coords, easier to drag)
    local startX = mob and 10 or math.floor(vp.X/2 - W/2)
    local startY = mob and 30 or math.floor(vp.Y/2 - H/2)

    -- ── Main Frame ─────────────────────────────────
    local Main = N("Frame",{
        Position = UDim2.new(0, startX, 0, startY),
        Size     = UDim2.new(0, W, 0, H),
        BackgroundColor3 = C.BG,
        ClipsDescendants = false,
        Parent = GUI,
    })
    CR(Main,10)
    local mStroke = STR(Main, C.PurpleD, 1.5)

    -- shadow
    N("ImageLabel",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,6),Size=UDim2.new(1,40,1,40),BackgroundTransparency=1,Image="rbxassetid://6014261993",ImageColor3=C.Black,ImageTransparency=0.55,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=0,Parent=Main})

    -- ── Resize handle (bottom-right corner) ───────────────
    local ResizeHandle = N("TextButton",{
        AnchorPoint = Vector2.new(1,1),
        Position    = UDim2.new(1,0,1,0),
        Size        = UDim2.new(0,18,0,18),
        BackgroundColor3 = C.PurpleDim,
        BackgroundTransparency = 0.3,
        Text = "",
        ZIndex = 10,
        Parent = Main,
    })
    CR(ResizeHandle, 4)
    STR(ResizeHandle, C.Purple, 1)
    -- little diagonal lines icon
    N("TextLabel",{
        Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=10,
        TextColor3=C.Purple,
        Text="⤡",
        ZIndex=11,
        Parent=ResizeHandle,
    })

    -- Hover glow on handle
    ResizeHandle.MouseEnter:Connect(function()
        TW(ResizeHandle,{BackgroundColor3=C.Purple,BackgroundTransparency=0},.12)
    end)
    ResizeHandle.MouseLeave:Connect(function()
        TW(ResizeHandle,{BackgroundColor3=C.PurpleDim,BackgroundTransparency=0.3},.12)
    end)

    -- Resize drag logic
    local MIN_W = mob and 280 or 340
    local MIN_H = mob and 220 or 260
    local MAX_W = mob and (vp.X - 10) or 800
    local MAX_H = mob and (vp.Y - 20) or 650
    local resizing = false
    local resizeStart, sizeStart

    ResizeHandle.InputBegan:Connect(function(i)
        local t = i.UserInputType
        if t==Enum.UserInputType.MouseButton1 or t==Enum.UserInputType.Touch then
            resizing   = true
            resizeStart = i.Position
            sizeStart   = Main.AbsoluteSize
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if not resizing then return end
        local t = i.UserInputType
        if t==Enum.UserInputType.MouseMovement or t==Enum.UserInputType.Touch then
            local dx = i.Position.X - resizeStart.X
            local dy = i.Position.Y - resizeStart.Y
            local nw = math.clamp(sizeStart.X + dx, MIN_W, MAX_W)
            local nh = math.clamp(sizeStart.Y + dy, MIN_H, MAX_H)
            -- Update W and H live
            W = nw; H = nh
            Main.Size = UDim2.new(0, nw, 0, nh)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        local t = i.UserInputType
        if t==Enum.UserInputType.MouseButton1 or t==Enum.UserInputType.Touch then
            resizing = false
        end
    end)

    -- stroke glow pulse every 1.5s
    local gDir = true
    local gT   = 0
    RS.Heartbeat:Connect(function(dt)
        if not Main.Parent then return end
        gT = gT + dt
        if gT < 1.5 then return end
        gT = 0
        if gDir then TW(mStroke,{Transparency=0.55},1.4,Enum.EasingStyle.Sine)
        else          TW(mStroke,{Transparency=0  },1.4,Enum.EasingStyle.Sine) end
        gDir = not gDir
    end)

    -- ─────────────────────────────────────────────────────
    --  TOPBAR  ← Title + Subtitle on left | Buttons on right
    -- ─────────────────────────────────────────────────────
    local Topbar = N("Frame",{
        Name="Topbar",
        Size=UDim2.new(1,0,0,38),
        BackgroundColor3=C.TopBG,
        ZIndex=3, Parent=Main,
    })
    N("Frame",{Position=UDim2.new(0,0,.5,0),Size=UDim2.new(1,0,.5,0),BackgroundColor3=C.TopBG,BorderSizePixel=0,Parent=Topbar})
    CR(Topbar,10); STR(Topbar,C.Stroke)

    -- "Ly" white + "nx" purple  — inside topbar, left side
    N("TextLabel",{
        Position=UDim2.new(0,10,0,5),
        Size=UDim2.new(0,60,0,16),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBlack,
        TextSize=mob and 15 or 17,
        TextColor3=C.White,
        TextXAlignment=Enum.TextXAlignment.Left,
        RichText=true,
        Text='<font color="rgb(238,232,255)">Ly</font><font color="rgb(138,43,226)">nx</font>',
        ZIndex=5, Parent=Topbar,
    })
    -- Subtitle below title in topbar
    local SubLabel = N("TextLabel",{
        Position=UDim2.new(0,11,0,23),
        Size=UDim2.new(0,120,0,10),
        BackgroundTransparency=1,
        Font=Enum.Font.Gotham,
        TextSize=9,
        TextColor3=C.Dim,
        TextXAlignment=Enum.TextXAlignment.Left,
        Text=subtitle,
        ZIndex=5, Parent=Topbar,
    })

    -- Drag zone: fills topbar but leaves title area and buttons alone
    local DragZone = N("TextButton",{
        Position=UDim2.new(0,130,0,0),
        Size=UDim2.new(1,-210,1,0),
        BackgroundTransparency=1,
        Text="",ZIndex=4,Parent=Topbar,
    })
    Draggable(Main, DragZone)

    -- — button (purple)
    local MinBtn = N("TextButton",{
        AnchorPoint=Vector2.new(1,.5),
        Position=UDim2.new(1,-40,.5,0),
        Size=UDim2.new(0,26,0,26),
        BackgroundColor3=C.PurpleDim,
        Text="−",Font=Enum.Font.GothamBold,TextSize=18,
        TextColor3=C.White,AutoButtonColor=false,
        ZIndex=5,Parent=Topbar,
    })
    CR(MinBtn,13)
    MinBtn.MouseEnter:Connect(function() TW(MinBtn,{BackgroundColor3=C.Purple},.12) end)
    MinBtn.MouseLeave:Connect(function() TW(MinBtn,{BackgroundColor3=C.PurpleDim},.12) end)

    -- X button (red)
    local XBtn = N("TextButton",{
        AnchorPoint=Vector2.new(1,.5),
        Position=UDim2.new(1,-8,.5,0),
        Size=UDim2.new(0,26,0,26),
        BackgroundColor3=C.Red,
        Text="✕",Font=Enum.Font.GothamBold,TextSize=12,
        TextColor3=C.White,AutoButtonColor=false,
        ZIndex=5,Parent=Topbar,
    })
    CR(XBtn,13)
    XBtn.MouseEnter:Connect(function() TW(XBtn,{BackgroundColor3=C.RedH,Size=UDim2.new(0,28,0,28)},.12) end)
    XBtn.MouseLeave:Connect(function() TW(XBtn,{BackgroundColor3=C.Red,Size=UDim2.new(0,26,0,26)},.12) end)

    -- ─────────────────────────────────────────────────────
    --  BODY
    -- ─────────────────────────────────────────────────────
    local Body = N("Frame",{
        Position=UDim2.new(0,0,0,38),
        Size=UDim2.new(1,0,1,-38),
        BackgroundTransparency=1,
        ClipsDescendants=true,
        Parent=Main,
    })

    -- ─────────────────────────────────────────────────────
    --  SIDEBAR  (tabs + user panel — no title here)
    -- ─────────────────────────────────────────────────────
    local Sidebar = N("Frame",{
        Size=UDim2.new(0,SW,1,0),
        BackgroundColor3=C.SideBG,
        ClipsDescendants=false,
        Parent=Body,
    })
    N("Frame",{Size=UDim2.new(1,0,0,10),BackgroundColor3=C.SideBG,BorderSizePixel=0,Parent=Sidebar})
    CR(Sidebar,10)
    -- right border
    N("Frame",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,0),Size=UDim2.new(0,1,1,0),BackgroundColor3=C.Stroke,BorderSizePixel=0,Parent=Sidebar})

    -- Tab scroll list — starts from very top of sidebar
    local TabScroll = N("ScrollingFrame",{
        Position=UDim2.new(0,0,0,4),
        Size=UDim2.new(1,0,1,-68),
        BackgroundTransparency=1,
        ScrollBarThickness=2,
        ScrollBarImageColor3=C.PurpleD,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        Parent=Sidebar,
    })
    LL(TabScroll, 4)
    PAD(TabScroll, 4,4,6,6)

    -- ── User Panel (bottom sidebar) ──────────────────────
    local UserPanel = N("Frame",{
        AnchorPoint=Vector2.new(0,1),
        Position=UDim2.new(0,0,1,0),
        Size=UDim2.new(1,0,0,64),
        BackgroundColor3=C.UserBG,
        Parent=Sidebar,
    })
    N("Frame",{Size=UDim2.new(1,0,0,10),BackgroundColor3=C.UserBG,BorderSizePixel=0,Parent=UserPanel})
    CR(UserPanel,10)
    N("Frame",{Position=UDim2.new(0,7,0,0),Size=UDim2.new(1,-14,0,1),BackgroundColor3=C.SectionLine,BorderSizePixel=0,Parent=UserPanel})

    -- Avatar
    local AvFrame = N("Frame",{
        Position=UDim2.new(0,8,0.5,-16),
        Size=UDim2.new(0,32,0,32),
        BackgroundColor3=C.PurpleDim,
        Parent=UserPanel,
    })
    CR(AvFrame,16); STR(AvFrame,C.Purple,1.5)
    local AvImg = N("ImageLabel",{
        Size=UDim2.new(1,-4,1,-4),
        Position=UDim2.new(0,2,0,2),
        BackgroundTransparency=1,
        Image="",ZIndex=2,
        Parent=AvFrame,
    })
    CR(AvImg,14)
    task.spawn(function()
        pcall(function()
            local img = PLS:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
            AvImg.Image = img
        end)
    end)

    N("TextLabel",{Position=UDim2.new(0,48,0.5,-16),Size=UDim2.new(1,-52,0,16),BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=mob and 10 or 11,TextColor3=C.White,Text=LP.DisplayName,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=2,Parent=UserPanel})
    N("TextLabel",{Position=UDim2.new(0,48,0.5,2 ),Size=UDim2.new(1,-52,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.Dim,Text="@"..LP.Name,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=2,Parent=UserPanel})

    -- ─────────────────────────────────────────────────────
    --  CONTENT
    -- ─────────────────────────────────────────────────────
    local Content = N("Frame",{
        Position=UDim2.new(0,SW+1,0,0),
        Size=UDim2.new(1,-(SW+1),1,0),
        BackgroundColor3=C.ContBG,
        ClipsDescendants=true,
        Parent=Body,
    })
    N("Frame",{Size=UDim2.new(1,0,0,10),BackgroundColor3=C.ContBG,BorderSizePixel=0,Parent=Content})
    CR(Content,10)

    -- Ambient particles
    local PFrame = N("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ClipsDescendants=true,ZIndex=0,Parent=Content})
    local pts, pOn = {}, true
    for i=1,14 do
        local p = N("Frame",{Size=UDim2.new(0,math.random(2,4),0,math.random(2,4)),Position=UDim2.new(math.random(),0,math.random(),0),BackgroundColor3=C.Purple,BackgroundTransparency=math.random(6,9)/10,ZIndex=0,Parent=PFrame})
        CR(p,3)
        pts[i]={f=p,dx=(math.random()-0.5)*.6,dy=(math.random()-0.5)*.6}
    end
    local ptT=0
    RS.Heartbeat:Connect(function(dt)
        if not pOn or not Main.Parent then return end
        ptT=ptT+dt; if ptT<0.033 then return end; ptT=0
        for _,p in ipairs(pts) do
            if not p.f.Parent then return end
            local nx=p.f.Position.X.Scale+p.dx*0.003
            local ny=p.f.Position.Y.Scale+p.dy*0.003
            if nx<0 or nx>1 then p.dx=-p.dx; nx=math.clamp(nx,0,1) end
            if ny<0 or ny>1 then p.dy=-p.dy; ny=math.clamp(ny,0,1) end
            p.f.Position=UDim2.new(nx,0,ny,0)
        end
    end)

    -- Tab content holder
    local TabHolder = N("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ZIndex=1,Parent=Content})

    -- ═══════════════════════════════════════════════════════
    --  WINDOW API
    -- ═══════════════════════════════════════════════════════
    local Win = {}
    Win._tabs     = {}
    Win._btns     = {}
    Win._active   = nil
    Win._hidden   = false
    Win._collapse = false

    local function SaveF()
        if saveFolder then
            pcall(function() writefile(saveFolder, game:GetService("HttpService"):JSONEncode(LynxLib.Flags)) end)
        end
    end

    -- ── Dialog ────────────────────────────────────────────
    local dlgOpen = false
    function Win:Dialog(o)
        if dlgOpen then return end; dlgOpen=true; o=o or {}
        local ov = N("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=C.Black,BackgroundTransparency=1,ZIndex=20,Parent=Main})
        TW(ov,{BackgroundTransparency=0.5},.2)
        local dw = mob and W-28 or 290
        local df = N("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.6,0),Size=UDim2.new(0,dw,0,124),BackgroundColor3=C.SideBG,ZIndex=21,Parent=Main})
        CR(df,10); STR(df,C.Purple,1.5)
        SP(df,{Position=UDim2.new(.5,0,.5,0)},.4)
        N("TextLabel",{Position=UDim2.new(0,14,0,12),Size=UDim2.new(1,-28,0,20),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=14,TextColor3=C.White,Text=o.Title or "Dialog",TextXAlignment=Enum.TextXAlignment.Left,ZIndex=22,Parent=df})
        N("TextLabel",{Position=UDim2.new(0,14,0,34),Size=UDim2.new(1,-28,0,44),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.Dim,Text=o.Text or "",TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=22,Parent=df})
        local br = N("Frame",{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,14,1,-12),Size=UDim2.new(1,-28,0,28),BackgroundTransparency=1,ZIndex=22,Parent=df})
        N("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Right,Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=br})
        local d={}
        function d:Close()
            dlgOpen=false
            TW(df,{Position=UDim2.new(.5,0,.7,0),BackgroundTransparency=1},.2)
            TW(ov,{BackgroundTransparency=1},.2)
            task.delay(.25,function() pcall(function() ov:Destroy();df:Destroy() end) end)
        end
        function d:Button(b)
            local btn=N("TextButton",{Size=UDim2.new(0,90,1,0),BackgroundColor3=b._p and C.Purple or C.Elem,Text=b.Name or "OK",Font=Enum.Font.GothamSemibold,TextSize=12,TextColor3=C.White,AutoButtonColor=false,ZIndex=23,Parent=br})
            CR(btn,7); STR(btn,b._p and C.PurpleL or C.Stroke)
            btn.MouseEnter:Connect(function() TW(btn,{BackgroundColor3=b._p and C.PurpleL or C.ElemH},.12) end)
            btn.MouseLeave:Connect(function() TW(btn,{BackgroundColor3=b._p and C.Purple or C.Elem},.12) end)
            btn.Activated:Connect(function() if b.Callback then pcall(b.Callback) end; d:Close() end)
        end
        for i,op in ipairs(o.Options or {}) do d:Button({Name=op[1],Callback=op[2],_p=i==1}) end
        return d
    end

    -- Controls
    function Win:Set(_,s) if s then SubLabel.Text=s end end

    function Win:Minimize()
        self._hidden = not self._hidden
        if self._hidden then
            TW(Main,{BackgroundTransparency=1},.2)
            task.delay(.22,function() Main.Visible=false end)
        else
            Main.Visible=true
            Main.BackgroundTransparency=1
            SP(Main,{BackgroundTransparency=0},.3)
        end
    end

    function Win:MinimizeBtn()
        self._collapse = not self._collapse
        if self._collapse then
            TW(Main,{Size=UDim2.new(0,W,0,38)},.28,Enum.EasingStyle.Quart)
            MinBtn.Text="+"
        else
            SP(Main,{Size=UDim2.new(0,W,0,H)},.38)
            MinBtn.Text="−"
        end
    end

    function Win:CloseBtn()
        self:Dialog({
            Title="Fechar Script",
            Text="Tem certeza que deseja fechar o Lynx Hub?",
            Options={
                {"Confirmar",function()
                    TW(Main,{Size=UDim2.new(0,0,0,0),BackgroundTransparency=1},.38,Enum.EasingStyle.Back,Enum.EasingDirection.In)
                    task.delay(.42,function() pcall(function() GUI:Destroy() end) end)
                end},
                {"Cancelar"},
            }
        })
    end

    function Win:SelectTab(r)
        if type(r)=="number" then r=self._tabs[r] end
        if r and r._sel then r:_sel() end
    end

    function Win:SetThemeParticles(s)
        pOn=s; PFrame.Visible=s
    end

    function Win:AddMinimizeButton(o3)
        o3 = o3 or {}
        local bp = o3.Button or {}
        local sp = o3.Stroke or {}
        local cr = o3.CornerRadius or UDim.new(0,10)

        local fg = N("ScreenGui",{
            Name="LynxFloat",IgnoreGuiInset=true,
            ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
            Parent=LP:WaitForChild("PlayerGui"),
        })

        local img = bp.Image or ""
        local sz  = bp.Size or UDim2.new(0,50,0,50)
        local v   = VPS()

        -- posição em Offset puro (obrigatório pro drag funcionar)
        local posX = bp.PositionX or (mob and 10 or 20)
        local posY = bp.PositionY or math.floor(v.Y/2 - 25)

        local fb = N("ImageButton",{
            Position         = UDim2.new(0,posX,0,posY),
            Size             = sz,
            BackgroundColor3 = bp.BackgroundColor3 or C.Purple,
            BackgroundTransparency = bp.BackgroundTransparency or 0,
            Image            = img,
            ScaleType        = Enum.ScaleType.Fit,
            Parent           = fg,
        })
        N("UICorner",{CornerRadius=cr,Parent=fb})
        N("UIStroke",{Color=sp.Color or C.PurpleL,Thickness=sp.Thickness or 1.5,Parent=fb})

        if img == "" then
            N("TextLabel",{Size=UDim2.new(.52,0,1,0),BackgroundTransparency=1,Font=Enum.Font.GothamBlack,TextSize=19,TextColor3=C.PurpleL,Text="L",TextXAlignment=Enum.TextXAlignment.Right,Parent=fb})
            N("TextLabel",{Position=UDim2.new(.48,0,0,0),Size=UDim2.new(.52,0,1,0),BackgroundTransparency=1,Font=Enum.Font.GothamBlack,TextSize=19,TextColor3=C.White,Text="X",TextXAlignment=Enum.TextXAlignment.Left,Parent=fb})
        end

        Draggable(fb)
        fb.Activated:Connect(function()
            if not _dragMoved then Win:Minimize() end
        end)
        fb.MouseEnter:Connect(function() TW(fb,{BackgroundColor3=C.PurpleL},.12) end)
        fb.MouseLeave:Connect(function() TW(fb,{BackgroundColor3=bp.BackgroundColor3 or C.Purple},.12) end)
        return fb
    end

    -- Wire buttons
    MinBtn.Activated:Connect(function() Win:MinimizeBtn() end)
    XBtn.Activated:Connect(function()   Win:CloseBtn()    end)

    -- ═══════════════════════════════════════════════════════
    --  MAKE TAB
    -- ═══════════════════════════════════════════════════════
    function Win:MakeTab(o4)
        o4 = o4 or {}
        local tName = o4[1] or o4.Title or o4.Name or "Tab"
        local tIcon = o4[2] or o4.Icon
        local Tab = {}

        local BH = mob and 38 or 32
        local TB = N("TextButton",{Size=UDim2.new(1,0,0,BH),BackgroundColor3=C.Elem,Text="",AutoButtonColor=false,ZIndex=2,Parent=TabScroll})
        CR(TB,7)

        local ico
        if tIcon then
            ico = N("ImageLabel",{Position=UDim2.new(0,8,.5,-8),Size=UDim2.new(0,16,0,16),BackgroundTransparency=1,Image=LynxLib:GetIcon(tIcon),ImageColor3=C.Faint,ZIndex=3,Parent=TB})
        end
        local txX = tIcon and 30 or 9
        local TBT = N("TextLabel",{Position=UDim2.new(0,txX,0,0),Size=UDim2.new(1,-txX-4,1,0),BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=mob and 11 or 12,TextColor3=C.Faint,Text=tName,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3,Parent=TB})

        local AccBar = N("Frame",{Position=UDim2.new(0,0,.18,0),Size=UDim2.new(0,3,.64,0),BackgroundColor3=C.Purple,Visible=false,ZIndex=3,Parent=TB})
        CR(AccBar,3)

        -- Content scroll
        local TC = N("ScrollingFrame",{
            Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
            ScrollBarThickness=3,ScrollBarImageColor3=C.PurpleD,
            CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,
            Visible=false,ZIndex=1,Parent=TabHolder,
        })
        LL(TC,6); PAD(TC,10,12,10,10)

        table.insert(Win._tabs, Tab)
        table.insert(Win._btns,  TB)

        local function Select()
            for i,btn in ipairs(Win._btns) do
                TW(btn,{BackgroundColor3=C.Elem},.15)
                local bar=btn:FindFirstChildWhichIsA("Frame")
                if bar then bar.Visible=false end
                local t=btn:FindFirstChildWhichIsA("TextLabel")
                if t then TW(t,{TextColor3=C.Faint},.15) end
                local im=btn:FindFirstChildWhichIsA("ImageLabel")
                if im then TW(im,{ImageColor3=C.Faint},.15) end
                local tab=Win._tabs[i]
                if tab and tab._content then tab._content.Visible=false end
            end
            TW(TB,{BackgroundColor3=C.PurpleDim},.15)
            AccBar.Visible=true
            TW(TBT,{TextColor3=C.White},.15)
            if ico then TW(ico,{ImageColor3=C.PurpleL},.15) end
            TC.Visible=true
            TC.Position=UDim2.new(.05,0,0,0)
            TW(TC,{Position=UDim2.new(0,0,0,0)},.2,Enum.EasingStyle.Quart)
            Win._active=Tab
        end

        Tab._sel=Select; Tab._content=TC
        TB.Activated:Connect(Select)
        if #Win._tabs==1 then Select() end

        TB.MouseEnter:Connect(function()
            if Win._active~=Tab then TW(TB,{BackgroundColor3=C.ElemH},.12) end
        end)
        TB.MouseLeave:Connect(function()
            if Win._active~=Tab then TW(TB,{BackgroundColor3=C.Elem},.12) end
        end)

        function Tab:Enable()  Select() end
        function Tab:Disable() TC.Visible=false end

        -- ── animate element in ───────────────────────────
        local function AIn(f)
            f.Position=UDim2.new(.04,0,0,0)
            f.BackgroundTransparency=1
            TW(f,{Position=UDim2.new(0,0,0,0),BackgroundTransparency=0},.22,Enum.EasingStyle.Quart)
        end

        -- ─────────────────────────────────────────────────
        --  AddSection
        -- ─────────────────────────────────────────────────
        function Tab:AddSection(o5)
            o5=o5 or {}
            local nm=o5[1] or o5.Name or ""
            local S=N("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Parent=TC})
            N("Frame",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,0,.5,0),Size=UDim2.new(1,0,0,1),BackgroundColor3=C.SectionLine,BorderSizePixel=0,Parent=S})
            local SL=N("TextLabel",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,7,.5,0),Size=UDim2.new(0,0,0,13),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=C.ContBG,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.PurpleL,Text=" "..nm.." ",Parent=S})
            local o={}
            function o:Set(n) SL.Text=" "..(n or "").." " end
            function o:Visible(v) if v==nil then S.Visible=not S.Visible else S.Visible=v end end
            function o:Destroy() S:Destroy() end
            return o
        end

        -- ─────────────────────────────────────────────────
        --  AddParagraph
        -- ─────────────────────────────────────────────────
        function Tab:AddParagraph(o5)
            o5=o5 or {}
            local PF=N("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=C.Elem,Parent=TC})
            CR(PF,7); STR(PF,C.Stroke); PAD(PF,9,9,11,11); AIn(PF)
            local TL=N("TextLabel",{Size=UDim2.new(1,0,0,15),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=C.White,Text=o5[1] or o5.Title or "",TextXAlignment=Enum.TextXAlignment.Left,Parent=PF})
            local DL=N("TextLabel",{Position=UDim2.new(0,0,0,18),Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.Dim,Text=o5[2] or o5.Text or "",TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,Parent=PF})
            local p={}
            function p:SetTitle(t) TL.Text=t end; function p:SetDesc(d) DL.Text=d end
            function p:Set(t,d) if d then TL.Text=t;DL.Text=d else DL.Text=t end end
            function p:Visible(v) if v==nil then PF.Visible=not PF.Visible else PF.Visible=v end end
            function p:Destroy() PF:Destroy() end
            return p
        end

        -- ─────────────────────────────────────────────────
        --  AddButton
        -- ─────────────────────────────────────────────────
        function Tab:AddButton(o5)
            o5=o5 or {}
            local bn  = o5[1] or o5.Name or o5.Title or "Button"
            local bd  = o5.Desc or o5.Description or ""
            local cbs = {o5[2] or o5.Callback or function()end}
            local bH  = bd~="" and (mob and 52 or 46) or (mob and 40 or 36)

            local BF=N("TextButton",{Size=UDim2.new(1,0,0,bH),BackgroundColor3=C.Elem,Text="",AutoButtonColor=false,Parent=TC})
            CR(BF,7); STR(BF,C.Stroke); AIn(BF)

            local BN=N("TextLabel",{Position=UDim2.new(0,11,0,bd~="" and 6 or 0),Size=UDim2.new(1,-52,bd~="" and 0 or 1,bd~="" and 16 or 0),AutomaticSize=bd=="" and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=13,TextColor3=C.White,Text=bn,TextXAlignment=Enum.TextXAlignment.Left,Parent=BF})
            if bd~="" then N("TextLabel",{Position=UDim2.new(0,11,0,24),Size=UDim2.new(1,-52,0,14),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.Dim,Text=bd,TextXAlignment=Enum.TextXAlignment.Left,Parent=BF}) end

            local RI=N("ImageLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-9,.5,0),Size=UDim2.new(0,24,0,24),BackgroundColor3=C.PurpleDim,Image="rbxassetid://15113922617",ImageColor3=C.White,ScaleType=Enum.ScaleType.Fit,Parent=BF})
            CR(RI,6)

            -- ripple
            local function Rip()
                local r=N("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,0),Size=UDim2.new(0,0,0,0),BackgroundColor3=C.Purple,BackgroundTransparency=0.55,ZIndex=5,Parent=BF})
                CR(r,50)
                TW(r,{Size=UDim2.new(1.8,0,3,0),BackgroundTransparency=1},.5,Enum.EasingStyle.Quart)
                task.delay(.52,function() pcall(function() r:Destroy() end) end)
            end

            BF.MouseEnter:Connect(function() TW(BF,{BackgroundColor3=C.ElemH},.12); TW(RI,{BackgroundColor3=C.PurpleD},.12) end)
            BF.MouseLeave:Connect(function() TW(BF,{BackgroundColor3=C.Elem},.12);  TW(RI,{BackgroundColor3=C.PurpleDim},.12) end)
            BF.MouseButton1Down:Connect(function() TW(BF,{BackgroundColor3=C.ElemA,Size=UDim2.new(1,-4,0,bH-2)},.07) end)
            BF.MouseButton1Up:Connect(function()   SP(BF,{BackgroundColor3=C.ElemH,Size=UDim2.new(1,0,0,bH)},.14) end)
            BF.Activated:Connect(function() Rip(); for _,cb in ipairs(cbs) do pcall(cb) end end)

            local bo={}
            function bo:Set(v) if type(v)=="string" then BN.Text=v elseif type(v)=="function" then cbs={v} end end
            function bo:Callback(f) table.insert(cbs,f) end
            function bo:Visible(v) if v==nil then BF.Visible=not BF.Visible else BF.Visible=v end end
            function bo:Destroy() BF:Destroy() end
            return bo
        end

        -- ─────────────────────────────────────────────────
        --  AddToggle
        -- ─────────────────────────────────────────────────
        function Tab:AddToggle(o5)
            o5=o5 or {}
            local tn  = o5[1] or o5.Name or o5.Title or "Toggle"
            local td  = o5.Desc or o5.Description or ""
            local tdf = o5[2] or o5.Default or false
            local cbs = {o5[3] or o5.Callback or function()end}
            local tf  = o5[4] or o5.Flag
            local tH  = td~="" and (mob and 52 or 46) or (mob and 40 or 36)
            if tf and LynxLib.Flags[tf]~=nil then tdf=LynxLib.Flags[tf] end

            local TF=N("Frame",{Size=UDim2.new(1,0,0,tH),BackgroundColor3=C.Elem,Parent=TC})
            CR(TF,7); STR(TF,C.Stroke); AIn(TF)

            N("TextLabel",{Position=UDim2.new(0,11,0,td~="" and 6 or 0),Size=UDim2.new(1,-64,td~="" and 0 or 1,td~="" and 16 or 0),AutomaticSize=td=="" and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=13,TextColor3=C.White,Text=tn,TextXAlignment=Enum.TextXAlignment.Left,Parent=TF})
            if td~="" then N("TextLabel",{Position=UDim2.new(0,11,0,24),Size=UDim2.new(1,-64,0,14),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.Dim,Text=td,TextXAlignment=Enum.TextXAlignment.Left,Parent=TF}) end

            -- Pill track
            local Track=N("Frame",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-10,.5,0),Size=UDim2.new(0,44,0,22),BackgroundColor3=tdf and C.Purple or C.TgOff,Parent=TF})
            CR(Track,11)
            local tStr=STR(Track,tdf and C.PurpleL or C.Stroke)

            -- Knob (sliding pill)
            local Knob=N("Frame",{AnchorPoint=Vector2.new(0,.5),Position=tdf and UDim2.new(0,22,.5,0) or UDim2.new(0,2,.5,0),Size=UDim2.new(0,16,0,16),BackgroundColor3=C.White,ZIndex=2,Parent=Track})
            CR(Knob,8)

            local st=tdf; local busy=false
            local function Flip(ns)
                if busy then return end; busy=true; st=ns
                if ns then
                    TW(Track,{BackgroundColor3=C.Purple},.2)
                    SP(Knob,{Position=UDim2.new(0,22,.5,0)},.25)
                    TW(tStr,{Color=C.PurpleL},.2)
                else
                    TW(Track,{BackgroundColor3=C.TgOff},.2)
                    SP(Knob,{Position=UDim2.new(0,2,.5,0)},.25)
                    TW(tStr,{Color=C.Stroke},.2)
                end
                if tf then LynxLib.Flags[tf]=st; LynxLib.Connection.FlagsChanged:_fire(tf,st); SaveF() end
                for _,cb in ipairs(cbs) do pcall(cb,st) end
                task.delay(.3,function() busy=false end)
            end

            TF.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then Flip(not st) end
            end)
            TF.MouseEnter:Connect(function() TW(TF,{BackgroundColor3=C.ElemH},.12) end)
            TF.MouseLeave:Connect(function() TW(TF,{BackgroundColor3=C.Elem},.12) end)

            if tf then LynxLib.Flags[tf]=st end
            if tdf then task.defer(function() for _,cb in ipairs(cbs) do pcall(cb,st) end end) end

            local to={}
            function to:Set(v,_) if type(v)=="boolean" then Flip(v) elseif type(v)=="function" then cbs={v} end end
            function to:Callback(f) table.insert(cbs,f) end
            function to:Visible(v) if v==nil then TF.Visible=not TF.Visible else TF.Visible=v end end
            function to:Destroy() TF:Destroy() end
            return to
        end

        -- ─────────────────────────────────────────────────
        --  AddSlider
        -- ─────────────────────────────────────────────────
        function Tab:AddSlider(o5)
            o5=o5 or {}
            local sn  = o5[1] or o5.Name or o5.Title or "Slider"
            local sd  = o5.Desc or o5.Description or ""
            local smn = o5[2] or o5.Min or o5.MinValue or 0
            local smx = o5[3] or o5.Max or o5.MaxValue or 100
            local sin = o5[4] or o5.Increase or 1
            local sdf = o5[5] or o5.Default or smn
            local cbs = {o5[6] or o5.Callback or function()end}
            local sf  = o5[7] or o5.Flag
            if sf and LynxLib.Flags[sf]~=nil then sdf=LynxLib.Flags[sf] end
            sdf=math.clamp(sdf,smn,smx)

            local sH=sd~="" and (mob and 62 or 56) or (mob and 50 or 46)
            local SF=N("Frame",{Size=UDim2.new(1,0,0,sH),BackgroundColor3=C.Elem,Parent=TC})
            CR(SF,7); STR(SF,C.Stroke); AIn(SF)

            N("TextLabel",{Position=UDim2.new(0,11,0,8),Size=UDim2.new(.65,0,0,15),BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=13,TextColor3=C.White,Text=sn,TextXAlignment=Enum.TextXAlignment.Left,Parent=SF})
            local SVL=N("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-11,0,8),Size=UDim2.new(0,50,0,15),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=C.PurpleL,Text=tostring(sdf),TextXAlignment=Enum.TextXAlignment.Right,Parent=SF})
            if sd~="" then N("TextLabel",{Position=UDim2.new(0,11,0,24),Size=UDim2.new(1,-22,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.Dim,Text=sd,TextXAlignment=Enum.TextXAlignment.Left,Parent=SF}) end

            local yO=sd~="" and 42 or 30
            local TBG=N("Frame",{Position=UDim2.new(0,11,0,yO),Size=UDim2.new(1,-22,0,6),BackgroundColor3=Color3.fromRGB(26,19,46),Parent=SF})
            CR(TBG,3)

            local ip=sdf==smx and 1 or (sdf-smn)/(smx-smn)
            local TFl=N("Frame",{Size=UDim2.new(ip,0,1,0),BackgroundColor3=C.Purple,Parent=TBG})
            CR(TFl,3)
            N("UIGradient",{Color=ColorSequence.new{ColorSequenceKeypoint.new(0,C.PurpleL),ColorSequenceKeypoint.new(1,C.Purple)},Parent=TFl})

            local SK=N("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(ip,0,.5,0),Size=UDim2.new(0,14,0,14),BackgroundColor3=C.White,ZIndex=2,Parent=TBG})
            CR(SK,7); STR(SK,C.Purple,2)

            local curV=sdf; if sf then LynxLib.Flags[sf]=curV end

            local function Upd(v)
                v=math.clamp(math.round((v-smn)/sin)*sin+smn,smn,smx)
                if v==curV then return end; curV=v
                local p=(v-smn)/(smx-smn)
                TW(TFl,{Size=UDim2.new(p,0,1,0)},.05)
                TW(SK, {Position=UDim2.new(p,0,.5,0)},.05)
                SVL.Text=tostring(v)
                if sf then LynxLib.Flags[sf]=v; LynxLib.Connection.FlagsChanged:_fire(sf,v); SaveF() end
                for _,cb in ipairs(cbs) do pcall(cb,v) end
            end

            local sliding=false
            local function CalcSet(pos)
                local ab=TBG.AbsolutePosition; local sz=TBG.AbsoluteSize
                Upd(smn+((pos.X-ab.X)/sz.X)*(smx-smn))
            end

            TBG.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    sliding=true; TW(SK,{Size=UDim2.new(0,18,0,18)},.08); CalcSet(i.Position)
                end
            end)
            UIS.InputChanged:Connect(function(i)
                if sliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then CalcSet(i.Position) end
            end)
            UIS.InputEnded:Connect(function(i)
                if sliding and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then
                    sliding=false; TW(SK,{Size=UDim2.new(0,14,0,14)},.1)
                end
            end)
            SF.MouseEnter:Connect(function() TW(SF,{BackgroundColor3=C.ElemH},.12) end)
            SF.MouseLeave:Connect(function() TW(SF,{BackgroundColor3=C.Elem},.12) end)
            task.defer(function() for _,cb in ipairs(cbs) do pcall(cb,curV) end end)

            local so={}
            function so:Set(v) if type(v)=="number" then Upd(v) elseif type(v)=="function" then cbs={v} end end
            function so:Callback(f) table.insert(cbs,f) end
            function so:Visible(v) if v==nil then SF.Visible=not SF.Visible else SF.Visible=v end end
            function so:Destroy() SF:Destroy() end
            return so
        end

        -- ─────────────────────────────────────────────────
        --  AddDropdown
        -- ─────────────────────────────────────────────────
        function Tab:AddDropdown(o5)
            o5=o5 or {}
            local dn  = o5[1] or o5.Name or o5.Title or "Dropdown"
            local dd  = o5.Desc or o5.Description or ""
            local dos = o5[2] or o5.Options or {}
            local ddf = o5[3] or o5.Default
            local cbs = {o5[4] or o5.Callback or function()end}
            local df  = o5[5] or o5.Flag
            local dmu = o5.MultiSelect or false
            local ops = {}; for _,v in ipairs(dos) do table.insert(ops,v) end
            if df and LynxLib.Flags[df]~=nil then ddf=LynxLib.Flags[df] end
            local sel = dmu and {} or ddf
            if dmu and ddf then if type(ddf)=="table" then for _,v in ipairs(ddf) do sel[v]=true end else sel[ddf]=true end end

            local dH=dd~="" and (mob and 58 or 50) or (mob and 46 or 40)
            local DF=N("Frame",{Size=UDim2.new(1,0,0,dH),BackgroundColor3=C.Elem,ClipsDescendants=false,ZIndex=2,Parent=TC})
            CR(DF,7); STR(DF,C.Stroke); AIn(DF)

            N("TextLabel",{Position=UDim2.new(0,11,0,dd~="" and 5 or 0),Size=UDim2.new(1,-46,dd~="" and 0 or 1,dd~="" and 16 or 0),AutomaticSize=dd=="" and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=13,TextColor3=C.White,Text=dn,TextXAlignment=Enum.TextXAlignment.Left,Parent=DF})
            if dd~="" then N("TextLabel",{Position=UDim2.new(0,11,0,23),Size=UDim2.new(1,-46,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.Dim,Text=dd,TextXAlignment=Enum.TextXAlignment.Left,Parent=DF}) end
            local SL=N("TextLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-30,.5,0),Size=UDim2.new(.45,0,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.Dim,Text=type(sel)=="string" and sel or "Nenhum",TextXAlignment=Enum.TextXAlignment.Right,TextTruncate=Enum.TextTruncate.AtEnd,Parent=DF})
            local Ar=N("TextLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-9,.5,0),Size=UDim2.new(0,16,0,16),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.Purple,Text="▾",Parent=DF})

            local open=false; local DL=nil
            local function ClsD()
                if DL then TW(DL,{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1},.16,Enum.EasingStyle.Quart); task.delay(.18,function() pcall(function() DL:Destroy() end); DL=nil end) end
                open=false; Ar.Text="▾"; TW(DF,{BackgroundColor3=C.Elem},.12)
            end
            local function OpnD()
                if DL then ClsD(); return end; open=true; Ar.Text="▴"; TW(DF,{BackgroundColor3=C.ElemH},.12)
                DL=N("Frame",{Position=UDim2.new(0,0,1,3),Size=UDim2.new(1,0,0,0),BackgroundColor3=C.DropBG,BackgroundTransparency=0.05,ClipsDescendants=true,ZIndex=15,Parent=DF})
                CR(DL,8); STR(DL,C.Stroke); LL(DL,3); PAD(DL,4,4,4,4)
                for _,opt in ipairs(ops) do
                    local isSel=dmu and sel[opt] or (sel==opt)
                    local it=N("TextButton",{Size=UDim2.new(1,0,0,mob and 36 or 28),BackgroundColor3=isSel and C.PurpleDim or C.DropItem,Text="",AutoButtonColor=false,ZIndex=16,Parent=DL})
                    CR(it,5)
                    N("TextLabel",{Position=UDim2.new(0,9,0,0),Size=UDim2.new(1,-28,1,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextColor3=isSel and C.White or C.Dim,Text=opt,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=17,Parent=it})
                    if isSel then N("TextLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-8,.5,0),Size=UDim2.new(0,14,0,14),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.Purple,Text="✓",ZIndex=17,Parent=it}) end
                    it.MouseEnter:Connect(function() TW(it,{BackgroundColor3=C.DropHov},.09) end)
                    it.MouseLeave:Connect(function() TW(it,{BackgroundColor3=isSel and C.PurpleDim or C.DropItem},.09) end)
                    it.Activated:Connect(function()
                        if dmu then sel[opt]=not sel[opt] else sel=opt; SL.Text=opt end
                        if df then LynxLib.Flags[df]=sel; LynxLib.Connection.FlagsChanged:_fire(df,sel); SaveF() end
                        for _,cb in ipairs(cbs) do pcall(cb,sel) end; ClsD()
                    end)
                end
                local th=math.min(#ops*(mob and 40 or 31)+10,mob and 180 or 148)
                SP(DL,{Size=UDim2.new(1,0,0,th)},.32)
            end
            DF.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    if open then ClsD() else OpnD() end
                end
            end)
            DF.MouseEnter:Connect(function() if not open then TW(DF,{BackgroundColor3=C.ElemH},.12) end end)
            DF.MouseLeave:Connect(function() if not open then TW(DF,{BackgroundColor3=C.Elem},.12) end end)
            if df then LynxLib.Flags[df]=sel end

            local dO={}
            function dO:Set(no,add)
                if type(no)=="table" and not add then ops={}; for _,v in ipairs(no) do table.insert(ops,v) end
                elseif type(no)=="table" and add then for _,v in ipairs(no) do table.insert(ops,v) end
                elseif type(no)=="function" then cbs={no} end; ClsD()
            end
            function dO:Add(...)  for _,v in ipairs({...}) do table.insert(ops,v) end end
            function dO:Remove(n) for i,v in ipairs(ops) do if v==n then table.remove(ops,i) break end end end
            function dO:Select(v) sel=v; SL.Text=v; if df then LynxLib.Flags[df]=v; SaveF() end; for _,cb in ipairs(cbs) do pcall(cb,v) end end
            function dO:Callback(f) table.insert(cbs,f) end
            function dO:Visible(v) if v==nil then DF.Visible=not DF.Visible else DF.Visible=v end end
            function dO:Destroy() DF:Destroy() end
            return dO
        end

        -- ─────────────────────────────────────────────────
        --  AddTextBox
        -- ─────────────────────────────────────────────────
        function Tab:AddTextBox(o5)
            o5=o5 or {}
            local tbn = o5[1] or o5.Name or o5.Title or "TextBox"
            local tbd = o5.Desc or o5.Description or ""
            local tcb = o5[4] or o5.Callback or function()end
            local tph = o5[5] or o5.PlaceholderText or "Input..."
            local tH  = tbd~="" and (mob and 66 or 60) or (mob and 52 or 48)

            local TBF=N("Frame",{Size=UDim2.new(1,0,0,tH),BackgroundColor3=C.Elem,Parent=TC})
            CR(TBF,7); STR(TBF,C.Stroke); AIn(TBF)
            N("TextLabel",{Position=UDim2.new(0,11,0,8),Size=UDim2.new(1,-22,0,15),BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,TextSize=13,TextColor3=C.White,Text=tbn,TextXAlignment=Enum.TextXAlignment.Left,Parent=TBF})
            if tbd~="" then N("TextLabel",{Position=UDim2.new(0,11,0,25),Size=UDim2.new(1,-22,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.Dim,Text=tbd,TextXAlignment=Enum.TextXAlignment.Left,Parent=TBF}) end

            local iy=tbd~="" and 42 or 28
            local IBG=N("Frame",{Position=UDim2.new(0,11,0,iy),Size=UDim2.new(1,-22,0,mob and 22 or 18),BackgroundColor3=C.DropBG,Parent=TBF})
            CR(IBG,5); local iStr=STR(IBG,C.Stroke)

            local tbobj={}
            local TI=N("TextBox",{Size=UDim2.new(1,-14,1,0),Position=UDim2.new(0,7,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.White,PlaceholderText=tph,PlaceholderColor3=C.Dim,Text=o5[2] or o5.Default or "",ClearTextOnFocus=o5[3] or o5.ClearText or false,TextXAlignment=Enum.TextXAlignment.Left,Parent=IBG})
            TI.Focused:Connect(function() TW(iStr,{Color=C.Purple,Thickness=1.5},.15); TW(IBG,{BackgroundColor3=C.Elem},.15) end)
            TI.FocusLost:Connect(function()
                TW(iStr,{Color=C.Stroke,Thickness=1},.15); TW(IBG,{BackgroundColor3=C.DropBG},.15)
                local v=TI.Text
                if tbobj.OnChanging then local r=tbobj.OnChanging(v); if r then v=r; TI.Text=v end end
                pcall(tcb,v)
            end)
            TBF.MouseEnter:Connect(function() TW(TBF,{BackgroundColor3=C.ElemH},.12) end)
            TBF.MouseLeave:Connect(function() TW(TBF,{BackgroundColor3=C.Elem},.12) end)

            tbobj.OnChanging=nil
            function tbobj:Visible(v) if v==nil then TBF.Visible=not TBF.Visible else TBF.Visible=v end end
            function tbobj:Destroy() TBF:Destroy() end
            return tbobj
        end

        -- ─────────────────────────────────────────────────
        --  AddDiscordInvite
        -- ─────────────────────────────────────────────────
        function Tab:AddDiscordInvite(o5)
            o5=o5 or {}
            local dt  = o5[1] or o5.Title or o5.Name or "Server"
            local dd2 = o5[2] or o5.Description or o5.Desc or ""
            local dl  = o5[3] or o5.Logo or o5.Icon or ""
            local di  = o5[4] or o5.Invite or o5.Link or ""
            local don = o5.Online or o5.MembersOnline
            local dm  = o5.Members or o5.TotalMembers

            local DC=N("Frame",{Size=UDim2.new(1,0,0,74),BackgroundColor3=Color3.fromRGB(30,32,35),ClipsDescendants=true,Parent=TC})
            CR(DC,9); STR(DC,C.Stroke); AIn(DC)

            if dl~="" then
                local lb=N("Frame",{Position=UDim2.new(0,11,0.5,-17),Size=UDim2.new(0,34,0,34),BackgroundColor3=C.PurpleDim,Parent=DC})
                CR(lb,17)
                N("ImageLabel",{Size=UDim2.new(1,-4,1,-4),Position=UDim2.new(0,2,0,2),BackgroundTransparency=1,Image=dl,Parent=lb})
            end
            local tx=dl~="" and 54 or 11
            N("TextLabel",{Position=UDim2.new(0,tx,0,11),Size=UDim2.new(.6,0,0,17),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=Color3.new(1,1,1),Text=dt,TextXAlignment=Enum.TextXAlignment.Left,Parent=DC})
            if dd2~="" then N("TextLabel",{Position=UDim2.new(0,tx,0,29),Size=UDim2.new(.6,0,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=Color3.fromRGB(175,178,182),Text=dd2,TextXAlignment=Enum.TextXAlignment.Left,Parent=DC}) end
            if don or dm then
                N("TextLabel",{Position=UDim2.new(0,tx,0,44),Size=UDim2.new(.6,0,0,12),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=10,TextColor3=Color3.fromRGB(140,144,148),Text=(don and "🟢 "..don.." online" or "")..(dm and "   👥 "..dm or ""),TextXAlignment=Enum.TextXAlignment.Left,Parent=DC})
            end

            local JB=N("TextButton",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-11,.5,0),Size=UDim2.new(0,72,0,26),BackgroundColor3=Color3.fromRGB(88,101,242),Text="Join",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.new(1,1,1),AutoButtonColor=false,Parent=DC})
            CR(JB,6)
            JB.MouseEnter:Connect(function() TW(JB,{BackgroundColor3=Color3.fromRGB(110,122,255)},.12) end)
            JB.MouseLeave:Connect(function() TW(JB,{BackgroundColor3=Color3.fromRGB(88,101,242)},.12) end)
            local cool=false
            JB.Activated:Connect(function()
                if cool then return end; cool=true
                pcall(function() setclipboard(di) end)
                JB.Text="✓ OK"; TW(JB,{BackgroundColor3=Color3.fromRGB(50,188,78)},.2)
                task.delay(2.5,function() JB.Text="Join"; TW(JB,{BackgroundColor3=Color3.fromRGB(88,101,242)},.2); task.delay(3,function() cool=false end) end)
            end)

            local dio={}
            function dio:Visible(v) if v==nil then DC.Visible=not DC.Visible else DC.Visible=v end end
            function dio:Destroy() DC:Destroy() end
            return dio
        end

        return Tab
    end -- MakeTab

    -- Open animation
    Main.BackgroundTransparency=1
    SP(Main,{Size=UDim2.new(0,W,0,H),Position=UDim2.new(0,startX,0,startY),BackgroundTransparency=0},.45)

    return Win
end -- MakeWindow

-- ══════════════════════════════════════════════════════════
function LynxLib:SetTheme(n)
    LynxLib.Save.Theme=n
    LynxLib.Connection.ThemeChanging:_fire(n)
    LynxLib.Connection.ThemeChanged:_fire(n)
end

function LynxLib:SetScale(n)
    n=math.clamp(n or 450,300,2000)
    local v=workspace.CurrentCamera.ViewportSize
    local s=v.Y/n
    for _,g in ipairs(LP.PlayerGui:GetChildren()) do
        if g.Name=="LynxLibrary" then
            local m=g:FindFirstChild("Main")
            if m then m.Size=UDim2.new(0,500*s,0,340*s) end
        end
    end
end

return LynxLib
