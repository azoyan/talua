local Macd = {}

setmetatable(Macd, {
    __call = function(self, fast_period, slow_period, signal_period)
        local Ema = require "ExponentialMovingAverage"
        local macd = {}
        setmetatable(macd, {
            __tostring = function()
                return "macd"
            end
        })

        fast_period = fast_period or 12
        slow_period = slow_period or 26
        signal_period = signal_period or 9
        assert(fast_period < slow_period)

        macd.fast_ema = Ema(fast_period)
        macd.slow_ema = Ema(slow_period)
        macd.signal_ema = Ema(signal_period)

        macd._series = {}
        macd.histogram = {}
        macd.signal = {}

        macd.series = self.series
        macd.last = self.last
        macd.add = self.add
        macd.reset = self.reset
        return macd
    end
})

local calculate = function(self, input)
    local fast_ema = self.fast_ema:add(input)
    local slow_ema = self.slow_ema:add(input)
    if #slow_ema.prices == slow_ema.period then
        local macd = fast_ema:last() - slow_ema:last()
        local signal_ema = self.signal_ema:add(macd)

        if #signal_ema.prices == signal_ema.period then
            local signal_table = self.signal
            local signal = signal_ema:last()
            signal_table[#signal_table + 1] = signal

            local histogram_table = self.histogram
            local histogram = macd - signal
            histogram_table[#histogram_table + 1] = histogram
        end
        self._series[#self._series + 1] = macd
    end
end

function Macd:add(...)
    assert(type(self) == "table" and tostring(self) == "macd",
        string.format([[Expected 'self' with type = 'macd', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon macd:add(...), instead macd.add(...)]], type(self), tostring(self)))

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

function Macd:series()
    assert(tostring(self) == "macd", string.format([[Expected 'self' with type = 'macd', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon macd:series(), instead macd.series()]], type(self), tostring(self)))
    return self._series, self.signal, self.histogram
end

function Macd:last()
    assert(type(self) == "table" and tostring(self) == "macd",
        string.format([[Expected 'self' with type = 'macd', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon macd:last(), instead macd.last()]], type(self), tostring(self)))
    return self._series[#self._series], self.signal[#self.signal], self.histogram[#self.histogram]
end

function Macd:reset()
    assert(type(self) == "table" and tostring(self) == "macd",
        string.format([[Expected 'self' with type = 'macd', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon macd:reset(), instead macd.reset()]], type(self), tostring(self)))
    self.fast_ema:reset()
    self.slow_ema:reset()
    self.signal_ema:reset()
    self._series = {}
    self.signal = {}
    self.histogram = {}
end

return Macd
