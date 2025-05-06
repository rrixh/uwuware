if(getgenv().globals)then
loadstring(game:HttpGet('https://raw.githubusercontent.com/rrixh/uwuware/refs/heads/main/skripts/globaLS'))();
else x99888888888887x=[[1]]
end;

getgenv().folders = {"", " ", "f", "+", "folder", "#bypass", "bypass", "kustomskript", "Kustom", "*request", "UNIVERSAL", "dahood", "exekutor", "draggable-mobile-button", "games", "images", "lib", "mobilefly", "rbxevent", "simulators", "skripts", "test", "ugc"}
getgenv().owner=owner;
getgenv().repo=repo;
getgenv().branch=branch;
getgenv().folder=folder;

getgenv().webimport = function(file,isfolder,arg3)
if(owner==nil)then owner="rrixh" end;
if(repo==nil)then warn("MUST ASSIGN VARIABLE --> Example:\n local repo = \"RepositoryNameHere\"") 
return end;
if(branch==nil)or(branch~="main")or(branch~="refs/heads/main")then
branch = "main" 
 end;
  finalFolder = folder;
if(isfolder==nil)or(isfolder=="")then isfolder=false;end;
 if(arg3=="symbol")or(not arg3)then
        finalFolder = folder 
elseif(arg3=="#bypass")then
finalFolder="%23"..folder
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