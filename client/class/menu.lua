function CreateMenuObject()
    local self = {}

    self.menuOpen = false
    self.items = {}

    return self
end

--- @class Menu
Menu = CreateMenuObject()

function Menu:RefreshInventory()
    Z.TriggerServerCallback('z-framework:inventory:getPlayerItems', function(items)
        self.items = items
    end)
end