local assert = require "luassert"
local say = require("say") -- our i18n lib, installed through luarocks, included as a luassert dependency

local function approx_same(_state, arguments)
    local expected = arguments[1]
    local passed = arguments[2]
    local precision = arguments[3] or 1

    if type(passed) == "table" and passed.type and passed.type == "C" then
        passed = passed.close
    end
    return math.abs(passed - expected) < precision
end

say:set_namespace("en")
say:set("assertion.approx_same.positive", "Expected %s in:\n%s")
say:set("assertion.approx_same.negative", "Expected %s to not be in:\n%s")
assert:register("assertion", "approx_same", approx_same, "assertion.approx_same.positive",
    "assertion.approx_same.negative")

local function approx_same_series(state, arguments)
    local expected = arguments[1]
    local passed = arguments[2]
    local precision = arguments[3] or 1

    if #expected ~= #passed then
        return false
    end

    for i = 1, #expected do
        if not approx_same(state, {expected[i], passed[i], precision}) then
            return false
        end
    end
    return true
end

say:set_namespace("en")
say:set("assertion.approx_same_series.positive", "Expected %s in:\n%s")
say:set("assertion.approx_same_series.negative", "Expected %s to not be in:\n%s")
assert:register("assertion", "approx_same_series", approx_same_series, "assertion.approx_same_series.positive",
    "assertion.approx_same_series.negative")
