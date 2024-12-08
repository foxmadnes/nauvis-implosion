nauvis_implosion_map_gen = {}


data:extend {
  ---- ELEVATION
  {
    type = "noise-expression",
    name = "gehenna_elevation",
    --intended_property = "elevation",
    expression = "elevation_gehenna_function(0)"
  },
  {
    type = "noise-function",
    name = "elevation_gehenna_function",
    expression = "min(10, starting_lake)",
    parameters = {"added_cliff_elevation"},
    local_expressions =
    {
      elevation_magnitude = 1,
      starting_lake = "elevation_magnitude * (-3 + (starting_lake_distance + starting_lake_noise) / 8) / 8",
      starting_lake_distance = "distance_from_nearest_point{x = x, y = y, points = starting_lake_positions, maximum_distance = 1024}",
      starting_lake_noise = "quick_multioctave_noise_persistence{x = x,\z
                                                                y = y,\z
                                                                seed0 = map_seed,\z
                                                                seed1 = 14,\z
                                                                input_scale = 1/8,\z
                                                                output_scale = 0.8,\z
                                                                octaves = 4,\z
                                                                octave_input_scale_multiplier = 0.5,\z
                                                                persistence = 0.68}"
    }
  },
}

nauvis_implosion_map_gen.gehenna = function()
  return
  {
    aux_climate_control = true,
    moisture_climate_control = true,
    property_expression_names =
    {
      elevation = "gehenna_elevation",
    },
    starting_area = "none",
    autoplace_controls =
    {
      ["iron-ore"] = {},
      ["copper-ore"] = {},
      ["stone"] = {},
      ["coal"] = {},
      ["uranium-ore"] = {},
      ["crude-oil"] = {},
      ["enemy-base"] = { frequency = 6, size = 6},
      ["rocks"] = {},
    },
    autoplace_settings =
    {
      ["tile"] =
      {
        settings =
        {
          ["dry-dirt"] = {},
          ["dirt-1"] = {},
          ["dirt-2"] = {},
          ["dirt-3"] = {},
          ["dirt-4"] = {},
          ["dirt-5"] = {},
          ["dirt-6"] = {},
          ["dirt-7"] = {},
          ["sand-1"] = {},
          ["sand-2"] = {},
          ["sand-3"] = {},
          ["red-desert-0"] = {},
          ["red-desert-1"] = {},
          ["red-desert-2"] = {},
          ["red-desert-3"] = {},
          ["water"] = { frequency = 0.01, size = 0.01, richness = 0.01},
        }
      },
      ["decorative"] =
      {
        settings =
        {
          ["enemy-decal-autoplace"] = {},
        }
      },
      ["entity"] =
      {
        settings =
        {
          ["iron-ore"] = {},
          ["copper-ore"] = {},
          ["stone"] = {},
          ["coal"] = {},
          ["crude-oil"] = {},
          ["uranium-ore"] = {},
          ["fish"] = {},
          ["big-sand-rock"] = {},
          ["huge-rock"] = {},
          ["big-rock"] = {},
        }
      }
    }
  }
end

return nauvis_implosion_map_gen.gehenna()