local function display_string_to_all_players(string)
   for index,player in pairs(game.connected_players) do  --loop through all online players on the server
      local label = player.gui.top["time"]
      if label==nil then
         player.gui.top.add{type="label", name="time", caption=string}
      else
         label.caption = string   
      end           
   end
end

local function display_time(remainingTicks)
   local seconds = math.floor(remainingTicks/60)
   local s = seconds%60

   local minutes = math.floor(seconds/60)
   local m = minutes%60

   local hours = math.floor(minutes/60)
   local h = hours%24

   local d = math.floor(hours/24)
   
   local dhms = string.format("Estimated time until implosion: %02d:%02d:%02d:%02d", d, h, m, s)

   display_string_to_all_players(dhms)
end

script.on_init(
   function ()
      storage.nauvis_exploded = storage.nauvis_exploded or false
      if not storage.nauvis_exploded then
         storage.nauvis_exploded = false
      end
   end
)

script.on_event({defines.events.on_tick},
   function (e)
      if not storage.nauvis_exploded and e.tick % 60 == 0 then
         local total_time_ticks =  300 --8640000
         local remaining_ticks = total_time_ticks - e.tick

         if (remaining_ticks <= 0) then
            -- game.play_sound("NauvisExplosion")
            -- explode
            storage.nauvis_exploded = true
            display_string_to_all_players("Nauvis has exploded")
            local nauvis_surface = game.surfaces["nauvis"]
            for chunk in nauvis_surface.get_chunks() do
               nauvis_surface.delete_chunk({chunk.x, chunk.y})
               nauvis_surface.generate_with_lab_tiles = true
            end
            return
         end

         display_time(remaining_ticks)
      end
   end
)
