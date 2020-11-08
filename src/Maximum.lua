local Maximum = {}

setmetatable(Maximum, {
    __call = function(self, period)
        assert(period > 0, "Period must be greater than zero")

        local maximum = {}
        setmetatable(maximum, {
            __tostring = function()
                return "max"
            end
        })

        maximum.period = period or 14
        maximum._series = {}

        maximum.series = self.series
        maximum.last = self.last
        maximum.add = self.add
        maximum.reset = self.reset
        return maximum
    end
})

local calculate = function(self, input)
    local series = self._series
    series[#series + 1] = input
    table.sort(series)
    if #series > self.period then
        table.remove(series, 1)
        assert(#self._series == self.period)
    end
end

function Maximum:add(...)
    assert(type(self) == "table" and tostring(self) == "max",
        string.format([[Expected 'self' with type = 'max', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon max:add(...), instead max.add(...)]], type(self), tostring(self)))

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

function Maximum:series()
    assert(type(self) == "table" and tostring(self) == "max",
        string.format([[Expected 'self' with type = 'max', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon max:series(), instead max.series()]], type(self), tostring(self)))
    return self._series
end

function Maximum:last()
    assert(type(self) == "table" and tostring(self) == "max",
        string.format([[Expected 'self' with type = 'max', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon max:last(), instead max.last()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function Maximum:reset()
    assert(type(self) == "table" and tostring(self) == "max",
        string.format([[Expected 'self' with type = 'max', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon max:reset(), instead max.reset()]], type(self), tostring(self)))
    self._series = {}
end

return Maximum
