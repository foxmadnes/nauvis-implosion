local function display_message_to_all_players(message, type)
   for _,player in pairs(game.connected_players) do
      local label = player.gui.top[type]
      if label==nil then
         player.gui.top.add{type="label", name=type, caption=message}
      else
         label.caption = message   
      end           
   end
end
-- /c game.planets['gehenna'].create_surface()
-- /c game.player.teleport({0,0},'gehenna')  

local function display_time(remainingTicks)
   local seconds = math.floor(remainingTicks/60)
   local s = seconds%60

   local minutes = math.floor(seconds/60)
   local m = minutes%60

   local h = math.floor(minutes/60)  
   
   local dhms = string.format("Estimated time until implosion: %d:%02d:%02d", h, m, s)

   display_message_to_all_players(dhms, "time")
end

local function count_and_update_active_nauvis_timers()
   local nauvis_surface = game.surfaces["nauvis"]
   local all_drills = nauvis_surface.find_entities_filtered{name = {"burner-mining-drill","electric-mining-drill","big-mining-drill"}}
   local total_count = 0
   for _,drill in pairs(all_drills) do
      if drill.status == defines.entity_status.working then
         total_count = total_count + 1
      end
   end
   storage.mining_coefficient = 0.001 * total_count
   local miner_message = string.format("%d active miners causing Nauvis to implode %.1f%% faster.", total_count, storage.mining_coefficient*100)
   display_message_to_all_players(miner_message, "miner")
end

local function explode_nauvis() 
   game.play_sound({path="nauvis-explosion-sound"})
   -- explode
   storage.nauvis_exploded = true
   display_message_to_all_players("Nauvis has exploded", "time")
   display_message_to_all_players("", "miner")
   local nauvis_surface = game.surfaces["nauvis"]
   for chunk in nauvis_surface.get_chunks() do
      nauvis_surface.delete_chunk({chunk.x, chunk.y})
      nauvis_surface.generate_with_lab_tiles = true
   end
end

local function nauvis_countdown(e)
   -- Only count down each second
   if not storage.nauvis_exploded and e.tick % 60 == 0 then
      if (e.tick % 3600 == 0) then
         count_and_update_active_nauvis_timers()
      end

      storage.remaining_ticks = storage.remaining_ticks - 60 * (1 + storage.mining_coefficient)

      if (storage.remaining_ticks <= 0) then
         explode_nauvis()
         return
      end

      display_time(storage.remaining_ticks / (1 + storage.mining_coefficient))
   end
end

script.on_init(
   function ()
      storage.nauvis_exploded = storage.nauvis_exploded or false
      storage.remaining_ticks = 2592000
      storage.mining_coefficient = 0
      if not storage.nauvis_exploded then
         storage.nauvis_exploded = false
      end
      script.on_event({defines.events.on_tick}, nauvis_countdown)
   end
)

script.on_load(
   function ()
      -- Only use the script on reload if nauvis hasn't exploded, to save performance
      if not storage.nauvis_exploded then
         script.on_event({defines.events.on_tick}, nauvis_countdown)
      end
   end
)