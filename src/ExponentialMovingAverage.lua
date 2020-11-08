local ExponentialMovingAverage = {}

setmetatable(ExponentialMovingAverage, {
    __call = function(self, period)
        period = period or 9
        assert(period > 0, "Period must be greater than zero")

        local ema = {}
        setmetatable(ema, {
            __tostring = function()
                return "ema"
            end
        })

        ema.period = period
        ema.k = 2.0 / (period + 1)
        ema._series = {}
        ema.prices = {}

        ema.series = self.series
        ema.last = self.last
        ema.add = self.add
        ema.reset = self.reset
        return ema
    end
})

local calculate = function(self, value)
    local prices = self.prices
    local prices_count = 1 + #self.prices
    prices[prices_count] = value

    local period = self.period
    if prices_count > period then
        table.remove(prices, 1)
        prices_count = prices_count - 1
    end
    assert(prices_count <= period)

    if prices_count == period then
        local series = self._series
        local series_count = #series
        if series_count == 0 then
            local SimpleMovingAverage = require "SimpleMovingAverage"
            local sma = SimpleMovingAverage(period)
            local sma_series = sma:add(prices):series()
            assert(#sma_series == 1)
            local average = sma_series[1]
            series[series_count + 1] = average
        elseif series_count > 0 then
            series[series_count + 1] = self.k * (value - series[series_count]) + series[series_count]
        end
    end
end

function ExponentialMovingAverage:add(...)
    assert(type(self) == "table" and tostring(self) == "ema",
        string.format([[Expected 'self' with type = 'ema', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon ema:add(...), instead ema.add(...)]], type(self), tostring(self)))

    local input = {...}

    for i = 1, #input do
        local item = input[i]
        assert(item, string.format("Expected 'number' or 'Candlestick'. Passed '%s'", tostring(item)))
        if type(item) == "number" then
            calculate(self, item)
        elseif tostring(item) == "C" then
            calculate(self, item.close)
        else
            for j = 1, #item do
                self:add(item[j])
            end
        end
    end
    return self
end

function ExponentialMovingAverage:series()
    assert(type(self) == "table" and tostring(self) == "ema",
        string.format([[Expected 'self' with type = 'ema', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon ema:series(), instead ema.series()]], type(self), tostring(self)))
    return self._series
end

function ExponentialMovingAverage:last()
    assert(type(self) == "table" and tostring(self) == "ema",
        string.format([[Expected 'self' with type = 'ema', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon ema:last(), instead ema.last()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function ExponentialMovingAverage:reset()
    assert(type(self) == "table" and tostring(self) == "ema",
        string.format([[Expected 'self' with type = 'ema', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon ema:reset(), instead ema.reset()]], type(self), tostring(self)))

    self.prices = {}
    self._series = {}
end

return ExponentialMovingAverage
