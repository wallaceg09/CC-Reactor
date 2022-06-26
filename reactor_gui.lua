os.loadAPI("txUI")
require("reactor")

local w, h = term.getSize()
local window = txUI.Window:new({w=w, h=h;})

local reactor = peripheral.find("fissionReactorLogicAdapter")

txUI.Controller:addWindow(window)
txUI.Controller.prototype.useNative = false

window:setTitleLabel(txUI.Label:new({text="Demo"; textColor=colors.white; textAlign="right"}))
window:addComponent(txUI.Button:new({x=1; y=1; w=1; h=1; action=(function(self) self.parent:close() end); textColor=colors.red; bgColor=window.tlColor; text="X"}))

window:addComponent(txUI.Label:new({x=1; y=2; w=w; text="Temp:"; bgColor=colors.lightGray, textAlign="left"}))

local temp_progress = txUI.ProgressBar:new({x=7, y=2, w=5})
local temp_value = txUI.Label:new({x=13, y=2, text="?", textAlign="left", bgColor=colors.lightGray})

window:addComponent(temp_progress)
window:addComponent(temp_value)

local dbg = txUI.Label:new({x=1; y=10; w=w; text="Debug", textAlign="left"})
window:addComponent(dbg)

function app_update(self, eventTbl)
    temp_progress.val = 100
    reactor_dat = poll_reactor(reactor)
    temp_perc_100 = math.floor((reactor_dat.temp / reactor_dat.max_temp * 100) + 0.5)
    temp_perc_100 = math.min(temp_perc_100, 100)

    temp_progress.val = temp_perc_100

    temp_celcius = reactor_dat.temp - 273.15
    temp_value.text=string.format("%dc", temp_celcius)

    --    dbg.text=string.format("%d/%d", reactor_dat.temp, reactor_dat.max_temp)
    dbg.text=eventTbl[1]
end

txUI.Controller.prototype.appUpdate = app_update

function tick()
    while true do
        os.sleep(5)
        os.queueEvent("ui_update")
    end
end
function start_update()
    txUI.Controller:startUpdateCycle()
end

parallel.waitForAll(tick, start_update)