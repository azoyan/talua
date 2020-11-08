local Roc = {}

setmetatable(Roc, {
    __call = function(self, period)
        assert(period > 0, "Period must be greater than zero")

        local roc = {}
        setmetatable(roc, {
            __tostring = function()
                return "roc"
            end
        })

        roc.period = period or 9
        roc.index = 1
        roc.count = 0
        roc.deque = {}
        for i = 1, period do
            roc.deque[i] = 0.0
        end
        roc._series = {}

        roc.series = self.series
        roc.last = self.last
        roc.add = self.add
        roc.reset = self.reset
        return roc
    end
})

local calculate = function(self, input)
    local previous
    local deque = self.deque
    local count = self.count
    local period = self.period
    local index = self.index
    if count >= period then
        previous = deque[index]
    else
        count = count + 1
        if count == 1 then
            previous = input
        else
            previous = deque[1]
        end
    end
    deque[index] = input

    if index + 1 < period then
        index = index + 1
    else
        index = 1
    end
    self.index = index
    self.count = count
    if count >= period then
        local roc = (input - previous) / previous * 100.0
        self._series[#self._series + 1] = roc
    end
end

function Roc:add(...)
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

function Roc:last()
    return self._series[#self._series]
end

function Roc:series()
    return self._series
end

function Roc:reset()
    self.index = 0
    self.count = 0
    for i = 0, self.period do
        self.deque[i] = 0.0
    end
end

return Roc
