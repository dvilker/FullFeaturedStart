local function giveGoods(event)
    local player = --[[---@type LuaPlayer]]game.players[event.player_index]
    local inventory = player.get_inventory(defines.inventory.character_main)
    local exists = inventory and inventory.get_contents() or {}
    local doFilter = settings.global["FullFeaturedStart-filter"].value

    local needRobots = settings.global["FullFeaturedStart-robots"].value - (exists['construction-robot'] or 0)
    if needRobots > 0 then
        player.insert({ name = 'construction-robot', count = needRobots })
    end

    local needFuel = settings.global["FullFeaturedStart-fuel"].value - (exists['rocket-fuel'] or 0)
    if needRobots > 0 then
        player.insert({ name = 'rocket-fuel', count = needFuel })
    end

    if doFilter then
        local withMk = {}
        for name, _ in pairs(game.equipment_prototypes) do
            local item = game.item_prototypes[name]
            if item then
                local mk = string.match(name, "-?m?k?(%d+)")
                mk = mk and tonumber(mk) or 1
                local uniName = string.gsub(name, "-?m?k?%d+", "")
                withMk[uniName] = withMk[uniName] or {}
                local wmk = withMk[uniName]
                if not wmk.mk or wmk.mk < mk then
                    wmk.item = item
                    wmk.name = name
                    wmk.mk = mk
                end
            end
        end
        for _, wmk in pairs(withMk) do
            local need = wmk.item.stack_size - (exists[wmk.name] or 0)
            if need > 0 then
                player.insert({ name = wmk.name, count = wmk.item.stack_size })
            end
        end
    else
        for name, _ in pairs(game.equipment_prototypes) do
            local item = game.item_prototypes[name]
            if item then
                player.insert({ name = name, count = item.stack_size })
            end
        end
    end

    player.insert({ name = 'FullFeaturedStart-tshort-armor', count = 1 })
end

script.on_event(defines.events.on_player_created, giveGoods)
script.on_event(defines.events.on_cutscene_cancelled, giveGoods)
script.on_event(defines.events.on_player_respawned, giveGoods)

local function handleSe()
    if remote.interfaces["space-exploration"] and
            remote.interfaces["space-exploration"]["get_on_player_respawned_event"] then
        script.on_event(
                remote.call("space-exploration", "get_on_player_respawned_event"),
                giveGoods
        )
    end
end

script.on_init(handleSe)
script.on_configuration_changed(handleSe)
script.on_load(handleSe)
