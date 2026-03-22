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
local HttpService = game:GetService("HttpService")
local LP  = PLS.LocalPlayer

-- HTTP request fallback (compatible with multiple executors)
local httpRequest = (typeof(request) == "function" and request)
    or (typeof(http_request) == "function" and http_request)
    or (typeof(syn) == "table" and typeof(syn.request) == "function" and syn.request)
    or (typeof(http) == "table" and typeof(http.request) == "function" and http.request)
    or (typeof(fluxus) == "table" and typeof(fluxus.request) == "function" and fluxus.request)
    or nil

-- ══════════════════
--  MOBILE DETECT
-- ══════════════════
local function Mobile()
    return UIS.TouchEnabled and not UIS.MouseEnabled
end
local function VPS()
    return workspace.CurrentCamera.ViewportSize
end

--- Text sizes: PC slightly larger = less aliasing on Roblox engine
local function UISize(pc, m)
    return Mobile() and m or pc
end

local function hookGuiQuality(gui)
    if not gui then
        return
    end
    pcall(function()
        gui.ScreenInsets = Enum.ScreenInsets.None
    end)
    local function applyRenderQuality(inst)
        if inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
            pcall(function()
                inst.ResampleMode = Enum.ResamplerMode.Default
            end)
        end
        if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
            inst.TextStrokeTransparency = 1
        end
    end
    gui.DescendantAdded:Connect(applyRenderQuality)
    for _, d in ipairs(gui:GetDescendants()) do
        applyRenderQuality(d)
    end
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
--  DRAG + TWEEN
-- ══════════════════
local UIScale = VPS().Y / 450

local function CreateTween(Configs)
	local Instance = Configs[1] or Configs.Instance
	local Prop = Configs[2] or Configs.Prop
	local NewVal = Configs[3] or Configs.NewVal
	local Time = Configs[4] or Configs.Time or 0.5
	local TweenWait = Configs[5] or Configs.wait or false
	local Info = TweenInfo.new(Time, Enum.EasingStyle.Quint)
	local Tween = TS:Create(Instance, Info, {[Prop] = NewVal})
	Tween:Play()
	if TweenWait then
		Tween.Completed:Wait()
	end
	return Tween
end

local _dragMoved = false

local function MakeDrag(Instance)
	task.spawn(function()
		Instance.Active = true
		Instance.AutoButtonColor = false
		local DragStart, StartPos, InputOn
		local function Update(Input)
			local delta = Input.Position - DragStart
			local Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X / UIScale, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y / UIScale)
			CreateTween({Instance, "Position", Position, 0.35})
		end
		Instance.MouseButton1Down:Connect(function() InputOn = true end)
		Instance.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				StartPos = Instance.Position
				DragStart = Input.Position
				while UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do RS.Heartbeat:Wait()
					if InputOn then
						local d = Input.Position - DragStart
						if math.abs(d.X) > 3 or math.abs(d.Y) > 3 then _dragMoved = true end
						Update(Input)
					end
				end
				InputOn = false
				task.delay(0.05, function() _dragMoved = false end)
			end
		end)
	end)
	return Instance
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
    local type = o.Type or "Info"
    local acc = NCOLS[type] or NCOLS.Info
    local iconName = (type == "Success" and "check") or (type == "Error" and "alert-octagon") or (type == "Warning" and "alert-triangle") or "info"
    
    if not notifHolder then
        local sg = N("ScreenGui",{Name="LynxNotif",IgnoreGuiInset=true,ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=LP:WaitForChild("PlayerGui")})
        hookGuiQuality(sg)
        notifHolder = N("Frame",{Name="H",AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,-20,1,-20),Size=UDim2.new(0,280,1,-40),BackgroundTransparency=1,Parent=sg})
        N("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Bottom,Padding=UDim.new(0,8),Parent=notifHolder})
    end
    
    local hH = (o.Description and o.Description ~= "") and 64 or 48
    local holder = N("Frame",{Size=UDim2.new(1,0,0,hH),BackgroundTransparency=1,ClipsDescendants=false,Parent=notifHolder})
    
    local card = N("CanvasGroup",{Size=UDim2.new(1,0,1,0),Position=UDim2.new(1,30,0,0),BackgroundColor3=C.BG,GroupTransparency=1,Parent=holder})
    CR(card,10); STR(card,C.PurpleDim,1)
    
    -- Icon using Lucide icons
    local ib = N("ImageLabel",{
        Position=UDim2.new(0,12,0.5,-14),
        Size=UDim2.new(0,28,0,28),
        BackgroundTransparency=1,
        Image=LynxLib:GetIcon(iconName) or "",
        ImageColor3=acc,
        ZIndex=2,Parent=card
    })
    
    local tY = (o.Description and o.Description ~= "") and 11 or 0
    local tl = N("TextLabel",{
        Position=UDim2.new(0,48,0,tY),
        Size=UDim2.new(1,-58,0,18),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=UISize(14,13),
        TextColor3=C.White,
        Text=o.Title or "Notification",
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=2,Parent=card
    })
    if not o.Description or o.Description == "" then tl.AnchorPoint = Vector2.new(0,0.5); tl.Position = UDim2.new(0,48,0.5,0) end

    if o.Description and o.Description ~= "" then
        N("TextLabel",{Position=UDim2.new(0,48,0,29),Size=UDim2.new(1,-58,0,20),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=C.Dim,Text=o.Description,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=2,Parent=card})
    end
    
    -- Full width thin progress bar at bottom
    local bar = N("Frame",{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,0,1,0),Size=UDim2.new(1,0,0,2),BackgroundColor3=acc,BackgroundTransparency=0.7,BorderSizePixel=0,ZIndex=3,Parent=card})
    local barFill = N("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=acc,BorderSizePixel=0,ZIndex=4,Parent=bar})
    
    -- Smooth Entrance (Slide + Bounce)
    TW(card,{GroupTransparency=0},.35,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
    TW(card,{Position=UDim2.new(0,0,0,0)},.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    
    local function remove()
        TW(card,{Position=UDim2.new(1,30,0,0)},.45,Enum.EasingStyle.Back,Enum.EasingDirection.In)
        TW(card,{GroupTransparency=1},.35,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
        task.delay(.45, function()
            TW(holder, {Size = UDim2.new(1, 0, 0, 0)}, .18, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            task.delay(.2, function() pcall(function() holder:Destroy() end) end)
        end)
    end
    
    local dur = o.Duration or 5
    if dur>0 then
        TW(barFill,{Size=UDim2.new(0,0,1,0)},dur,Enum.EasingStyle.Linear)
        task.delay(dur,function() remove() end)
    end
    
    local api = {}
    function api:Remove() remove() end
    return api
end

function LynxLib:SendDiscordLog(data, DISCORD_WEBHOOK)
    if not DISCORD_WEBHOOK or not httpRequest then return end
    pcall(function()
        local json = HttpService:JSONEncode(data)
        httpRequest({
            Url = DISCORD_WEBHOOK,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = json
        })
    end)
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
    --  PC:     580 × 400,  sidebar 170
    --  Mobile: (screen-20) × (screen-60), sidebar 130
    local W, H, SW
    if mob then
        W  = math.min(vp.X - 20, 420)
        H  = math.min(vp.Y - 60, 480)
        SW = 130
    else
        W, H, SW = 580, 400, 170
    end

    -- Load saved flags
    if saveFolder then
        pcall(function()
            local httpGet = game.HttpGet or game.HttpGetAsync
            if not httpGet then return end
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
    hookGuiQuality(GUI)

    local startX = math.floor(mob and 10 or (vp.X / 2 - W / 2))
    local startY = math.floor(mob and 30 or (vp.Y / 2 - H / 2))

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

    -- ── Resize handle ───────────────
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
    N("ImageLabel",{
        Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,
        Image="rbxassetid://117273761878755",
        ImageColor3=C.White,
        ScaleType=Enum.ScaleType.Fit,
        ZIndex=11,
        Parent=ResizeHandle,
    })

    ResizeHandle.MouseEnter:Connect(function()
        TW(ResizeHandle,{BackgroundColor3=C.Purple,BackgroundTransparency=0},.12)
    end)
    ResizeHandle.MouseLeave:Connect(function()
        TW(ResizeHandle,{BackgroundColor3=C.PurpleDim,BackgroundTransparency=0.3},.12)
    end)

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

    -- stroke glow pulse
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
    --  TOPBAR
    -- ─────────────────────────────────────────────────────
    local Topbar = N("Frame",{
        Name="Topbar",
        Size=UDim2.new(1,0,0,44),
        BackgroundColor3=C.TopBG,
        ZIndex=3, Parent=Main,
    })
    local TopFiller = N("Frame",{Name="Filler",Position=UDim2.new(0,0,.5,0),Size=UDim2.new(1,0,.5,0),BackgroundColor3=C.TopBG,BorderSizePixel=0,Parent=Topbar})
    CR(Topbar,10); local tStroke = STR(Topbar,C.Stroke)

    N("TextLabel",{
        Position=UDim2.new(0,14,0,0),
        Size=UDim2.new(0,180,1,0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBlack,
        TextSize=UISize(22, 18),
        TextColor3=C.White,
        TextXAlignment=Enum.TextXAlignment.Left,
        RichText=true,
        Text='<font color="rgb(238,232,255)">Lyn</font><font color="rgb(138,43,226)">X</font><font color="rgb(238,232,255)">Scripts</font>',
        ZIndex=5, Parent=Topbar,
    })
    local SubLabel = N("TextLabel",{
        Position=UDim2.new(0,14,0,28),
        Size=UDim2.new(0,160,0,12),
        BackgroundTransparency=1,
        Font=Enum.Font.Gotham,
        TextSize=UISize(12, 11),
        TextColor3=C.Dim,
        TextXAlignment=Enum.TextXAlignment.Left,
        Text=subtitle,
        ZIndex=5, Parent=Topbar,
    })

    local DragZone = N("ImageButton",{
        Position=UDim2.new(0,180,0,0),
        Size=UDim2.new(1,-260,1,0),
        BackgroundTransparency=1,
        Image="",ZIndex=4,Parent=Topbar,
    })
    do
        local dragging, dragStart, startPos
        DragZone.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Main.Position
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + (delta.X / UIScale), startPos.Y.Scale, startPos.Y.Offset + (delta.Y / UIScale))
                CreateTween({Main, "Position", newPos, 0.08})
            end
        end)
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    -- — button (minimize)
    local MinBtn = N("TextButton",{
        AnchorPoint=Vector2.new(1,.5),
        Position=UDim2.new(1,-42,.5,0),
        Size=UDim2.new(0,26,0,26),
        BackgroundColor3=C.Elem,
        Text="—",
        TextColor3=C.Dim,
        TextSize=UISize(17,16),
        Font=Enum.Font.GothamBold,
        AutoButtonColor=false,
        ZIndex=5,Parent=Topbar,
    })
    CR(MinBtn,8)
    local minStroke = STR(MinBtn, C.Stroke, 1)
    MinBtn.MouseEnter:Connect(function()
        TW(MinBtn,{BackgroundColor3=C.PurpleDim,TextColor3=C.PurpleL},.15)
        TW(minStroke,{Color=C.Purple,Thickness=1.5},.15)
    end)
    MinBtn.MouseLeave:Connect(function()
        TW(MinBtn,{BackgroundColor3=C.Elem,TextColor3=C.Dim},.15)
        TW(minStroke,{Color=C.Stroke,Thickness=1},.15)
    end)

    -- X button (purple themed)
    local XBtn = N("TextButton",{
        AnchorPoint=Vector2.new(1,.5),
        Position=UDim2.new(1,-10,.5,0),
        Size=UDim2.new(0,26,0,26),
        BackgroundColor3=C.Elem,
        Text="×",
        TextColor3=C.Dim,
        TextSize=UISize(19,18),
        Font=Enum.Font.GothamBold,
        AutoButtonColor=false,
        ZIndex=5,Parent=Topbar,
    })
    CR(XBtn,8)
    local xStroke = STR(XBtn, C.Stroke, 1)
    XBtn.MouseEnter:Connect(function()
        TW(XBtn,{BackgroundColor3=C.PurpleDim,TextColor3=C.PurpleL},.15)
        TW(xStroke,{Color=C.Purple,Thickness=1.5},.15)
    end)
    XBtn.MouseLeave:Connect(function()
        TW(XBtn,{BackgroundColor3=C.Elem,TextColor3=C.Dim},.15)
        TW(xStroke,{Color=C.Stroke,Thickness=1},.15)
    end)

    -- BODY
    local Body = N("Frame",{
        Position=UDim2.new(0,0,0,44),
        Size=UDim2.new(1,0,1,-44),
        BackgroundTransparency=1,
        ClipsDescendants=true,
        Parent=Main,
    })
    CR(Body,10)

    -- SIDEBAR
    local Sidebar = N("Frame",{
        Size=UDim2.new(0,SW,1,0),
        BackgroundColor3=C.SideBG,
        ClipsDescendants=true,
        Parent=Body,
    })
    N("Frame",{Size=UDim2.new(1,0,0,10),BackgroundColor3=C.SideBG,BorderSizePixel=0,Parent=Sidebar})
    CR(Sidebar,10)
    N("Frame",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,0),Size=UDim2.new(0,1,1,-70),BackgroundColor3=C.Stroke,BorderSizePixel=0,Parent=Sidebar})

    local TabScroll = N("ScrollingFrame",{
        Position=UDim2.new(0,0,0,6),
        Size=UDim2.new(1,0,1,-76),
        BackgroundTransparency=1,
        ScrollBarThickness=3,
        ScrollBarImageColor3=C.PurpleD,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        Parent=Sidebar,
    })
    LL(TabScroll, 5)
    PAD(TabScroll, 6,6,8,8)

    local UserPanel = N("Frame",{
        AnchorPoint=Vector2.new(0,1),
        Position=UDim2.new(0,0,1,0),
        Size=UDim2.new(1,0,0,70),
        BackgroundColor3=C.UserBG,
        ClipsDescendants=true,
        Parent=Sidebar,
    })
    N("Frame",{Size=UDim2.new(1,0,0,12),BackgroundColor3=C.UserBG,BorderSizePixel=0,Parent=UserPanel})
    CR(UserPanel,10)
    N("Frame",{Position=UDim2.new(0,8,0,1),Size=UDim2.new(1,-16,0,1),BackgroundColor3=C.SectionLine,BorderSizePixel=0,Parent=UserPanel})

    local AvFrame = N("Frame",{
        Position=UDim2.new(0,10,0.5,-18),
        Size=UDim2.new(0,36,0,36),
        BackgroundColor3=C.PurpleDim,
        Parent=UserPanel,
    })
    CR(AvFrame,18); STR(AvFrame,C.Purple,1.5)
    local AvImg = N("ImageLabel",{
        Size=UDim2.new(1,-4,1,-4),
        Position=UDim2.new(0,2,0,2),
        BackgroundTransparency=1,
        Image="",ZIndex=2,
        Parent=AvFrame,
    })
    CR(AvImg,16)
    task.spawn(function()
        pcall(function()
            local img = PLS:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            AvImg.Image = img
        end)
    end)

    N("TextLabel",{Position=UDim2.new(0,54,0.5,-16),Size=UDim2.new(1,-60,0,17),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=UISize(13,12),TextColor3=C.White,Text=LP.DisplayName,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=2,Parent=UserPanel})
    N("TextLabel",{Position=UDim2.new(0,54,0.5,3 ),Size=UDim2.new(1,-60,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=C.Dim,Text="@"..LP.Name,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=2,Parent=UserPanel})

    -- CONTENT
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
    N("UIGradient",{
        Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20,10,40)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10,8,18)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(25,12,50)),
        }),
        Transparency=NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.92),
            NumberSequenceKeypoint.new(0.5, 0.97),
            NumberSequenceKeypoint.new(1, 0.92),
        }),
        Rotation=45,
        Parent=PFrame,
    })

    local pts = {}
    for i=1,12 do
        local sz = math.random(2,5)
        local p = N("Frame",{
            Size=UDim2.new(0,sz,0,sz),
            Position=UDim2.new(math.random()*0.9+0.05,0,math.random()*0.9+0.05,0),
            BackgroundColor3=C.PurpleL,
            BackgroundTransparency=math.random(55,80)/100,
            ZIndex=0,Parent=PFrame,
        })
        CR(p,math.ceil(sz/2))
        pts[i]={f=p,dx=(math.random()-0.5)*0.5,dy=(math.random()-0.5)*0.5}
    end
    for i=1,5 do
        local sz = math.random(8,18)
        local p = N("Frame",{
            Size=UDim2.new(0,sz,0,sz),
            Position=UDim2.new(math.random()*0.8+0.1,0,math.random()*0.8+0.1,0),
            BackgroundColor3=C.Purple,
            BackgroundTransparency=math.random(82,92)/100,
            ZIndex=0,Parent=PFrame,
        })
        CR(p,math.ceil(sz/2))
        pts[#pts+1]={f=p,dx=(math.random()-0.5)*0.25,dy=(math.random()-0.5)*0.25}
    end

    local ptT=0
    RS.Heartbeat:Connect(function(dt)
        if not Main or not Main.Parent then return end
        ptT=ptT+dt; if ptT<0.033 then return end; ptT=0
        for _,p in ipairs(pts) do
            if not p.f or not p.f.Parent then continue end
            local nx=p.f.Position.X.Scale+p.dx*0.002
            local ny=p.f.Position.Y.Scale+p.dy*0.002
            if nx<0.02 or nx>0.98 then p.dx=-p.dx; nx=math.clamp(nx,0.02,0.98) end
            if ny<0.02 or ny>0.98 then p.dy=-p.dy; ny=math.clamp(ny,0.02,0.98) end
            p.f.Position=UDim2.new(nx,0,ny,0)
        end
    end)

    local TabHolder = N("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ZIndex=1,Parent=Content})

    -- WINDOW API
    local Win = {}
    Win._tabs     = {}
    Win._btns     = {}
    Win._active   = nil
    Win._hidden   = false
    Win._collapse = false
    Win.Initialized = false
    local suppressMenuKeyToggle = false

    local function SaveF()
        if saveFolder then
            pcall(function() writefile(saveFolder, game:GetService("HttpService"):JSONEncode(LynxLib.Flags)) end)
        end
    end

    local dlgOpen = false
    function Win:Dialog(o)
        if dlgOpen then return end; dlgOpen=true; o=o or {}
        local ov = N("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=C.Black,BackgroundTransparency=1,ZIndex=20,Parent=Main})
        TW(ov,{BackgroundTransparency=0.5},.2)
        local dw = mob and W-28 or 290
        local df = N("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.6,0),Size=UDim2.new(0,dw,0,124),BackgroundColor3=C.SideBG,ZIndex=21,Parent=Main})
        CR(df,10); STR(df,C.Purple,1.5)
        SP(df,{Position=UDim2.new(.5,0,.5,0)},.4)
        N("TextLabel",{Position=UDim2.new(0,14,0,12),Size=UDim2.new(1,-28,0,20),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=UISize(15,14),TextColor3=C.White,Text=o.Title or "Dialog",TextXAlignment=Enum.TextXAlignment.Left,ZIndex=22,Parent=df})
        N("TextLabel",{Position=UDim2.new(0,14,0,34),Size=UDim2.new(1,-28,0,44),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(13,12),TextColor3=C.Dim,Text=o.Text or "",TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=22,Parent=df})
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
            local btn=N("TextButton",{Size=UDim2.new(0,90,1,0),BackgroundColor3=b._p and C.Purple or C.Elem,Text=b.Name or "OK",Font=Enum.Font.GothamMedium,TextSize=UISize(13,12),TextColor3=C.White,AutoButtonColor=false,ZIndex=23,Parent=br})
            CR(btn,7); STR(btn,b._p and C.PurpleL or C.Stroke)
            btn.MouseEnter:Connect(function() TW(btn,{BackgroundColor3=b._p and C.PurpleL or C.ElemH},.12) end)
            btn.MouseLeave:Connect(function() TW(btn,{BackgroundColor3=b._p and C.Purple or C.Elem},.12) end)
            btn.Activated:Connect(function() if b.Callback then pcall(b.Callback) end; d:Close() end)
        end
        for i,op in ipairs(o.Options or {}) do d:Button({Name=op[1],Callback=op[2],_p=i==1}) end
        return d
    end

    function Win:Set(_,s) if s then SubLabel.Text=s end end
    function Win:Minimize() Main.Visible = not Main.Visible end

    function Win:MinimizeBtn()
        if Win._wait then return end
        Win._wait = true
        if Win._collapse then
            MinBtn.Text = "—"
            Body.Visible = true
            ResizeHandle.Visible = true
            TopFiller.Visible = true
            mStroke.Enabled = true
            CreateTween({Main, "Size", Win._savedSize, 0.25, true})
            Win._collapse = false
        else
            Win._savedSize = Main.Size
            Body.Visible = false
            ResizeHandle.Visible = false
            TopFiller.Visible = false
            mStroke.Enabled = false
            CreateTween({Main, "Size", UDim2.fromOffset(Main.Size.X.Offset, 44), 0.25, true})
            MinBtn.Text = "+"
            Win._collapse = true
        end
        Win._wait = false
    end

    function Win:CloseBtn()
        self:Dialog({
            Title="Close Script",
            Text="Are you sure you want to close the menu?",
            Options={
                {"Confirm",function()
                    TW(Main,{Size=UDim2.new(0,0,0,0),BackgroundTransparency=1},.38,Enum.EasingStyle.Back,Enum.EasingDirection.In)
                    task.delay(.42,function() pcall(function() GUI:Destroy() end) end)
                end},
                {"Cancel"},
            }
        })
    end

    function Win:SelectTab(r)
        if type(r)=="number" then r=self._tabs[r] end
        if r and r._sel then r:_sel() end
    end


    function Win:AddMinimizeButton(Configs)
        local Button = MakeDrag(N("ImageButton", {
            Size = UDim2.fromOffset(60, 60),
            Position = UDim2.fromScale(0.15, 0.15),
            BackgroundTransparency = 1,
            AutoButtonColor = false,
            Parent = GUI,
        }))
        local Stroke, Corner
        if Configs.Corner then
            Corner = N("UICorner", {Parent = Button})
            for k,v in pairs(Configs.Corner) do Corner[k]=v end
        end
        if Configs.Stroke then
            Stroke = N("UIStroke", {Parent = Button})
            for k,v in pairs(Configs.Stroke) do Stroke[k]=v end
        end
        for k,v in pairs(Configs.Button or {}) do Button[k]=v end
        Button.Activated:Connect(function()
            if not _dragMoved then Win:Minimize() end
        end)
        return { Stroke = Stroke, Corner = Corner, Button = Button }
    end

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

        local BH = mob and 40 or 36
        local TB = N("TextButton",{Size=UDim2.new(1,0,0,BH),BackgroundColor3=C.Elem,Text="",AutoButtonColor=false,ZIndex=2,Parent=TabScroll})
        CR(TB,8)

        local ico
        if tIcon then
            ico = N("ImageLabel",{Position=UDim2.new(0,10,.5,-9),Size=UDim2.new(0,18,0,18),BackgroundTransparency=1,Image=LynxLib:GetIcon(tIcon),ImageColor3=C.Faint,ZIndex=3,Parent=TB})
        end
        local txX = tIcon and 34 or 11
        local TBT = N("TextLabel",{Position=UDim2.new(0,txX,0,0),Size=UDim2.new(1,-txX-6,1,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=UISize(14, 13),TextColor3=C.Faint,Text=tName,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3,Parent=TB})

        local AccBar = N("Frame",{Position=UDim2.new(0,0,.18,0),Size=UDim2.new(0,3,.64,0),BackgroundColor3=C.Purple,Visible=false,ZIndex=3,Parent=TB})
        CR(AccBar,3)

        local TC = N("ScrollingFrame",{
            Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
            ScrollBarThickness=4,ScrollBarImageColor3=C.PurpleD,
            CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,
            Visible=false,ZIndex=1,Parent=TabHolder,
        })
        LL(TC,5); PAD(TC,12,14,12,12)

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

        local function AIn(f)
            f.Position=UDim2.new(.04,0,0,0)
            f.BackgroundTransparency=1
            TW(f,{Position=UDim2.new(0,0,0,0),BackgroundTransparency=0},.22,Enum.EasingStyle.Quart)
        end

        function Tab:AddSection(o5)
            o5=o5 or {}
            local nm=o5[1] or o5.Name or ""
            local S=N("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Parent=TC})
            N("Frame",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,0,.5,0),Size=UDim2.new(1,0,0,1),BackgroundColor3=C.SectionLine,BorderSizePixel=0,Parent=S})
            local SL=N("TextLabel",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,7,.5,0),Size=UDim2.new(0,0,0,13),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=C.ContBG,Font=Enum.Font.GothamBold,TextSize=UISize(11,10),TextColor3=C.PurpleL,Text=" "..nm.." ",Parent=S})
            local o={}
            function o:Set(n) SL.Text=" "..(n or "").." " end
            function o:Visible(v) if v==nil then S.Visible=not S.Visible else S.Visible=v end end
            function o:Destroy() S:Destroy() end
            return o
        end

        function Tab:AddParagraph(o5)
            o5=o5 or {}
            local PF=N("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=C.Elem,Parent=TC})
            CR(PF,7); STR(PF,C.Stroke); PAD(PF,9,9,11,11); AIn(PF)
            local TL=N("TextLabel",{Size=UDim2.new(1,0,0,15),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=UISize(14,13),TextColor3=C.White,Text=o5[1] or o5.Title or "",TextXAlignment=Enum.TextXAlignment.Left,Parent=PF})
            local DL=N("TextLabel",{Position=UDim2.new(0,0,0,18),Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=C.Dim,Text=o5[2] or o5.Text or "",TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,Parent=PF})
            local p={}
            function p:SetTitle(t) TL.Text=t end; function p:SetDesc(d) DL.Text=d end
            function p:Set(t,d) if d then TL.Text=t;DL.Text=d else DL.Text=t end end
            function p:Visible(v) if v==nil then PF.Visible=not PF.Visible else PF.Visible=v end end
            function p:Destroy() PF:Destroy() end
            return p
        end

        function Tab:AddButton(o5)
            o5=o5 or {}
            local bn  = o5[1] or o5.Name or o5.Title or "Button"
            local bd  = o5.Desc or o5.Description or ""
            local cbs = {o5[2] or o5.Callback or function()end}
            local bH  = bd~="" and (mob and 52 or 46) or (mob and 40 or 36)
            local BF=N("TextButton",{Size=UDim2.new(1,0,0,bH),BackgroundColor3=C.Elem,Text="",AutoButtonColor=false,Parent=TC})
            CR(BF,7); STR(BF,C.Stroke); AIn(BF)
            local BN=N("TextLabel",{Position=UDim2.new(0,11,0,bd~="" and 6 or 0),Size=UDim2.new(1,-52,bd~="" and 0 or 1,bd~="" and 16 or 0),AutomaticSize=bd=="" and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,BackgroundTransparency=1,Font=Enum.Font.GothamMedium,TextSize=UISize(14,13),TextColor3=C.White,Text=bn,TextXAlignment=Enum.TextXAlignment.Left,Parent=BF})
            if bd~="" then N("TextLabel",{Position=UDim2.new(0,11,0,24),Size=UDim2.new(1,-52,0,14),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=C.Dim,Text=bd,TextXAlignment=Enum.TextXAlignment.Left,Parent=BF}) end
            local RI=N("ImageLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-9,.5,0),Size=UDim2.new(0,24,0,24),BackgroundColor3=C.PurpleDim,Image="rbxassetid://15113922617",ImageColor3=C.White,ScaleType=Enum.ScaleType.Fit,Parent=BF})
            CR(RI,6)
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
            N("TextLabel",{Position=UDim2.new(0,11,0,td~="" and 6 or 0),Size=UDim2.new(1,-64,td~="" and 0 or 1,td~="" and 16 or 0),AutomaticSize=td=="" and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,BackgroundTransparency=1,Font=Enum.Font.GothamMedium,TextSize=UISize(14,13),TextColor3=C.White,Text=tn,TextXAlignment=Enum.TextXAlignment.Left,Parent=TF})
            if td~="" then N("TextLabel",{Position=UDim2.new(0,11,0,24),Size=UDim2.new(1,-64,0,14),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=C.Dim,Text=td,TextXAlignment=Enum.TextXAlignment.Left,Parent=TF}) end
            local Track=N("Frame",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-10,.5,0),Size=UDim2.new(0,44,0,22),BackgroundColor3=tdf and C.Purple or C.TgOff,Parent=TF})
            CR(Track,11)
            local tStr=STR(Track,tdf and C.PurpleL or C.Stroke)
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
            N("TextLabel",{Position=UDim2.new(0,11,0,8),Size=UDim2.new(.65,0,0,15),BackgroundTransparency=1,Font=Enum.Font.GothamMedium,TextSize=UISize(14,13),TextColor3=C.White,Text=sn,TextXAlignment=Enum.TextXAlignment.Left,Parent=SF})
            local SVL=N("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-11,0,8),Size=UDim2.new(0,50,0,15),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=UISize(14,13),TextColor3=C.PurpleL,Text=tostring(sdf),TextXAlignment=Enum.TextXAlignment.Right,Parent=SF})
            if sd~="" then N("TextLabel",{Position=UDim2.new(0,11,0,24),Size=UDim2.new(1,-22,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=C.Dim,Text=sd,TextXAlignment=Enum.TextXAlignment.Left,Parent=SF}) end
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

        function Tab:AddDropdown(o5)
            o5=o5 or {}
            local dn  = o5[1] or o5.Name or o5.Title or "Dropdown"
            local dd  = o5.Desc or o5.Description or ""
            local dos = o5[2] or o5.Options or {}
            local ddf = o5[3] or o5.Default
            local cbs = {o5[4] or o5.Callback or function()end}
            local df  = o5[5] or o5.Flag
            local dmu = o5.MultiSelect or false
            local compact = o5.Compact
            local ops = {}; for _,v in ipairs(dos) do table.insert(ops,v) end
            if df and LynxLib.Flags[df]~=nil then ddf=LynxLib.Flags[df] end
            local sel = dmu and {} or ddf
            if dmu and ddf then if type(ddf)=="table" then for _,v in ipairs(ddf) do sel[v]=true end else sel[ddf]=true end end
            local dH
            if dd~="" then
                dH = mob and 58 or 50
            elseif compact then
                dH = mob and 32 or 28
            else
                dH = mob and 46 or 40
            end
            local DF=N("Frame",{Size=UDim2.new(1,0,0,dH),BackgroundColor3=C.Elem,ClipsDescendants=false,ZIndex=2,Parent=TC})
            CR(DF,7); STR(DF,C.Stroke); AIn(DF)
            if compact and dd=="" then
                N("TextLabel",{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,9,0.5,0),Size=UDim2.new(1,-46,0,14),BackgroundTransparency=1,Font=Enum.Font.GothamMedium,TextSize=UISize(13,12),TextColor3=C.White,Text=dn,TextXAlignment=Enum.TextXAlignment.Left,Parent=DF})
            else
                N("TextLabel",{Position=UDim2.new(0,11,0,dd~="" and 5 or 0),Size=UDim2.new(1,-46,dd~="" and 0 or 1,dd~="" and 16 or 0),AutomaticSize=dd=="" and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,BackgroundTransparency=1,Font=Enum.Font.GothamMedium,TextSize=UISize(14,13),TextColor3=C.White,Text=dn,TextXAlignment=Enum.TextXAlignment.Left,Parent=DF})
                if dd~="" then N("TextLabel",{Position=UDim2.new(0,11,0,23),Size=UDim2.new(1,-46,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=C.Dim,Text=dd,TextXAlignment=Enum.TextXAlignment.Left,Parent=DF}) end
            end
            local SL=N("TextLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-30,.5,0),Size=UDim2.new(.45,0,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=C.Dim,Text=type(sel)=="string" and sel or "None",TextXAlignment=Enum.TextXAlignment.Right,TextTruncate=Enum.TextTruncate.AtEnd,Parent=DF})
            local Ar=N("TextLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-9,.5,0),Size=UDim2.new(0,16,0,16),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=UISize(13,12),TextColor3=C.Purple,Text="▾",Parent=DF})
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
                    N("TextLabel",{Position=UDim2.new(0,9,0,0),Size=UDim2.new(1,-28,1,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(13,12),TextColor3=isSel and C.White or C.Dim,Text=opt,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=17,Parent=it})
                    if isSel then N("TextLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-8,.5,0),Size=UDim2.new(0,14,0,14),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=UISize(12,11),TextColor3=C.Purple,Text="✓",ZIndex=17,Parent=it}) end
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

        function Tab:AddKeybind(o5)
            o5 = o5 or {}
            local kn = o5[1] or o5.Name or o5.Title or "Keybind"
            local df = o5[2] or o5.Default or "RightControl"
            local flag = o5[3] or o5.Flag
            local cbs = {o5[4] or o5.Callback or function() end}
            if flag and LynxLib.Flags[flag] ~= nil then
                df = LynxLib.Flags[flag]
            end
            if type(df) ~= "string" or df == "" then
                df = "RightControl"
            end

            local dH = mob and 32 or 28
            local Row = N("TextButton", {
                Size = UDim2.new(1, 0, 0, dH),
                BackgroundColor3 = C.Elem,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 2,
                Parent = TC,
            })
            CR(Row, 7)
            STR(Row, C.Stroke)
            AIn(Row)

            N("TextLabel", {
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 9, 0.5, 0),
                Size = UDim2.new(1, -46, 0, 14),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = UISize(13, 12),
                TextColor3 = C.White,
                Text = kn,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = Row,
            })
            local SL = N("TextLabel", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -30, 0.5, 0),
                Size = UDim2.new(0.45, 0, 0, 13),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                TextSize = UISize(12, 11),
                TextColor3 = C.Dim,
                Text = df,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Parent = Row,
            })
            N("ImageLabel", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -9, 0.5, 0),
                Size = UDim2.new(0, 16, 0, 16),
                BackgroundTransparency = 1,
                Image = LynxLib:GetIcon("keyboard"),
                ImageColor3 = C.Purple,
                Parent = Row,
            })

            local listening = false
            local listenConn

            local function getVal()
                if flag and LynxLib.Flags[flag] ~= nil then
                    return LynxLib.Flags[flag]
                end
                return df
            end

            local function stopListen()
                listening = false
                suppressMenuKeyToggle = false
                if listenConn then
                    listenConn:Disconnect()
                    listenConn = nil
                end
                TW(Row, {BackgroundColor3 = C.Elem}, 0.12)
                SL.Text = getVal()
            end

            local function startListen()
                if listening then
                    return
                end
                if listenConn then
                    listenConn:Disconnect()
                    listenConn = nil
                end
                listening = true
                suppressMenuKeyToggle = true
                SL.Text = "..."
                TW(Row, {BackgroundColor3 = C.ElemH}, 0.12)

                task.delay(12, function()
                    if listening then
                        stopListen()
                    end
                end)

                listenConn = UIS.InputBegan:Connect(function(input, _gp)
                    if not listening then
                        return
                    end
                    if input.UserInputType ~= Enum.UserInputType.Keyboard then
                        return
                    end
                    if input.KeyCode == Enum.KeyCode.Escape then
                        stopListen()
                        return
                    end
                    if input.KeyCode ~= Enum.KeyCode.Unknown then
                        local name = input.KeyCode.Name
                        df = name
                        if flag then
                            LynxLib.Flags[flag] = name
                            LynxLib.Connection.FlagsChanged:_fire(flag, name)
                            SaveF()
                        end
                        for _, cb in ipairs(cbs) do
                            pcall(cb, name)
                        end
                        SL.Text = name
                        stopListen()
                    end
                end)
            end

            Row.MouseEnter:Connect(function()
                if not listening then
                    TW(Row, {BackgroundColor3 = C.ElemH}, 0.12)
                end
            end)
            Row.MouseLeave:Connect(function()
                if not listening then
                    TW(Row, {BackgroundColor3 = C.Elem}, 0.12)
                end
            end)
            Row.Activated:Connect(function()
                task.defer(function()
                    task.wait(0.12)
                    if Row.Parent then
                        startListen()
                    end
                end)
            end)
            Row.MouseButton1Down:Connect(function()
                TW(Row, {BackgroundColor3 = C.ElemA}, 0.07)
            end)
            Row.MouseButton1Up:Connect(function()
                TW(Row, {BackgroundColor3 = listening and C.ElemH or C.Elem}, 0.12)
            end)

            if flag then
                LynxLib.Flags[flag] = df
            end

            local kb = {}
            function kb:Set(val)
                if type(val) == "string" and val ~= "" then
                    df = val
                    if flag then
                        LynxLib.Flags[flag] = val
                    end
                    SL.Text = val
                end
            end
            function kb:Callback(f)
                table.insert(cbs, f)
            end
            function kb:Visible(v)
                if v == nil then
                    Row.Visible = not Row.Visible
                else
                    Row.Visible = v
                end
            end
            function kb:Destroy()
                if listenConn then
                    listenConn:Disconnect()
                end
                suppressMenuKeyToggle = false
                Row:Destroy()
            end
            return kb
        end

        function Tab:AddTextBox(o5)
            o5=o5 or {}
            local tbn = o5[1] or o5.Name or o5.Title or "TextBox"
            local tbd = o5.Desc or o5.Description or ""
            local tcb = o5[4] or o5.Callback or function()end
            local tph = o5[5] or o5.PlaceholderText or "Input..."
            local tH  = tbd~="" and (mob and 66 or 60) or (mob and 52 or 48)
            local TBF=N("Frame",{Size=UDim2.new(1,0,0,tH),BackgroundColor3=C.Elem,Parent=TC})
            CR(TBF,7); STR(TBF,C.Stroke); AIn(TBF)
            N("TextLabel",{Position=UDim2.new(0,11,0,8),Size=UDim2.new(1,-22,0,15),BackgroundTransparency=1,Font=Enum.Font.GothamMedium,TextSize=UISize(14,13),TextColor3=C.White,Text=tbn,TextXAlignment=Enum.TextXAlignment.Left,Parent=TBF})
            if tbd~="" then N("TextLabel",{Position=UDim2.new(0,11,0,25),Size=UDim2.new(1,-22,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=C.Dim,Text=tbd,TextXAlignment=Enum.TextXAlignment.Left,Parent=TBF}) end
            local iy=tbd~="" and 42 or 28
            local IBG=N("Frame",{Position=UDim2.new(0,11,0,iy),Size=UDim2.new(1,-22,0,mob and 22 or 18),BackgroundColor3=C.DropBG,Parent=TBF})
            CR(IBG,5); local iStr=STR(IBG,C.Stroke)
            local tbobj={}
            local TI=N("TextBox",{Size=UDim2.new(1,-14,1,0),Position=UDim2.new(0,7,0,0),BackgroundTransparency=1,Font=Enum.Font.GothamMedium,TextSize=UISize(13,12),TextColor3=C.White,PlaceholderText=tph,PlaceholderColor3=C.Dim,Text=o5[2] or o5.Default or "",ClearTextOnFocus=o5[3] or o5.ClearText or false,TextXAlignment=Enum.TextXAlignment.Left,Parent=IBG})
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
            N("TextLabel",{Position=UDim2.new(0,tx,0,11),Size=UDim2.new(.6,0,0,17),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=UISize(14,13),TextColor3=Color3.new(1,1,1),Text=dt,TextXAlignment=Enum.TextXAlignment.Left,Parent=DC})
            if dd2~="" then N("TextLabel",{Position=UDim2.new(0,tx,0,29),Size=UDim2.new(.6,0,0,13),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=Color3.fromRGB(175,178,182),Text=dd2,TextXAlignment=Enum.TextXAlignment.Left,Parent=DC}) end
            if don or dm then
                N("TextLabel",{Position=UDim2.new(0,tx,0,44),Size=UDim2.new(.6,0,0,12),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=UISize(12,11),TextColor3=Color3.fromRGB(140,144,148),Text=(don and "🟢 "..don.." online" or "")..(dm and "   👥 "..dm or ""),TextXAlignment=Enum.TextXAlignment.Left,Parent=DC})
            end
            local JB=N("TextButton",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-11,.5,0),Size=UDim2.new(0,72,0,26),BackgroundColor3=Color3.fromRGB(88,101,242),Text="Join",Font=Enum.Font.GothamBold,TextSize=UISize(13,12),TextColor3=Color3.new(1,1,1),AutoButtonColor=false,Parent=DC})
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

        function Tab:SetSpacing(gap, padTop, padBottom, padSides)
            local tc = self._content
            if not tc then return end
            for _, c in ipairs(tc:GetChildren()) do
                if c:IsA("UIListLayout") then
                    c.Padding = UDim.new(0, gap or 6)
                elseif c:IsA("UIPadding") then
                    c.PaddingTop = UDim.new(0, padTop or 10)
                    c.PaddingBottom = UDim.new(0, padBottom or 12)
                    c.PaddingLeft = UDim.new(0, padSides or 10)
                    c.PaddingRight = UDim.new(0, padSides or 10)
                end
            end
        end

        function Tab:AddFileSaveRow(o5)
            o5 = o5 or {}
            local label = o5.Label or o5[1] or "File"
            local default = o5.Default or o5[2] or ""
            local onSave = o5.OnSave or o5[3] or function() end
            local onChange = o5.OnChange or function() end
            local rowH = mob and 42 or 36
            local wrap = N("Frame", {Size = UDim2.new(1, 0, 0, rowH), BackgroundColor3 = C.Elem, Parent = TC})
            CR(wrap, 7)
            STR(wrap, C.Stroke)
            AIn(wrap)
            N("TextLabel", {
                Position = UDim2.new(0, 9, 0, 2),
                Size = UDim2.new(1, -18, 0, 11),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = UISize(11, 10),
                TextColor3 = C.Dim,
                Text = label,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = wrap,
            })
            local iy = mob and 20 or 18
            local IBG = N("Frame", {
                Position = UDim2.new(0, 9, 0, 14),
                Size = UDim2.new(1, -98, 0, iy),
                BackgroundColor3 = C.DropBG,
                Parent = wrap,
            })
            CR(IBG, 5)
            local iStr = STR(IBG, C.Stroke)
            local TI = N("TextBox", {
                Size = UDim2.new(1, -12, 1, 0),
                Position = UDim2.new(0, 6, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = UISize(13, 12),
                TextColor3 = C.White,
                Text = default,
                PlaceholderText = o5.Placeholder or "",
                PlaceholderColor3 = C.Dim,
                ClearTextOnFocus = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = IBG,
            })
            TI.Focused:Connect(function()
                TW(iStr, {Color = C.Purple, Thickness = 1.5}, 0.15)
            end)
            TI.FocusLost:Connect(function()
                TW(iStr, {Color = C.Stroke, Thickness = 1}, 0.15)
                pcall(onChange, TI.Text)
            end)
            local SB = N("TextButton", {
                Position = UDim2.new(1, -86, 0, 14),
                Size = UDim2.new(0, 78, 0, iy),
                BackgroundColor3 = C.PurpleDim,
                Text = o5.SaveLabel or "Save",
                Font = Enum.Font.GothamMedium,
                TextSize = UISize(13, 12),
                TextColor3 = C.White,
                AutoButtonColor = false,
                Parent = wrap,
            })
            CR(SB, 5)
            STR(SB, C.Purple, 1)
            SB.MouseEnter:Connect(function()
                TW(SB, {BackgroundColor3 = C.PurpleD}, 0.12)
            end)
            SB.MouseLeave:Connect(function()
                TW(SB, {BackgroundColor3 = C.PurpleDim}, 0.12)
            end)
            SB.Activated:Connect(function()
                pcall(onSave, TI.Text)
            end)
            local ro = {}
            function ro:Get()
                return TI.Text
            end
            function ro:Set(t)
                TI.Text = t or ""
            end
            function ro:Visible(v)
                if v == nil then
                    wrap.Visible = not wrap.Visible
                else
                    wrap.Visible = v
                end
            end
            function ro:Destroy()
                wrap:Destroy()
            end
            return ro
        end

        function Tab:AddButtonRow(o5)
            o5 = o5 or {}
            local pairs_ = o5[1] or o5.Buttons or {}
            local rowH = mob and 40 or 36
            local row = N("Frame", {Size = UDim2.new(1, 0, 0, rowH), BackgroundTransparency = 1, Parent = TC})
            for i = 1, math.min(#pairs_, 2) do
                local pair = pairs_[i]
                local name = pair[1] or "OK"
                local cb = pair[2] or function() end
                local BF = N("TextButton", {
                    Position = UDim2.new(i == 1 and 0 or 0.5, i == 1 and 0 or 4, 0, 0),
                    Size = UDim2.new(0.5, -4, 1, 0),
                    BackgroundColor3 = C.Elem,
                    Text = "",
                    AutoButtonColor = false,
                    Parent = row,
                })
                CR(BF, 7)
                STR(BF, C.Stroke)
                AIn(BF)
                local BN = N("TextLabel", {
                    Position = UDim2.new(0, 11, 0, 0),
                    Size = UDim2.new(1, -40, 1, 0),
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamMedium,
                    TextSize = UISize(14, 13),
                    TextColor3 = C.White,
                    Text = name,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = BF,
                })
                local RI = N("ImageLabel", {
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -9, 0.5, 0),
                    Size = UDim2.new(0, 22, 0, 22),
                    BackgroundColor3 = C.PurpleDim,
                    Image = "rbxassetid://15113922617",
                    ImageColor3 = C.White,
                    ScaleType = Enum.ScaleType.Fit,
                    Parent = BF,
                })
                CR(RI, 6)
                local function Rip()
                    local r = N("Frame", {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, 0, 0, 0),
                        BackgroundColor3 = C.Purple,
                        BackgroundTransparency = 0.55,
                        ZIndex = 5,
                        Parent = BF,
                    })
                    CR(r, 50)
                    TW(r, {Size = UDim2.new(1.8, 0, 3, 0), BackgroundTransparency = 1}, 0.5, Enum.EasingStyle.Quart)
                    task.delay(0.52, function()
                        pcall(function()
                            r:Destroy()
                        end)
                    end)
                end
                BF.MouseEnter:Connect(function()
                    TW(BF, {BackgroundColor3 = C.ElemH}, 0.12)
                    TW(RI, {BackgroundColor3 = C.PurpleD}, 0.12)
                end)
                BF.MouseLeave:Connect(function()
                    TW(BF, {BackgroundColor3 = C.Elem}, 0.12)
                    TW(RI, {BackgroundColor3 = C.PurpleDim}, 0.12)
                end)
                BF.MouseButton1Down:Connect(function()
                    TW(BF, {BackgroundColor3 = C.ElemA}, 0.07)
                end)
                BF.MouseButton1Up:Connect(function()
                    TW(BF, {BackgroundColor3 = C.ElemH}, 0.12)
                end)
                BF.Activated:Connect(function()
                    Rip()
                    pcall(cb)
                end)
            end
            local bro = {}
            function bro:Visible(v)
                if v == nil then
                    row.Visible = not row.Visible
                else
                    row.Visible = v
                end
            end
            function bro:Destroy()
                row:Destroy()
            end
            return bro
        end

        function Tab:AddButtonRowWithToggle(o5)
            o5 = o5 or {}
            local pairs_ = o5.Buttons or o5[1] or {}
            local tg = o5.Toggle or {}
            local tn = tg[1] or tg.Name or tg.Title or "Auto-Load"
            local tdf = tg[2] ~= nil and tg[2] or tg.Default or false
            local tcbs = {tg[3] or tg.Callback or function() end}
            local tflag = tg[4] or tg.Flag
            local rowH = mob and 40 or 36
            local row = N("Frame", {Size = UDim2.new(1, 0, 0, rowH), BackgroundTransparency = 1, Parent = TC})
            local gap = 5
            local wScale = 1 / 3
            local function addBtn(i, pair)
                local name = pair[1] or "OK"
                local cb = pair[2] or function() end
                local BF = N("TextButton", {
                    Position = UDim2.new(wScale * (i - 1), gap * (i - 1), 0, 0),
                    Size = UDim2.new(wScale, -gap, 1, 0),
                    BackgroundColor3 = C.Elem,
                    Text = "",
                    AutoButtonColor = false,
                    Parent = row,
                })
                CR(BF, 7)
                STR(BF, C.Stroke)
                AIn(BF)
                N("TextLabel", {
                    Position = UDim2.new(0, 8, 0, 0),
                    Size = UDim2.new(1, -36, 1, 0),
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamMedium,
                    TextSize = UISize(13, 12),
                    TextColor3 = C.White,
                    Text = name,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Parent = BF,
                })
                local RI = N("ImageLabel", {
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -7, 0.5, 0),
                    Size = UDim2.new(0, 20, 0, 20),
                    BackgroundColor3 = C.PurpleDim,
                    Image = "rbxassetid://15113922617",
                    ImageColor3 = C.White,
                    ScaleType = Enum.ScaleType.Fit,
                    Parent = BF,
                })
                CR(RI, 6)
                local function Rip()
                    local r = N("Frame", {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, 0, 0, 0),
                        BackgroundColor3 = C.Purple,
                        BackgroundTransparency = 0.55,
                        ZIndex = 5,
                        Parent = BF,
                    })
                    CR(r, 50)
                    TW(r, {Size = UDim2.new(1.8, 0, 3, 0), BackgroundTransparency = 1}, 0.5, Enum.EasingStyle.Quart)
                    task.delay(0.52, function()
                        pcall(function()
                            r:Destroy()
                        end)
                    end)
                end
                BF.MouseEnter:Connect(function()
                    TW(BF, {BackgroundColor3 = C.ElemH}, 0.12)
                    TW(RI, {BackgroundColor3 = C.PurpleD}, 0.12)
                end)
                BF.MouseLeave:Connect(function()
                    TW(BF, {BackgroundColor3 = C.Elem}, 0.12)
                    TW(RI, {BackgroundColor3 = C.PurpleDim}, 0.12)
                end)
                BF.MouseButton1Down:Connect(function()
                    TW(BF, {BackgroundColor3 = C.ElemA}, 0.07)
                end)
                BF.MouseButton1Up:Connect(function()
                    TW(BF, {BackgroundColor3 = C.ElemH}, 0.12)
                end)
                BF.Activated:Connect(function()
                    Rip()
                    pcall(cb)
                end)
            end
            for i = 1, math.min(#pairs_, 2) do
                addBtn(i, pairs_[i])
            end
            if tflag and LynxLib.Flags[tflag] ~= nil then
                tdf = LynxLib.Flags[tflag]
            end
            local TF = N("Frame", {
                Position = UDim2.new(wScale * 2, gap * 2, 0, 0),
                Size = UDim2.new(wScale, -gap, 1, 0),
                BackgroundColor3 = C.Elem,
                Parent = row,
            })
            CR(TF, 7)
            STR(TF, C.Stroke)
            AIn(TF)
            N("TextLabel", {
                Position = UDim2.new(0, 6, 0, 0),
                Size = UDim2.new(1, -52, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = UISize(12, 11),
                TextColor3 = C.White,
                Text = tn,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Parent = TF,
            })
            local Track = N("Frame", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -6, 0.5, 0),
                Size = UDim2.new(0, 40, 0, 20),
                BackgroundColor3 = tdf and C.Purple or C.TgOff,
                Parent = TF,
            })
            CR(Track, 10)
            local tStr = STR(Track, tdf and C.PurpleL or C.Stroke)
            local Knob = N("Frame", {
                AnchorPoint = Vector2.new(0, 0.5),
                Position = tdf and UDim2.new(0, 20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                Size = UDim2.new(0, 14, 0, 14),
                BackgroundColor3 = C.White,
                ZIndex = 2,
                Parent = Track,
            })
            CR(Knob, 7)
            local st = tdf
            local busy = false
            local function Flip(ns)
                if busy then
                    return
                end
                busy = true
                st = ns
                if ns then
                    TW(Track, {BackgroundColor3 = C.Purple}, 0.2)
                    SP(Knob, {Position = UDim2.new(0, 20, 0.5, 0)}, 0.25)
                    TW(tStr, {Color = C.PurpleL}, 0.2)
                else
                    TW(Track, {BackgroundColor3 = C.TgOff}, 0.2)
                    SP(Knob, {Position = UDim2.new(0, 2, 0.5, 0)}, 0.25)
                    TW(tStr, {Color = C.Stroke}, 0.2)
                end
                if tflag then
                    LynxLib.Flags[tflag] = st
                    LynxLib.Connection.FlagsChanged:_fire(tflag, st)
                    SaveF()
                end
                for _, f in ipairs(tcbs) do
                    pcall(f, st)
                end
                task.delay(0.3, function()
                    busy = false
                end)
            end
            TF.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    Flip(not st)
                end
            end)
            TF.MouseEnter:Connect(function()
                TW(TF, {BackgroundColor3 = C.ElemH}, 0.12)
            end)
            TF.MouseLeave:Connect(function()
                TW(TF, {BackgroundColor3 = C.Elem}, 0.12)
            end)
            if tflag then
                LynxLib.Flags[tflag] = st
            end
            if tdf then
                task.defer(function()
                    for _, f in ipairs(tcbs) do
                        pcall(f, st)
                    end
                end)
            end
            local to = {}
            function to:Set(v, _)
                if type(v) == "boolean" then
                    Flip(v)
                elseif type(v) == "function" then
                    tcbs = {v}
                end
            end
            function to:Callback(f)
                table.insert(tcbs, f)
            end
            function to:Visible(v)
                if v == nil then
                    TF.Visible = not TF.Visible
                else
                    TF.Visible = v
                end
            end
            function to:Destroy()
                TF:Destroy()
            end
            local bro = {}
            function bro:Visible(v)
                if v == nil then
                    row.Visible = not row.Visible
                else
                    row.Visible = v
                end
            end
            function bro:Destroy()
                row:Destroy()
            end
            return {Row = bro, Toggle = to}
        end

        function Tab:AddConfigManager(o5)
            o5 = o5 or {}
            local folder = o5.Folder or "LynxConfigs"
            local autoloadFile = o5.AutoloadFile or "LynxConfigs/autoload.txt"
            local ph = o5.Placeholder or o5[1] or "Config name..."
            local defName = o5.Default or o5[2] or ""
            local rowH = mob and 36 or 32
            local btnH = rowH - 8
            -- Same visual logic as AddTextBox without description: taller field and breathing room
            local iy = 28
            local ibgH = mob and 24 or 22
            local wrapH = iy + ibgH + 12

            local wrap = N("Frame", {Size = UDim2.new(1, 0, 0, wrapH), BackgroundColor3 = C.Elem, Parent = TC})
            CR(wrap, 7)
            STR(wrap, C.Stroke)
            AIn(wrap)
            N("TextLabel", {
                Position = UDim2.new(0, 11, 0, 8),
                Size = UDim2.new(1, -22, 0, 15),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = UISize(14, 13),
                TextColor3 = C.White,
                Text = o5.Label or "Save config",
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = wrap,
            })
            local IBG = N("Frame", {
                Position = UDim2.new(0, 11, 0, iy),
                Size = UDim2.new(1, -98, 0, ibgH),
                BackgroundColor3 = C.DropBG,
                Parent = wrap,
            })
            CR(IBG, 5)
            local iStr = STR(IBG, C.Stroke)
            local TI = N("TextBox", {
                Size = UDim2.new(1, -14, 1, 0),
                Position = UDim2.new(0, 7, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = UISize(13, 12),
                TextColor3 = C.White,
                Text = defName,
                PlaceholderText = ph,
                PlaceholderColor3 = C.Dim,
                ClearTextOnFocus = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = IBG,
            })
            TI.Focused:Connect(function()
                TW(iStr, {Color = C.Purple, Thickness = 1.5}, 0.15)
                TW(IBG, {BackgroundColor3 = C.Elem}, 0.15)
            end)
            TI.FocusLost:Connect(function()
                TW(iStr, {Color = C.Stroke, Thickness = 1}, 0.15)
                TW(IBG, {BackgroundColor3 = C.DropBG}, 0.15)
            end)
            local SB = N("TextButton", {
                Position = UDim2.new(1, -86, 0, iy),
                Size = UDim2.new(0, 78, 0, ibgH),
                BackgroundColor3 = C.PurpleDim,
                Text = "Save",
                Font = Enum.Font.GothamMedium,
                TextSize = UISize(13, 12),
                TextColor3 = C.White,
                AutoButtonColor = false,
                Parent = wrap,
            })
            CR(SB, 5)
            STR(SB, C.Purple, 1)
            SB.MouseEnter:Connect(function()
                TW(SB, {BackgroundColor3 = C.PurpleD}, 0.12)
            end)
            SB.MouseLeave:Connect(function()
                TW(SB, {BackgroundColor3 = C.PurpleDim}, 0.12)
            end)

            local listHolder = N("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent = TC,
            })
            LL(listHolder, 4)

            local function getAutoloadName()
                local n = ""
                pcall(function()
                    if isfile(autoloadFile) then
                        n = (readfile(autoloadFile) or ""):gsub("^%s+", ""):gsub("%s+$", "")
                    end
                end)
                return n
            end

            local function scanFiles()
                local entries = {}
                local seenPath = {}
                local function addEntry(path)
                    if type(path) ~= "string" or path == "" then
                        return
                    end
                    local name = path:match("([^/\\]+)%.[jJ][sS][oO][nN]$")
                    if not name then
                        return
                    end
                    if seenPath[path] then
                        return
                    end
                    seenPath[path] = true
                    table.insert(entries, {name = name, path = path})
                end
                pcall(function()
                    if not isfolder(folder) then
                        return
                    end
                    local list = listfiles(folder)
                    if type(list) ~= "table" then
                        return
                    end
                    for _, path in ipairs(list) do
                        addEntry(path)
                    end
                end)
                table.sort(entries, function(a, b)
                    return a.name:lower() < b.name:lower()
                end)
                return entries
            end

            local function normPath(p)
                if type(p) ~= "string" then
                    return ""
                end
                return (p:gsub("\\", "/"))
            end

            local function tryDeletePath(fp)
                if type(fp) ~= "string" or fp == "" then
                    return false
                end
                local exists = false
                pcall(function()
                    exists = isfile(fp)
                end)
                if not exists then
                    return false
                end
                pcall(function()
                    if delfile then
                        delfile(fp)
                    end
                end)
                pcall(function()
                    if deletefile then
                        deletefile(fp)
                    end
                end)
                local gone = false
                pcall(function()
                    gone = not isfile(fp)
                end)
                return gone
            end

            local function deleteConfigFile(displayName, listPath)
                local variants = {}
                local seen = {}
                local function add(p)
                    if type(p) ~= "string" or p == "" then
                        return
                    end
                    if not seen[p] then
                        seen[p] = true
                        table.insert(variants, p)
                    end
                    local n = normPath(p)
                    if n ~= p and not seen[n] then
                        seen[n] = true
                        table.insert(variants, n)
                    end
                end
                add(listPath)
                add(folder .. "/" .. displayName .. ".json")
                add(folder .. "\\" .. displayName .. ".json")
                local deleted = false
                for _, fp in ipairs(variants) do
                    if tryDeletePath(fp) then
                        deleted = true
                        break
                    end
                end
                if deleted then
                    pcall(function()
                        if getAutoloadName() == displayName and isfile(autoloadFile) then
                            if delfile then
                                delfile(autoloadFile)
                            elseif deletefile then
                                deletefile(autoloadFile)
                            end
                        end
                    end)
                    LynxLib:Notify({Title = "Configuration", Description = "Config deleted: " .. displayName, Type = "Warning", Duration = 2})
                else
                    LynxLib:Notify({Title = "Configuration", Description = "Could not delete (executor/path).", Type = "Error", Duration = 3})
                end
            end

            local function loadConfig(displayName, listPath)
                pcall(function()
                    local raw
                    local tryPaths = {listPath, folder .. "/" .. displayName .. ".json", folder .. "\\" .. displayName .. ".json"}
                    for _, p in ipairs(tryPaths) do
                        if type(p) == "string" and p ~= "" then
                            local okR, data = pcall(function()
                                return readfile(p)
                            end)
                            if okR and data and data ~= "" then
                                raw = data
                                break
                            end
                        end
                    end
                    if not raw then
                        return
                    end
                    local d = game:GetService("HttpService"):JSONDecode(raw)
                    if d then
                        for k, v in pairs(d) do
                            LynxLib.Flags[k] = v
                        end
                        for k, v in pairs(d) do
                            LynxLib.Connection.FlagsChanged:_fire(k, v)
                        end
                        LynxLib:Notify({Title = "Configuration", Description = "Loaded: " .. displayName, Type = "Success", Duration = 3})
                    end
                end)
            end

            local function setAutoload(name, on)
                pcall(function()
                    if not isfolder(folder) then
                        makefolder(folder)
                    end
                    if on then
                        writefile(autoloadFile, tostring(name or ""):gsub("^%s+", ""):gsub("%s+$", ""))
                        LynxLib:Notify({Title = "Auto-load", Description = name, Type = "Success", Duration = 2})
                    else
                        if isfile(autoloadFile) then
                            if delfile then
                                delfile(autoloadFile)
                            elseif deletefile then
                                deletefile(autoloadFile)
                            end
                        end
                    end
                end)
            end

            local function refresh()
                for _, c in ipairs(listHolder:GetChildren()) do
                    if not c:IsA("UIListLayout") then
                        c:Destroy()
                    end
                end
                local files = scanFiles()
                local autoN = getAutoloadName()
                for _, entry in ipairs(files) do
                    local name = entry.name
                    local fpath = entry.path
                    local r = N("Frame", {Size = UDim2.new(1, 0, 0, rowH), BackgroundColor3 = C.Elem, Parent = listHolder})
                    CR(r, 6)
                    STR(r, C.Stroke, 1)
                    AIn(r)
                    N("TextLabel", {
                        Position = UDim2.new(0, 8, 0, 0),
                        Size = UDim2.new(1, -158, 1, 0),
                        BackgroundTransparency = 1,
                        Font = Enum.Font.GothamMedium,
                        TextSize = UISize(13, 12),
                        TextColor3 = C.White,
                        Text = name,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Parent = r,
                    })
                    local isAuto = autoN == name
                    local autoBtn = N("TextButton", {
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -124, 0.5, 0),
                        Size = UDim2.new(0, mob and 44 or 48, 0, btnH),
                        BackgroundColor3 = isAuto and C.PurpleDim or C.DropBG,
                        Text = "Auto",
                        Font = Enum.Font.GothamBold,
                        TextSize = UISize(11, 10),
                        TextColor3 = isAuto and C.PurpleL or C.Dim,
                        AutoButtonColor = false,
                        Parent = r,
                    })
                    CR(autoBtn, 4)
                    STR(autoBtn, isAuto and C.Purple or C.Stroke, 1)
                    autoBtn.MouseEnter:Connect(function()
                        TW(autoBtn, {BackgroundColor3 = C.ElemH}, 0.1)
                    end)
                    autoBtn.MouseLeave:Connect(function()
                        TW(autoBtn, {BackgroundColor3 = isAuto and C.PurpleDim or C.DropBG}, 0.1)
                    end)
                    autoBtn.Activated:Connect(function()
                        if getAutoloadName() == name then
                            setAutoload(name, false)
                        else
                            setAutoload(name, true)
                        end
                        task.defer(function()
                            task.wait(0.05)
                            refresh()
                        end)
                    end)

                    local loadBtn = N("TextButton", {
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -68, 0.5, 0),
                        Size = UDim2.new(0, mob and 52 or 56, 0, btnH),
                        BackgroundColor3 = C.PurpleDim,
                        Text = "Load",
                        Font = Enum.Font.GothamMedium,
                        TextSize = UISize(12, 11),
                        TextColor3 = C.White,
                        AutoButtonColor = false,
                        Parent = r,
                    })
                    CR(loadBtn, 4)
                    STR(loadBtn, C.Purple, 1)
                    loadBtn.MouseEnter:Connect(function()
                        TW(loadBtn, {BackgroundColor3 = C.PurpleD}, 0.1)
                    end)
                    loadBtn.MouseLeave:Connect(function()
                        TW(loadBtn, {BackgroundColor3 = C.PurpleDim}, 0.1)
                    end)
                    loadBtn.Activated:Connect(function()
                        loadConfig(name, fpath)
                    end)

                    local delBtn = N("TextButton", {
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -6, 0.5, 0),
                        Size = UDim2.new(0, 28, 0, btnH),
                        BackgroundColor3 = Color3.fromRGB(55, 28, 38),
                        Text = "×",
                        Font = Enum.Font.GothamBold,
                        TextSize = UISize(16, 15),
                        TextColor3 = C.RedH,
                        AutoButtonColor = false,
                        ZIndex = 5,
                        Active = true,
                        Parent = r,
                    })
                    CR(delBtn, 4)
                    STR(delBtn, C.Red, 1)
                    delBtn.MouseEnter:Connect(function()
                        TW(delBtn, {BackgroundColor3 = Color3.fromRGB(75, 35, 45)}, 0.1)
                    end)
                    delBtn.MouseLeave:Connect(function()
                        TW(delBtn, {BackgroundColor3 = Color3.fromRGB(55, 28, 38)}, 0.1)
                    end)
                    delBtn.Activated:Connect(function()
                        deleteConfigFile(name, fpath)
                        task.defer(function()
                            task.wait(0.05)
                            refresh()
                        end)
                    end)
                end
            end

            SB.Activated:Connect(function()
                local name = (TI.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
                if name == "" then
                    return
                end
                pcall(function()
                    if not isfolder(folder) then
                        makefolder(folder)
                    end
                    writefile(folder .. "/" .. name .. ".json", game:GetService("HttpService"):JSONEncode(LynxLib.Flags))
                    LynxLib:Notify({Title = "Configuration", Description = "Saved: " .. name, Type = "Success", Duration = 2})
                end)
                task.defer(function()
                    task.wait(0.05)
                    refresh()
                end)
            end)

            local api = {}
            function api:Refresh()
                refresh()
            end
            function api:SetName(s)
                TI.Text = s or ""
            end
            function api:Visible(v)
                if v == nil then
                    wrap.Visible = not wrap.Visible
                    listHolder.Visible = wrap.Visible
                else
                    wrap.Visible = v
                    listHolder.Visible = v
                end
            end
            function api:Destroy()
                wrap:Destroy()
                listHolder:Destroy()
            end
            refresh()
            return api
        end

        return Tab
    end -- MakeTab

    -- ══ Intro (blur + splash + loading bar → hub) ══════════════════════
    Main.Visible = false

    local IntroGui = N("ScreenGui", {
        Name = "LynxIntro",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 100,
        Parent = LP:WaitForChild("PlayerGui"),
    })

    local introBlur = N("BlurEffect", {
        Name = "LynxIntroBlur",
        Size = 0,
        Parent = game:GetService("Lighting"),
    })
    TW(introBlur, { Size = 18 }, 0.5, Enum.EasingStyle.Quart)

    local Overlay = N("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = C.Black,
        BackgroundTransparency = 1,
        Parent = IntroGui,
    })
    TW(Overlay, { BackgroundTransparency = 0.45 }, 0.5, Enum.EasingStyle.Quart)

    local Card = N("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 340, 0, 120),
        BackgroundTransparency = 1,
        Parent = IntroGui,
    })

    local IntroTitle = N("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBlack,
        TextSize = 52,
        TextColor3 = C.White,
        TextXAlignment = Enum.TextXAlignment.Center,
        RichText = true,
        Text = '<font color="rgb(238,232,255)">Lyn</font><font color="rgb(138,43,226)">x</font><font color="rgb(238,232,255)">Scripts</font>',
        TextTransparency = 1,
        Parent = Card,
    })

    local IntroSub = N("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 60),
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamSemibold,
        TextSize = 16,
        TextColor3 = C.Dim,
        TextXAlignment = Enum.TextXAlignment.Center,
        Text = "Initializing",
        TextTransparency = 1,
        Parent = Card,
    })

    local BarTrack = N("Frame", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 92),
        Size = UDim2.new(0, 180, 0, 8),
        BackgroundColor3 = C.TgOff,
        BackgroundTransparency = 1,
        Parent = Card,
    })
    CR(BarTrack, 4)

    local BarFill = N("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = C.Purple,
        Parent = BarTrack,
    })
    CR(BarFill, 4)
    N("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, C.PurpleL),
            ColorSequenceKeypoint.new(1, C.Purple),
        }),
        Parent = BarFill,
    })

    task.spawn(function()
        local function cleanupAndShowHub()
            pcall(function() IntroGui:Destroy() end)
            pcall(function() introBlur:Destroy() end)
            Main.Visible = true
            Main.BackgroundTransparency = 1
            Main.Size = UDim2.new(0, W * 0.85, 0, H * 0.85)
            SP(Main, {
                Size = UDim2.new(0, W, 0, H),
                BackgroundTransparency = 0,
            }, 0.45)
            TW(mStroke, { Transparency = 0 }, 0.4)
        end

        local ok, err = pcall(function()
            task.wait(0.1)
            TW(IntroTitle, { TextTransparency = 0 }, 0.3, Enum.EasingStyle.Quart)
            task.wait(0.1)
            TW(IntroSub, { TextTransparency = 0 }, 0.25, Enum.EasingStyle.Quart)
            TW(BarTrack, { BackgroundTransparency = 0 }, 0.25, Enum.EasingStyle.Quart)
            task.wait(0.2)

            TW(BarFill, { Size = UDim2.new(1, 0, 1, 0) }, 1.0, Enum.EasingStyle.Quint)
            task.wait(1.2)

            TW(IntroTitle, { TextTransparency = 1 }, 0.25, Enum.EasingStyle.Quart)
            TW(IntroSub, { TextTransparency = 1 }, 0.25, Enum.EasingStyle.Quart)
            TW(BarTrack, { BackgroundTransparency = 1 }, 0.25, Enum.EasingStyle.Quart)
            TW(BarFill, { BackgroundTransparency = 1 }, 0.25, Enum.EasingStyle.Quart)
            TW(Overlay, { BackgroundTransparency = 1 }, 0.3, Enum.EasingStyle.Quart)
            TW(introBlur, { Size = 0 }, 0.3, Enum.EasingStyle.Quart)
            task.wait(0.3)

            cleanupAndShowHub()
        end)
        if not ok then
            if warn then warn("[Lynx intro]", err) end
            cleanupAndShowHub()
        end
    end)

    LynxLib.Flags.MenuKeybind = LynxLib.Flags.MenuKeybind or "RightControl"
    UIS.InputBegan:Connect(function(input, gp)
        if gp or suppressMenuKeyToggle then
            return
        end
        if input.KeyCode.Name == LynxLib.Flags.MenuKeybind then
            GUI.Enabled = not GUI.Enabled
        end
    end)

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

-- ══════════════════════════════════════════════════════════
--  AUTO RUN
-- ══════════════════════════════════════════════════════════
pcall(function()
    if getgenv then getgenv().LynxLib = LynxLib end
end)

local Win = LynxLib:MakeWindow({})

-- ══ HOME ══
local HomeTab = Win:MakeTab({"Home", "home"})
HomeTab:AddParagraph({"Welcome to LynXScripts!", "Premium script hub for Roblox.\nSelect a tab on the left to get started."})
HomeTab:AddButton({"Discord Server", function()
    pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/vnmgYmVtuv")
            LynxLib:Notify({Title="Link Copied", Description="Discord invite copied!", Type="Success"})
        end
    end)
end})
HomeTab:AddDiscordInvite({"LynXScripts Community","Official script hub","","https://discord.gg/vnmgYmVtuv",Online="127",Members="1.2k"})

-- ══ SETTINGS ══
local SettingsTab = Win:MakeTab({"Settings", "settings"})
SettingsTab:SetSpacing(4, 6, 8, 8)
SettingsTab:AddSection({"MENU"})

SettingsTab:AddKeybind({"Hide/Show Menu Key", "RightControl", "MenuKeybind"})


SettingsTab:AddSection({"CONFIGURATION"})

SettingsTab:AddConfigManager({
    Label = "Save config",
    Placeholder = "Config name...",
    Folder = "LynxConfigs",
    AutoloadFile = "LynxConfigs/autoload.txt",
})

pcall(function()
    if isfile("LynxConfigs/autoload.txt") then
        local auto = readfile("LynxConfigs/autoload.txt")
        if auto and auto ~= "" and isfile("LynxConfigs/"..auto..".json") then
            local stringdata = readfile("LynxConfigs/" .. auto .. ".json")
            if stringdata then
                local d = game:GetService("HttpService"):JSONDecode(stringdata)
                if d then
                    for k,v in pairs(d) do LynxLib.Flags[k] = v end
                    for k,v in pairs(d) do LynxLib.Connection.FlagsChanged:_fire(k, v) end
                end
            end
        end
    end
end)

LynxLib:Notify({Title="LynXScripts", Description="Hub loaded successfully!", Type="Success", Duration=4})
