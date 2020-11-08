local Candlestick = {}

setmetatable(Candlestick, {
    __call = function(self)
        local item = {
            open = self.open,
            close = self.close,
            high = self.high,
            low = self.low,
            volume = self.volume
        }
        setmetatable(item, {
            __tostring = function()
                return "C"
            end
        })
        return item
    end
})

function Candlestick:open(open)
    self.open = open
    return self
end

function Candlestick:close(close)
    self.close = close
    return self
end

function Candlestick:high(high)
    self.high = high
    return self
end

function Candlestick:low(low)
    self.low = low
    return self
end

function Candlestick:volume(volume)
    self.volume = volume
    return self
end

return Candlestick
