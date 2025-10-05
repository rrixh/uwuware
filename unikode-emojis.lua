-- emojis.lua (runtime builder) --
-- usage example :
--[[ 
local e = loadstring(game:HttpGet("https://raw.githubusercontent.com/refs/heads/main/unikode-emojis.lua"))();

print(e.lollipop) -- 🍭
]]--
-- UTF-8 emoji lib (rbx-safe, mojibake-proof)

return (function()
  local U = utf8.char

  -- Build from: "1F680" / "1F468-200D-1F4BB" / 128640 / {"1F468","200D","1F4BB"}
  local function E(seq)
    local cps, t = {}, type(seq)
    if t == "number" then cps = {seq}
    elseif t == "string" then for cp in seq:gmatch("[0-9A-Fa-f]+") do cps[#cps+1] = tonumber("0x"..cp) end
    elseif t == "table" then for _, cp in ipairs(seq) do cps[#cps+1] = type(cp)=="number" and cp or tonumber("0x"..tostring(cp)) end
    else return "" end
    local out = {}; for _, n in ipairs(cps) do out[#out+1] = U(n) end
    return table.concat(out)
  end

  local T, meta = {}, {}
  local function normAlias(s) return (string.lower(s or ""):gsub("^%s+",""):gsub("%s+$","")) end

  -- Public: add aliases → glyph. Accepts string or {..} aliases. Returns glyph.
  T.add = function(names, seq)
    local list = (type(names)=="string") and {names} or (type(names)=="table" and names or nil)
    if not list then return nil end
    local glyph = E(seq)
    for _, name in ipairs(list) do
      local a = normAlias(name); if a ~= "" then
        T[a] = glyph; meta[a] = seq
        T[a:gsub("%s+","")] = glyph
        T[a:gsub("%s+","_")] = glyph
      end
    end
    return glyph
  end

  -- Tone modifiers for hands/person
  local SKIN = { light="1F3FB", medium_light="1F3FC", medium="1F3FD", medium_dark="1F3FE", dark="1F3FF" }
  function T.tone(glyph, tone)
    local mod = SKIN[tostring(tone or "medium")] or SKIN.medium
    return (glyph or "") .. E(mod)
  end

  -- Flags: from ISO-2 (e.g., "US","NG")
  local BASE_A = 0x1F1E6
  local function regional(letter) return BASE_A + (string.byte(letter) - string.byte("A")) end
  function T.flag(code)
    if not code or #code < 2 then return "" end
    local c = string.upper(code)
    return U(regional(c:sub(1,1))) .. U(regional(c:sub(2,2)))
  end

  setmetatable(T, { __index = function() return "" end })

  ----------------------------------------------------------------
  -- CORE / HEARTS / UI / SYMBOLS (a lot)
  ----------------------------------------------------------------
  T.add({"heart","redheart"},"2764-FE0F"); T.add({"pinkheart"},"1FA77"); T.add({"orangeheart"},"1F9E1")
  T.add({"yellowheart"},"1F49B"); T.add({"greenheart"},"1F49A"); T.add({"blueheart"},"1F499")
  T.add({"purpleheart"},"1F49C"); T.add({"blackheart","blkheart"},"1F5A4"); T.add({"whiteheart"},"1F90D")
  T.add({"brownheart"},"1F90E"); T.add({"sparkleheart","sparklyheart"},"1F496"); T.add({"heartbeat","hearts"},"1F493")
  T.add({"sparkles","twinkles"},"2728"); T.add({"star","fav"},"2B50")
  T.add({"boom","pow","explode"},"1F4A5"); T.add({"droplet","sweat","drip"},"1F4A6"); T.add({"dash","speed","smoke"},"1F4A8")
  T.add({"fire","flame","lit"},"1F525"); T.add({"zap","bolt"},"26A1"); T.add({"check","ok","yes","tick"},"2705"); T.add({"x","cross","no","wrong"},"274C")
  T.add({"warn","warning","alert"},"26A0-FE0F"); T.add({"info","i"},"2139-FE0F")
  T.add({"link","chain"},"1F517"); T.add({"key"},"1F511"); T.add({"lock"},"1F512"); T.add({"unlock"},"1F513")
  T.add({"gear","cog"},"2699-FE0F"); T.add({"paperclip","clip"},"1F4CE"); T.add({"pushpin","pin"},"1F4CC")
  T.add({"trash","bin"},"1F5D1-FE0F"); T.add({"search","magnify"},"1F50D"); T.add({"lightbulb","idea"},"1F4A1")
  T.add({"bell","notify"},"1F514"); T.add({"mutebell","silent"},"1F515"); T.add({"speaker"},"1F50A"); T.add({"mute","nosound"},"1F507")
  T.add({"calendar"},"1F4C5"); T.add({"hourglass"},"23F3"); T.add({"clock","time"},"1F553")
  T.add({"camera"},"1F4F7"); T.add({"movie","clapper"},"1F3AC")
  T.add({"play"},"25B6-FE0F"); T.add({"pause"},"23F8-FE0F"); T.add({"stop"},"23F9-FE0F"); T.add({"record"},"23FA-FE0F")
  T.add({"ff","fastforward"},"23E9"); T.add({"rew","rewind"},"23EA"); T.add({"nexttrack"},"23ED-FE0F"); T.add({"prevtrack"},"23EE-FE0F")
  T.add({"book"},"1F4D6"); T.add({"notebook"},"1F4D3"); T.add({"page"},"1F4C4"); T.add({"memo","pencil"},"1F4DD"); T.add({"pen"},"1F58A-FE0F")
  T.add({"email","envelope"},"2709-FE0F"); T.add({"mdash","emdash"},"2014")
  T.add({"gem","diamond"},"1F48E"); T.add({"crown","king"},"1F451"); T.add({"trophy"},"1F3C6"); T.add({"target","bullseye"},"1F3AF")

  ----------------------------------------------------------------
  -- FACES (very complete “Smileys & Emotion” set commonly used)
  ----------------------------------------------------------------
  local faces = {
    {"grin","smile","1F600"},
    {"beaming","grinbig","1F601"},
    {"lol","joy","1F602"},
    {"rofl","rolling","1F923"},
    {"sweatsmile","phew","1F605"},
    {"tearsmile","1F972"},
    {"happy","blush","1F60A"},
    {"slight_smile","1F642"},
    {"upside_down","1F643"},
    {"wink","1F609"},
    {"smirk","1F60F"},
    {"relieved","1F60C"},
    {"heart_eyes","loving","1F60D"},
    {"kissing","1F617"},
    {"kissing_heart","1F618"},
    {"kissing_smile","1F619"},
    {"yum","delicious","1F60B"},
    {"stuck_out_tongue","1F61B"},
    {"tongue_wink","1F61C"},
    {"zany","goofy","1F92A"},
    {"moneyface","1F911"},
    {"hug","1F917"},
    {"shushing","1F92B"},
    {"thinking","think","hmm","1F914"},
    {"zipper_mouth","1F910"},
    {"neutral","serious","1F610"},
    {"expressionless","1F611"},
    {"no_mouth","1F636"},
    {"smirk_unamused","unamused","1F612"},
    {"rolling_eyes","1F644"},
    {"grimace","1F62C"},
    {"woozy","1F974"},
    {"drooling","1F924"},
    {"sleepy","1F62A"},
    {"sleep","zzz","1F634"},
    {"mask","1F637"},
    {"thermometer","sick","1F912"},
    {"head_bandage","1F915"},
    {"nausea","sick","1F922"},
    {"vomit","barf","1F92E"},
    {"sneeze","1F927"},
    {"hot","heat","1F975"},
    {"cold","freeze","1F976"},
    {"exploding_head","mindblown","1F92F"},
    {"cowboy","1F920"},
    {"sunglasses","cool","1F60E"},
    {"nerd","1F913"},
    {"party","1F973"},
    {"disguise","1F978"},
    {"clown","1F921"},
    {"poop","1F4A9"},
    {"ghost","1F47B"},
    {"skull","1F480"},
    {"alien","1F47D"},
    {"robot","bot","1F916"},
    {"jackolantern","pumpkinface","1F383"},
    {"smile_halo","innocent","1F607"},
    {"devil","smiling_devil","1F608"},
    {"ogre","1F479"},
    {"goblin","1F47A"},
    {"anger","1F4A2"},
    {"sweat","1F613"},
    {"cry","sob","1F62D"},
    {"sad","frown","1F641"},
    {"pleading","1F97A"},
    {"smiling_tears","1F972"},
    {"fearful","1F628"},
    {"scream","omg","shock","1F631"},
    {"confounded","1F616"},
    {"persevere","1F623"},
    {"tired","1F62B"},
    {"weary","1F629"},
    {"anguish","1F627"},
    {"dizzy","1F635"},
    {"dizzy_stars","1F635-200D-1F4AB"},
    {"melting","1FAE0"},
    {"salute","1FAE1"},
    {"facepalm","1F926"},
    {"shrug","1F937"},
    {"eyes","look","1F440"},
    {"kiss_mark","1F48B"},
    {"heart_on_fire","1F9E1-200D-1F525"},
    {"mending_heart","2764-FE0F-200D-1FA79"},
  }
  for _, row in ipairs(faces) do
    local aliases, seq = {table.unpack(row,1,#row-1)}, row[#row]
    T.add(aliases, seq)
  end

  ----------------------------------------------------------------
  -- HANDS (tone-able)
  ----------------------------------------------------------------
  T.add({"thumbsup","like"},"1F44D"); T.add({"thumbsdown","dislike"},"1F44E"); T.add({"okhand","ok"},"1F44C")
  T.add({"peace","deuces","victory"},"270C-FE0F"); T.add({"clap","applause"},"1F44F"); T.add({"pray","please"},"1F64F")
  T.add({"pointright"},"1F449"); T.add({"pointleft"},"1F448"); T.add({"pointup"},"261D-FE0F"); T.add({"pointup2"},"1F446"); T.add({"pointdown"},"1F447")
  T.add({"raised","hand","stop"},"270B"); T.add({"vulcan"},"1F596"); T.add({"writing","handwrite"},"270D-FE0F")
  T.add({"handshake"},"1F91D"); T.add({"hearthands","hearthand"},"1FAF6")

  ----------------------------------------------------------------
  -- WEATHER / NATURE
  ----------------------------------------------------------------
  T.add({"sun","sunny"},"2600-FE0F"); T.add({"moon","halfmoon"},"1F319"); T.add({"glowstar","star2"},"1F31F")
  T.add({"cloud","cloudy"},"2601-FE0F"); T.add({"rain","raindrops","rainy"},"1F327-FE0F")
  T.add({"storm","thunder"},"26C8-FE0F"); T.add({"snow","snowflake"},"2744-FE0F")
  T.add({"tornado"},"1F32A-FE0F"); T.add({"rainbow"},"1F308"); T.add({"water","wave"},"1F30A")
  T.add({"leaf"},"1F343"); T.add({"flower","blossom"},"1F338"); T.add({"tree"},"1F333")

  ----------------------------------------------------------------
  -- ANIMALS (broad, commonly used)
  ----------------------------------------------------------------
  local animals = {
    {"dog","puppy","1F436"}, {"guide_dog","1F9AE"},
    {"cat","kitty","1F431"}, {"lion","1F981"}, {"tiger","1F42F"}, {"leopard","1F406"},
    {"horse","1F434"}, {"unicorn","1F984"}, {"cow","1F42E"}, {"ox","1F402"}, {"water_buffalo","1F403"},
    {"pig","1F437"}, {"boar","1F417"}, {"mouse","1F42D"}, {"rat","1F400"},
    {"rabbit","bunny","1F430"}, {"bear","1F43B"}, {"panda","1F43C"}, {"koala","1F428"},
    {"monkey","1F412"}, {"monkey_face","1F435"}, {"gorilla","1F98D"},
    {"fox","1F98A"}, {"wolf","1F43A"}, {"deer","1F98C"}, {"bison","1F9AC"},
    {"bat","1F987"}, {"cat_face","1F431"}, {"polar_bear","1F43B-200D-2744-FE0F"},
    {"bird","1F426"}, {"penguin","1F427"}, {"chicken","1F414"}, {"rooster","1F413"}, {"hatching_chick","1F423"},
    {"eagle","1F985"}, {"owl","1F989"}, {"duck","1F986"}, {"swan","1F9A2"},
    {"butterfly","1F98B"}, {"bee","honeybee","1F41D"}, {"beetle","1F41E"}, {"ladybug","1F41E"},
    {"ant","1F41C"}, {"spider","1F577-FE0F"}, {"scorpion","1F982"},
    {"snake","1F40D"}, {"lizard","1F98E"}, {"turtle","1F422"}, {"crocodile","1F40A"},
    {"frog","1F438"}, {"fish","1F41F"}, {"tropical_fish","1F420"}, {"blowfish","1F421"},
    {"dolphin","1F42C"}, {"shark","1F988"}, {"whale","1F433"}, {"whale2","1F40B"},
    {"octopus","1F419"}, {"crab","1F980"}, {"shrimp","1F990"}, {"lobster","1F99E"}, {"oyster","1F9AA"},
    {"snail","1F40C"}, {"bug","1F41B"},
  }
  for _, row in ipairs(animals) do T.add({row[1], row[2]}, row[3]) end

  ----------------------------------------------------------------
  -- FRUITS + key foods (broad set)
  ----------------------------------------------------------------
  local fruits = {
    {"grapes","1F347"},{"melon","1F348"},{"watermelon","1F349"},{"tangerine","orange","1F34A"},
    {"lemon","1F34B"},{"banana","1F34C"},{"pineapple","1F34D"},{"redapple","apple","1F34E"},
    {"greenapple","1F34F"},{"pear","1F350"},{"peach","1F351"},{"cherries","cherry","1F352"},
    {"strawberry","1F353"},{"kiwi","1F95D"},{"tomato","1F345"},{"olive","1FAD2"},
    {"coconut","1F965"},{"avocado","1F951"},{"blueberries","1FAD0"},{"mango","1F96D"},
    {"eggplant","1F346"},{"carrot","1F955"},{"corn","1F33D"},{"hotpepper","pepper","1F336-FE0F"},
    {"cucumber","1F952"},{"potato","1F954"},{"sweet_potato","1F360"},{"garlic","1F9C4"},{"onion","1F9C5"},
    -- sweets & misc:
    {"lollipop","candy","1F36D"},{"cookie","1F36A"},{"chocolate","1F36B"},{"doughnut","donut","1F369"},
    {"cake","birthday","1F382"},{"cupcake","1F9C1"},{"pie","1F967"},{"icecream","1F368"},{"shaved_ice","1F367"},
    {"custard","pudding","1F36E"},
    -- meals/drinks:
    {"pizza","1F355"},{"burger","hamburger","1F354"},{"fries","1F35F"},{"hotdog","1F32D"},
    {"sandwich","1F96A"},{"taco","1F32E"},{"burrito","1F32F"},{"stuffed_flatbread","1F959"},
    {"ramen","noodles","1F35C"},{"spaghetti","1F35D"},{"rice","1F35A"},{"curry","1F35B"},
    {"sushi","1F363"},{"bento","1F371"},{"fried_shrimp","1F364"},{"oden","1F362"},
    {"meat_on_bone","1F356"},{"poultry_leg","1F357"},{"steak","cut_of_meat","1F969"},
    {"salad","1F957"},{"bread","1F35E"},{"croissant","1F950"},{"baguette","1F956"},{"pretzel","1F968"},
    {"cheese","1F9C0"},{"butter","1F9C8"},{"salt","1F9C2"},
    {"coffee","2615"},{"tea","1F375"},{"sake","1F376"},{"beer","1F37A"},{"wine","1F377"},{"cocktail","1F378"}
  }
  for _, r in ipairs(fruits) do
    local a,b,cp = r[1], r[2], r[3]
    if b then T.add({a,b}, cp) else T.add(a, cp) end
  end

  ----------------------------------------------------------------
  -- SPORTS / BALLS
  ----------------------------------------------------------------
  T.add({"soccer","football_eu"},"26BD"); T.add({"basketball"},"1F3C0"); T.add({"football","nfl"},"1F3C8")
  T.add({"baseball"},"26BE"); T.add({"tennis"},"1F3BE"); T.add({"volleyball"},"1F3D0"); T.add({"rugby"},"1F3C9")
  T.add({"8ball","pool"},"1F3B1"); T.add({"bowling"},"1F3B3"); T.add({"boxingglove"},"1F94A")
  T.add({"medal"},"1F3C5"); T.add({"trophy"},"1F3C6"); T.add({"running","runner"},"1F3C3")

  ----------------------------------------------------------------
  -- TECH / OBJECTS
  ----------------------------------------------------------------
  T.add({"headphones"},"1F3A7"); T.add({"gamepad","controller"},"1F3AE"); T.add({"joystick"},"1F579-FE0F")
  T.add({"computer","pc"},"1F5A5-FE0F"); T.add({"laptop"},"1F4BB"); T.add({"phone","mobile"},"1F4F1")
  T.add({"battery"},"1F50B"); T.add({"antenna","signal","wifibars"},"1F4F6"); T.add({"satellite"},"1F4E1")
  T.add({"bug"},"1F41B"); T.add({"toolbox"},"1F9F0"); T.add({"brick"},"1F9F1"); T.add({"teddybear","teddy"},"1F9F8")
  T.add({"clipboard","clip"},"1F4CB"); T.add({"robot","bot"},"1F916")

  ----------------------------------------------------------------
  -- TRAVEL / VEHICLES / PLACES
  ----------------------------------------------------------------
  T.add({"car","redcar"},"1F697"); T.add({"taxi"},"1F695"); T.add({"bus"},"1F68C"); T.add({"policecar"},"1F693")
  T.add({"ambulance"},"1F691"); T.add({"fireengine"},"1F692"); T.add({"train"},"1F686"); T.add({"subway"},"1F687")
  T.add({"airplane","plane"},"2708-FE0F"); T.add({"rocket","launch"},"1F680"); T.add({"helicopter"},"1F681")
  T.add({"ship"},"1F6A2"); T.add({"boat"},"26F5"); T.add({"anchor"},"2693")
  T.add({"world","globe"},"1F310"); T.add({"map"},"1F5FA-FE0F"); T.add({"pin","location","loc"},"1F4CD")
  T.add({"building"},"1F3E2"); T.add({"house"},"1F3E0"); T.add({"castle"},"1F3F0")

  ----------------------------------------------------------------
  -- FLAGS: Build ALL via ISO and alias a big set of common names.
  ----------------------------------------------------------------
  local iso = {  -- 2-letter ISO-3166-1 alpha-2 codes (full set including territories)
    "AD","AE","AF","AG","AI","AL","AM","AO","AQ","AR","AS","AT","AU","AW","AX","AZ","BA","BB","BD","BE","BF","BG","BH","BI","BJ","BL","BM","BN","BO","BQ","BR","BS","BT","BV","BW","BY","BZ","CA","CC","CD","CF","CG","CH","CI","CK","CL","CM","CN","CO","CR","CU","CV","CW","CX","CY","CZ","DE","DJ","DK","DM","DO","DZ",
    "EC","EE","EG","EH","ER","ES","ET",
    "FI","FJ","FK","FM","FO","FR",
    "GA","GB","GD","GE","GF","GG","GH","GI","GL","GM","GN","GP","GQ","GR","GS","GT","GU","GW","GY",
    "HK","HM","HN","HR","HT","HU",
"ID","IE","IL","IM","IN","IO","IQ","IR","IS","IT","JE","JM","JO","JP","KE","KG","KH","KI","KM","KN","KP","KR","KW","KY","KZ","LA","LB","LC","LI","LK","LR","LS","LT","LU","LV","LY","MA","MC","MD","ME","MF","MG","MH","MK","ML","MM","MN","MO","MP","MQ","MR","MS","MT","MU","MV","MW","MX","MY","MZ","NA","NC","NE","NF","NG","NI","NL","NO","NP","NR","NU","NZ","OM","PA","PE","PF","PG","PH","PK","PL","PM","PN","PR","PS","PT","PW","PY","QA","RE","RO","RS","RU","RW",    "SA","SB","SC","SD","SE","SG","SH","SI","SJ","SK","SL","SM","SN","SO","SR","SS","ST","SV","SX","SY","SZ",    "TC","TD","TF","TG","TH","TJ","TK","TL","TM","TN","TO","TR","TT","TV","TW","TZ",
    "UA","UG","UM","US","UY","UZ",    "VA","VC","VE","VG","VI","VN","VU",
    "WF","WS",
    "YE","YT",
    "ZA","ZM","ZW"
  };

  for _, c in ipairs(iso) do
    local g = T.flag(c)
    local lo = normAlias(c)
    T[lo] = g; T[lo.."flag"] = g; T[lo.."_flag"] = g
  end
  -- common-country human aliases → flags
  local country = {
    usa="US", unitedstates="US", america="US", usaflag="US", usflag="US",
    uk="GB", britain="GB", unitedkingdom="GB",
    uae="AE", dubai="AE",
    saudi="SA", saudiarabia="SA",
    southkorea="KR", korea="KR", northkorea="KP",
    china="CN", india="IN", russia="RU", japan="JP",
    canada="CA", mexico="MX", brazil="BR", argentina="AR", chile="CL", colombia="CO", peru="PE", venezuela="VE",
    france="FR", germany="DE", italy="IT", spain="ES", portugal="PT", netherlands="NL", holland="NL", belgium="BE",
    sweden="SE", norway="NO", denmark="DK", finland="FI", poland="PL", greece="GR", ukraine="UA", ireland="IE",
    turkey="TR", egypt="EG", israel="IL", iran="IR", iraq="IQ", pakistan="PK", bangladesh="BD", philippines="PH",
    thailand="TH", vietnam="VN", malaysia="MY", indonesia="ID", singapore="SG",
    nigeria="NG", southafrica="ZA", kenya="KE", ghana="GH", ethiopia="ET", morocco="MA", tunisia="TN", algeria="DZ",
    australia="AU", newzealand="NZ"
  }
  for alias, code in pairs(country) do
    local g = T.flag(code); local a = normAlias(alias)
    T[a] = g; T[a.."flag"] = g; T[a.."_flag"] = g
  end

  -- brand shortcuts you asked for
  T.add({"lollipop","candy"},"1F36D"); T.add({"clipboard","clip"},"1F4CB"); T.add({"mdash","emdash"},"2014")

  T._seq = meta
  return T
end)();