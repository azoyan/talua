local Ppo = {}

setmetatable(Ppo, {
    __call = function(self, fast_period, slow_period, signal_period)
        local Ema = require "ExponentialMovingAverage"
        local ppo = {}

        setmetatable(ppo, {
            __tostring = function()
                return "ppo"
            end
        })

        fast_period = fast_period or 12
        slow_period = slow_period or 26
        signal_period = signal_period or 9

        ppo.fast_ema = Ema(fast_period)
        ppo.slow_ema = Ema(slow_period)
        ppo.signal_ema = Ema(signal_period)

        ppo._series = {}
        ppo.signals = {}
        ppo.histograms = {}

        ppo.series = self.series
        ppo.last = self.last
        ppo.add = self.add
        ppo.reset = self.reset
        return ppo
    end
})

local calculate = function(self, input)
    local fast_val = self.fast_ema:add(input):last()
    local slow_val = self.slow_ema:add(input):last()

    if fast_val and slow_val then
        local ppo = ((fast_val - slow_val) / slow_val) * 100.0
        self._series[#self._series + 1] = ppo
        local signal = self.signal_ema:add(ppo):last()
        if signal then
            local histogram = ppo - signal
            self.signals[#self.signals + 1] = signal
            self.histograms[#self.histograms + 1] = histogram
        end
    end
end

function Ppo:add(...)
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

function Ppo:series()
    return self._series, self.signals, self.histograms
end

function Ppo:last()
    return self._series[#self._series], self.signals[#self.signals], self.histograms[#self.histograms]
end

function Ppo:reset()
    self.fast_ema:reset()
    self.slow_ema:reset()
    self.signal_ema:reset()

    self._series = {}
    self.histograms = {}
    self.signals = {}
end

return Ppo
