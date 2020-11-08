local ChandelierExit = {}

setmetatable(ChandelierExit, {
    __call = function(self, period, multiplier)
        local AverageTrueRange = require "AverageTrueRange"
        local Minimum = require "Minimum"
        local Maximum = require "Maximum"

        local ce = {}
        setmetatable(ce, {
            __tostring = function()
                return "ce"
            end
        })
        ce.period = period or 22
        ce.min = Minimum(period)
        ce.max = Maximum(period)
        ce.multiplier = multiplier or 3.0
        ce.atr = AverageTrueRange(period)

        ce._series = {}
        ce.longs = {}
        ce.shorts = {}

        ce.last = self.last
        ce.series = self.series
        ce.add = self.add
        ce.reset = self.reset
        return ce
    end
})

local calculate = function(self, input)
    assert(tostring(input) == "C", string.format("Input should be 'Candlestick'. Passed %s", tostring(input)))
    local atr = self.atr
    local min = self.min
    local max = self.max

    atr:add(input)
    min:add(input)
    max:add(input)
    if atr:last() then
        local multiplied_atr = atr:last() * self.multiplier
        local longs = self.longs
        longs[#longs + 1] = max:last() - multiplied_atr
        local shorts = self.shorts
        shorts[#shorts + 1] = min:last() + multiplied_atr

        self._series[#self._series + 1] = multiplied_atr
    end
end

function ChandelierExit:add(...)
    local input = {...}
    for i = 1, #input do
        local item = input[i]
        if type(item) == "table" then
            if tostring(item) == "C" then
                calculate(self, item)
            else
                for j = 1, #input[i] do
                    self:add(input[i][j])
                end
            end
        end
    end
    return self
end

function ChandelierExit:reset()
    self._series = {}
    self.longs = {}
    self.shorts = {}
    self.atr:reset()
    self.min:reset()
    self.max:reset()
end

function ChandelierExit:series()
    return self._series, self.longs, self.shorts
end

function ChandelierExit:last()
    return self._series[#self._series], self.longs[#self.longs], self.shorts[#self.shorts]
end

return ChandelierExit
