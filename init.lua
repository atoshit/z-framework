--- Z-Framework
--- @class Z
--- @field IO table Z-Framework IO
--- @field Enums table Z-Framework Enums
--- @field Event table Z-Framework Event
--- @field Callback table Z-Framework Callback
--- @field Function table Z-Framework Function
--- @field Players table Z-Framework Players
Z = {}

--- Z-Framework IO
--- @class Z.IO
--- @field Trace fun(message:string):void Trace message
--- @field Warn fun(message:string):void Warn message
--- @field Error fun(message:string):void Error message
--- @field Info fun(message:string):void Info message
--- @field Success fun(message:string):void Success message
Z.IO = Z.IO or {}

--- Z-Framework Enums
--- @class Z.Enums
--- @field Color table Z-Framework Color
Z.Enums = Z.Enums or {}

--- Z-Framework Event
--- @class Z.Event
--- @field Register fun(eventName:string, callback:function):void Register event
--- @field Trigger fun(eventName:string, ...):void Trigger event
--- @field TriggerServer fun(eventName:string, ...):void Trigger server event
--- @field TriggerClient fun(eventName:string, ...):void Trigger client event
Z.Event = Z.Event or {}

--- Z-Framework Function
--- @class Z.Function
--- @field requestModel fun(model:string):boolean Request model
--- @field setPlayerModel fun(player:number, model:string):boolean Set Player Model
--- @field setEntityCoords fun(entity:number, x:number, y:number, z:number, deadFlag:boolean, ragdollFlag:boolean, clearArea:boolean):boolean Set Entity Coordinates
--- @field setEntityHeading fun(entity:number, heading:number):boolean Set Entity Heading
--- @field loadingShow fun():void Show loading screen
--- @field loadingHide fun():void Hide loading screen
Z.Function = Z.Function or {}

Ctz = Citizen