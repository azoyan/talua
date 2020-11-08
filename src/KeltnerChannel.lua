local KeltnerChannel = {}

setmetatable(KeltnerChannel, {
    __call = function(self, period, multiplier)
        period = period or 14
        assert(period > 0, "Period must be greater than zero")
        multiplier = multiplier or 2
        assert(multiplier > 0, "Multiplier must be greater than zero")

        local kc = {}

        setmetatable(kc, {
            __tostring = function()
                return "kc"
            end
        })

        local AverageTrueRange = require "AverageTrueRange"
        local ExponentialMovingAverage = require "SimpleMovingAverage"

        kc.period = period
        kc.multiplier = multiplier
        kc.atr = AverageTrueRange(period)
        kc.ema = ExponentialMovingAverage(period)
        kc.typical_prices = {}

        kc._series = {}
        kc.series = self.series
        kc.last = self.last
        kc.add = self.add
        kc.reset = self.reset
        return kc
    end
})

local calculate = function(self, input)
    local channel

    local typical_price = (input.close + input.high + input.low) / 3.0
    local typical_prices = self.typical_prices
    local typical_price_count = #typical_prices + 1
    typical_prices[typical_price_count] = typical_price

    local average = self.ema:add(typical_price)
    local atr = self.atr:add(input)
    if #typical_prices >= self.period then
        atr = atr:last()
        if atr then
            average = average:last()
            local multiplied_atr = atr * self.multiplier
            channel = {
                average = average,
                upper = average + multiplied_atr,
                lower = average - multiplied_atr
            }
            self._series[#self._series + 1] = channel
        end
    end
end

function KeltnerChannel:add(...)
    assert(tostring(self) == "kc", string.format([[Expected 'self' with type = 'kc', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon kc:add(...), instead kc.add(...)]], type(self), tostring(self)))

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

function KeltnerChannel:series()
    assert(type(self) == "table" and tostring(self) == "kc",
        string.format([[Expected 'self' with type = 'kc', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon kc:series(), instead kc.series()]], type(self), tostring(self)))
    return self._series
end

function KeltnerChannel:last()
    assert(type(self) == "table" and tostring(self) == "kc",
        string.format([[Expected 'self' with type = 'kc', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon kc:last(), instead kc.last()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function KeltnerChannel:reset()
    assert(type(self) == "table" and tostring(self) == "kc",
        string.format([[Expected 'self' with type = 'kc', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon kc:reset(), instead kc.reset()]], type(self), tostring(self)))

    self.prices = {}
    self._series = {}
end

return KeltnerChannel
