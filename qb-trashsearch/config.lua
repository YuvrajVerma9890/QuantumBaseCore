Config = Config or {}

Config.ItemTiers = 1

Config.Timer = 10 -- in seconds

--33% on each to get money/an item or nothing
Config.RewardTypes = {
    [1] = {
        type = "item"
    },
    [2] = {
        type = "money",
    },
    [3] = {
        type = "nothing",
    }
}

--rewards for small trashcans
Config.RewardsSmall = {
    [1] = {item = "cokebaggy", minAmount = 1, maxAmount = 3},
    [2] = {item = "lockpick", minAmount = 1, maxAmount = 2},
    [3] = {item = "vinremover", minAmount = 1, maxAmount = 1},
    [4] = {item = "rolling_paper", minAmount = 1, maxAmount = 4},
    [5] = {item = "plastic", minAmount = 1, maxAmount = 7},
    [6] = {item = "harness", minAmount = 1, maxAmount = 1},
    [7] = {item = "repairkit", minAmount = 1, maxAmount = 2},
}

Config.Objects = {
    -- Bins
    `hei_heist_kit_bin_01`,
    `prop_bin_01a`,
    `prop_bin_02a`,
    `prop_bin_03a`,
    `prop_bin_04a`,
    `prop_bin_05a`,
    `prop_bin_06a`,
    `prop_bin_07a`,
    `prop_bin_07b`,
    `prop_bin_07c`,
    `prop_bin_07d`,
    `prop_bin_08a`,
    `prop_bin_08open`,
    `prop_bin_09a`,
    `prop_bin_10a`,
    `prop_bin_10b`,
    `prop_bin_11a`,
    `prop_bin_11b`,
    `prop_bin_12a`,
    `prop_bin_13a`,
    `prop_bin_14a`,
    `prop_bin_14b`,
    `prop_bin_beach_01a`,
    `prop_bin_beach_01d`,
    `prop_bin_delpiero`,
    `prop_bin_delpiero_b`,
    `prop_cs_bin_01`,
    `prop_cs_bin_01_skinned`,
    `prop_cs_bin_02`,
    `prop_cs_bin_03`,
    `prop_gas_binunit01`,
    `prop_gas_smallbin01`,
    `prop_recyclebin_01a`,
    `prop_recyclebin_02_c`,
    `prop_recyclebin_02_d`,
    `prop_recyclebin_02a`,
    `prop_recyclebin_02b`,
    `prop_recyclebin_03_a`,
    `prop_recyclebin_04_a`,
    `prop_recyclebin_04_b`,
    `prop_recyclebin_05_a`,
    `zprop_bin_01a_old`,
    -- Bin Bags
    `bkr_prop_fakeid_binbag_01`,
    `hei_prop_heist_binbag`,
    `ng_proc_binbag_01a`,
    `ng_proc_binbag_02a`,
    `p_binbag_01_s`,
    `p_rub_binbag_test`,
    `prop_cs_rub_binbag_01`,
    `prop_cs_street_binbag_01`,
    `prop_ld_binbag_01`,
    `prop_ld_rub_binbag_01`,
    `prop_rub_binbag_01`,
    `prop_rub_binbag_01b`,
    `prop_rub_binbag_03`,
    `prop_rub_binbag_03b`,
    `prop_rub_binbag_04`,
    `prop_rub_binbag_05`,
    `prop_rub_binbag_06`,
    `prop_rub_binbag_08`,
    `prop_rub_binbag_sd_01`,
    `prop_rub_binbag_sd_02`,
    -- Dumpsters
    `p_dumpster_t`,
    `prop_cs_dumpster_01a`,
    `prop_dumpster_01a`,
    `prop_dumpster_02a`,
    `prop_dumpster_02b`,
    `prop_dumpster_3a`,
    `prop_dumpster_4a`,
    `prop_dumpster_4b`
}