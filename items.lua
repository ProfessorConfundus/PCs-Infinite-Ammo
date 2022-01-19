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



-- todo: fix errors on starting up

local generatedPrototypes = {}
local generatedRecipes = {}
for key, prototype in pairs(data.raw["ammo"]) do
---@diagnostic disable-next-line: undefined-field
    local currentWorkingPrototype = table.deepcopy(prototype)
    if string.sub(prototype.name,1,string.len("pc-unlimited-"))=="pc-unlimited-" then
        goto continue
    end
    currentWorkingPrototype.name = "pc-unlimited-" .. currentWorkingPrototype.name
    currentWorkingPrototype.magazine_size = math.huge
    currentWorkingPrototype.icons = {
        {
            icon = currentWorkingPrototype.icon
        },
        {
            icon = "__PCs-Infinite-Ammo__/icons/infinity icon 64.png",
            icon_size = 64
        }
    }
---@diagnostic disable-next-line: undefined-field
    local currentWorkingRecipe = table.deepcopy(data.raw["recipe"][prototype.name])
    currentWorkingRecipe.enabled = true
    currentWorkingRecipe.name = "pc-unlimited-" .. prototype.name
    currentWorkingRecipe.ingredients = {{prototype.name,1},{"stone",1}}
    currentWorkingRecipe.result = "pc-unlimited-" .. prototype.name

    table.insert(generatedPrototypes, currentWorkingPrototype)
    table.insert(generatedRecipes, currentWorkingRecipe)

    ::continue::
end

for index, value in ipairs(generatedPrototypes) do
    data:extend{value, generatedRecipes[index]}
end