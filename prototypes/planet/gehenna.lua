local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")

---Creates a new prototype by cloning 'old' and overwriting it with properties from 'new'. Provide 'nil' as a string in order to delete items inside 'old'
---@param old data.AnyPrototype
---@param new table
---@return data.AnyPrototype
merge = function(old, new)
    if not old then
        error("Failed to merge: Old prototype is nil", 2)
    end

    old = table.deepcopy(old)
    for k, v in pairs(new) do
        if v == "nil" then
            old[k] = nil
        else
            old[k] = v
        end
    end
    return old
end


data:extend {merge(data.raw.planet.nauvis, {
    name = "gehenna",
    order = "g[gehenna]",
    distance = 30,
    orientation = 0.1,
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.gleba_aquilo, 0.9),
    icon = "__nauvis-implosion__/graphics/icons/gehenna.png",
    starmap_icon = "__nauvis-implosion__/graphics/icons/starmap-planet-gehenna.png",
})}

data:extend{{
    type = "space-connection",
    name = "gleba-gehenna",
    subgroup = "planet-connections",
    from = "gleba",
    to = "gehenna",
    order = "f",
    length = 30000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.gleba_aquilo),
    icon = "__nauvis-implosion__/graphics/icons/gehenna.png",
}}