mainMenuInventory = zUI.CreateSubMenu(mainMenu, "Votre inventaire", "Vos objets", Config.Menu.Banner)

mainMenuInventory:SetItems(function(Items)
    for item, quantity in pairs(Menu.items) do
        Items:AddButton(item, "Quantité: " .. quantity, {RightLabel = "→→"}, function(onSelected)
        end)
    end
end)

