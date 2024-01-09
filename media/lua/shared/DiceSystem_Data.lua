DICE_SYSTEM_MOD_STRING = "GenericDiceSystem"
PLAYER_DICE_VALUES = {
    STATUS_EFFECTS = { "Stable", "Wounded", "Bleeding", "Charmed", "OnFire", "Prone", "Unconscious" },
    OCCUPATIONS = {
        "Unemployed"
        -- "Unemployed", "Artist", "WageSlave", 
        -- "Soldier", "Frontiersmen", "LawEnforcement", 
        -- "FirstResponders", "Criminal", "BlueCollar", 
        -- "Engineer", "WhiteCollar", "Clinician", 
        -- "Academic", "Follower" 
    },

    SKILLS = {"Strength", "Dexterity", "Endurance", "Intelligence", "Education", "Social"},

    SKILL_DESCRIPTORS = {
        Strength = {"Pathetic", "Feeble", "Weak", "", "Muscular", "Huge", "Herculean"},
        Dexterity = { "Sloth Like", "Slow", "Clumsy", "", "Nimble", "Agile", "Acrobatic"},
        Endurance = {"Bedridden", "Frail", "Weak", "", "Perfect Health", "Indefatigable", "Ironclad"},
        Intelligence = {"Donkey Brained", "Imbecilic", "Slow", "", "Perceptive", "Brilliant", "How bout dem Apples" },
        Education = {"Illiterate", "Dropout", "Barely Passed", "", "Associate's Degree", "Bachelor's Degree", "Graduate Scholar"},
        Social = {"Wet Sack of Gravel", "Unbearable", "Awkward", "", "Charming", "Magnetic", "Je Ne Sais Quoi" }
    },

    -- Strength (Str): A character’s physical strength, fitness and forcefulness. 
    -- Dexterity (Dex): Physical co-ordination and agility, reflexes. 
    -- Endurance (End): A character’s ability to sustain damage, stamina and determination. 
    -- Intelligence (Int): A character’s intellect and quickness of mind. 
    -- Education (Edu): A measure of a character’s learning and experience. 
    -- Social Standing (Soc): A character’s place in society.

    DEFAULT_HEALTH = 2,
    DEFAULT_MOVEMENT = 6,

    MAX_ALLOCATED_POINTS = 18,
    MAX_PER_SKILL_ALLOCATED_POINTS = 18,
    MIN_PER_SKILL_ALLOCATED_POINTS = 8,


    OCCUPATIONS_BONUS = {
        Unemployed      = { },
        -- Artist          = { Chance = 2, Awareness = 1 },
        -- WageSlave       = { Chance = 2, Resolve = 1 },
        -- Soldier         = { Brutality = 2, Resolve = 1 },
        -- Frontiersmen    = { Brutality = 2, Endurance = 1 },
        -- LawEnforcement  = { Awareness = 2, Resolve = 1 },
        -- FirstResponders = { Awareness = 2, Endurance = 1 },
        -- Criminal        = { Chance = 2, Brutality = 1 },
        -- BlueCollar      = { Endurance = 2, Brutality = 1 },
        -- Engineer        = { Endurance = 2, Resolve = 1 },
        -- WhiteCollar     = { Endurance = 2, Chance = 1 },
        -- Clinician       = { Endurance = 2, Awareness = 1 },
        -- Academic        = { Awareness = 2, Chance = 1 },
        -- Follower        = { Chance = 2, Endurance = 1},
        -- Dryad           = { Resolve = 2, Endurance = 2}
    },
}


COLORS_DICE_TABLES = {
    -- Normal colors for status effects
    STATUS_EFFECTS     = {
        Stable = { r = 0, g = 0.68, b = 0.94 },
        Wounded = { r = 0.95, g = 0.35, b = 0.16 },
        Bleeding = { r = 0.66, g = 0.15, b = 0.18 },
        Charmed = { r = 1, g = 1, b = 1 },
        OnFire = { r = 1, g = 0.2, b = 0 },
        Prone = { r = 0.04, g = 0.58, b = 0.27 },
        Unconscious = { r = 0.57, g = 0.15, b = 0.56 }
    },

    -- Used for color blind users
    STATUS_EFFECTS_ALT = {
        Stable = { r = 0.17, g = 0.94, b = 0.45 },     -- #2CF074
        Wounded = { r = 0.46, g = 0.58, b = 0.23 },    -- #75943A
        Bleeding = { r = 0.56, g = 0.15, b = 0.25 },   -- #8F263F
        Charmed = { r = 1, g = 1, b = 1 },            -- only white
        OnFire = { r = 1, g = 1, b = 1 },              -- only white
        Prone = { r = 0.35, g = 0.49, b = 0.64 },      -- #5A7EA3
        Unconscious = { r = 0.96, g = 0.69, b = 0.81 } -- #F5B0CF
    }
}


--**************************************--

DiceSystem_Common = {}

-- ---Returns the occupation bonus for a certain skill
-- ---@param occupation string
-- ---@param skill string
-- ---@return integer
-- function DiceSystem_Common.GetOccupationBonus(occupation, skill)
--     if PLAYER_DICE_VALUES.OCCUPATIONS_BONUS[occupation][skill] ~= nil then
--         return PLAYER_DICE_VALUES.OCCUPATIONS_BONUS[occupation][skill]
--     end
--     return 0
-- end

---Assign the correct color table for status effects
---@param colorsTable table
function DiceSystem_Common.SetStatusEffectsColorsTable(colorsTable)
    DiceSystem_Common.statusEffectsColors = colorsTable
end

---@param attribute_total number
---@return number
function DiceSystem_Common.GetAttributeBonus(attribute_total)
    local bonus = 0

    if attribute_total <= 3 then
        bonus = -3
    elseif attribute_total >= 4 and attribute_total <= 5 then
        bonus = -2
    elseif attribute_total >= 6 and attribute_total <= 8 then
        bonus = -1
    elseif attribute_total >= 9 and attribute_total <= 12 then
        bonus = 0
    elseif attribute_total >= 13 and attribute_total <= 15 then
        bonus = 1
    elseif attribute_total >= 16 and attribute_total <= 17 then
        bonus = 2
    elseif attribute_total >= 18 then
        bonus = 3
    end

    return bonus
end

---@param attribute string
---@param bonus number
function DiceSystem_Common.GetAttributeDescriptor(attribute, bonus)
    local descriptor = ""

    return descriptor
end

--- Do a roll for a specific skill and print the result into chat. If something goes
---@param skill string
---@param points number
---@return number
function DiceSystem_Common.Roll(skill, points)
    local rolledValue1 = ZombRand(6) + 1
    local rolledValue2 = ZombRand(6) + 1
    local rolledValue = rolledValue1 + rolledValue2
    local additionalMsg = ""

    local finalValue = rolledValue + points

    if finalValue < 7 then
        -- Failure
        additionalMsg = "<SPACE> <RGB:1,0,0>  "
    elseif finalValue >= 7 and finalValue < 10 then
        -- partial success
        additionalMsg = "  "
    elseif finalValue >= 10 then
        -- partial success
        additionalMsg = "<SPACE> <RGB:0,1,0>  "
    end

    local operand = " + "
    if points < 0 then
        operand = " - "
    end
    local point_str = tostring(math.abs(points))

    local message = "(||DICE_SYSTEM_MESSAGE||)rolled " ..
        skill .. ": " .. additionalMsg .. " (" .. tostring(rolledValue1) .. "+" .. tostring(rolledValue2) .. ")" .. operand .. point_str .. " = " .. tostring(finalValue)

    -- send to chat
    if isClient() then
        DiceSystem_ChatOverride.NotifyRoll(message)
    end

    return finalValue
end

---Get the forename without the tabulations added by Buffy's bios
---@param plDescriptor SurvivorDesc
function DiceSystem_Common.GetForenameWithoutTabs(plDescriptor)
    local forenameWithTabs = plDescriptor:getForename()
    local forename = string.gsub(forenameWithTabs, "^%s*(%a+)", "%1")
    if forename == nil then forename = "" end
    return forename
end

if isDebugEnabled() then
    ---Writes a log in the console ONLY if debug is enabled
    ---@param text string
    function DiceSystem_Common.DebugWriteLog(text)
        --writeLog("DiceSystem", text)
        print("[DiceSystem] " .. text)
    end
else
    ---Placeholder, to prevent non essential calls
    function DiceSystem_Common.DebugWriteLog()
        return
    end
end
