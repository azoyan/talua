local EffcuencyRatio = {}

setmetatable(EffcuencyRatio, {
    __call = function(self, period)
        assert(period > 0, "Period must be greater than zero")

        local er = {}
        setmetatable(er, {
            __tostring = function()
                return "er"
            end
        })

        er.period = period or 9
        er.prices = {}
        local diffs = {}
        diffs[1] = 0.0
        er.diffs = diffs
        er.prices = {}

        er._series = {}
        er.series = self.series
        er.last = self.last
        er.add = self.add
        er.reset = self.reset
        return er
    end
})

local calculate = function(self, input)
    local prices = self.prices
    local prices_count = #prices + 1
    prices[prices_count] = input

    local period = self.period

    local diffs = self.diffs
    if prices_count > 1 then
        local diff = math.abs(prices[prices_count] - prices[prices_count - 1])
        diffs[#diffs + 1] = diff
    end

    if #diffs >= period then
        local sum = 0.0
        local diffs_count = #diffs
        for i = 0, period - 1 do
            sum = sum + diffs[diffs_count - i]
        end

        local first_index = 1 + prices_count - period
        local er = (prices[prices_count] - prices[first_index]) / sum
        self._series[#self._series + 1] = er
    end
end

function EffcuencyRatio:add(...)
    assert(tostring(self) == "er", string.format([[Expected 'self' with type = 'er', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon er:add(...), instead er.add(...)]], type(self), tostring(self)))

    local input = {...}
    for i = 1, #input do
        local item = input[i]
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

function EffcuencyRatio:last()
    assert(tostring(self) == "er", string.format([[Expected 'self' with type = 'er', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon er:last(), instead er.last()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function EffcuencyRatio:series()
    assert(tostring(self) == "er", string.format([[Expected 'self' with type = 'er', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon er:series(), instead er.series()]], type(self), tostring(self)))
    return self._series
end

function EffcuencyRatio:reset()
    local diffs = {}
    diffs[1] = 0.0
    self.diffs = diffs
    self.prices = {}
    self._series = {}
end

return EffcuencyRatio
