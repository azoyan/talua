local RelativeStrengthIndex = {}

setmetatable(RelativeStrengthIndex, {
    __call = function(self, period)
        assert(period > 0, "Period must be greater than zero")
        local rsi = {}
        setmetatable(rsi, {
            __tostring = function()
                return "rsi"
            end
        })
        rsi.period = period or 14
        rsi.avg_gains = {}
        rsi.avg_losses = {}
        rsi.prices = {}
        rsi.gains = {}
        rsi.losses = {}
        rsi._series = {}
        rsi.series = self.series
        rsi.last = self.last
        rsi.add = self.add
        rsi.reset = self.reset
        return rsi
    end
})

local calculate = function(self, input)
    local prices = self.prices
    local prices_count = 1 + #prices
    prices[prices_count] = input

    local gains = self.gains
    local gains_count = 1 + #gains

    local losses = self.losses
    local losses_count = 1 + #losses
    if prices_count > 1 then
        local difference = math.abs(prices[prices_count] - prices[prices_count - 1])

        if prices[prices_count] > prices[prices_count - 1] then
            gains[gains_count] = difference
            losses[losses_count] = 0
        else
            gains[gains_count] = 0
            losses[losses_count] = difference
        end
    end

    local avg_gains = self.avg_gains
    local avg_losses = self.avg_losses
    local avg_count = 1 + #avg_gains

    local period = self.period
    if prices_count == period then
        local sum_of_gains, sum_of_losses = 0.0, 0.0
        for i = 1, gains_count do
            sum_of_gains = sum_of_gains + gains[i]
        end
        for i = 1, losses_count do
            sum_of_losses = sum_of_losses + losses[i]
        end
        local first_avg_gain = sum_of_gains / period
        local fisrt_avg_loss = sum_of_losses / period
        avg_gains[avg_count] = first_avg_gain
        avg_losses[avg_count] = fisrt_avg_loss
    elseif prices_count > period then
        local avg_gain = (avg_gains[avg_count - 1] * (period - 1) + gains[gains_count]) / period
        avg_gains[avg_count] = avg_gain

        local avg_loss = (avg_losses[avg_count - 1] * (period - 1) + losses[losses_count]) / period
        avg_losses[avg_count] = avg_loss

        local rs = avg_gain / avg_loss
        local rsi = 100 - (100 / (1 + rs))
        self._series[#self._series + 1] = rsi
    end
end

function RelativeStrengthIndex:add(...)
    assert(type(self) == "table" and tostring(self) == "rsi",
        string.format([[Expected 'self' with type = 'rsi', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon rsi:add(...), instead rsi.add()]], type(self), tostring(self)))

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

function RelativeStrengthIndex:last()
    assert(type(self) == "table" and tostring(self) == "rsi",
        string.format([[Expected 'self' with type = 'rsi', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon rsi:reset(), instead rsi.reset()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function RelativeStrengthIndex:series()
    assert(type(self) == "table" and tostring(self) == "rsi",
        string.format([[Expected 'self' with type = 'rsi', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon rsi:series(), instead rsi.series()]], type(self), tostring(self)))

    return self._series
end

function RelativeStrengthIndex:reset()
    assert(type(self) == "table" and tostring(self) == "rsi",
        string.format([[Expected 'self' with type = 'rsi', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon rsi:reset(), instead rsi.reset()]], type(self), tostring(self)))
    self.avg_gains = {}
    self.avg_losses = {}
    self.prices = {}
    self.gains = {}
    self.losses = {}
    self._series = {}
end

return RelativeStrengthIndex
