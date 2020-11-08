local Atr = {}

setmetatable(Atr, {
    __call = function(self, period)
        period = period or 14
        assert(period > 0, "Period must be greater than zero")

        local TrueRange = require "TrueRange"
        local Ema = require "ExponentialMovingAverage"

        local atr = {}
        setmetatable(atr, {
            __tostring = function()
                return "atr"
            end
        })
        atr.true_range = TrueRange()
        atr.ema = Ema(period)

        atr.add = self.add
        atr.last = self.last
        atr._series = {}
        atr.series = self.series
        atr.reset = self.reset
        return atr
    end
})

local calculate = function(self, input)
    local truerange = self.true_range:add(input):last()
    self.ema:add(truerange)
    if #self.ema.prices == self.ema.period then
        self._series[#self._series + 1] = self.ema:last()
    end
    assert(#self.ema.prices <= self.ema.period)
end

function Atr:add(...)
    assert(tostring(self) == "atr", string.format([[Expected 'self' with type = 'atr', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon atr:add(...), instead atr.add(...)]], type(self), tostring(self)))

    local input = {...}
    for i = 1, #input do
        local item = input[i]
        if tostring(item) == "C" then
            calculate(self, item)
        else
            for j = 1, #input[i] do
                self:add(input[i][j])
            end
        end
    end
    return self
end

function Atr:last()
    assert(type(self) == "table" and tostring(self) == "atr",
        string.format([[Expected 'self' with type = 'atr', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon atr:last(), instead atr.last()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function Atr:reset()
    assert(type(self) == "table" and tostring(self) == "atr",
        string.format([[Expected 'self' with type = 'atr', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon atr:reset(), instead atr.reset()]], type(self), tostring(self)))
    self._series = {}
    self.ema:reset()
    self.true_range:reset()
end

function Atr:series()
    assert(type(self) == "table" and tostring(self) == "atr",
        string.format([[Expected 'self' with type = 'atr', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon atr:series(), instead atr.series()]], type(self), tostring(self)))
    return self._series
end

return Atr
