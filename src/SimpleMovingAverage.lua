local Sma = {}

setmetatable(Sma, {
    __call = function(self, period)
        assert(period > 0, "Period must be greater than zero")

        local sma = {}
        sma.period = period or 9
        sma.type = "sma"
        sma.series = self.series
        sma._series = {}
        sma.prices = {}
        sma.last = self.last
        sma.add = self.add
        sma.reset = self.reset
        setmetatable(sma, {
            __tostring = function()
                return "sma"
            end
        })
        return sma
    end
})

local calculate = function(self, value)
    local prices = self.prices
    local prices_count = 1 + #prices
    prices[prices_count] = value

    local period = self.period
    if prices_count > period then
        table.remove(prices, 1)
        prices_count = prices_count - 1
    end
    assert(prices_count <= period)

    if prices_count == period then
        local average = 0
        for i = 1, prices_count do
            average = average + prices[i]
        end
        average = average / period
        self._series[#self._series + 1] = average
    end
end

function Sma:add(...)
    assert(type(self) == "table" and tostring(self) == "sma",
        string.format([[Expected 'self' with type = 'sma', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon sma:add(...), instead sma.add(...)]], type(self), tostring(self)))

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

function Sma:last()
    assert(type(self) == "table" and tostring(self) == "sma",
        string.format([[Expected 'self' with type = 'sma', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon sma:last(), instead sma.last()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function Sma:series()
    assert(type(self) == "table" and tostring(self) == "sma",
        string.format([[Expected 'self' with type = 'sma', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon sma:series(), instead sma.series()]], type(self), tostring(self)))
    return self._series
end

function Sma:reset()
    self.prices = {}
    self._series = {}
end

return Sma
