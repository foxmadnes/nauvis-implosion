local autoplace_utils = require("autoplace_utils")

data:extend{{
    name = "enemy-decal-autoplace",
    type = "optimized-decorative",
    order = "b[decorative]-b[enemy-decal]",
    collision_box = {{-6, -4}, {6, 4}},
    collision_mask = {layers={water_tile=true}, colliding_with_tiles_only=true},
    render_layer = "decals",
    tile_layer = 254,
    decal_overdraw_priority = 500,
    autoplace =
    {
      order = "a[doodad]-g[enemy-decal]-a",
      probability_expression = "-1.5 + rpi(0.2) + asterisk_noise - min(0, decorative_knockout) + region_box",
      local_expressions =
      {
        region_box = "min(range_select{input = moisture, from = 0, to = 0.3, slope = 0.05, min = -10, max = 1},\z
                          range_select{input = aux, from = 0, to = 0.6, slope = 0.05, min = -10, max = 1},\z
                          range_select{input = temperature, from = 10, to = 15, slope = 0.5, min = -10, max = 1})"
      }
    },
    pictures =
    {
        {
        filename = "__base__/graphics/decorative/enemy-decal/enemy-decal-00.png",
        width = 1016,
        height = 726,
        shift = util.by_pixel(0, 0),
        scale = 0.5
        },
        {
        filename = "__base__/graphics/decorative/enemy-decal/enemy-decal-01.png",
        width = 998,
        height = 722,
        shift = util.by_pixel(-4, 1),
        scale = 0.5
        },
        {
        filename = "__base__/graphics/decorative/enemy-decal/enemy-decal-02.png",
        width = 1014,
        height = 718,
        shift = util.by_pixel(0, 0),
        scale = 0.5
        },
        {
        filename = "__base__/graphics/decorative/enemy-decal/enemy-decal-03.png",
        width = 1010,
        height = 718,
        shift = util.by_pixel(1, 0),
        scale = 0.5
        },
        {
        filename = "__base__/graphics/decorative/enemy-decal/enemy-decal-04.png",
        width = 862,
        height = 722,
        shift = util.by_pixel(4, 0),
        scale = 0.5
        },
        {
        filename = "__base__/graphics/decorative/enemy-decal/enemy-decal-05.png",
        width = 920,
        height = 578,
        shift = util.by_pixel(14, -1),
        scale = 0.5
        },
        {
        filename = "__base__/graphics/decorative/enemy-decal/enemy-decal-06.png",
        width = 968,
        height = 708,
        shift = util.by_pixel(3, -2),
        scale = 0.5
        },
        {
        filename = "__base__/graphics/decorative/enemy-decal/enemy-decal-07.png",
        width = 1016,
        height = 722,
        shift = util.by_pixel(0, -1),
        scale = 0.5
        }
    },
}}