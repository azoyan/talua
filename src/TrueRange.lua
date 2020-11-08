local TrueRange = {}

setmetatable(TrueRange, {
    __call = function(self)
        local truerange = {}
        setmetatable(truerange, {
            __tostring = function()
                return "tr"
            end
        })
        truerange.prev_close = nil
        truerange._series = {}

        truerange.series = self.series
        truerange.add = self.add
        truerange.reset = self.reset
        truerange.last = self.last
        return truerange
    end
})

local calculate = function(self, input)
    assert(input and (tostring(input) == "C"), "Expected type 'Candlestick', passed " .. tostring(input))
    local max_dist
    local prev_close = self.prev_close
    if prev_close then
        local dist1 = input.high - input.low
        local dist2 = math.abs(input.high - prev_close)
        local dist3 = math.abs(input.low - prev_close)
        max_dist = math.max(dist1, dist2, dist3)
    else
        max_dist = input.high - input.low
    end
    self.prev_close = input.close
    self._series[#self._series + 1] = max_dist
end

function TrueRange:add(...)
    assert(type(self) == "table" and tostring(self) == "tr",
        string.format([[Expected 'self' with type = 'tr', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon tr:add(...), instead tr.add(...)]], type(self), tostring(self)))

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

function TrueRange:last()
    assert(type(self) == "table" and tostring(self) == "tr",
        string.format([[Expected 'self' with type = 'tr', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon tr:last(), instead tr.last()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function TrueRange:series()
    assert(type(self) == "table" and tostring(self) == "tr",
        string.format([[Expected 'self' with type = 'tr', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon tr:series(), instead tr.series()]], type(self), tostring(self)))
    return self._series
end

function TrueRange:reset()
    assert(type(self) == "table" and tostring(self) == "tr",
        string.format([[Expected 'self' with type = 'tr', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon tr:reset(), instead tr.reset()]], type(self), tostring(self)))
    self._series = {}
    self.prev_close = nil
end

return TrueRange
