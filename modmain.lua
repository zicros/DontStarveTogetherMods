PrefabFiles = {
    "alpha"
}

--------------------------------------- Namespace --------------------------------------------------
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
----------------------------------------------------------------------------------------------------

require("mods")
require("stategraph")

--------------------------------------- Strings ----------------------------------------------------
STRINGS.NAMES.ALPHA = "Alpha Name"
STRINGS.RECIPE_DESC.ALPHA = "Alpha recipe description."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ALPHA = "Alpha description"
----------------------------------------------------------------------------------------------------

------------------------------------ User configurations -------------------------------------------
local set_infinite_lighter = GetModConfigData("set_infinite_lighter")
----------------------------------------------------------------------------------------------------

------------------------------------ Recipe --------------------------------------------------------
local alphaRecipeIngredients = {}
alphaRecipeIngredients[#alphaRecipeIngredients + 1] = Ingredient("twigs", 1)
alphaRecipeIngredients[#alphaRecipeIngredients + 1] = Ingredient("rope", 1)

local alpha = GLOBAL.Recipe("alpha", { Ingredient("goldnugget", 1), Ingredient("rope", 1) }, RECIPETABS.WAR, {SCIENCE=2})
----------------------------------------------------------------------------------------------------


local function GetPlayer()
    return GLOBAL.ThePlayer
end

local function ModLighter(lighter)
    local fireRadius = 3
    if lighter.fire.Light:GetRadius() ~= fireRadius then
        lighter.fire.Light:SetRadius(fireRadius)
    end

    if lighter.components.fueled:IsEmpty() then
        lighter.components.fueled:StartConsuming()
    elseif lighter.components.fueled.consuming then
        lighter.components.fueled:StopConsuming()
    end
end

local function LighterPostInit(self, inst)
    local function PercentChanged(inst, data)
        --print("Percent changed:", inst.name, data.percent)
        if inst.components.tool or inst.prefab == "torch" then return end
        if inst.components.weapon
           and inst.components.fueled
           and inst.components.inventoryitem
           and inst.components.inventoryitem.owner
           and inst.components.inventoryitem.owner.components.playercontroller
        then
            local player = inst.components.inventoryitem.owner
            local playercontroller = player.components.playercontroller

            if inst.components.weapon.inst:HasTag("lighter") then
                local lighter = inst.components.weapon.inst
                -- Set the durability if possible
                if lighter ~= nil then
                    -- print("Found ", lighter.name, lighter.fire.Light:GetRadius(), lighter.components.fueled:GetDebugString())
                    ModLighter(lighter)
                end
            end
        end
    end

    self.inst:ListenForEvent("percentusedchange", PercentChanged)
    --print("End Setting up")
end

if set_infinite_lighter then
    AddComponentPostInit("weapon", LighterPostInit)
    --AddPlayerPostInit(LighterPostInit)
end


