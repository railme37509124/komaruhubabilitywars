local klib = loadstring(game:HttpGet("https://raw.githubusercontent.com/railme37509124/KLib/main/KLib.lua"))()
local plrs = game.Players
ff = {
    Killaura = false,
    Legitaura = false,
    Botfarm = false,
    Antigravability = false
}
scr = function(l) return loadstring(game:HttpGet(l))() end
function lookatplr(plr)
    local chrPos = plrs.LocalPlayer.Character.PrimaryPart.Position
    local tPos = plr.Character:FindFirstChild("HumanoidRootPart").Position
    local modTPos = Vector3.new(tPos.X,chrPos.Y,tPos.Z)
    local newCF = CFrame.new(chrPos,modTPos)
    plrs.LocalPlayer.Character:SetPrimaryPartCFrame(newCF)
end

LocalPlayerTab = klib.CreateTab{
	Name = "Local Player Modifications",
	Image = "rbxassetid://116556658002611"
}

CombatTab = klib.CreateTab{
	Name = "PVP Advantages",
	Image = "rbxassetid://115629447580333"
}

SettingsTab = klib.CreateTab{
	Name = "Configuration",
	Image = "rbxassetid://138694934892500"
}

OtherScriptsTab = klib.CreateTab{
	Name = "Universal Scripts",
	Image = "rbxassetid://84848575129381"
}

modconnections = {}
LocalPlayerTab:MakeSlider({
	Name = "Walk Speed",
	Callback = function(value)
        plrs.LocalPlayer.Character.Humanoid.WalkSpeed = value
	end,
	Min = 16,
	Max = 150,
	Round = true
})
LocalPlayerTab:MakeSlider({
	Name = "Jump Power",
	Callback = function(value)
        plrs.LocalPlayer.Character.Humanoid.JumpPower = value
	end,
	Min = 50,
	Max = 250,
	Round = true
})
function hitplr(plr)
    game:GetService("ReplicatedStorage")["Remote Events"].Punch:FireServer(plr.Character)
end
function entitynearpositon(dist)
    for _, v in plrs:GetPlayers() do
        if v == plrs.LocalPlayer then continue end
        if not v.Character then continue end
        if not v.Character:FindFirstChild("Humanoid") then continue end
        if not (v.Character:FindFirstChild("Humanoid").Health > 0) then continue end

        if (v.Character.HumanoidRootPart.Position - plrs.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < dist then
            return v
        end
    end
end
local avpart = nil
CombatTab:MakeToggle({
    Name = "Anti Void",
    Callback = function(state)
        if state then
            avpart = Instance.new("Part")
            avpart.Material = Enum.Material.ForceField
            avpart.Transparency = 0
            avpart.CanCollide = false
            avpart.Anchored = true
            avpart.Color = Color3.fromRGB(87, 255, 98)
            avpart.CastShadow = false
            avpart.Size = Vector3.new(10000, 3, 10000)
            avpart.Position = Vector3.new(156, 11, 31)
            avpart.Parent = workspace
            avpart.Touched:Connect(function(prt)
                if prt.Name == "HumanoidRootPart" then
                    plrs.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 60, 0)
                end
            end)
        else
            if avpart then
                avpart:Destroy()
            end
        end
    end
})
local karange = 10
CombatTab:MakeToggle({
    Name = "KillAura",
    Callback = function(state)
         ff.Killaura = state
         print("tg: ".. tostring(state))
    end
})
CombatTab:MakeToggle({
    Name = "LegitAura",
    Callback = function(state)
        ff.Legitaura = state
        print("tg: ".. tostring(state))
    end
})
CombatTab:MakeToggle({
    Name = "Anti Gravity Ability",
    Callback = function(state)
        ff.Antigravability = state
        print("tg: ".. tostring(state))
    end
})
CombatTab:MakeSlider({
	Name = "KillAura Distance threshold",
	Callback = function(value)
        karange = value
	end,
	Min = 10,
	Max = 50,
	Round = true
})
local Highlights = {}
local Charadded = {}
local Plradded = nil
local function addhighlight(plr)
    local hl = Instance.new("Highlight", plr.Character)
    Highlights[plr] = hl
end
LocalPlayerTab:MakeToggle({
	Name = "Show players",
	Callback = function(state)
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
local SelectionBoxes = {}
local Charadded2 = {}
local Plradded2 = nil
local function addbox(plr)
    local sb = Instance.new("SelectionBox", plr.Character)
    sb.Adornee = plr.Character
    SelectionBoxes[plr] = sb
end
LocalPlayerTab:MakeToggle({
	Name = "Player Boxes",
	Callback = function(state)
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
local infjumpcon = nil
LocalPlayerTab:MakeToggle({
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
local lcharadded = nil
local reachval = 10
-- i basically made a hitbox extender for reach before then i realied theres a 100000x better way :3
CombatTab:MakeToggle({
	Name = "Reach",
	Callback = function(state)
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
--[[CombatTab:MakeToggle({
	Name = "[Reach] Show HumanoidRootParts",
	Callback = function(state)
        showroots = state
	end
})]]
CombatTab:MakeSlider({
	Name = "Reach Range",
	Callback = function(value)
        reachval = value
	end,
	Min = 10,
	Max = 30,
	Round = true
})
SettingsTab:MakeSlider({
	Name = "Gui Drag Speed",
	Callback = function(value)
        klib.DragSpeed = value
	end,
	Min = 0,
	Max = 1,
	Round = false
})
local selected = nil
local cti = tick()
CombatTab:MakeToggle({
	Name = "KillAura AutoFarm",
	Callback = function(state)
        ff.Botfarm = state
        print("tg: ".. tostring(state))
	end
})

OtherScriptsTab:MakeButton({
    Name = "Infinite Yield",
    Callback = function()
        scr("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    end
})

OtherScriptsTab:MakeButton({
    Name = "DEX Explorer",
    Callback = function()
        scr("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua")
    end
})


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
                        mouse1press() -- // legit aura 🤓
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
                selected = entitynearpositon(100)
                if entitynearpositon(100) ~= selected then
                    selected = entitynearpositon(100)
                end
                task.wait(0.01)
            until selected ~= nil
            if selected.Character then
                if selected.Character:FindFirstChild("Humanoid") then
                    if selected.Character.Humanoid.Health > 0 then
                        plrs.LocalPlayer.Character.Humanoid:MoveTo(selected.Character.HumanoidRootPart.Position)
                        --plrs.LocalPlayer.Character.Humanoid.Jump = true
                        if game.Players.LocalPlayer.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then
                            game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                        --plrs.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
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

klib.SendNotification("Komaru Hub", "Loaded Successfully! Game: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, 5)
