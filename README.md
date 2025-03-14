# Variable Documentation

This document provides an overview of the variables used, along with their purposes, types, and sources. For a more detailed overview, we refer to the paper.


| **Name** | **Description**                      | **Type** | **Source** |
|-------------------|--------------------------------------|---------------|-------------------|
| `code`        | ISO 3166-1 Alpha-3 Code       | String        | https://www.iso.org/obp/ui/#search |
| `country`        | English short name      | String         | https://www.iso.org/obp/ui/#search |
| `year`      | Year from 1960 to 2010      | Integer         | - |
| `any_lr`      | Variable indicating if any land reform happened in a given year  |  Integer (Binary)   | Bhattacharya et al. (2021) |
| `cum_lr`      | Cumulative `any_lr`    | Integer         | Bhattacharya et al. (2021)  |
| `class_lr`      | Classic land reform    | Integer (Binary)         | Bhattacharya et al. (2021)  |
| `cum_class_lr`      | Cumulative `class_lr`    | Integer         | Bhattacharya et al. (2021)  |
| `mot_cons`      |  Motive: Consolidation  | Integer (Binary)         | Bhattacharya et al. (2021)  |
| `mot_ten`      |  Motive: Improving tenure security  | Integer (Binary)         | Bhattacharya et al. (2021)  |
| `mot_ceil`      |  Motive: Imposing landholding ceilings  | Integer (Binary)         | Bhattacharya et al. (2021)  |
| `mot_expr`      |  Motive: Expropriation  | Integer (Binary)         | Bhattacharya et al. (2021)  |
| `mot_redist`      |  Motive: Redistribution  | Integer (Binary)         | Bhattacharya et al. (2021)  |
| `mot_priv`      |  Motive: Redistribution  | Integer (Binary)         | Bhattacharya et al. (2021)  |
| `propoor`      |  Motive: Pro-poor  | Integer (Binary)         | Bhattacharya et al. (2021)  |
| `proefficiency`      |  Motive: Pro-efficiency  | Integer (Binary)         | Bhattacharya et al. (2021)  |
| `agout`      |  Agricultural Output  | Float         | U.S. Department of Agriculture, Economic Research Service (2024) |
| `cereal_yield`      |  Cereal Yield | Float | Food and Agriculture Organization of the United Nations (2024) |
| `lstock`      |  Livestock | Float  | Food and Agriculture Organization of the United Nations (2024)  |
| `fert`      |  Feriliser | Float  | Food and Agriculture Organization of the United Nations (2024)  |
| `tract`      |  Tractors | Float  | Food and Agriculture Organization of the United Nations (2024)  |
| `plqi`      |  Peterson land quality index | Float  | Peterson (1987) |
| `perarr`      |  Percentage of A.a.P.C land | Float  | Food and Agriculture Organization of the United Nations (2024) |
| `rdensity`      |  Road Density | Float  | Canning (1998) & World Bank (2024) |
| `tfr`      |  Total fertility rate | Float  | World Bank (2024) |
| `life_expectancy`      |  Life expectancy | Float  | Jdanov et al. (2022) & Riley (2005) & Zijdeman and Ribeira da Silva (2015) & World Bank (2024) |
| `rule_of_law`      |  Rule of law | Float  | Coppedge et al. (2024) |
| `gov_consumption`      |  Government consumption | Float  | Feenstra et al. (2015) |
