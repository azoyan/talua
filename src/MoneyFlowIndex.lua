local MoneyFlowIndex = {}

setmetatable(MoneyFlowIndex, {
    __call = function(self, period)
        local mfi = {}
        setmetatable(mfi, {
            __tostring = function()
                return "mfi"
            end
        })

        mfi.period = period or 14
        mfi._series = {}
        mfi.money_flows = {}
        mfi.positive_money_flow = {}
        mfi.negative_money_flow = {}

        mfi.typical_price = {}

        mfi.last = self.last
        mfi.series = self.series
        mfi.add = self.add
        mfi.reset = self.reset
        return mfi
    end
})

local calculate = function(self, input)
    local typical_price = (input.high + input.low + input.close) / 3.0

    self.typical_price[#self.typical_price + 1] = typical_price
    if #self.money_flows == 0 then
        self.money_flows[#self.money_flows + 1] = 0.0
        return
    end

    local money_flow = typical_price * input.volume
    self.money_flows[#self.money_flows + 1] = money_flow
    if self.typical_price[#self.typical_price] > self.typical_price[#self.typical_price - 1] then
        self.positive_money_flow[#self.positive_money_flow + 1] = money_flow
        self.negative_money_flow[#self.negative_money_flow + 1] = 0
    else
        self.negative_money_flow[#self.negative_money_flow + 1] = money_flow
        self.positive_money_flow[#self.positive_money_flow + 1] = 0
    end

    if #self.money_flows >= self.period then
        if #self.positive_money_flow > self.period then
            table.remove(self.positive_money_flow, 1)
        end
        if #self.negative_money_flow > self.period then
            table.remove(self.negative_money_flow, 1)
        end

        local sum_of_positive = 0
        for i = 1, #self.positive_money_flow do
            sum_of_positive = sum_of_positive + self.positive_money_flow[i]
        end

        local sum_of_negative = 0
        for i = 1, #self.negative_money_flow do
            sum_of_negative = sum_of_negative + self.negative_money_flow[i]
        end
        local money_ratio = sum_of_positive / sum_of_negative
        local money_flow_index = 100.0 - (100.0 / (1.0 + money_ratio))
        self._series[#self._series + 1] = money_flow_index
    end
    assert(#self.positive_money_flow <= self.period)
    assert(#self.negative_money_flow <= self.period)
end

function MoneyFlowIndex:add(...)
    assert(type(self) == "table" and tostring(self) == "mfi",
        string.format([[Expected 'self' with type = 'mfi', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon mfi:add(...), instead mfi.add()]], type(self), tostring(self)))

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

function MoneyFlowIndex:last()
    assert(type(self) == "table" and tostring(self) == "mfi",
        string.format([[Expected 'self' with type = 'mfi', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon mfi:reset(), instead mfi.reset()]], type(self), tostring(self)))
    return self._series[#self._series]
end

function MoneyFlowIndex:series()
    assert(type(self) == "table" and tostring(self) == "mfi",
        string.format([[Expected 'self' with type = 'mfi', but current type = '%s' (%s).
    May be you forget pass 'self' argument on calling.
    Try call with colon mfi:series(), instead mfi.series()]], type(self), tostring(self)))

    return self._series
end

function MoneyFlowIndex:reset()
    assert(type(self) == "table" and tostring(self) == "mfi",
        string.format([[Expected 'self' with type = 'mfi', but current type = '%s' (%s).
        May be you forget pass 'self' argument on calling.
        Try call with colon mfi:reset(), instead mfi.reset()]], type(self), tostring(self)))
    self._series = {}
    self.money_flows = {}
    self.positive_money_flow = {}
    self.negative_money_flow = {}
    self.typical_price = {}
end

return MoneyFlowIndex
