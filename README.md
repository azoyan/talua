![logo](https://i.ibb.co/rmMfs7V/image-2020-11-19-23-58-36.png)
[![build status](https://github.com/azoyan/talua/workflows/CI/badge.svg)](https://github.com/azoyan/talua/actions?query=workflow%3ACI)
[![Build Status](https://travis-ci.org/azoyan/talua.svg?branch=main)](https://travis-ci.org/azoyan/talua)
[![Build status](https://ci.appveyor.com/api/projects/status/02o3vqncjddyw8d8?svg=true)](https://ci.appveyor.com/project/azoyan/talua)
[![Coverage Status](https://coveralls.io/repos/github/azoyan/talua/badge.svg?branch=main)](https://coveralls.io/github/azoyan/talua?branch=main)
[![codecov](https://codecov.io/gh/azoyan/talua/branch/main/graph/badge.svg?token=NP5G0OBNB3)](https://codecov.io/gh/azoyan/talua)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg)](LICENSE)
 
Techincal Analysis library written in Lua

Provides most popular technical indicators.

## Getting started


## Basic ideas

Common to the whole API are the functions `add`, `last`, `series` and `reset`.

### `add(...)` 
The add function is universal and can take a `number`, several numbers, or a table of numbers as arguments, as well as, in most cases, a candlestick (`Candlestick`), several candlesticks, and a table of candlesticks. 

The function returns the `self`, so you can call it multiple times or call another method of the object. Take a look:
```Lua
local SimpleMovingAverage = require "SimpleMovingAverage"

local sma = SimpleMovingAverage(4)

sma:add(4.0)
sma:add(5.0)
sma:add(6.0)
sma:add(6.0)

-- it is same as:
sma:add(4,0, 5.0, 6.0, 6.0)
-- or
sma:add{4,0, 5.0, 6.0, 6.0}
-- or
sma:add{{4.0, {5.0, {6.0, {6.0 }}}}}
-- or
sma:add(4.0):add(5.0):add(6.0):add(6.0)
```
You can combine numbers and Сandlesticks as you like:
```lua
local Candlestick = require "Candlestick"
local candle1 = Candlestick():close(4.0)
local candle2 = Candlestick():close(4.0)

sma:add({candle1, candle2}, {7, 1}):add(Candlestick():close(3)):add(4.0):add{5.0, 5.5}
```

### `last()`
Returns last or in other words actual or current value of indicator series:
```
local last = sma:add{4.0, 5.0, 6.0, 6.0, 6.0, 6.0, 2.0}:last() -- 5.0
```

### `series()`
Returns series of indicator values:
```lua
local sma = SimpleMovingAverage(9)

local input = {22.81, 23.09, 22.91, 23.23, 22.83, 23.05, 23.02, 23.29, 23.41, 23.49, 24.60, 24.63, 24.51, 23.73,
              23.31, 23.53, 23.06, 23.25, 23.12, 22.80, 22.84}

local series = sma:add(input):series() -- 23.07, 23.15, 23.31, 23.51, 23.65, 23.75, 23.78, 23.83, 23.81, 23.79, 23.75, 23.55, 23.35
```

Example:
```lua
local RelativeStrengthIndex = require "RelativeStrengthIndex"
    
local rsi = RelativeStrengthIndex(14) -- period argument

rsi:add(283.46, 280.69, 285.48, 294.08, 293.90, 299.92, 301.15, 284.45, 294.09, 302.77, 301.97, 306.85,
        305.02, 301.06, 291.97, 284.18, 286.48, 284.54, 276.82, 284.49, 275.01, 279.07, 277.85, 278.85,
        283.76, 291.72, 284.73, 291.82, 296.74, 291.13)

local last = rsi:last() -- returns last RSI value 54.17

-- To return series of RSI:
local series = rsi:series() -- 55.37, 50.07, 51.55, 50.20, 45.14, 50.48, 44.69, 47.47, 46.71, 47.45, 51.05, 56.29, 51.12, 55.58, 58.41, 54.17

local SimpleMovingAverage = require "SimpleMovingAverage"

local sma = SimpleMovingAverage(4)
-- Possibly usage:
 sma:add{4.0, 5.0, 6.0, 6.0, 6.0, 6.0, 2.0}:last() -- 5.0
```

## List of indicators

So far there are the following indicators available.

* Trend
  * Exponential Moving Average (EMA)
  * Simple Moving Average (SMA)
* Oscillators
  * Relative Strength Index (RSI)
  * Fast Stochastic
  * Slow Stochastic
  * Moving Average Convergence Divergence (MACD)
  * Percentage Price Oscillator (PPO)
  * Money Flow Index (MFI)
* Other
  * Minimum
  * Maximum
  * True Range
  * Standard Deviation (SD)
  * Average True Range (AR)
  * Efficiency Ratio (ER)
  * Bollinger Bands (BB)
  * Chandelier Exit (CE)
  * Keltner Channel (KC)
  * Rate of Change (ROC)
  * On Balance Volume (OBV)
