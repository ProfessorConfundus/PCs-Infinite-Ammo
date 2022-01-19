script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
        if event.setting == "PCs-Infinite-Ammo-IsEnabled" and event.setting_type == "runtime-global" then
            if settings.global[event.setting].value == true then
                for _,force in pairs(game.forces) do
                    for key, _ in pairs(force.recipes) do
                        if string.sub(tostring(key),1,string.len("pc-unlimited-"))=="pc-unlimited-" then
                            force.recipes[key].enabled = true
                        end
                    end
                end
            else
                for _,force in pairs(game.forces) do
                    for key, _ in pairs(force.recipes) do
                        if string.sub(tostring(key),1,string.len("pc-unlimited-"))=="pc-unlimited-" then
                            force.recipes[key].enabled = false
                        end
                    end
                end
            end
        end
    end
)