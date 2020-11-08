local FastStochastic = {}

setmetatable(FastStochastic, {
    __call = function(self, period)
        local Minimum = require "Minimum"
        local Maximum = require "Maximum"
        local fast_stochastic = {}
        setmetatable(fast_stochastic, {
            __tostring = function()
                return "faststochastic"
            end
        })
        fast_stochastic.period = period or 14
        fast_stochastic.minimum = Minimum(fast_stochastic.period)
        fast_stochastic.maximum = Maximum(fast_stochastic.period)

        fast_stochastic.lows = {}
        fast_stochastic.highs = {}

        fast_stochastic._series = {}

        fast_stochastic.series = self.series
        fast_stochastic.last = self.last
        fast_stochastic.add = self.add
        fast_stochastic.reset = self.reset
        return fast_stochastic
    end
})

local calculate = function(self, candle)
    local maximum = self.maximum
    local minimum = self.minimum

    local lows = self.lows
    local highs = self.highs

    lows[#lows + 1] = candle.low
    highs[#highs + 1] = candle.high

    if #lows > self.period then
        table.remove(lows, 1)
        table.remove(highs, 1)
    end

    if #lows == self.period then
        maximum:add(highs)
        minimum:add(lows)
        local max = maximum:last()
        local min = minimum:last()
        self._series[#self._series + 1] = (candle.close - min) / (max - min) * 100.0
        maximum:reset()
        minimum:reset()
    end
end

function FastStochastic:add(...)
    assert(tostring(self) == "faststochastic",
        string.format([[Expected 'self' with type = 'faststochastic', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon faststochastic:add(...), instead faststochastic.add()]], type(self), tostring(self)))

    local input = {...}
    for i = 1, #input do
        local item = input[i]
        if tostring(item) == "C" then
            calculate(self, item)
        else
            for j = 1, #item do
                self:add(item[j])
            end
        end
    end
    return self
end

function FastStochastic:last()
    assert(tostring(self) == "faststochastic",
        string.format([[Expected 'self' with type = 'faststochastic', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon faststochastic:reset(), instead faststochastic.reset()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function FastStochastic:series()
    assert(tostring(self) == "faststochastic",
        string.format([[Expected 'self' with type = 'faststochastic', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon faststochastic:series(), instead faststochastic.series()]], type(self), tostring(self)))

    return self._series
end

function FastStochastic:reset()
    assert(tostring(self) == "faststochastic",
        string.format([[Expected 'self' with type = 'faststochastic', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon faststochastic:reset(), instead faststochastic.reset()]], type(self), tostring(self)))
    self.maximum:reset()
    self.minimum:reset()
    self._series = {}
    self.lows = {}
    self.highs = {}
end

return FastStochastic
