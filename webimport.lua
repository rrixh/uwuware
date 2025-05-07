-- modifying webimport()
owner="rrixh"; repo="uwuware"; branch="main"; folder="none";

local G,E=pcall(function()
if(getgenv().globals)then
loadstring(game:HttpGet('https://raw.githubusercontent.com/rrixh/uwuware/refs/heads/main/skripts/globaLS'))();
else x99888888888887x=[[87682482]]
end;
end);
-----
if(not G)then warn("⚠️ [Globals]\n", E) end;
------
local _webimport,no=pcall(function()

getgenv().folders = {"", " ", "f", "+", "folder", "#bypass", "bypass", "kustomskript", "Kustom", "*request", "UNIVERSAL", "dahood", "exekutor", "draggable-mobile-button", "games", "images", "lib", "mobilefly", "rbxevent", "simulators", "skripts", "test", "ugc"};
getgenv().Me = {"rrixh", "lulas", "lula", "Lula", "Lulas", "lulaslollipop", "Lulaslollipop"};
getgenv().tora = {"ToraIsMe", "gumanba"};
getgenv().owner=owner;
getgenv().repo=repo;
getgenv().branch=branch;
getgenv().folder=folder;

getgenv().webimport = function(file,isfolder,arg3)
if(owner==nil)or (table.find(Me:lower(),owner))then owner="rrixh" end;
if(table.find(tora:lower(),owner))then owner="gumanba"; repo="Scripts";
end;
if(file==file..".uwuware")then repo = "uwuware" end;
if(repo==nil)then 
warn("MUST ASSIGN 'repo' VARIABLE --> Example:\t local repo = \"RepositoryNameHere\"") 
repo="uwuware" end;
if(branch==nil)or(branch~="main")or(branch~="refs/heads/main")then
branch = "main";
elseif(branch=="refs")or(branch=="refs/heads")or(branch=="rhm")then
branch = "refs/heads/main"
 end;
  finalFolder = folder;
if(isfolder==nil)or(isfolder=="")or(isfolder=="none")then isfolder=false;end;
 if(arg3=="symbol")or(not arg3)then
        finalFolder = folder 
elseif(arg3=="#bypass")or(arg3 =="bypass")then
finalFolder="%23"..folder;
elseif(arg3=="*request")or(arg3 =="request")then
finalFolder="%2a"..folder;
elseif(table.find(getgenv().folders, arg3))then
finalFolder = (folder.."/")
    end;

    if(isfolder)then
finalFolder = (folder.."/")
        url=string.format("https://raw.githubusercontent.com/%s/%s/%s/%s/%s", owner, repo, "refs/heads/"..branch, finalFolder, file)
    else
  url = string.format("https://raw.githubusercontent.com/%s/%s/%s/%s", owner, repo, "refs/heads/"..branch, file)
    end;
   skript=(game:HttpGet(url))
    return (loadstring(skript,file)());
end;
-----
end);

if(not _webimport)then 
warn("⚠️ [webimport] function error:\n", no) 
else
print("webimport ✅")
end;