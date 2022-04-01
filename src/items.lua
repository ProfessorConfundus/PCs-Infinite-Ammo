--[[ local unlimitedFirearmMagazine = table.deepcopy(data.raw["ammo"]["firearm-magazine"])
unlimitedFirearmMagazine.name = "pc-unlimited-firearm-magazine"
unlimitedFirearmMagazine.magazine_size = math.huge
unlimitedFirearmMagazine.icons = {
    {
        icon = unlimitedFirearmMagazine.icon,
        tint = {r=0,g=1,b=0.5,a=0.3}
    }
}
local unlimitedFirearmMagazine_recipe = table.deepcopy(data.raw["recipe"]["firearm-magazine"])
unlimitedFirearmMagazine_recipe.enabled = false
unlimitedFirearmMagazine_recipe.name = "pc-unlimited-firearm-magazine"
unlimitedFirearmMagazine_recipe.ingredients = {{"firearm-magazine",1},{"stone",1}}
unlimitedFirearmMagazine_recipe.result = "pc-unlimited-firearm-magazine"

data:extend{unlimitedFirearmMagazine,unlimitedFirearmMagazine_recipe} ]]



-- todo: none


local rustyLocale = require '__rusty-locale__.locale'


local generatedPrototypes = {}
local generatedRecipes = {}
for _, prototype in pairs(data.raw["ammo"]) do
    --log("prototype name ---")
    --log(prototype.name)

---@diagnostic disable-next-line: undefined-field
    local currentWorkingPrototype = table.deepcopy(prototype)
    if string.sub(prototype.name,1,string.len("pc-unlimited-"))=="pc-unlimited-" then
        goto continue
    end
    currentWorkingPrototype.name = "pc-unlimited-" .. currentWorkingPrototype.name
    --                                                      |
    currentWorkingPrototype.magazine_size = 34.0282346638528850000000000000000000000e37 -- TODO: Find the true highest value for this, as it seems Factorio might have a bug related to data type limits (or I just don't know what I'm doing, which is likely).
--  currentWorkingPrototype.magazine_size = 4.4028234663852894248860260600420480424e37
	local infinityIcon = {
		icon = "__PCs-Infinite-Ammo__/icons/infinity icon 64.png",
		icon_size = 64
	}
	if currentWorkingPrototype.icons then
		table.insert(currentWorkingPrototype.icons, infinityIcon)
	elseif currentWorkingPrototype.icon then
		currentWorkingPrototype.icons = {
			{
				icon = currentWorkingPrototype.icon
			},
			infinityIcon,
		}
	else
		log("Icons and icon is missing for "..currentWorkingPrototype.name..". Will probably break if anything is changed")
	--[[
		currentWorkingPrototype.icons = {
			{
				icon = currentWorkingPrototype.icon --nil will cause an error (no icon)
			},
			infinityIcon,
		}
	--]]
	end

    local currentWorkingPrototypeLocale = rustyLocale.of_item(prototype)
    currentWorkingPrototype.localised_name = {"naming-scheme.name", currentWorkingPrototypeLocale.name}
    currentWorkingPrototype.localised_description = {"naming-scheme.description", currentWorkingPrototypeLocale.name}

    --log(currentWorkingPrototype.name)

    table.insert(generatedPrototypes, currentWorkingPrototype)

    --[[ log("\n")
    log("prototypes list ---")
    for pKey, pValue in pairs(generatedPrototypes) do
        log(pKey)
        log(pValue.name)
    end ]]
    --log("\n")

---@diagnostic disable-next-line: undefined-field
    --[[ local currentWorkingRecipe = table.deepcopy(data.raw["recipe"][prototype.name])
    --log(currentWorkingRecipe.name)
    currentWorkingRecipe.name = "pc-unlimited-" .. prototype.name
    currentWorkingRecipe.category = "crafting"
    currentWorkingRecipe.normal = {
        enabled = true,
        ingredients = {{prototype.name,1},{"stone",1}},
        result = "pc-unlimited-" .. prototype.name,
        hidden = false,
        hide_from_player_crafting = false
    }
    currentWorkingRecipe.expensive = nil ]]

    local currentWorkingRecipe = {
        type = "recipe",
        name = "pc-infinite-" .. prototype.name,
        normal = {
            ingredients = {{prototype.name,1},{"stone",1}},
            result = "pc-unlimited-" .. prototype.name,
        },
        expensive = nil
    }

    --log(currentWorkingRecipe.name)

    table.insert(generatedRecipes, currentWorkingRecipe)

    --[[ log("\n")
    log("recipes list ---")
    for rKey, rValue in pairs(generatedRecipes) do
        log(rKey)
        log(rValue.name)
        log("r: " .. tostring(rValue.result))
        log("c: " .. tostring(rValue.category))
    end
    log("\n") ]]

    ::continue::
end

---@diagnostic disable-next-line: undefined-field
local testItemPrototype = table.deepcopy(data.raw["ammo"]["firearm-magazine"])

testItemPrototype.name = "test-pc-unlimited-no-locale-item"
testItemPrototype.icons = {
    {
        icon = testItemPrototype.icon,
        tint = {r = 0.69, g = 0.420, b = 0.1337}
    }
}

local testItemLocale = rustyLocale.of_item(testItemPrototype)
-- testItemPrototype.localised_name = {"naming-scheme.name", testItemLocale.name}
-- testItemPrototype.localised_description = {"naming-scheme.description", testItemLocale.name}

--log("\n")
--log("data extending ---")
for index, value in ipairs(generatedPrototypes) do
    data:extend{value, generatedRecipes[index]}
    --[[ log("\n")
    log(tostring(index))
    log(value.name)
    log(generatedRecipes[index].name)
    log("\n") ]]
end
data:extend{testItemPrototype}