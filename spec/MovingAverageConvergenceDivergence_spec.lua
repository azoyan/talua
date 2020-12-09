require "spec.approx"

describe("#macd Moving Average Convergence Divergence", function()
    local Macd = require "MovingAverageConvergenceDivergence"

    it("add() series() #macd1", function()
        local input = {459.99, 448.85, 446.06, 450.81, 442.8, 448.97, 444.57, 441.4, 430.47, 420.05, 431.14, 425.66,
                       430.58, 431.72, 437.87, 428.43, 428.35, 432.5, 443.66, 455.72, 454.49, 452.08, 452.73, 461.91,
                       463.58, 461.14, 452.08, 442.66, 428.91, 429.79, 431.99, 427.72, 423.2, 426.21, 426.98, 435.69,
                       434.33, 429.8, 419.85, 426.24, 402.8, 392.05, 390.53, 398.67, 406.13, 405.46, 408.38, 417.2,
                       430.12, 442.78, 439.29, 445.52, 449.98, 460.71, 458.66, 463.84, 456.77, 452.97, 454.74, 443.86,
                       428.85, 434.58, 433.26, 442.93, 439.66, 441.35}

        local expected_macd = {8.27526950390762, 7.70337838145673, 6.41607475695588, 4.23751978326482, 2.55258332486574,
                               1.37888571985366, 0.102981491199103, -1.25840195280313, -2.07055819009491,
                               -2.62184232825689, -2.32906674045495, -2.18163211479299, -2.40262627286643,
                               -3.34212168135286, -3.53036313607754, -5.50747124862733, -7.85127422856084,
                               -9.7193674552488, -10.4228665080072, -10.2601621589375, -10.0692096101343,
                               -9.5719196119536, -8.36963349244508, -6.30163572368542, -3.59968150914517,
                               -1.72014836089687, 0.269003232299383, 2.18017324711349, 4.50863780861044,
                               6.11802015384473, 7.72243059351439, 8.32745380871404, 8.40344118462588, 8.50840632319353,
                               7.62576184402923, 5.64994908292869, 4.49465476488206, 3.43298936168441, 3.33347385363294,
                               2.95666285611526, 2.76256121582526}

        local expected_signal = {3.03752586873394, 1.90565222933578, 1.05870843537763, 0.410640325343509,
                                 -0.152012994298479, -0.790034731709356, -1.33810041258299, -2.17197457979186,
                                 -3.30783450954566, -4.59014109868629, -5.75668618055047, -6.65738137622787,
                                 -7.33974702300915, -7.78618154079804, -7.90287193112745, -7.58262468963905,
                                 -6.78603605354027, -5.77285851501159, -4.5644861655494, -3.21555428301682,
                                 -1.67071586469137, -0.112968660984149, 1.45411118991556, 2.82877971367525,
                                 3.94371200786538, 4.85665087093101, 5.41047306555065, 5.45836826902626,
                                 5.26562556819742, 4.89909832689482, 4.58597343224244, 4.26011131701701,
                                 3.96060129677866}

        local expected_histogram = {-5.10808405882886, -4.52749455759267, -3.38777517583258, -2.5922724401365,
                                    -2.25061327856795, -2.55208694964351, -2.19226272349455, -3.33549666883547,
                                    -4.54343971901518, -5.12922635656252, -4.66618032745672, -3.60278078270961,
                                    -2.72946258712514, -1.78573807115556, -0.466761561317625, 1.28098896595362,
                                    3.1863545443951, 4.05271015411472, 4.83348939784878, 5.39572753013031,
                                    6.17935367330181, 6.23098881482887, 6.26831940359883, 5.49867409503879,
                                    4.4597291767605, 3.65175545226252, 2.21528877847857, 0.191580813902426,
                                    -0.770970803315363, -1.46610896521041, -1.2524995786095, -1.30344846090175,
                                    -1.1980400809534}

        local macd = Macd(12, 26, 9)
        local mcd, signal, histogram = macd:add(input):series()
        assert.are.same(#expected_macd, #mcd)
        assert.are.approx_same_series(expected_macd, mcd)
        assert.are.approx_same_series(expected_signal, signal)
        assert.are.approx_same_series(expected_histogram, histogram)
    end)

    it("add(), last(), series(), reset() with Candlesticks #macd2", function()
        local Candle = require "Candlestick"
        local macd = Macd()
        local input = {Candle():open(165.36):high(165.43):low(164.84):close(164.92),
                       Candle():open(164.9):high(165.24):low(164.84):close(164.92),
                       Candle():open(164.9):high(165.28):low(164.9):close(165.2),
                       Candle():open(165.19):high(165.28):low(164.9):close(165.07),
                       Candle():open(165.26):high(165.43):low(164.9):close(165.2),
                       Candle():open(165.21):high(165.58):low(163.65):close(165.26),
                       Candle():open(165.26):high(165.45):low(164.97):close(165.07),
                       Candle():open(165.07):high(165.27):low(164.23):close(164.41),
                       Candle():open(164.42):high(164.56):low(163.94):close(163.98),
                       Candle():open(163.99):high(164.16):low(163.77):close(163.81),
                       Candle():open(163.85):high(164.16):low(163.7):close(164.09),
                       Candle():open(164.08):high(164.55):low(164.03):close(164.37),
                       Candle():open(164.38):high(164.59):low(163.7):close(164.44),
                       Candle():open(164.45):high(164.47):low(164.35):close(164.4),
                       Candle():open(164.4):high(164.4):low(164.21):close(164.34),
                       Candle():open(164.33):high(164.39):low(164.29):close(164.35),
                       Candle():open(164.34):high(164.48):low(164.22):close(164.35),
                       Candle():open(164.36):high(164.51):low(164.27):close(164.29),
                       Candle():open(164.27):high(164.47):low(164.27):close(164.44),
                       Candle():open(164.47):high(164.58):low(164.34):close(164.4),
                       Candle():open(164.46):high(164.5):low(164.13):close(164.28),
                       Candle():open(164.3):high(164.96):low(164.14):close(164.85),
                       Candle():open(164.84):high(165.38):low(164.84):close(165.33),
                       Candle():open(165.33):high(165.92):low(165.3):close(165.9),
                       Candle():open(165.9):high(165.94):low(165.78):close(165.83),
                       Candle():open(165.83):high(166.03):low(165.72):close(165.77),
                       Candle():open(165.78):high(165.94):low(165.68):close(165.88),
                       Candle():open(165.88):high(166):low(165.54):close(165.76),
                       Candle():open(165.76):high(166.03):low(165.73):close(166.02),
                       Candle():open(166.02):high(166.09):low(166.01):close(166.05),
                       Candle():open(166.06):high(166.06):low(166):close(166.01),
                       Candle():open(166.02):high(166.08):low(166.01):close(166.04),
                       Candle():open(166.13):high(166.13):low(165.71):close(165.88),
                       Candle():open(165.85):high(165.93):low(165.65):close(165.77),
                       Candle():open(165.75):high(166.02):low(165.72):close(165.94),
                       Candle():open(165.92):high(166.02):low(165.79):close(165.84),
                       Candle():open(165.95):high(166.17):low(165.85):close(165.98),
                       Candle():open(165.98):high(166.4):low(165.73):close(166.31),
                       Candle():open(166.31):high(166.38):low(165.86):close(165.89),
                       Candle():open(165.89):high(166.19):low(165.87):close(166.15),
                       Candle():open(166.14):high(166.17):low(165.96):close(166.03),
                       Candle():open(166.02):high(166.22):low(165.93):close(165.98),
                       Candle():open(165.98):high(166.26):low(165.94):close(166.17),
                       Candle():open(166.17):high(166.19):low(165.87):close(165.92),
                       Candle():open(165.92):high(166.04):low(165.83):close(165.85),
                       Candle():open(165.85):high(165.97):low(165.76):close(165.84),
                       Candle():open(165.83):high(166.08):low(165.82):close(165.95),
                       Candle():open(165.94):high(165.98):low(165.93):close(165.98),
                       Candle():open(165.88):high(165.96):low(165.88):close(165.96),
                       Candle():open(165.94):high(165.96):low(165.86):close(165.86),
                       Candle():open(165.83):high(165.92):low(165.81):close(165.92),
                       Candle():open(165.91):high(166.23):low(165.91):close(166.22),
                       Candle():open(166.21):high(166.94):low(165.82):close(166.83),
                       Candle():open(166.83):high(166.85):low(164.84):close(165.18),
                       Candle():open(165.17):high(166.33):low(164.48):close(166.27),
                       Candle():open(166.27):high(166.64):low(166.26):close(166.53),
                       Candle():open(166.53):high(166.63):low(166.2):close(166.39),
                       Candle():open(166.38):high(166.92):low(166.38):close(166.8),
                       Candle():open(166.81):high(166.98):low(166.58):close(166.66),
                       Candle():open(166.66):high(166.73):low(165.88):close(165.98),
                       Candle():open(165.98):high(166.54):low(165.17):close(166),
                       Candle():open(166):high(166.12):low(165.81):close(165.94),
                       Candle():open(165.9):high(165.96):low(165.81):close(165.84),
                       Candle():open(165.84):high(165.94):low(165.83):close(165.84),
                       Candle():open(166.15):high(166.52):low(166.15):close(166.51),
                       Candle():open(166.46):high(166.46):low(166.27):close(166.27)}

        local expected_macd = {0.356824457808159, 0.392776513608879, 0.406895343497098, 0.434060861574807,
                               0.452790987002345, 0.459114692257487, 0.461230248314848, 0.444868017324865,
                               0.418203955810498, 0.40610870583987, 0.38402714297581, 0.373518486680894,
                               0.38735337435088, 0.360274116834802, 0.355693227136044, 0.33847807734773,
                               0.317144520364309, 0.311972707680837, 0.284422453211647, 0.254012168904325,
                               0.226494001211648, 0.211127983774787, 0.199076226708598, 0.185769850355229,
                               0.165250383407653, 0.152077007498207, 0.163954539107664, 0.220052838355997,
                               0.129872841033688, 0.144690531552868, 0.175391679035954, 0.186278427872736,
                               0.225391653566788, 0.242299261691016, 0.198539703820359, 0.163588030801236,
                               0.129553665549167, 0.093434961542045, 0.064072045735401, 0.093784039952595,
                               0.096848604767189}

        local expected_signal = {0.425196119688776, 0.421378636918995, 0.413908338130358, 0.405830367840465,
                                 0.402134969142548, 0.393762798680999, 0.386148884372008, 0.376614722967152,
                                 0.364720682446584, 0.354171087493434, 0.340221360637077, 0.322979522290526,
                                 0.303682418074751, 0.285171531214758, 0.267952470313526, 0.251515946321867,
                                 0.234262833739024, 0.21782566849086, 0.207051442614221, 0.209651721762576,
                                 0.193695945616799, 0.183894862804013, 0.182194226050401, 0.183011066414868,
                                 0.191487183845252, 0.201649599414405, 0.201027620295596, 0.193539702396724,
                                 0.180742495027212, 0.163280988330179, 0.143439199811223, 0.133508167839498,
                                 0.126176255225036}

        local expected_histogram = {-0.006992163878279, -0.015269931079125, -0.029881195154548, -0.032311881159572,
                                    -0.014781594791668, -0.033488681846197, -0.030455657235964, -0.038136645619422,
                                    -0.047576162082275, -0.042198379812597, -0.05579890742543, -0.068967353386202,
                                    -0.077188416863103, -0.074043547439971, -0.068876243604928, -0.065746095966638,
                                    -0.069012450331371, -0.065748660992654, -0.043096903506557, 0.010401116593421,
                                    -0.063823104583111, -0.039204331251145, -0.006802547014447, 0.003267361457868,
                                    0.033904469721536, 0.040649662276612, -0.002487916475237, -0.029951671595488,
                                    -0.051188829478045, -0.069846026788135, -0.079367154075823, -0.039724127886902,
                                    -0.029327650457847}

        macd:add(input)
        local series, signals, histograms = macd:series()

        assert.are.approx_same_series(expected_macd, series, 0.1)
        assert.are.approx_same_series(expected_signal, signals, 0.1)
        assert.are.approx_same_series(expected_histogram, histograms, 0.1)

        local expected_last_macd = 0.096848604767189
        local expected_last_signal = 0.126176255225036
        local expected_last_histogram = -0.029327650457847
        local last_macd, last_signal, last_histogram = macd:last()
        assert.are.approx_same(expected_last_macd, last_macd)
        assert.are.approx_same(expected_last_signal, last_signal)
        assert.are.approx_same(expected_last_histogram, last_histogram)

        macd:reset()
        local last_macd, last_signal, last_histogram = macd:last()
        assert.falsy(last_macd)
        assert.falsy(last_signal)
        assert.falsy(last_histogram)

        series, signals, histograms = macd:series()
        assert.are.same(0, #series)
        assert.are.same(0, #signals)
        assert.are.same(0, #histograms)
        macd:add(input)
        series, signals, histograms = macd:series()
        assert.are.same(#expected_macd, #series)
        assert.are.same(#expected_signal, #signals)
        assert.are.same(#expected_histogram, #histograms)
        assert.are.approx_same_series(expected_macd, series, 0.1)
        assert.are.approx_same_series(expected_signal, signals, 0.1)
        assert.are.approx_same_series(expected_histogram, histograms, 0.1)
    end)
end)