local OnBalanceVolume = {}

setmetatable(OnBalanceVolume, {
    __call = function(self)
        local obv = {}
        setmetatable(obv, {
            __tostring = function()
                return "obv"
            end
        })
        obv.prev_close = 0.0

        obv._series = {}
        obv.series = self.series
        obv.last = self.last
        obv.add = self.add
        obv.reset = self.reset
        return obv
    end
})

local calculate = function(self, input)
    if #self._series == 0 then
        self._series[#self._series + 1] = input.volume
        self.prev_close = input.close
        return
    end

    local close = input.close
    local prev_close = self.prev_close
    if close > prev_close then
        self._series[#self._series + 1] = self._series[#self._series] + input.volume
    elseif close < prev_close then
        self._series[#self._series + 1] = self._series[#self._series] - input.volume
    elseif close == prev_close then
        self._series[#self._series + 1] = self._series[#self._series]
    end

    self.prev_close = close
end

function OnBalanceVolume:add(...)
    assert(type(self) == "table" and tostring(self) == "obv",
        string.format([[Expected 'self' with type = 'obv', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon obv:add(...), instead obv.add(...)]], type(self), tostring(self)))

    local input = {...}
    for i = 1, #input do
        local item = input[i]
        assert(item and (type(item) == "table"), "Expected type 'Candlestick', passed " .. tostring(item))
        if type(item) == "table" then
            if tostring(item) == "C" then
                calculate(self, item)
            else
                for j = 1, #input[i] do
                    self:add(input[i][j])
                end
            end
        end
    end
    return self
end

function OnBalanceVolume:series()
    assert(type(self) == "table" and tostring(self) == "obv",
        string.format([[Expected 'self' with type = 'obv', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon obv:series(), instead obv.series()]], type(self), tostring(self)))
    return self._series
end

function OnBalanceVolume:last()
    assert(type(self) == "table" and tostring(self) == "obv",
        string.format([[Expected 'self' with type = 'obv', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon obv:last(), instead obv.last()]], type(self), tostring(self)))

    return self._series[#self._series]
end

function OnBalanceVolume:reset()
    assert(type(self) == "table" and tostring(self) == "obv",
        string.format([[Expected 'self' with type = 'obv', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon obv:reset(), instead obv.reset()]], type(self), tostring(self)))
    self.prev_close = 0.0
    self._series = {}
end

return OnBalanceVolume
