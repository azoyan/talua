local SlowStochastic = {}

setmetatable(SlowStochastic, {
    __call = function(self, stochastic_period, ema_period)
        local slowStochastic = {}
        setmetatable(slowStochastic, {
            __tostring = function()
                return "slowstochastic"
            end
        })
        stochastic_period = stochastic_period or 14
        ema_period = ema_period or 3

        local FastStochastic = require "FastStochastic"
        local ExponentialMovingAverage = require "ExponentialMovingAverage"

        slowStochastic.stochastic_period = stochastic_period
        slowStochastic.ema_period = ema_period

        slowStochastic.fast_stochastic = FastStochastic(stochastic_period)
        slowStochastic.ema = ExponentialMovingAverage(ema_period)

        slowStochastic._series = {}
        slowStochastic.series = self.series
        slowStochastic.last = self.last
        slowStochastic.add = self.add
        slowStochastic.reset = self.reset
        return slowStochastic
    end
})

local calculate = function(self, input)
    local fast_stochastic = self.fast_stochastic:add(input)
    local fast_series = fast_stochastic:series()
    if #fast_series >= self.ema_period then
        local begin = #fast_series
        local last = begin - self.ema_period + 1
        for i = begin, last, -1 do
            self.ema:add(fast_series[i])
        end
        self._series[#self._series + 1] = self.ema:last()
        self.ema:reset()
    end
end

function SlowStochastic:add(...)
    assert(tostring(self) == "slowstochastic",
        string.format([[Expected 'self' with type = 'slowstochastic', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon slowstochastic:add(...), instead slowstochastic.add()]], type(self), tostring(self)))

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

function SlowStochastic:last()
    assert(tostring(self) == "slowstochastic",
        string.format([[Expected 'self' with type = 'slowstochastic', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon slowstochastic:reset(), instead slowstochastic.reset()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function SlowStochastic:series()
    assert(tostring(self) == "slowstochastic",
        string.format([[Expected 'self' with type = 'slowstochastic', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon slowstochastic:series(), instead slowstochastic.series()]], type(self), tostring(self)))

    return self._series
end

function SlowStochastic:reset()
    assert(tostring(self) == "slowstochastic",
        string.format([[Expected 'self' with type = 'slowstochastic', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon slowstochastic:reset(), instead slowstochastic.reset()]], type(self), tostring(self)))
    self.fast_stochastic:reset()
    self.ema:reset()
    self._series = {}
end

return SlowStochastic
