local StandardDeviation = {}

setmetatable(StandardDeviation, {
    __call = function(self, period)
        assert(period > 0, "Period must be greater than zero")

        local sd = {}
        setmetatable(sd, {
            __tostring = function()
                return "sd"
            end
        })

        sd.period = period or 9
        sd.index = 0
        sd.count = 0
        sd.m = 0.0
        sd.m2 = 0.0
        sd.deque = {}
        sd.mean = self.mean
        for i = 0, period do
            sd.deque[i] = 0.0
        end
        sd._series = {}

        sd.series = self.series
        sd.last = self.last
        sd.add = self.add
        sd.reset = self.reset
        return sd
    end
})

local calculate = function(self, input)
    local deque = self.deque
    local index = self.index
    local period = self.period

    local old_val = deque[index]
    deque[index] = input

    if index + 1 < period then
        self.index = index + 1
    else
        self.index = 0
    end

    if self.count < period then
        local count = self.count + 1
        self.count = count
        local m = self.m
        local delta = input - m
        m = m + delta / count

        local delta2 = input - m
        self.m = m

        self.m2 = self.m2 + delta * delta2
    else
        local delta = input - old_val
        local old_m = self.m
        self.m = self.m + delta / self.period
        local delta2 = input - self.m + old_val - old_m
        self.m2 = self.m2 + delta * delta2
        self._series[#self._series + 1] = math.sqrt(self.m2 / self.count)
    end
    if self.m2 < 0.0 then
        self.m2 = 0.0
    end

end

function StandardDeviation:add(...)
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

function StandardDeviation:last()
    return self._series[#self._series]
end

function StandardDeviation:series()
    return self._series
end

function StandardDeviation:mean()
    return self.m
end

function StandardDeviation:reset()
    self.index = 0
    self.count = 0
    self.m = 0.0
    self.m2 = 0.0
    for i = 0, self.period do
        self.deque[i] = 0.0
    end
    self._series = {}
end

return StandardDeviation
