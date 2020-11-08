local BollingerBands = {}

setmetatable(BollingerBands, {
    __call = function(self, period, multiplier)
        assert(period > 0, "Period must be greater than zero")

        local StandardDeviation = require "StandardDeviation"

        local bb = {}
        setmetatable(bb, {
            __tostring = function()
                return "bb"
            end
        })
        bb.sd = StandardDeviation:new(period)

        bb.period = period or 9
        bb.multiplier = multiplier or 2.0

        bb.series = self.series
        bb._series = {}
        bb.add = self.add
        bb.reset = self.reset
        return bb
    end
})

local calculate = function(self, input)
    local sd = self.sd:add(input)
    local mean = self.sd:mean()

    self.band = {
        average = mean,
        upper = mean + sd * self.multiplier,
        lower = mean - sd * self.multiplier
    }
end

function BollingerBands:add(...)
    local input = {...}
    local count = #input
    for i = 1, count do
        if type(input[i]) == "number" then
            calculate(self, input[i])
        elseif tostring(input) == "C" then
            for j = 1, #input[i] do
                calculate(self, input[i][j])
            end
        end
    end
    return self.band
end

function BollingerBands:reset()
    self.index = 0
    self.count = 0
    for i = 0, self.period do
        self.deque[i] = 0.0
    end
end

return BollingerBands
