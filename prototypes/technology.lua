data:extend(
{
  {
    type = "technology",
    name = "planet-discovery-gehenna",
    icons = util.technology_icon_constant_planet("__nauvis-implosion__/graphics/technology/gehenna.png"),
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-space-location",
        space_location = "gehenna",
        use_icon_overlay_constant = true
      },
    },
    prerequisites = {"planet-discovery-gleba", "agricultural-science-pack"},
    unit =
    {
      count = 1500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"agricultural-science-pack", 1}
      },
      time = 60
    }
  },
})