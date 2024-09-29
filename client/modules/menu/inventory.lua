mainMenuInventory = zUI.CreateSubMenu(mainMenu, "Votre inventaire", "Vos objets", Config.Menu.Banner)

mainMenuInventory:SetItems(function(Items)
    for item, data in pairs(Menu.items) do
        print(item, json.encode(data))
        Items:AddList(data.label, "Quantité: " .. tostring(data.quantity), {"Utiliser", "Donner", "Supprimer"}, {LeftBadge = data.image}, function(onSelected, onHovered, onListChange, index)

        end)
    end
end)

