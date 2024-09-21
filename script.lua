repeat task.wait() until game:IsLoaded()
task.wait(1) -- for safety ig
print("something1")
-- made by altered (Not discord username)
-- railme37509124 on github
-- dumbdog9 on youtube
-- UI library: KLib V2
-- Credits to: Infinite Yield, some other script for the ui library inspiration i dont know its name tho lol, and me
local liblib = "https://raw.githubusercontent.com/railme37509124/KLibV2/refs/heads/main/library"
local klib = loadstring(game:HttpGet(liblib))() -- you can go modify this a bit to change the color theme if you would like to
klib:SetTitle("Komaru Hub | Ability Wars")
local http = game:GetService("HttpService")
local backroompos = CFrame.new(-7157, 96, -5071)
local od = klib.Destroy
local unloaded = false
local destroy = function()
    unloaded = true
    task.wait(0.01)
    od()
end
local modlist = {
    1756212802,
    4393226871,
    374663048,
    472468023,
    355408714,
    792324784,
    368943249,
    169175274,
    597766981,
    51266516,
    75237783,
    1168192062,
    134725061,
    3233825722,
    479724701,
    157508986,
    533784762,
    110439399,
}

local plrs = game.Players
local sets = {
    WalkSpeedValue = 16,
    JumpPowerValue = 50,
    GravityValue = 196.2,
    AutoArena = false,
    InfiniteJump = false,
    ShowPlayers = false,
    JoinLeaveNotifier = false,
    AntiModerator = false,
    AntiVoid = false,
    LookAtPlayers = false,
    TargetStrafe = false,
    KillAura = false,
    LegitAura = false,
    AntiGravAbility = false,
    KillAuraDistanceValue = 0,
    Reach = false,
    AvoidTime = false,
    ReachSlider = 2,
    GuiDragSpeed = 0.2,
    AntiVoidColorHex = "#ffffff",
    AbilityEsp = false,
    -- KillAura Autofarm will NOT save hahahaha
}
local debugging = true
function writecfg()
    if not isfile("KOMARUCONFIG.json") then
        writefile("KOMARUCONFIG.json", http:JSONEncode(sets))
    end
end

function savesettings()
    writefile("KOMARUCONFIG.json", http:JSONEncode(sets))
    if debugging then 
        print("--------------------\n" .. http:JSONEncode(sets))
    end
end

function loadsettings()
    writecfg()
    sets = http:JSONDecode(readfile("KOMARUCONFIG.json"))
end
loadsettings()
if debugging then
    for i, v in sets do
        print(i, v)
    end
end


-- wouldnt be worth the time to change this
ff = {
    Killaura = false,
    Legitaura = false,
    Botfarm = false, 
    Antigravability = false,
    Lookatplayers = false,
    Targetstrafe
}

dcl = "https://discord.gg/uSbrxdZ4"
scr = function(l) return loadstring(game:HttpGet(l))() end
function lookatplr(plr)
    local chrPos = plrs.LocalPlayer.Character.PrimaryPart.Position
    local tPos = plr.Character:FindFirstChild("HumanoidRootPart").Position
    local modTPos = Vector3.new(tPos.X,chrPos.Y,tPos.Z)
    local newCF = CFrame.new(chrPos,modTPos)
    plrs.LocalPlayer.Character:SetPrimaryPartCFrame(newCF)
end
LocalPlayerTab_ = klib.CreateTab{
	Name = "Local Player"
}
LocalPlayerTab = LocalPlayerTab_:Section()
LocalPlayerTab2 = LocalPlayerTab_:Section()
CombatTab_ = klib.CreateTab{
	Name = "PVP"
}
CombatTab = CombatTab_:Section()
CombatTab2 = CombatTab_:Section()
SettingsTab_ = klib.CreateTab{
	Name = "Config"
}
SettingsTab = SettingsTab_:Section()
OtherScriptsTab_ = klib.CreateTab{
	Name = "Universal"
}
OtherScriptsTab = OtherScriptsTab_:Section()
modconnections = {}
LocalPlayerTab:Slider({
	Name = "Walk Speed",
	Callback = function(value)
        sets["WalkSpeedValue"] = value
        plrs.LocalPlayer.Character.Humanoid.WalkSpeed = value
	end,
	Min = 16,
	Max = 150,
	Round = true
}).Set(sets["WalkSpeedValue"])
LocalPlayerTab:Slider({
	Name = "Jump Power",
	Callback = function(value)
        sets["JumpPowerValue"] = value
        plrs.LocalPlayer.Character.Humanoid.JumpPower = value
	end,
	Min = 50,
	Max = 250,
	Round = true
}).Set(sets["JumpPowerValue"])
LocalPlayerTab:Slider({
	Name = "Gravity",
	Callback = function(value)
        sets["GravityValue"] = value
        workspace.Gravity = value
	end,
	Min = 0,
	Max = 196.2,
	Round = true
}).Set(sets["GravityValue"])

function hitplr(plr)
    game:GetService("ReplicatedStorage")["Remote Events"].Punch:FireServer(plr.Character)
end
function entitynearpositon(dist)
    for _, v in plrs:GetPlayers() do
        if v == plrs.LocalPlayer then continue end
        if not v.Character then continue end
        if not v.Character:FindFirstChild("Humanoid") then continue end
        if not (v.Character:FindFirstChild("Humanoid").Health > 0) then continue end
        if not plrs.LocalPlayer.Character then return end
        if not plrs.LocalPlayer.Character:FindFirstChild("Humanoid") then return end
        if not (plrs.LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0) then return end
        if (v.Character.HumanoidRootPart.Position - plrs.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < dist then
            return v
        end
    end
end
local avpart = nil
local istouched
local antivoidtoggle = CombatTab:Toggle({
    Name = "Anti Void",
    Callback = function(state)
        sets["AntiVoid"] = state
        if state then
            avpart = Instance.new("Part")
            avpart.Material = Enum.Material.ForceField
            avpart.Transparency = 0
            avpart.CanCollide = false
            avpart.Anchored = true
            avpart.Color = Color3.fromRGB(87, 255, 98)
            avpart.CastShadow = false
            avpart.Size = Vector3.new(10000, 20, 10000)
            avpart.Position = Vector3.new(156, 0, 31)
            avpart.Parent = workspace
            avpart.Touched:Connect(function(prt)
                if prt.Name == "HumanoidRootPart" and not istouched then
                    if prt.Parent.Name == plrs.LocalPlayer.Name then
                        for i = 1, 12 do
                            plrs.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(plrs.LocalPlayer.Character.HumanoidRootPart.Velocity.X, plrs.LocalPlayer.Character.HumanoidRootPart.Velocity.Y + 26, plrs.LocalPlayer.Character.HumanoidRootPart.Velocity.Z)
                            task.wait(0.05)
                        end
                        istouched = true
                        task.wait(.5)
                        istouched = false
                    end
                end
            end)
        else
            if avpart then
                avpart:Destroy()
            end
        end
    end
})
if sets["AntiVoid"] then antivoidtoggle.Click() end
CombatTab:TextBox({
	Name = "AntiVoid Color",
	ClearOnFocus = true,
	ClearOnLost = true,
	EnterPressed = false,
	Placeholder = "Color in hex code",
	Callback = function(text)
		if avpart then
            if not text:find("#") then
                avpart.Color = Color3.fromHex("#" .. text)
            else
                avpart.Color = Color3.fromHex(text)
            end
        end
	end,
})
local lookatplayerstoggle = CombatTab:Toggle({
    Name = "LookAt Players",
    Callback = function(state)
        sets["LookAtPlayers"] = state
        ff.Lookatplayers = state
    end
})
if sets["LookAtPlayers"] then lookatplayerstoggle.Click() end

local targetstrafetoggle = CombatTab:Toggle({
	Name = "TargetStrafe",
	Callback = function(state)
        sets["TargetStrafe"] = state
        ff.Targetstrafe = state
	end
})
if sets["TargetStrafe"] then targetstrafetoggle.Click() end

local karange = 10
local katoggle = CombatTab:Toggle({
    Name = "KillAura",
    Callback = function(state)
        sets["KillAura"] = state
        ff.Killaura = state
        if debugging then print("tg: ".. tostring(state)) end
    end
})
if sets["katoggle"] then katoggle.Click() end

local latoggle = CombatTab:Toggle({
    Name = "LegitAura",
    Callback = function(state)
        sets["LegitAura"] = state
        ff.Legitaura = state
        print("tg: ".. tostring(state))
    end
})
if sets["LegitAura"] then latoggle.Click() end

local antgtoggle = CombatTab:Toggle({
    Name = "Anti Gravity Ability",
    Callback = function(state)
        sets["AntiGravAbility"] = state
        ff.Antigravability = state
        print("tg: ".. tostring(state))
    end
})
if sets["AntiGravAbility"] then antgtoggle.Click() end
local kadistance = CombatTab:Slider({
	Name = "KillAura Distance threshold",
	Callback = function(value)
        sets["KillAuraDistanceValue"] = value
        karange = value
	end,
	Min = 10,
	Max = 50,
	Round = true
}).Set(sets["KillAuraDistanceValue"])
local lcharadded2 = nil
local autoarenatog = LocalPlayerTab:Toggle({
	Name = "Auto Arena",
	Callback = function(state)
        sets["AutoArena"] = state
        if state then
            lcharadded2 = plrs.LocalPlayer.CharacterAdded:Connect(function()
                task.wait(plrs.LocalPlayer:GetNetworkPing())
                if firetouchinterest then -- god your shitty executors
                    firetouchinterest(plrs.LocalPlayer.Character.HumanoidRootPart, workspace.Portals["Arena Frame"].Portal, 1)
                else
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Shit executor",
                        Text = v.Name .. "oops, your executor is ass and has no firetouchinterest!",
                        Duration = 4
                    })
                    plrs.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Portals["Arena Frame"].Portal.CFrame
                end
            end)
        else
            if lcharadded2 then
                lcharadded2:Disconnect()
            end
        end
	end
})
if sets["AutoArena"] then autoarenatog.Click() end
local Highlights = {}
local Charadded = {}
local Plradded = nil
local function addhighlight(plr)
    local hl = Instance.new("Highlight", plr.Character)
    Highlights[plr] = hl
end
local showplayerstog = LocalPlayerTab2:Toggle({
	Name = "Show players",
	Callback = function(state)
        sets["ShowPlayers"] = state
        if state then
            for _, v in plrs:GetPlayers() do
                if v.Character ~= nil then
                    addhighlight(v)
                end
                Charadded[v.Name] = v.CharacterAdded:Connect(function()
                    addhighlight(v)
                end)
            end
            Plradded = plrs.PlayerAdded:Connect(function(v)
                if v.Character ~= nil then
                    addhighlight(v)
                end
                Charadded[v.Name] = v.CharacterAdded:Connect(function()
                    addhighlight(v)
                end)
            end)
        else
            for _, v in Charadded do
                v:Disconnect()
            end
            Plradded:Disconnect()
            for _, v in Highlights do
                if v ~= nil then
                    v:Destroy()
                end
            end
        end
	end
})
if sets["ShowPlayers"] then showplayerstog.Click() end

local SelectionBoxes = {}
local Charadded2 = {}
local Plradded2 = nil
local function addbox(plr)
    local sb = Instance.new("SelectionBox", plr.Character)
    sb.Adornee = plr.Character
    SelectionBoxes[plr] = sb
end
local showboxestog = LocalPlayerTab2:Toggle({
	Name = "Player Boxes",
	Callback = function(state)
        sets["ShowBoxes"] = state
        if state then
            for _, v in plrs:GetPlayers() do
                if v.Character ~= nil then
                    addbox(v)
                end
                Charadded2[v.Name] = v.CharacterAdded:Connect(function()
                    addbox(v)
                end)
            end
            Plradded2 = plrs.PlayerAdded:Connect(function(v)
                if v.Character ~= nil then
                    addbox(v)
                end
                Charadded2[v.Name] = v.CharacterAdded:Connect(function()
                    addbox(v)
                end)
            end)
        else
            for _, v in Charadded2 do
                v:Disconnect()
            end
            Plradded2:Disconnect()
            for _, v in SelectionBoxes do
                if v ~= nil then
                    v:Destroy()
                end
            end
        end
	end
})
if sets["ShowBoxes"] then showboxestog.Click() end
local BBGuis = {}
local Charadded4 = {}
local Plradded4 = nil
local function addbb(plr)
    local h = plr.Character.Head["Name Tag"]:Clone()
    h.Parent = plr.Character.Head
    h.Name = "abilesp"
    h.TextLabel.Text = plr.leaderstats.Ability.Value
    h.StudsOffset = Vector3.new(0, -3, 0)
    h.Size = UDim2.new(0, 200, 0, 200)
    h.AlwaysOnTop = true
    plr.leaderstats.Ability:GetPropertyChangedSignal("Value"):Connect(function()
        h.TextLabel.Text = plr.leaderstats.Ability.Value
    end)
    BBGuis[plr] = h
end
abilesptog = LocalPlayerTab2:Toggle({
	Name = "Ability ESP",
	Callback = function(state)
        sets["AbilityEsp"] = state
        if state then
            for _, v in plrs:GetPlayers() do
                if v.Character ~= nil then
                    addbb(v)
                end
                Charadded4[v.Name] = v.CharacterAdded:Connect(function()
                    task.wait(2)
                    addbb(v)
                end)
            end
            Plradded4 = plrs.PlayerAdded:Connect(function(v)
                if v.Character ~= nil then
                    task.wait(2)
                    addbb(v)
                end
                Charadded4[v.Name] = v.CharacterAdded:Connect(function()
                    task.wait(2)
                    addbb(v)
                end)
            end)
        else
            for _, v in Charadded4 do
                v:Disconnect()
            end
            Plradded4:Disconnect()
            for _, v in BBGuis do
                if v ~= nil then
                    v:Destroy()
                end
            end
        end
	end
})
if sets["AbilityEsp"] then abilesptog.Click() end

plraddedj = nil
plraddedl = nil
LocalPlayerTab2:Toggle({
    Name = "Join/Leave notif",
    Callback = function(state)
        if state then
            plraddedj = game.Players.PlayerAdded:Connect(function(v)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Player Join",
                    Text = v.Name .. " [@" .. v.DisplayName .. "]",
                    Duration = 10
                })
            end)
            plraddedl = game.Players.PlayerRemoving:Connect(function(v)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Player Leave",
                    Text = v.Name .. " [@" .. v.DisplayName .. "]",
                    Duration = 10
                })
            end)
        else
            if plraddedj then
                plraddedj:Disconnect()
            end
            if plraddedl then
                plraddedl:Disconnect()
            end
        end
    end,
    Default = true
})
local amodplradded
LocalPlayerTab2:Toggle({
    Name = "Anti Moderator",
    Callback = function(state)
        if state then
            amodplradded = game.Players.PlayerAdded:Connect(function(v)
                if table.find(modlist, v.UserId) then
                    plrs.LocalPlayer:Kick("\nKOMARU HUB ANTI MOD\n\t" .. v.Name .. "\t")
                end
            end)
        else
            if amodplradded then
                amodplradded:Disconnect()
            end
        end
    end,
    Default = true
})
local infjumpcon = nil
local infjumptog = LocalPlayerTab:Toggle({
	Name = "Infinite Jump",
	Callback = function(state)
        if state then
            infjumpcon = game:GetService("UserInputService").JumpRequest:Connect(function()
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end)
        else
            if infjumpcon then
                infjumpcon:Disconnect()
            end
        end
	end
})
if sets["InfiniteJump"] then infjumptog.Click() end
LocalPlayerTab:TextBox({
	Name = "Fake Punches",
	ClearOnFocus = false,
	ClearOnLost = false,
	EnterPressed = false,
	Placeholder = "Fake Punches",
	Callback = function(text)
        if tonumber(text) ~= nil then -- prevent letters because people are stupid
            game:GetService("Players").LocalPlayer.PlayerGui.Counter.Frame.TextLabel.Text = tonumber(text)
        end
	end,
})
local lcharadded = nil
local reachval = 2
CombatTab:Slider({
	Name = "Reach Range",
	Callback = function(value)
        sets["ReachSlider"] = value
        reachval = value
	end,
	Min = 2,
	Max = 30,
	Round = true
}).Set(sets["ReachSlider"])
local reachtog = CombatTab:Toggle({
	Name = "Reach",
	Callback = function(state)
        sets["Reach"] = state
        if state then
            plrs.LocalPlayer.Character.Hitbox.Size = Vector3.new(reachval, reachval, reachval)
            lcharadded = plrs.LocalPlayer.CharacterAdded:Connect(function()
                task.wait(2)
                plrs.LocalPlayer.Character.Hitbox.Size = Vector3.new(reachval, reachval, reachval)
            end)
        else
            if lcharadded then
                lcharadded:Disconnect()
            end
        end
	end
})
if sets["Reach"] then reachtog.Click() end
cadded = nil
local avtime = CombatTab:Toggle({
	Name = "Avoid Time",
	Callback = function(state)
        sets["AvoidTime"] = state
        if state then
            cadded = workspace.ChildAdded:Connect(function(v)
                if v.Name == "1" then
                    v.CanCollide = true
                    if (plrs.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude < 112 then
                        plrs.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 99, 0)
                        plrs.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                    end
                end
            end)
        else
            if cadded then
                cadded:Disconnect()
            end
        end
	end
})
if sets["AvoidTime"] then avtime.Click() end
SettingsTab:Slider({
	Name = "Gui Drag Speed",
	Callback = function(value)
        sets["GuiDragSpeed"] = value
        klib.DragSpeed = value
	end,
	Min = 0,
	Max = 1,
    Default = klib.DragSpeed,
	Round = false
}).Set(sets["GuiDragSpeed"])
local selected = nil
local cti = tick()
CombatTab:Toggle({
	Name = "KillAura AutoFarm",
	Callback = function(state)
        ff.Botfarm = state
        print("tg: ".. tostring(state))
	end
})
OtherScriptsTab:Button({
    Name = "Infinite Yield",
    Callback = function()
        scr("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    end
})
OtherScriptsTab:Button({
    Name = "DEX Explorer",
    Callback = function()
        scr("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua")
    end
})
SettingsTab:Button({
    Name = "Copy discord",
    Callback = function()
        setclipboard(dcl)
    end
})
SettingsTab:Button({
    Name = "Reset Config",
    Callback = function()
        delfile("KOMARUCONFIG.json")
        game.StarterGui:SetCore("SendNotification", {
            Title = "Config Deleted",
            Text = "Success!",
            Duration = 4
        })
    end
})
if game.PlaceId == 8260276694 then
    local zzz = {}
    for i, v in workspace["Start Abilities"]:GetChildren() do
        table.insert(zzz, v.Name)
    end
    table.sort(zzz)
    CombatTab2:DropDown({
        Name = "Equip Ability",
        List = zzz,
        Callback = function(a)
            game:GetService("ReplicatedStorage")["Remote Events"].AbilitySelect:FireServer(a)
        end
    })
end

task.spawn(function()
    repeat
        if ff.Lookatplayers then
            local tar = entitynearpositon(karange)
            if tar then
                if tar.Character then
                    if tar.Character:FindFirstChild("HumanoidRootPart") then
                        lookatplr(tar)
                    end
                end
            end
        end
        task.wait(0.01)
    until nil
end)
task.spawn(function()
    repeat
        if ff.Targetstrafe then
            local tar = entitynearpositon(karange)
            if tar then
                if tar.Character then
                    if tar.Character:FindFirstChild("HumanoidRootPart") then
                        plrs.LocalPlayer.Character.HumanoidRootPart.CFrame = tar.Character.HumanoidRootPart.CFrame + Vector3.new(math.random(1, 9), math.random(1, 9), math.random(1, 9))
                    end
                end
            end
        end
        task.wait(0.02)
    until nil
end)
task.spawn(function()
    repeat
        if ff.Killaura then
            local tar = entitynearpositon(karange)
            if tar then
                if tar.Character then
                    if tar.Character:FindFirstChild("HumanoidRootPart") then
                        hitplr(tar)
                    end
                end
            end
        end
        task.wait(0.01)
    until nil
end)
task.spawn(function()
    repeat
        if ff.Legitaura then
            local tar = entitynearpositon(karange)
            if tar then
                if tar.Character then
                    if tar.Character:FindFirstChild("HumanoidRootPart") then
                        mouse1press()
                    end
                end
            end
        end
        task.wait(0.1)
    until nil
end)
task.spawn(function()
    repeat
        if ff.Botfarm then
            repeat
                selected = entitynearpositon(1000)
                if entitynearpositon(1000) ~= selected then
                    selected = entitynearpositon(1000)
                end
                task.wait(0.01)
            until selected ~= nil
            if selected.Character then
                if selected.Character:FindFirstChild("Humanoid") then
                    if selected.Character.Humanoid.Health > 0 then
                        if selected.Character.Humanoid.WalkSpeed ~= 40 then
                            plrs.LocalPlayer.Character.HumanoidRootPart.CFrame = selected.Character.HumanoidRootPart.CFrame
                        end
                    else
                        task.wait(4)
                        selected = nil
                    end
                end
            end
        end
        task.wait()
    until nil
end)
task.spawn(function()
    repeat
        if ff.Antigravability then
            if plrs.LocalPlayer.Character["Left Arm"]:FindFirstChild("Gravity Particle") then
                plrs.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(plrs.LocalPlayer.Character.HumanoidRootPart.Velocity.X, 0, plrs.LocalPlayer.Character.HumanoidRootPart.Velocity.Z)
            end
        end
        task.wait(0.1)
    until nil
end)
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/railme37509124/komaruhubabilitywars/refs/heads/main/script.lua'))()")
end)
print("something2")
task.spawn(function()
    repeat task.wait(5) savesettings() until unloaded
end)
game.StarterGui:SetCore("SendNotification", {
    Title = "Loaded",
    Text = "Enjoy using komaru hub!",
    Duration = 10
})
