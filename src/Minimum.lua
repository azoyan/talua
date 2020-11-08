local Minimum = {}

setmetatable(Minimum, {
    __call = function(self, period)
        assert(period > 0, "Period must be greater than zero")

        local minimum = {}
        setmetatable(minimum, {
            __tostring = function()
                return "min"
            end
        })
        minimum.period = period or 14
        minimum._series = {}

        minimum.series = self.series
        minimum.last = self.last
        minimum.add = self.add
        minimum.reset = self.reset
        return minimum
    end
})

local calculate = function(self, input)
    local series = self._series
    series[#series + 1] = input
    table.sort(series, function(a, b)
        return a > b
    end)
    if #series > self.period then
        -- print("MINUMUM input = ", input)
        table.remove(series, 1)
        assert(#self._series == self.period)
    end

end

function Minimum:add(...)
    assert(type(self) == "table" and tostring(self) == "min",
        string.format([[Expected 'self' with type = 'min', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon min:add(...), instead min.add(...)]], type(self), tostring(self)))

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

function Minimum:series()
    assert(type(self) == "table" and tostring(self) == "min",
        string.format([[Expected 'self' with type = 'max', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon min:series(), instead min.series()]], type(self), tostring(self)))
    return self._series
end

function Minimum:last()
    assert(type(self) == "table" and tostring(self) == "min",
        string.format([[Expected 'self' with type = 'max', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon min:last(), instead min.last()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function Minimum:reset()
    assert(type(self) == "table" and tostring(self) == "min",
        string.format([[Expected 'self' with type = 'min', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon min:reset(), instead min.reset()]], type(self), tostring(self)))
    self._series = {}
end

return Minimum
