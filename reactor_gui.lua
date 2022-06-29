os.loadAPI("txUI")
require("reactor")

local w, h = term.getSize()
local window = txUI.Window:new({ w = w, h = h; })

-- FIXME: I think this reactor should be changed, does it conflict with the "require(reactor)"?
local reactor = peripheral.find("fissionReactorLogicAdapter")
local active = reactor.getStatus()

function get_activate_button_text()
	local text = ""
	if active then
		text = "SCRAM!"
	else
		text = "Activate"
	end
	
	return text
end

function setup_temp()
    window:addComponent(txUI.Label:new(
            { x = 1;
              y = 2;
              w = w;
              text = "Temp:";
              bgColor = colors.lightGray;
              textAlign = "left"
            })
    )

    local temp_progress = txUI.ProgressBar:new(
            { x = 7,
              y = 2,
              w = 5
            }
    )
    local temp_value = txUI.Label:new(
            {
                x = 13,
                y = 2,
                text = "?",
                textAlign = "left",
                bgColor = colors.lightGray
            }
    )

    window:addComponent(temp_progress)
    window:addComponent(temp_value)

    return { progress = temp_progress, value_label = temp_value }
end

function update_temp(reactor_dat)
    temp_perc_100 = math.floor((reactor_dat.temp / reactor_dat.max_temp * 100) + 0.5)
    temp_perc_100 = math.min(temp_perc_100, 100)

    temp_tbl.progress.val = temp_perc_100

    temp_celcius = reactor_dat.temp - 273.15
    temp_tbl.value_label.text = string.format("%dc", temp_celcius)
	
	if temp_perc_100 > 75 then
		reactor.scram()
	end
end

function app_update(self, eventTbl)
    reactor_dat = poll_reactor(reactor)
    update_temp(reactor_dat)

    --    dbg.text=string.format("%d/%d", reactor_dat.temp, reactor_dat.max_temp)
    dbg.text = eventTbl[1]
end

function tick()
    while true do
        os.sleep(5)
        os.queueEvent("ui_update")
    end
end

function start_update()
    txUI.Controller:startUpdateCycle()
end

txUI.Controller.prototype.appUpdate = app_update

txUI.Controller:addWindow(window)
txUI.Controller.prototype.useNative = false

window:setTitleLabel(txUI.Label:new({ text = "Demo"; textColor = colors.white; textAlign = "right" }))
window:addComponent(txUI.Button:new({ x = 1; y = 1; w = 1; h = 1; action = (function(self)
    self.parent:close()
end); textColor = colors.red; bgColor = window.tlColor; text = "X" }))

dbg = txUI.Label:new({ x = 1; y = 10; w = w; text = "Debug", textAlign = "left" })
window:addComponent(dbg)

temp_tbl = setup_temp()
local activate_button = txUI.Button:new({
	x=w-12,
	y=2,
	w=10,
	text = get_activate_button_text(),
	action = function(self)
		if active then
			reactor.scram()
		else 
			reactor.activate()
		end
		
		active = not active
	end
		
})
window:addComponent(activate_button)

parallel.waitForAll(tick, start_update)