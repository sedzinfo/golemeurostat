# The indicators of the app

The catalogue, one row per indicator: its `id`, whether it is for
countries or regions (`level`), its `topic`, `name` and `unit`, the
Eurostat `dataset` it comes from, the values that fix the other
dimensions of that dataset (`filters`, such as `sex=T;age=Y15-74`) and a
short `definition`.

The rows come from two files of `inst/extdata`: `indicators.csv`,
written by hand, whose rows come first, and `indicators_generated.csv`,
the series of the main tables of Eurostat, written by
`data-raw/build_indicators.R` (`generated` is `TRUE` for these). A
generated row with the same `id`, or the same `level`, `dataset` and
`filters`, as a hand-written one is left out. A row added to
`indicators.csv` adds an indicator to the app.

## Usage

``` r
indicators()
```

## Value

A data frame with one row per indicator.

## Examples

``` r
indicators()[, c("id", "level", "name", "unit")]
#>                                   id   level
#> 1                            gdp_pps country
#> 2                            gdp_eur country
#> 3                         gdp_growth country
#> 4                        price_level country
#> 5                            exports country
#> 6                         investment country
#> 7                        rd_spending country
#> 8                           gov_debt country
#> 9                        gov_balance country
#> 10                       tax_revenue country
#> 11                   gov_expenditure country
#> 12                         inflation country
#> 13                      house_prices country
#> 14                      net_earnings country
#> 15                    gender_pay_gap country
#> 16                      unemployment country
#> 17                youth_unemployment country
#> 18            long_term_unemployment country
#> 19                   employment_rate country
#> 20             gender_employment_gap country
#> 21                         part_time country
#> 22                              neet country
#> 23                             arope country
#> 24                      poverty_rate country
#> 25                     median_income country
#> 26                              gini country
#> 27                      income_ratio country
#> 28                       deprivation country
#> 29                      housing_cost country
#> 30                      overcrowding country
#> 31                        population country
#> 32                 population_growth country
#> 33                        birth_rate country
#> 34                         fertility country
#> 35                     net_migration country
#> 36                        median_age country
#> 37                old_age_dependency country
#> 38                   life_expectancy country
#> 39                healthy_life_years country
#> 40                  infant_mortality country
#> 41                   health_spending country
#> 42                     early_leavers country
#> 43                          tertiary country
#> 44                    adult_learning country
#> 45                    internet_daily country
#> 46                   online_shopping country
#> 47                        renewables country
#> 48                    energy_imports country
#> 49                    ghg_per_capita country
#> 50                   municipal_waste country
#> 51                         recycling country
#> 52                              cars country
#> 53                         homicides country
#> 54                         r_gdp_pps  region
#> 55                              r_rd  region
#> 56                    r_unemployment  region
#> 57                      r_employment  region
#> 58                           r_arope  region
#> 59               r_population_growth  region
#> 60                         r_density  region
#> 61                 r_life_expectancy  region
#> 62                        r_tertiary  region
#> 63                          tipsen10 country
#> 64                  tipsna20_cp_meur country
#> 65                   tipsna20_pc_gdp country
#> 66              tec00115_clv_pch_pre country
#> 67          tec00115_clv_pch_pre_hab country
#> 68                          tipsna10 country
#> 69                          tipspd10 country
#> 70                         cei_pc032 country
#> 71               tec00001_cp_eur_hab country
#> 72                  tec00001_cp_meur country
#> 73                  tec00013_cp_meur country
#> 74                   tec00013_pc_gdp country
#> 75                       tipsna30_p6 country
#> 76                      tipsna30_p61 country
#> 77                      tipsna30_p62 country
#> 78                  tec00010_cp_meur country
#> 79                   tec00010_pc_gdp country
#> 80                       tet00004_p7 country
#> 81                      tet00004_p71 country
#> 82                      tet00004_p72 country
#> 83                   tipsna51_pc_gdp country
#> 84                 tipsna51_pd15_nac country
#> 85                       tet00003_p6 country
#> 86                      tet00003_p61 country
#> 87                      tet00003_p62 country
#> 88                  tec00011_cp_meur country
#> 89                   tec00011_pc_gdp country
#> 90                          tipsex13 country
#> 91                       tec00110_p6 country
#> 92                       tec00110_p7 country
#> 93                          tipspc10 country
#> 94                  tec00009_cp_meur country
#> 95                   tec00009_pc_gdp country
#> 96         sdg_08_10_clv_pch_pre_hab country
#> 97           sdg_08_10_clv20_eur_hab country
#> 98            tipsna40_clv15_eur_hab country
#> 99                          tipsna50 country
#> 100                         tipsho50 country
#> 101                sdg_16_30_eur_hab country
#> 102                sdg_16_30_mio_eur country
#> 103             tipsna62_pch_pre_per country
#> 104                 tipsna62_ths_per country
#> 105             tipsna60_pch_pre_per country
#> 106                 tipsna60_ths_per country
#> 107                         tec00112 country
#> 108                       r_tgs00026  region
#> 109                       r_tgs00036  region
#> 110                         tec00116 country
#> 111                  tipslm10_pch_3y country
#> 112                 tipslm10_pch_pre country
#> 113                         tesem170 country
#> 114                     tipsna70_i15 country
#> 115                 tipsna70_pch_pre country
#> 116                 tesem160_nlpr_hw country
#> 117                tesem160_nlpr_per country
#> 118                     tipslm20_i15 country
#> 119                 tipslm20_pch_10y country
#> 120                  tipslm20_pch_1y country
#> 121                  tipslm20_pch_3y country
#> 122                  tipslm20_pch_5y country
#> 123                         tec00113 country
#> 124                         tipspd30 country
#> 125                         tipspd40 country
#> 126                         tipspc30 country
#> 127                         tipspc40 country
#> 128                         tec00131 country
#> 129                 tec00132_inv_bsn country
#> 130                 tec00132_inv_gov country
#> 131                  tec00132_inv_hh country
#> 132                 tec00132_inv_tot country
#> 133                         tec00104 country
#> 134                         tec00021 country
#> 135                     tec00023_s13 country
#> 136                   tec00023_s1311 country
#> 137                   tec00023_s1313 country
#> 138                   tec00023_s1314 country
#> 139                 tec00127_mio_eur country
#> 140                  tec00127_pc_gdp country
#> 141                         tec00097 country
#> 142                         tec00118 country
#> 143                         tec00027 country
#> 144                tipscp10_cid_ea20 country
#> 145                tipscp10_cid_ea21 country
#> 146                         tec00120 country
#> 147                         tec00114 country
#> 148  sdg_10_10_exp_pps_eu27_2020_hab country
#> 149   sdg_10_10_vi_pps_eu27_2020_hab country
#> 150                     tec00039_bal country
#> 151                     tec00039_cre country
#> 152                     tec00039_deb country
#> 153                     tec00041_bal country
#> 154                     tec00041_cre country
#> 155                     tec00041_deb country
#> 156                     tec00042_bal country
#> 157                     tec00042_cre country
#> 158                     tec00042_deb country
#> 159                     tec00038_bal country
#> 160                     tec00038_cre country
#> 161                     tec00038_deb country
#> 162                     tec00040_bal country
#> 163                     tec00040_cre country
#> 164                     tec00040_deb country
#> 165                         tec00106 country
#> 166                         tec00105 country
#> 167                         tec00107 country
#> 168                         tps00001 country
#> 169           tps00204_gbirthrt_thsp country
#> 170               tps00204_lbirth_nr country
#> 171                 eq_fer05_flbirth country
#> 172                  eq_fer05_lbirth country
#> 173                 eq_fer05_mlbirth country
#> 174                tps00029_death_nr country
#> 175           tps00029_gdeathrt_thsp country
#> 176              tps00019_cnmigratrt country
#> 177                  tps00019_growrt country
#> 178               tps00019_natgrowrt country
#> 179                   eq_mor06_death country
#> 180                  eq_mor06_fdeath country
#> 181                  eq_mor06_mdeath country
#> 182                         tps00005 country
#> 183            r_tgs00099_cnmigratrt  region
#> 184                r_tgs00099_growrt  region
#> 185             r_tgs00099_natgrowrt  region
#> 186                         tps00028 country
#> 187              eq_pop04_fmedagepop country
#> 188               eq_pop04_medagepop country
#> 189              eq_pop04_mmedagepop country
#> 190                tps00010_pc_y0_14 country
#> 191               tps00010_pc_y15_24 country
#> 192               tps00010_pc_y25_49 country
#> 193               tps00010_pc_y50_64 country
#> 194               tps00010_pc_y65_79 country
#> 195              tps00010_pc_y80_max country
#> 196                eq_pop03_pc_y0_17 country
#> 197               eq_pop03_pc_y15_24 country
#> 198               eq_pop03_pc_y25_49 country
#> 199               eq_pop03_pc_y50_64 country
#> 200              eq_pop03_pc_y65_max country
#> 201                         eq_pop02 country
#> 202                         tps00198 country
#> 203                         tps00003 country
#> 204                       r_tgs00024  region
#> 205                         tps00157 country
#> 206                         tps00178 country
#> 207                       r_tgs00096  region
#> 208                 tps00017_agemoth country
#> 209                tps00017_agemoth1 country
#> 210                         tps00199 country
#> 211                       r_tgs00100  region
#> 212                       tps00205_f country
#> 213                       tps00205_m country
#> 214                       tps00205_t country
#> 215                         tps00027 country
#> 216                     r_tgs00101_f  region
#> 217                     r_tgs00101_m  region
#> 218                     r_tgs00101_t  region
#> 219                         tps00206 country
#> 220                tps00014_fagemar1 country
#> 221                tps00014_magemar1 country
#> 222                         tps00216 country
#> 223                 tps00176_complet country
#> 224                   tps00176_reach country
#> 225                 tps00177_complet country
#> 226                   tps00177_reach country
#> 227                 tps00024_complet country
#> 228                   tps00024_reach country
#> 229                         tps00194 country
#> 230                    tps00191_frst country
#> 231                    tps00191_sseq country
#> 232                   tps00191_total country
#> 233                     tps00192_neg country
#> 234                     tps00192_pos country
#> 235                 tps00192_pos_hum country
#> 236                 tps00192_pos_rfg country
#> 237               tps00192_pos_sprot country
#> 238                   tps00192_total country
#> 239                     tps00193_neg country
#> 240                     tps00193_pos country
#> 241                 tps00193_pos_hum country
#> 242                 tps00193_pos_rfg country
#> 243               tps00193_pos_sprot country
#> 244                   tps00193_total country
#> 245                         tps00195 country
#> 246                    tps00170_educ country
#> 247                     tps00170_emp country
#> 248                     tps00170_fam country
#> 249                     tps00170_oth country
#> 250                   tps00170_total country
#> 251                    tps00171_educ country
#> 252                     tps00171_fam country
#> 253                     tps00171_oth country
#> 254                   tps00171_total country
#> 255                       tps00150_f country
#> 256                       tps00150_m country
#> 257                       tps00150_t country
#> 258                      sdg_03_12_f country
#> 259                      sdg_03_12_m country
#> 260                      sdg_03_12_t country
#> 261                 tps00214_eur_hab country
#> 262                 tps00214_mio_eur country
#> 263                 tps00214_mio_pps country
#> 264                  tps00214_pc_che country
#> 265                  tps00214_pc_gdp country
#> 266                 tps00214_pps_hab country
#> 267                 tps00207_eur_hab country
#> 268                 tps00207_mio_eur country
#> 269                 tps00207_mio_pps country
#> 270                  tps00207_pc_che country
#> 271                  tps00207_pc_gdp country
#> 272                 tps00207_pps_hab country
#> 273                         tps00046 country
#> 274                         tps00044 country
#> 275                         tps00045 country
#> 276                         tps00167 country
#> 277                       tps00048_i country
#> 278                       tps00048_j country
#> 279                       tps00048_m country
#> 280                       tps00048_o country
#> 281                       tps00149_f country
#> 282                       tps00149_m country
#> 283                       tps00149_t country
#> 284                       tps00146_f country
#> 285                       tps00146_m country
#> 286                       tps00146_t country
#> 287                       tps00143_f country
#> 288                       tps00143_m country
#> 289                       tps00143_t country
#> 290                       tps00125_f country
#> 291                       tps00125_m country
#> 292                       tps00125_t country
#> 293                       tps00116_f country
#> 294                       tps00116_m country
#> 295                       tps00116_t country
#> 296                       tps00128_f country
#> 297                       tps00128_m country
#> 298                       tps00128_t country
#> 299                  tps00202_y_ge85 country
#> 300                  tps00202_y15_19 country
#> 301                  tps00202_y50_54 country
#> 302                       r_tgs00061  region
#> 303                       r_tgs00058  region
#> 304                       r_tgs00059  region
#> 305                       r_tgs00057  region
#> 306                       r_tgs00060  region
#> 307                     sdg_11_52_nr country
#> 308                     sdg_11_52_rt country
#> 309                  dsb_sprpb01_dis country
#> 310              dsb_sprpb01_dis_tot country
#> 311                 dsb_sprpb01_errc country
#> 312                    dsb_sprpb02_f country
#> 313                    dsb_sprpb02_m country
#> 314                    dsb_sprpb02_t country
#> 315                tepsr_sp200_f_sev country
#> 316             tepsr_sp200_f_sm_sev country
#> 317               tepsr_sp200_f_some country
#> 318                tepsr_sp200_m_sev country
#> 319             tepsr_sp200_m_sm_sev country
#> 320               tepsr_sp200_m_some country
#> 321                tepsr_sp200_t_sev country
#> 322             tepsr_sp200_t_sm_sev country
#> 323               tepsr_sp200_t_some country
#> 324                         tps00217 country
#> 325                       tps00215_f country
#> 326                       tps00215_m country
#> 327                       tps00215_t country
#> 328                   yth_educ_020_f country
#> 329                   yth_educ_020_m country
#> 330                   yth_educ_020_t country
#> 331                   yth_educ_030_f country
#> 332                   yth_educ_030_m country
#> 333                   yth_educ_030_t country
#> 334                       tps00065_f country
#> 335                       tps00065_m country
#> 336                       tps00065_t country
#> 337                       tps00186_f country
#> 338                       tps00186_m country
#> 339                       tps00186_t country
#> 340                  tps00197_y25_34 country
#> 341                  tps00197_y25_64 country
#> 342                  tps00197_y35_44 country
#> 343                  tps00197_y45_54 country
#> 344                  tps00197_y55_64 country
#> 345                     r_tgs00109_f  region
#> 346                     r_tgs00109_m  region
#> 347                     r_tgs00109_t  region
#> 348                   tps00066_ed0_2 country
#> 349                   tps00066_ed3_4 country
#> 350                   tps00066_ed5_8 country
#> 351                       tps00053_f country
#> 352                       tps00053_m country
#> 353                       tps00053_t country
#> 354                        tipslm100 country
#> 355                  tps00073_y15_24 country
#> 356                  tps00073_y15_29 country
#> 357                  tps00073_y15_64 country
#> 358                  tps00073_y20_64 country
#> 359                  tps00073_y25_54 country
#> 360                  tps00073_y55_64 country
#> 361                  tps00159_y15_64 country
#> 362                  tps00159_y20_64 country
#> 363                  tps00203_pc_act country
#> 364                  tps00203_pc_pop country
#> 365                 tps00203_ths_per country
#> 366                         tesem090 country
#> 367         sdg_08_30a_eu27_2020_for country
#> 368                   sdg_08_30a_nat country
#> 369        sdg_08_30a_neu27_2020_for country
#> 370                         tesem080 country
#> 371                        tqoe4a3_f country
#> 372                        tqoe4a3_m country
#> 373                        tqoe4a3_t country
#> 374                        tqoe3a5_f country
#> 375                        tqoe3a5_m country
#> 376                        tqoe3a5_t country
#> 377                         tps00071 country
#> 378                       tps00182_f country
#> 379                       tps00182_m country
#> 380                       tps00182_t country
#> 381                         tps00181 country
#> 382                     r_tgs00007_f  region
#> 383                     r_tgs00007_m  region
#> 384                     r_tgs00007_t  region
#> 385               tps00173_d1_d4_md5 country
#> 386                     tps00173_d11 country
#> 387              tps00173_d12_d4_md5 country
#> 388           tps00173_d2_d4_md5_rat country
#> 389               sdg_01_10_total_pc country
#> 390          sdg_01_10_total_ths_per country
#> 391              sdg_01_10_y_lt18_pc country
#> 392         sdg_01_10_y_lt18_ths_per country
#> 393                  ilc_pns4_y_ge65 country
#> 394                  ilc_pns4_y_lt65 country
#> 395                         tessi191 country
#> 396                       tps00184_f country
#> 397                       tps00184_m country
#> 398                       tps00184_t country
#> 399                ilc_pns6_y_ge18_f country
#> 400                ilc_pns6_y_ge18_m country
#> 401                ilc_pns6_y_ge18_t country
#> 402                ilc_pns6_y_ge65_f country
#> 403                ilc_pns6_y_ge65_m country
#> 404                ilc_pns6_y_ge65_t country
#> 405                  ilc_pns5_y_ge65 country
#> 406                  ilc_pns5_y_ge75 country
#> 407                   tps00185_sc101 country
#> 408                   tps00185_sc102 country
#> 409                   tps00185_sc103 country
#> 410                   tps00185_sc111 country
#> 411                   tps00185_sc112 country
#> 412                   tps00185_sc113 country
#> 413                       r_tgs00104  region
#> 414                 sdg_05_11_y18_29 country
#> 415                 sdg_05_11_y18_74 country
#> 416                 sdg_05_11_y30_44 country
#> 417                 sdg_05_11_y45_64 country
#> 418                 sdg_05_11_y65_74 country
#> 419                     tps00101_adm country
#> 420                     tps00101_oth country
#> 421                     tps00101_spr country
#> 422                         tps00099 country
#> 423                         tps00098 country
#> 424                         tps00100 country
#> 425                         tps00103 country
#> 426                     tps00083_dis country
#> 427                    tps00083_excl country
#> 428                     tps00083_fam country
#> 429                     tps00083_hou country
#> 430                     tps00083_old country
#> 431                    tps00083_sick country
#> 432                     tps00083_srv country
#> 433                   tps00083_total country
#> 434                     tps00083_une country
#> 435                     tps00082_dis country
#> 436                    tps00082_excl country
#> 437                     tps00082_fam country
#> 438                     tps00082_hou country
#> 439                     tps00082_old country
#> 440                    tps00082_sick country
#> 441                     tps00082_srv country
#> 442                   tps00082_total country
#> 443                     tps00082_une country
#> 444                 tps00108_gov_gen country
#> 445                 tps00108_rec_oth country
#> 446                tps00108_sco_empl country
#> 447             tps00108_sco_per_pro country
#> 448                   sdg_16_70_f_nr country
#> 449              sdg_16_70_f_p_hthab country
#> 450                   sdg_16_70_m_nr country
#> 451              sdg_16_70_m_p_hthab country
#> 452                   sdg_16_70_t_nr country
#> 453              sdg_16_70_t_p_hthab country
#> 454                     tin00175_dom country
#> 455                     tin00175_for country
#> 456                   tin00175_total country
#> 457                    tin00177_i551 country
#> 458               tin00177_i551_i553 country
#> 459                    tin00177_i552 country
#> 460               tin00177_i552_i553 country
#> 461                    tin00177_i553 country
#> 462                     tin00176_eur country
#> 463                   tin00176_world country
#> 464                     tin00174_dom country
#> 465                     tin00174_for country
#> 466                   tin00174_total country
#> 467                   tin00180_bedpl country
#> 468                   tin00180_bedrm country
#> 469                   tin00181_bedpl country
#> 470                   tin00181_estbl country
#> 471                    tin00182_i551 country
#> 472               tin00182_i551_i553 country
#> 473                    tin00182_i552 country
#> 474               tin00182_i552_i553 country
#> 475                    tin00182_i553 country
#> 476                 r_tgs00112_bedpl  region
#> 477                 r_tgs00112_estbl  region
#> 478                  tin00187_y_ge15 country
#> 479                  tin00187_y_ge65 country
#> 480                  tin00187_y15_24 country
#> 481                  tin00187_y25_34 country
#> 482                  tin00187_y25_44 country
#> 483                  tin00187_y35_44 country
#> 484                  tin00187_y45_54 country
#> 485                  tin00187_y45_64 country
#> 486                  tin00187_y55_64 country
#> 487                   tin00186_n_ge1 country
#> 488                   tin00186_n_ge4 country
#> 489                    tin00186_n1_3 country
#> 490                   tin00185_n_ge1 country
#> 491                   tin00185_n_ge4 country
#> 492                    tin00185_n1_3 country
#> 493                     tin00188_per country
#> 494                 tin00188_per_hol country
#> 495                 tin00188_per_oth country
#> 496                 tin00188_per_vfr country
#> 497                    tin00188_prof country
#> 498                   tin00188_total country
#> 499                   tin00189_n_ge1 country
#> 500                   tin00189_n_ge4 country
#> 501                    tin00189_n1_3 country
#> 502                  tin00189_n15_28 country
#> 503                  tin00189_n29_91 country
#> 504                    tin00189_n4_7 country
#> 505                   tin00189_n8_14 country
#> 506                     tin00191_per country
#> 507                 tin00191_per_hol country
#> 508                 tin00191_per_oth country
#> 509                 tin00191_per_vfr country
#> 510                    tin00191_prof country
#> 511                   tin00191_total country
#> 512                   tin00192_n_ge1 country
#> 513                   tin00192_n_ge4 country
#> 514                    tin00192_n1_3 country
#> 515                  tin00192_n15_28 country
#> 516                  tin00192_n29_91 country
#> 517                    tin00192_n4_7 country
#> 518                   tin00192_n8_14 country
#> 519                         tin00196 country
#> 520                         tin00195 country
#> 521                     tai03_uaa_ib country
#> 522                     tai03_uaa_it country
#> 523                         tag00127 country
#> 524                 tag00128_hld_grp country
#> 525                 tag00128_per_leg country
#> 526                 tag00128_per_ntl country
#> 527                   tag00128_total country
#> 528                tag00128_unit_cml country
#> 529                     tag00007_ara country
#> 530                      tag00007_fa country
#> 531                  tag00007_j0000t country
#> 532                    tag00007_pecr country
#> 533                     tag00007_uaa country
#> 534           tag00007_uaaxk0000_org country
#> 535                        tai05_ara country
#> 536                     tai05_j0000t country
#> 537                       tai05_pecr country
#> 538              tag00124_a0010x1000 country
#> 539                   tag00124_a2000 country
#> 540                   tag00124_a3100 country
#> 541                   tag00124_a4100 country
#> 542                   tag00124_a4200 country
#> 543                   tag00124_a5000 country
#> 544                   tag00124_a6111 country
#> 545                  tag00124_a6710r country
#> 546                     tag00125_nap country
#> 547                   tag00125_total country
#> 548                  tag00125_y_ge65 country
#> 549                  tag00125_y_lt25 country
#> 550                  tag00125_y25_34 country
#> 551                  tag00125_y35_39 country
#> 552                  tag00125_y40_44 country
#> 553                  tag00125_y45_54 country
#> 554                  tag00125_y55_64 country
#> 555                 tag00020_flf_d_r country
#> 556          tag00020_flf_d_rfam_hld country
#> 557          tag00020_flf_d_rfamxhld country
#> 558             tag00020_flf_d_rnfam country
#> 559             tag00020_flf_manxgrp country
#> 560                   tag00020_total country
#> 561                  tag00102_prd_bp country
#> 562                  tag00102_prd_pp country
#> 563                  tag00056_prd_bp country
#> 564                  tag00056_prd_pp country
#> 565                  tag00055_prd_bp country
#> 566                  tag00055_prd_pp country
#> 567                         tag00057 country
#> 568                         tag00062 country
#> 569                         tag00060 country
#> 570                         tag00064 country
#> 571                         tag00063 country
#> 572                         tag00059 country
#> 573                         tag00061 country
#> 574                         tag00068 country
#> 575                         tag00071 country
#> 576                         tag00069 country
#> 577                         tag00067 country
#> 578                         tag00066 country
#> 579                         tag00070 country
#> 580                         tag00065 country
#> 581                      tag00052_ni country
#> 582                      tag00052_ri country
#> 583                      tag00048_ni country
#> 584                      tag00048_ri country
#> 585                      tag00046_ni country
#> 586                      tag00046_ri country
#> 587                      tag00050_ni country
#> 588                      tag00050_ri country
#> 589                         tag00038 country
#> 590                         tag00040 country
#> 591                         tag00037 country
#> 592                         tag00039 country
#> 593                         tag00041 country
#> 594                       r_tgs00046  region
#> 595                         tag00045 country
#> 596                         tag00044 country
#> 597                         tag00043 country
#> 598                         tag00042 country
#> 599                         tag00014 country
#> 600                         tag00016 country
#> 601                         tag00018 country
#> 602                         tag00017 country
#> 603                 r_tgs00045_a2000  region
#> 604                r_tgs00045_a2300f  region
#> 605                 r_tgs00045_a3100  region
#> 606                 r_tgs00045_a4100  region
#> 607                 r_tgs00045_a4200  region
#> 608                     tag00025_ara country
#> 609                   tag00025_j0000 country
#> 610                   tag00025_k0000 country
#> 611                    tag00025_pecr country
#> 612                     tag00025_uaa country
#> 613                            tai04 country
#> 614             tag00115_v0000_s0000 country
#> 615                   tag00115_v3100 country
#> 616                   tag00115_v3200 country
#> 617                   tag00115_v4100 country
#> 618                   tag00115_v4210 country
#> 619                   tag00120_f1110 country
#> 620                   tag00120_f1120 country
#> 621                   tag00120_f1240 country
#> 622                   tag00120_h0000 country
#> 623                   tag00120_t1000 country
#> 624               tag00047_ar_ths_ha country
#> 625      tag00047_hprd_humd_eu_ths_t country
#> 626              tag00047_humd_eu_pc country
#> 627                   tag00100_i1110 country
#> 628                   tag00100_i1120 country
#> 629                   tag00100_i1130 country
#> 630                   tag00103_g1000 country
#> 631                   tag00103_g2000 country
#> 632                   tag00103_g9100 country
#> 633                   tag00103_r1000 country
#> 634                   tag00103_r2000 country
#> 635               tag00101_ar_ths_ha country
#> 636      tag00101_hprd_humd_eu_ths_t country
#> 637              tag00101_humd_eu_pc country
#> 638               tag00051_ar_ths_ha country
#> 639      tag00051_hprd_humd_eu_ths_t country
#> 640              tag00051_humd_eu_pc country
#> 641               tag00094_ar_ths_ha country
#> 642      tag00094_hprd_humd_eu_ths_t country
#> 643              tag00094_humd_eu_pc country
#> 644               tag00053_ar_ths_ha country
#> 645      tag00053_hprd_humd_eu_ths_t country
#> 646              tag00053_humd_eu_pc country
#> 647               tag00027_ar_ths_ha country
#> 648      tag00027_hprd_humd_eu_ths_t country
#> 649              tag00027_humd_eu_pc country
#> 650                   tag00121_w1000 country
#> 651                   tag00121_w1100 country
#> 652                   tag00121_w1200 country
#> 653                   tag00121_w1300 country
#> 654               tag00093_ar_ths_ha country
#> 655      tag00093_hprd_humd_eu_ths_t country
#> 656              tag00093_humd_eu_pc country
#> 657                   tag00122_o1100 country
#> 658                   tag00122_o1910 country
#> 659               tag00049_ar_ths_ha country
#> 660      tag00049_hprd_humd_eu_ths_t country
#> 661              tag00049_humd_eu_pc country
#> 662                   tai10_clc2_321 country
#> 663                  tai10_clc23_321 country
#> 664                    tai10_clc2x23 country
#> 665                   tai11_clc2_321 country
#> 666                  tai11_clc23_321 country
#> 667                    tai11_clc2x23 country
#> 668                         tag00076 country
#> 669                         tag00116 country
#> 670                         tag00083 country
#> 671                     tag00075_eur country
#> 672                   tag00075_eur_t country
#> 673                     tag00075_tlw country
#> 674               tet00037_pc_exp_eu country
#> 675               tet00037_pc_imp_eu country
#> 676                tet00001_ivol_exp country
#> 677                tet00001_ivol_imp country
#> 678                 tet00001_rt_ivol country
#> 679                 tet00028_ivu_exp country
#> 680                 tet00028_ivu_imp country
#> 681                  tet00028_rt_ivu country
#> 682             tet00002_mio_bal_val country
#> 683             tet00002_mio_exp_val country
#> 684             tet00002_mio_imp_val country
#> 685             tet00038_mio_bal_val country
#> 686             tet00038_mio_exp_val country
#> 687             tet00038_mio_imp_val country
#> 688             tet00011_cont_exp_eu country
#> 689             tet00011_cont_imp_eu country
#> 690             tet00011_mio_bal_val country
#> 691             tet00011_mio_exp_val country
#> 692             tet00011_mio_imp_val country
#> 693             tet00012_cont_exp_eu country
#> 694             tet00012_cont_imp_eu country
#> 695             tet00012_mio_bal_val country
#> 696             tet00012_mio_exp_val country
#> 697             tet00012_mio_imp_val country
#> 698                         ttr00012 country
#> 699                         ttr00011 country
#> 700                       r_tgs00077  region
#> 701                       r_tgs00078  region
#> 702                 ttr00007_mio_tkm country
#> 703                   ttr00007_ths_t country
#> 704                         ttr00009 country
#> 705                       r_tgs00075  region
#> 706                       r_tgs00076  region
#> 707                         ttr00003 country
#> 708                         ttr00015 country
#> 709                 ttr00006_mio_tkm country
#> 710                   ttr00006_ths_t country
#> 711                    ttr00002_mway country
#> 712                  ttr00002_rd_eur country
#> 713                 ttr00005_mio_tkm country
#> 714                   ttr00005_ths_t country
#> 715                    r_tgs00113_km  region
#> 716               r_tgs00113_km_tkm2  region
#> 717                    r_tgs00114_km  region
#> 718               r_tgs00114_km_tkm2  region
#> 719                    sdg_09_60_iww country
#> 720                   sdg_09_60_rail country
#> 721           sdg_09_60_rail_iww_avd country
#> 722                sdg_09_50_bus_tot country
#> 723                    sdg_09_50_trn country
#> 724        sdg_09_50_trn_bus_tot_avd country
#> 725                         ttr00001 country
#> 726                       cei_gsr011 country
#> 727                            tai07 country
#> 728                        tai08_ch4 country
#> 729                   tai08_ch4_co2e country
#> 730                        tai08_co2 country
#> 731                        tai08_ghg country
#> 732                        tai08_n2o country
#> 733                   tai08_n2o_co2e country
#> 734                         ten00137 country
#> 735                  ten00141_pc_gdp country
#> 736          ten00141_pc_tsco_x_isco country
#> 737                         ten00139 country
#> 738                 ten00136_mio_eur country
#> 739                  ten00136_pc_gdp country
#> 740             sdg_12_61_clv20_meur country
#> 741                 sdg_12_61_pc_gdp country
#> 742                   ten00108_total country
#> 743                     ten00108_w11 country
#> 744                   ten00110_total country
#> 745                     ten00110_w11 country
#> 746                    sdg_12_51_haz country
#> 747               sdg_12_51_haz_nhaz country
#> 748                   sdg_12_51_nhaz country
#> 749                         ten00138 country
#> 750                        cei_pc035 country
#> 751                   ten00062_w1501 country
#> 752                 ten00062_w150101 country
#> 753                 ten00062_w150102 country
#> 754                 ten00062_w150103 country
#> 755                 ten00062_w150104 country
#> 756                 ten00062_w150107 country
#> 757                 ten00062_w150199 country
#> 758                   ten00063_w1501 country
#> 759                 ten00063_w150101 country
#> 760                 ten00063_w150102 country
#> 761                 ten00063_w150103 country
#> 762                 ten00063_w150104 country
#> 763                 ten00063_w150107 country
#> 764                 ten00006_abs_agr country
#> 765              ten00006_abs_elc_cl country
#> 766                 ten00006_abs_ind country
#> 767              ten00006_abs_ind_cl country
#> 768                 ten00006_abs_pws country
#> 769                    ten00006_abst country
#> 770                     ten00003_fgw country
#> 771                     ten00003_frw country
#> 772                     ten00003_fsw country
#> 773                     ten00030_sld country
#> 774                 ten00030_sld_agr country
#> 775                ten00030_sld_comp country
#> 776                ten00030_sld_incn country
#> 777                ten00030_sld_land country
#> 778                 ten00030_sld_oth country
#> 779                     ten00030_slp country
#> 780                  sdg_12_21_t_hab country
#> 781                  sdg_12_21_ths_t country
#> 782                        cei_pc020 country
#> 783                    ten00124_fc_e country
#> 784                ten00124_fc_ind_e country
#> 785             ten00124_fc_oth_cp_e country
#> 786             ten00124_fc_oth_hh_e country
#> 787                ten00124_fc_tra_e country
#> 788                        sdg_07_20 country
#> 789                    sdg_07_40_ren country
#> 790                sdg_07_40_ren_elc country
#> 791            sdg_07_40_ren_heat_cl country
#> 792                sdg_07_40_ren_tra country
#> 793                    sdg_07_11_i05 country
#> 794                   sdg_07_11_mtoe country
#> 795                sdg_07_11_toe_hab country
#> 796                    sdg_07_10_i05 country
#> 797                   sdg_07_10_mtoe country
#> 798                sdg_07_10_toe_hab country
#> 799               sdg_07_30_eur_kgoe country
#> 800               sdg_07_30_pps_kgoe country
#> 801        sdg_07_50_c0000x0350_0370 country
#> 802                  sdg_07_50_g3000 country
#> 803              sdg_07_50_o4000xbio country
#> 804                  sdg_07_50_total country
#> 805                 isoc_env_ict_nrg country
#> 806                     tsc00001_bes country
#> 807                     tsc00001_gov country
#> 808                     tsc00001_hes country
#> 809                     tsc00001_pnp country
#> 810                   tsc00001_total country
#> 811                       r_tgs00042  region
#> 812                     tsc00003_bes country
#> 813                     tsc00003_gov country
#> 814                     tsc00003_hes country
#> 815                     tsc00003_pnp country
#> 816                   tsc00003_total country
#> 817                     tsc00004_bes country
#> 818                     tsc00004_gov country
#> 819                     tsc00004_hes country
#> 820                     tsc00004_pnp country
#> 821                   tsc00004_total country
#> 822                     tsc00002_bes country
#> 823                     tsc00002_gov country
#> 824                     tsc00002_hes country
#> 825                     tsc00002_pnp country
#> 826                   tsc00002_total country
#> 827                       r_tgs00043  region
#> 828                         tsc00006 country
#> 829                     tsc00005_bes country
#> 830                     tsc00005_gov country
#> 831                     tsc00005_hes country
#> 832                     tsc00005_pnp country
#> 833                   tsc00005_total country
#> 834                  tsc00008_nabs14 country
#> 835                   tsc00008_total country
#> 836            tsc00008_totalxnabs14 country
#> 837                         tin00140 country
#> 838                tsc00011_c_htc_mh country
#> 839                     tsc00011_kis country
#> 840                       r_tgs00039  region
#> 841                       tsc00025_f country
#> 842                       tsc00025_m country
#> 843                       tsc00025_t country
#> 844                       r_tgs00038  region
#> 845                sdg_09_40_appl_nr country
#> 846            sdg_09_40_appl_p_mhab country
#> 847                sdg_09_40_invt_nr country
#> 848            sdg_09_40_invt_p_mhab country
#> 849                         tin00134 country
#> 850                 tin00028_i_ilt12 country
#> 851                   tin00028_i_iu3 country
#> 852                 tin00028_i_iuevr country
#> 853                   tin00028_i_iux country
#> 854                         tin00093 country
#> 855                         tin00092 country
#> 856                         tin00091 country
#> 857                         tin00101 country
#> 858                         tin00102 country
#> 859                         tin00127 country
#> 860                         tin00098 country
#> 861                         tin00095 country
#> 862                         tin00103 country
#> 863                         tin00094 country
#> 864                         tin00099 country
#> 865                  tin00096_pc_ind country
#> 866            tin00096_pc_ind_ilt12 country
#> 867                       r_tgs00050  region
#> 868                       r_tgs00052  region
#> 869                         tin00111 country
#> 870                         tin00110 country
#> 871                         tin00116 country
#> 872                   tin00074_c_ict country
#> 873                 tin00074_g_u_ict country
#> 874                     tin00074_ict country
#> 875                   tin00085_c_ict country
#> 876                 tin00085_g_u_ict country
#> 877                     tin00085_ict country
#> 878                   tin00086_c_ict country
#> 879                 tin00086_g_u_ict country
#> 880                     tin00086_ict country
#> 881                   sdg_17_60_deg3 country
#> 882                  sdg_17_60_total country
#> 883                       r_tgs00006  region
#> 884               r_tgs00003_mio_eur  region
#> 885     r_tgs00003_mio_pps_eu27_2020  region
#> 886               r_tgs00037_b1g_i20  region
#> 887           r_tgs00037_b1g_pch_pre  region
#> 888              r_tgs00037_b1gq_i20  region
#> 889          r_tgs00037_b1gq_pch_pre  region
#> 890                       tps00134_f country
#> 891                       tps00134_m country
#> 892                       tps00134_t country
#> 893                       tps00165_f country
#> 894                       tps00165_m country
#> 895                       tps00165_t country
#> 896                       tps00122_f country
#> 897                       tps00122_m country
#> 898                       tps00122_t country
#> 899                       tps00152_f country
#> 900                       tps00152_m country
#> 901                       tps00152_t country
#> 902                       tps00131_f country
#> 903                       tps00131_m country
#> 904                       tps00131_t country
#> 905                       tps00140_f country
#> 906                       tps00140_m country
#> 907                       tps00140_t country
#> 908                       tps00137_f country
#> 909                       tps00137_m country
#> 910                       tps00137_t country
#> 911                       tps00119_f country
#> 912                       tps00119_m country
#> 913                       tps00119_t country
#> 914            sdg_03_41_a15_a19_b90 country
#> 915           sdg_03_41_b15_b19_b942 country
#> 916                sdg_03_41_b20_b24 country
#> 917                  sdg_03_41_total country
#> 918                      sdg_16_10_f country
#> 919                      sdg_16_10_m country
#> 920                      sdg_16_10_t country
#> 921                       r_tgs00064  region
#> 922                   r_tgs00111_dom  region
#> 923                   r_tgs00111_for  region
#> 924                 r_tgs00111_total  region
#> 925                       r_tgs00047  region
#> 926                       r_tgs00107  region
#> 927                       tespm050_r country
#> 928                     r_tespm050_r  region
#> 929                  sdg_01_10a_deg1 country
#> 930                  sdg_01_10a_deg2 country
#> 931                  sdg_01_10a_deg3 country
#> 932                tepsr_lm440_own_l country
#> 933             tepsr_lm440_rent_mkt country
#> 934                 tepsr_lm230_deg1 country
#> 935                 tepsr_lm230_deg2 country
#> 936                 tepsr_lm230_deg3 country
#> 937                  tepsr_lm230_nrp country
#> 938                tepsr_lm230_total country
#> 939             tepsr_sp410_f_y16_74 country
#> 940            tepsr_sp410_ind_total country
#> 941             tepsr_sp410_m_y16_74 country
#> 942               sdg_04_70_f_y16_74 country
#> 943              sdg_04_70_ind_total country
#> 944               sdg_04_70_m_y16_74 country
#> 945                         tipsbp10 country
#> 946                         tipsii10 country
#> 947              tipsbp60_pc_oecd_eu country
#> 948          tipsbp60_pch_oecd_eu_1y country
#> 949          tipsbp60_pch_oecd_eu_3y country
#> 950          tipsbp60_pch_oecd_eu_5y country
#> 951              tipsbp60_pch_wrl_1y country
#> 952                         tipsgo10 country
#> 953                         tipspd22 country
#> 954                  tipsun20_y15_24 country
#> 955                  tipsun20_y15_74 country
#> 956                  tipsun20_y25_74 country
#> 957                  tipslm60_pc_pop country
#> 958                 tipslm60_ppch_3y country
#> 959                         tipsbp20 country
#> 960                      tipsbp11_ca country
#> 961                       tipsbp11_g country
#> 962                      tipsbp11_gs country
#> 963                     tipsbp11_in1 country
#> 964                     tipsbp11_in2 country
#> 965                       tipsbp11_s country
#> 966                      tipsbp12_ca country
#> 967                       tipsbp12_g country
#> 968                      tipsbp12_gs country
#> 969                     tipsbp12_in1 country
#> 970                     tipsbp12_in2 country
#> 971                       tipsbp12_s country
#> 972                      tipsbp13_ca country
#> 973                       tipsbp13_g country
#> 974                      tipsbp13_gs country
#> 975                     tipsbp13_in1 country
#> 976                     tipsbp13_in2 country
#> 977                       tipsbp13_s country
#> 978                         tipsbp18 country
#> 979                         tipsbp90 country
#> 980                        tipsbp100 country
#> 981                         tipsbp17 country
#> 982                         tipsbp70 country
#> 983                     tipser11_i15 country
#> 984                  tipser11_pch_1y country
#> 985                  tipser11_pch_3y country
#> 986                 tipslm50_pch_10y country
#> 987                  tipslm50_pch_1y country
#> 988                     tipser12_i15 country
#> 989                  tipser12_pch_1y country
#> 990                  tipser12_pch_3y country
#> 991                     tipser13_i15 country
#> 992                     tipser13_i20 country
#> 993                         tipsii20 country
#> 994                         tipsii50 country
#> 995                       tipsex11_g country
#> 996                      tipsex11_gs country
#> 997                       tipsex11_s country
#> 998                       tipsex20_g country
#> 999                      tipsex20_gs country
#> 1000                      tipsex20_s country
#> 1001                      tipsex10_g country
#> 1002                     tipsex10_gs country
#> 1003                      tipsex10_s country
#> 1004                        tipsex12 country
#> 1005                 tipsfs10_pc_gdp country
#> 1006                tipsfs10_pch_pre country
#> 1007                    tipsfs11_s12 country
#> 1008                   tipsfs11_s121 country
#> 1009         tipsfs11_s121_s122_s123 country
#> 1010              tipsfs11_s122_s123 country
#> 1011                   tipsfs11_s124 country
#> 1012                   tipsfs11_s125 country
#> 1013         tipsfs11_s125_s126_s127 country
#> 1014                     tipsfs13_f2 country
#> 1015                  tipsfs13_f2_f8 country
#> 1016                     tipsfs13_f3 country
#> 1017                     tipsfs13_f4 country
#> 1018                     tipsfs13_f5 country
#> 1019                     tipsfs13_f6 country
#> 1020                     tipsfs13_f7 country
#> 1021                     tipsfs13_f8 country
#> 1022                        tipsfs20 country
#> 1023                 tipsfs30_pc_gdp country
#> 1024                tipsfs30_pch_pre country
#> 1025                    tipsfs31_s12 country
#> 1026                   tipsfs31_s121 country
#> 1027         tipsfs31_s121_s122_s123 country
#> 1028              tipsfs31_s122_s123 country
#> 1029                   tipsfs31_s124 country
#> 1030                   tipsfs31_s125 country
#> 1031         tipsfs31_s125_s126_s127 country
#> 1032                     tipsfs33_f2 country
#> 1033                  tipsfs33_f2_f8 country
#> 1034                     tipsfs33_f3 country
#> 1035                     tipsfs33_f4 country
#> 1036                     tipsfs33_f5 country
#> 1037                     tipsfs33_f6 country
#> 1038                     tipsfs33_f7 country
#> 1039                     tipsfs33_f8 country
#> 1040                    tipspd13_s11 country
#> 1041                    tipspd13_s14 country
#> 1042                    tipspd13_s15 country
#> 1043                    tipspd15_s11 country
#> 1044                    tipspd15_s14 country
#> 1045                    tipspd15_s15 country
#> 1046                        tipspd20 country
#> 1047                    tipspd23_s11 country
#> 1048                    tipspd23_s14 country
#> 1049                    tipspd23_s15 country
#> 1050                    tipspd25_s11 country
#> 1051                    tipspd25_s14 country
#> 1052                    tipspd25_s15 country
#> 1053                    tipspc13_s11 country
#> 1054                    tipspc13_s14 country
#> 1055                    tipspc13_s15 country
#> 1056                    tipspc15_s11 country
#> 1057                    tipspc15_s14 country
#> 1058                    tipspc15_s15 country
#> 1059                        tipspc20 country
#> 1060                    tipspc23_s11 country
#> 1061                    tipspc23_s14 country
#> 1062                    tipspc23_s15 country
#> 1063                    tipspc25_s11 country
#> 1064                    tipspc25_s14 country
#> 1065                    tipspc25_s15 country
#> 1066                        tipsun10 country
#> 1067                 tipslm70_pc_act country
#> 1068                tipslm70_ppch_3y country
#> 1069                 tipslm80_pc_act country
#> 1070                tipslm80_ppch_3y country
#> 1071                 tipslm90_pc_pop country
#> 1072                tipslm90_ppch_3y country
#> 1073                        tipslm15 country
#> 1074                        tipslm16 country
#> 1075                     tipslc10_pc country
#> 1076                tipslc10_ppch_3y country
#> 1077                     tipslc20_pc country
#> 1078                tipslc20_ppch_3y country
#> 1079                     tipslc30_pc country
#> 1080                tipslc30_ppch_3y country
#> 1081                     tipslc40_pc country
#> 1082                tipslc40_ppch_3y country
#> 1083                        tipsst10 country
#> 1084                teina200_mio_eur country
#> 1085                 teina200_pc_gdp country
#> 1086                teina210_mio_eur country
#> 1087                 teina210_pc_gdp country
#> 1088                teina225_mio_eur country
#> 1089                 teina225_pc_gdp country
#> 1090          cei_pc030_eur_kg_clv15 country
#> 1091                   cei_pc030_i00 country
#> 1092                cei_pc030_pps_kg country
#> 1093                       cei_pc034 country
#> 1094                       cei_pc031 country
#> 1095                       cei_pc040 country
#> 1096                       cei_pc050 country
#> 1097                       cei_wm010 country
#> 1098                 cei_wm020_w1501 country
#> 1099               cei_wm020_w150101 country
#> 1100               cei_wm020_w150102 country
#> 1101               cei_wm020_w150103 country
#> 1102               cei_wm020_w150104 country
#> 1103               cei_wm020_w150107 country
#> 1104                      cei_srm030 country
#> 1105                       sdg_12_31 country
#> 1106                      cei_gsr030 country
#> 1107                    sdg_01_20_pc country
#> 1108               sdg_01_20_ths_per country
#> 1109        sdg_01_20a_eu27_2020_for country
#> 1110                  sdg_01_20a_nat country
#> 1111       sdg_01_20a_neu27_2020_for country
#> 1112              sdg_01_31_total_pc country
#> 1113         sdg_01_31_total_ths_per country
#> 1114             sdg_01_31_y_lt18_pc country
#> 1115        sdg_01_31_y_lt18_ths_per country
#> 1116             sdg_01_40_y_lt18_pc country
#> 1117            sdg_01_40_y_lt18_ths country
#> 1118             sdg_01_40_y_lt65_pc country
#> 1119            sdg_01_40_y_lt65_ths country
#> 1120                       sdg_01_41 country
#> 1121                  sdg_01_50_a_60 country
#> 1122                  sdg_01_50_b_60 country
#> 1123                 sdg_01_50_total country
#> 1124                     sdg_03_60_f country
#> 1125                     sdg_03_60_m country
#> 1126                     sdg_03_60_t country
#> 1127                       sdg_10_30 country
#> 1128                  sdg_11_11_a_60 country
#> 1129                  sdg_11_11_b_60 country
#> 1130                 sdg_11_11_total country
#> 1131              sdg_02_10_bmi_ge25 country
#> 1132              sdg_02_10_bmi_ge30 country
#> 1133              sdg_02_10_bmi25_29 country
#> 1134               sdg_02_20_clv_i20 country
#> 1135         sdg_02_20_clv20_eur_awu country
#> 1136               sdg_02_30_eur_hab country
#> 1137               sdg_02_30_mio_eur country
#> 1138                       sdg_02_40 country
#> 1139                 sdg_02_60_kg_ha country
#> 1140                     sdg_02_60_t country
#> 1141                   sdg_15_50_km2 country
#> 1142                    sdg_15_50_pc country
#> 1143                     sdg_03_20_f country
#> 1144                     sdg_03_20_m country
#> 1145                     sdg_03_20_t country
#> 1146                  sdg_03_42_prvt country
#> 1147                 sdg_03_42_total country
#> 1148                   sdg_03_42_trt country
#> 1149                     sdg_08_60_f country
#> 1150                     sdg_08_60_m country
#> 1151                     sdg_08_60_t country
#> 1152                  sdg_11_20_a_60 country
#> 1153                  sdg_11_20_b_60 country
#> 1154                 sdg_11_20_total country
#> 1155               sdg_11_40_mway_nr country
#> 1156               sdg_11_40_mway_rt country
#> 1157             sdg_11_40_rd_rur_nr country
#> 1158             sdg_11_40_rd_rur_rt country
#> 1159             sdg_11_40_rd_urb_nr country
#> 1160             sdg_11_40_rd_urb_rt country
#> 1161              sdg_11_40_total_nr country
#> 1162              sdg_11_40_total_rt country
#> 1163                sdg_11_40_unk_nr country
#> 1164                sdg_11_40_unk_rt country
#> 1165                     sdg_04_10_f country
#> 1166                     sdg_04_10_m country
#> 1167                     sdg_04_10_t country
#> 1168        sdg_04_10a_eu27_2020_for country
#> 1169                  sdg_04_10a_nat country
#> 1170       sdg_04_10a_neu27_2020_for country
#> 1171                     sdg_04_20_f country
#> 1172                     sdg_04_20_m country
#> 1173                     sdg_04_20_t country
#> 1174                     sdg_04_31_f country
#> 1175                     sdg_04_31_m country
#> 1176                     sdg_04_31_t country
#> 1177                 sdg_04_40_ef461 country
#> 1178                  sdg_04_40_read country
#> 1179                   sdg_04_40_sci country
#> 1180                     sdg_04_60_f country
#> 1181                     sdg_04_60_m country
#> 1182                     sdg_04_60_t country
#> 1183                       sdg_05_20 country
#> 1184                   sdg_05_30_emp country
#> 1185                sdg_05_30_emp_pt country
#> 1186              sdg_05_30_emp_temp country
#> 1187               sdg_05_30_uemp_pt country
#> 1188        sdg_05_40_f_pc_inac_wwrk country
#> 1189              sdg_05_40_f_pc_pop country
#> 1190        sdg_05_40_m_pc_inac_wwrk country
#> 1191              sdg_05_40_m_pc_pop country
#> 1192        sdg_05_40_t_pc_inac_wwrk country
#> 1193              sdg_05_40_t_pc_pop country
#> 1194                       sdg_06_20 country
#> 1195                  sdg_07_60_a_60 country
#> 1196                  sdg_07_60_b_60 country
#> 1197                 sdg_07_60_total country
#> 1198               sdg_08_11_inv_bsn country
#> 1199               sdg_08_11_inv_gov country
#> 1200                sdg_08_11_inv_hh country
#> 1201               sdg_08_11_inv_tot country
#> 1202                     sdg_08_20_f country
#> 1203                     sdg_08_20_m country
#> 1204                     sdg_08_20_t country
#> 1205        sdg_08_20a_eu27_2020_for country
#> 1206                  sdg_08_20a_nat country
#> 1207       sdg_08_20a_neu27_2020_for country
#> 1208                     sdg_08_30_f country
#> 1209                     sdg_08_30_m country
#> 1210                     sdg_08_30_t country
#> 1211                     sdg_08_40_f country
#> 1212                     sdg_08_40_m country
#> 1213                     sdg_08_40_t country
#> 1214                   sdg_09_10_bes country
#> 1215                   sdg_09_10_gov country
#> 1216                   sdg_09_10_hes country
#> 1217                   sdg_09_10_pnp country
#> 1218                 sdg_09_10_total country
#> 1219                   sdg_09_30_bes country
#> 1220                   sdg_09_30_gov country
#> 1221                   sdg_09_30_hes country
#> 1222                   sdg_09_30_pnp country
#> 1223                 sdg_09_30_total country
#> 1224                  sdg_09_70_pm10 country
#> 1225                 sdg_09_70_pm2_5 country
#> 1226                       sdg_10_41 country
#> 1227                       sdg_10_50 country
#> 1228                  sdg_16_20_a_60 country
#> 1229                  sdg_16_20_b_60 country
#> 1230                 sdg_16_20_total country
#> 1231                   tessi165_deg1 country
#> 1232                   tessi165_deg2 country
#> 1233                   tessi165_deg3 country
#> 1234    sdg_13_40_avg_30y_eur_hab_kp country
#> 1235       sdg_13_40_avg_30y_meur_kp country
#> 1236      sdg_13_40_val_a_eur_hab_kp country
#> 1237         sdg_13_40_val_a_meur_kp country
#> 1238                   sdg_14_10_km2 country
#> 1239                    sdg_14_10_pc country
#> 1240                   sdg_15_20_km2 country
#> 1241                    sdg_15_20_pc country
#> 1242               sdg_17_40_mio_eur country
#> 1243                sdg_17_40_pc_gdp country
#> 1244                       sdg_17_50 country
#> 1245                  sdg_06_10_a_60 country
#> 1246                  sdg_06_10_b_60 country
#> 1247                 sdg_06_10_total country
#> 1248                   r_tepsr_lm220  region
#> 1249                        tespm010 country
#> 1250                        tespm020 country
#> 1251                        tespm030 country
#> 1252                 tespm150_y_ge65 country
#> 1253                 tespm150_y_lt18 country
#> 1254                 tespm150_y18_24 country
#> 1255                 tespm150_y25_49 country
#> 1256                 tespm150_y50_64 country
#> 1257                        tespm151 country
#> 1258                        tespm040 country
#> 1259                      tespm050_f country
#> 1260                      tespm050_m country
#> 1261                      tespm050_t country
#> 1262                        tespm060 country
#> 1263                        tespm070 country
#> 1264                        tesem020 country
#> 1265                        tespm080 country
#> 1266                      r_tespm080  region
#> 1267               tesem150_f_y15_24 country
#> 1268               tesem150_f_y15_29 country
#> 1269               tesem150_m_y15_24 country
#> 1270               tesem150_m_y15_29 country
#> 1271               tesem150_t_y15_24 country
#> 1272               tesem150_t_y15_29 country
#> 1273                        tesem050 country
#> 1274                        tespm090 country
#> 1275                        tespn020 country
#> 1276                        tespm100 country
#> 1277                      tespm110_f country
#> 1278                      tespm110_m country
#> 1279                      tespm110_t country
#> 1280                        tespm120 country
#> 1281                        tespm130 country
#> 1282                        tespm140 country
#> 1283                      tesem030_f country
#> 1284                      tesem030_m country
#> 1285                      tesem030_t country
#> 1286                        tesem040 country
#> 1287                        tesem060 country
#> 1288                        tesem070 country
#> 1289                        tesem100 country
#> 1290                        tesem110 country
#> 1291                      tesem120_f country
#> 1292                      tesem120_m country
#> 1293                      tesem120_t country
#> 1294                      tesem140_f country
#> 1295                      tesem140_m country
#> 1296                      tesem140_t country
#> 1297               tesem190_job_tctr country
#> 1298                tesem190_nf_pjob country
#> 1299                        tesem200 country
#> 1300                        tesem210 country
#> 1301                        tesem220 country
#> 1302                        tesem240 country
#> 1303                  tesov190_a_ge3 country
#> 1304                     tesov190_a1 country
#> 1305               tesov190_a2_2lt65 country
#> 1306                      tesov250_f country
#> 1307                      tesov250_m country
#> 1308                      tesov250_t country
#> 1309                  tesov252_total country
#> 1310                 tesov252_y_ge65 country
#> 1311                 tesov252_y_lt18 country
#> 1312                 tesov252_y18_64 country
#> 1313                   tepsr_lm410_f country
#> 1314                   tepsr_lm410_m country
#> 1315                   tepsr_lm410_t country
#> 1316                      tessi010_f country
#> 1317                      tessi010_m country
#> 1318                      tessi010_t country
#> 1319                  tessi012_total country
#> 1320                 tessi012_y_ge65 country
#> 1321                 tessi012_y_lt18 country
#> 1322                 tessi012_y18_24 country
#> 1323                 tessi012_y25_49 country
#> 1324                 tessi012_y50_64 country
#> 1325                     tessi014_a1 country
#> 1326                     tessi014_a2 country
#> 1327            tessi014_a2_ch2_lt14 country
#> 1328                   tepsr_lm420_f country
#> 1329                   tepsr_lm420_m country
#> 1330                   tepsr_lm420_t country
#> 1331                   tepsr_lm430_f country
#> 1332                   tepsr_lm430_m country
#> 1333                   tepsr_lm430_t country
#> 1334                     tepsr_lm412 country
#> 1335                  tepsr_spi110_f country
#> 1336                  tepsr_spi110_m country
#> 1337                  tepsr_spi110_t country
#> 1338                  tepsr_spi130_f country
#> 1339                  tepsr_spi130_m country
#> 1340                  tepsr_spi130_t country
#> 1341                  tepsr_spi120_f country
#> 1342                  tepsr_spi120_m country
#> 1343                  tepsr_spi120_t country
#> 1344                 tesov016_y_ge16 country
#> 1345                 tesov016_y_ge18 country
#> 1346                 tesov016_y_ge65 country
#> 1347                 tesov016_y_ge75 country
#> 1348                 tesov016_y_lt16 country
#> 1349                 tesov016_y_lt18 country
#> 1350                 tesov016_y16_64 country
#> 1351                      tessi180_f country
#> 1352                      tessi180_m country
#> 1353                      tessi180_t country
#> 1354                      tessi220_f country
#> 1355                      tessi220_m country
#> 1356                      tessi220_t country
#> 1357                  tesov092_total country
#> 1358                 tesov092_y_ge65 country
#> 1359                 tesov092_y_lt18 country
#> 1360                 tesov092_y18_64 country
#> 1361              tepsr_wc110_y15_24 country
#> 1362              tepsr_wc110_y15_64 country
#> 1363              tepsr_wc110_y20_64 country
#> 1364              tepsr_wc110_y25_54 country
#> 1365              tepsr_wc110_y55_64 country
#> 1366                      tesov110_f country
#> 1367                      tesov110_m country
#> 1368                      tesov110_t country
#> 1369                   tepsr_wc130_f country
#> 1370                   tepsr_wc130_m country
#> 1371                   tepsr_wc130_t country
#> 1372              tepsr_wc160_y15_24 country
#> 1373              tepsr_wc160_y15_64 country
#> 1374              tepsr_wc160_y20_64 country
#> 1375              tepsr_wc160_y25_54 country
#> 1376              tepsr_wc160_y55_64 country
#> 1377                      tessi020_f country
#> 1378                      tessi020_m country
#> 1379                      tessi020_t country
#> 1380                  tessi022_total country
#> 1381                 tessi022_y_ge65 country
#> 1382                 tessi022_y_lt18 country
#> 1383                 tessi022_y18_24 country
#> 1384                  tessi030_total country
#> 1385                 tessi030_y_ge65 country
#> 1386                 tessi030_y_lt18 country
#> 1387                 tessi030_y18_64 country
#> 1388                      tessi080_f country
#> 1389                      tessi080_m country
#> 1390                      tessi080_t country
#> 1391                  tessi082_total country
#> 1392                 tessi082_y_ge65 country
#> 1393                 tessi082_y_lt18 country
#> 1394                 tessi082_y18_64 country
#> 1395                  tessi120_total country
#> 1396                 tessi120_y_ge65 country
#> 1397                 tessi120_y_lt18 country
#> 1398                 tessi120_y18_24 country
#> 1399                 tessi120_y25_54 country
#> 1400                 tessi120_y55_64 country
#> 1401                  tessi121_a_ge3 country
#> 1402                     tessi121_a1 country
#> 1403               tessi121_a2_2lt65 country
#> 1404                 tessi122_wi0_02 country
#> 1405               tessi122_wi02_045 country
#> 1406                 tessi122_wi02_1 country
#> 1407              tessi122_wi045_055 country
#> 1408              tessi122_wi055_085 country
#> 1409                tessi122_wi085_1 country
#> 1410                 tessi123_wi0_02 country
#> 1411               tessi123_wi02_045 country
#> 1412                 tessi123_wi02_1 country
#> 1413              tessi123_wi045_055 country
#> 1414              tessi123_wi055_085 country
#> 1415                tessi123_wi085_1 country
#> 1416                    tessi124_emp country
#> 1417               tessi124_inac_oth country
#> 1418                   tessi124_nemp country
#> 1419                    tessi124_pop country
#> 1420                    tessi124_ret country
#> 1421                    tessi124_une country
#> 1422                    tessi125_own country
#> 1423                   tessi125_rent country
#> 1424                  tessi125_total country
#> 1425                   tessi126_b_40 country
#> 1426                   tessi126_b_50 country
#> 1427                   tessi126_b_60 country
#> 1428                   tessi126_b_70 country
#> 1429                        tessi150 country
#> 1430                      tessi160_f country
#> 1431                      tessi160_m country
#> 1432                      tessi160_t country
#> 1433                  tessi161_total country
#> 1434                 tessi161_y_ge65 country
#> 1435                 tessi161_y_lt18 country
#> 1436                 tessi161_y18_64 country
#> 1437                    tessi162_qu1 country
#> 1438                    tessi162_qu2 country
#> 1439                    tessi162_qu3 country
#> 1440                    tessi162_qu4 country
#> 1441                    tessi162_qu5 country
#> 1442                   tessi163_a_60 country
#> 1443                   tessi163_b_60 country
#> 1444                  tessi163_total country
#> 1445                  tessi164_own_l country
#> 1446                 tessi164_own_nl country
#> 1447                tessi164_rent_fr country
#> 1448               tessi164_rent_mkt country
#> 1449                  tessi166_a_ge3 country
#> 1450                     tessi166_a1 country
#> 1451                     tessi166_a2 country
#> 1452                      tessi170_f country
#> 1453                      tessi170_m country
#> 1454                      tessi170_t country
#> 1455                  tessi171_total country
#> 1456                 tessi171_y_ge65 country
#> 1457                 tessi171_y_lt18 country
#> 1458                 tessi171_y18_64 country
#> 1459                   tessi172_a_60 country
#> 1460                   tessi172_b_60 country
#> 1461                  tessi172_total country
#> 1462                  tessi173_own_l country
#> 1463                 tessi173_own_nl country
#> 1464                tessi173_rent_fr country
#> 1465               tessi173_rent_mkt country
#> 1466                   tessi174_deg1 country
#> 1467                   tessi174_deg2 country
#> 1468                   tessi174_deg3 country
#> 1469                  tessi175_a_ge3 country
#> 1470                     tessi175_a1 country
#> 1471                     tessi175_a2 country
#> 1472                      tessi176_f country
#> 1473                      tessi176_m country
#> 1474                      tessi176_t country
#> 1475                  tessi177_total country
#> 1476                 tessi177_y_ge65 country
#> 1477                 tessi177_y_lt18 country
#> 1478                 tessi177_y18_64 country
#> 1479                   tessi178_a_60 country
#> 1480                   tessi178_b_60 country
#> 1481                  tessi178_total country
#> 1482                        tessi190 country
#> 1483                     tessi250_ft country
#> 1484                     tessi250_pt country
#> 1485                      tessi291_0 country
#> 1486                      tessi291_1 country
#> 1487                      tessi291_2 country
#> 1488                      tessi291_3 country
#> 1489                      tessi291_4 country
#> 1490                 tessi292_a_60_f country
#> 1491                 tessi292_a_60_m country
#> 1492                 tessi292_a_60_t country
#> 1493                 tessi292_b_60_f country
#> 1494                 tessi292_b_60_m country
#> 1495                 tessi292_b_60_t country
#> 1496                tessi292_total_f country
#> 1497                tessi292_total_m country
#> 1498                tessi292_total_t country
#> 1499                      tessi293_f country
#> 1500                      tessi293_m country
#> 1501                      tessi293_t country
#> 1502                      tessi294_f country
#> 1503                      tessi294_m country
#> 1504                      tessi294_t country
#> 1505                      tessi295_f country
#> 1506                      tessi295_m country
#> 1507                      tessi295_t country
#> 1508                      tessi300_f country
#> 1509                      tessi300_m country
#> 1510                      tessi300_t country
#> 1511                  tessi301_total country
#> 1512                 tessi301_y_ge65 country
#> 1513                 tessi301_y_lt18 country
#> 1514                 tessi301_y18_64 country
#> 1515                   tessi302_a_60 country
#> 1516                   tessi302_b_60 country
#> 1517                  tessi302_total country
#> 1518                   tessi303_deg1 country
#> 1519                   tessi303_deg2 country
#> 1520                   tessi303_deg3 country
#> 1521                      tespn010_f country
#> 1522                      tespn010_m country
#> 1523                      tespn010_t country
#> 1524                 tespn050_y_ge60 country
#> 1525                 tespn050_y_ge65 country
#> 1526                 tespn050_y_ge75 country
#> 1527                 tespn050_y_lt60 country
#> 1528                 tespn050_y_lt65 country
#> 1529                 tespn050_y_lt75 country
#> 1530                      tespn060_f country
#> 1531                      tespn060_m country
#> 1532                      tespn060_t country
#> 1533                      tespn070_f country
#> 1534                      tespn070_m country
#> 1535                      tespn070_t country
#> 1536                      tespn080_f country
#> 1537                      tespn080_m country
#> 1538                      tespn080_t country
#> 1539                 tespn090_y_ge65 country
#> 1540                 tespn090_y_ge75 country
#> 1541                      tespn100_f country
#> 1542                      tespn100_m country
#> 1543                      tespn100_t country
#> 1544                    tespn110_own country
#> 1545                   tespn110_rent country
#> 1546                  tespn110_total country
#> 1547                   tespn120_b_40 country
#> 1548                   tespn120_b_50 country
#> 1549                   tespn120_b_60 country
#> 1550                   tespn120_b_70 country
#> 1551                 tespn240_y_ge65 country
#> 1552                 tespn240_y_lt65 country
#> 1553                        tespn250 country
#> 1554                        tespn260 country
#> 1555                 tespn270_y_ge60 country
#> 1556                 tespn270_y_ge75 country
#> 1557                     tepsr_sp310 country
#> 1558                   tepsr_sp320_f country
#> 1559                   tepsr_sp320_m country
#> 1560                   tepsr_sp320_t country
#> 1561                     tepsr_lm210 country
#> 1562              tepsr_wc170_y15_24 country
#> 1563              tepsr_wc170_y15_74 country
#> 1564              tepsr_wc170_y20_64 country
#> 1565              tepsr_wc170_y25_29 country
#> 1566              tepsr_wc170_y25_54 country
#> 1567              tepsr_wc170_y55_64 country
#> 1568              tepsr_wc220_m_ge60 country
#> 1569               tepsr_wc220_m0_11 country
#> 1570              tepsr_wc220_m12_23 country
#> 1571              tepsr_wc220_m24_59 country
#> 1572                 tepsr_wc220_nrp country
#> 1573               tepsr_wc220_total country
#> 1574                   tepsr_wc230_f country
#> 1575                   tepsr_wc230_m country
#> 1576                   tepsr_wc230_t country
#> 1577               tepsr_lm411_total country
#> 1578              tepsr_lm411_y_ge18 country
#> 1579              tepsr_lm411_y_ge65 country
#> 1580              tepsr_lm411_y_lt18 country
#> 1581               tepsr_lm411_y_lt6 country
#> 1582              tepsr_lm411_y12_17 country
#> 1583              tepsr_lm411_y18_64 country
#> 1584               tepsr_lm411_y6_11 country
#> 1585                     tepsr_sp210 country
#> 1586                tepsr_sp110_gf07 country
#> 1587                tepsr_sp110_gf09 country
#> 1588                tepsr_sp110_gf10 country
#> 1589                     tai06_a2000 country
#> 1590                     tai06_a3100 country
#> 1591                     tai06_a4100 country
#> 1592                     tai06_a4200 country
#> 1593                     tai06_a5000 country
#> 1594                     tai06_a6111 country
#>                                                                                                                                                                                                               name
#> 1                                                                                                                                                                                        GDP per inhabitant in PPS
#> 2                                                                                                                                                                                               GDP per inhabitant
#> 3                                                                                                                                                                                                  Real GDP growth
#> 4                                                                                                                                                                                               Price level of GDP
#> 5                                                                                                                                                                                    Exports of goods and services
#> 6                                                                                                                                                                       Investment (gross fixed capital formation)
#> 7                                                                                                                                                                             Research and development expenditure
#> 8                                                                                                                                                                                            Government gross debt
#> 9                                                                                                                                                                            Government deficit (-) or surplus (+)
#> 10                                                                                                                                                                                  Taxes and social contributions
#> 11                                                                                                                                                                                          Government expenditure
#> 12                                                                                                                                                                                                Inflation (HICP)
#> 13                                                                                                                                                                                               House price index
#> 14                                                                                                                                                                                 Net earnings of a single worker
#> 15                                                                                                                                                                                                  Gender pay gap
#> 16                                                                                                                                                                                               Unemployment rate
#> 17                                                                                                                                                                                         Youth unemployment rate
#> 18                                                                                                                                                                                     Long-term unemployment rate
#> 19                                                                                                                                                                                                 Employment rate
#> 20                                                                                                                                                                                           Gender employment gap
#> 21                                                                                                                                                                                            Part-time employment
#> 22                                                                                                                                                 Young people neither in employment nor in education or training
#> 23                                                                                                                                                                          At risk of poverty or social exclusion
#> 24                                                                                                                                                                                         At-risk-of-poverty rate
#> 25                                                                                                                                                                                   Median equivalised net income
#> 26                                                                                                                                                                            Income inequality (Gini coefficient)
#> 27                                                                                                                                                                           Income quintile share ratio (S80/S20)
#> 28                                                                                                                                                                          Severe material and social deprivation
#> 29                                                                                                                                                                                    Housing cost overburden rate
#> 30                                                                                                                                                                                               Overcrowding rate
#> 31                                                                                                                                                                                                      Population
#> 32                                                                                                                                                                                               Population growth
#> 33                                                                                                                                                                                                      Birth rate
#> 34                                                                                                                                                                                                  Fertility rate
#> 35                                                                                                                                                                                                   Net migration
#> 36                                                                                                                                                                                                      Median age
#> 37                                                                                                                                                                                        Old-age dependency ratio
#> 38                                                                                                                                                                                        Life expectancy at birth
#> 39                                                                                                                                                                                     Healthy life years at birth
#> 40                                                                                                                                                                                           Infant mortality rate
#> 41                                                                                                                                                                                              Health expenditure
#> 42                                                                                                                                                                       Early leavers from education and training
#> 43                                                                                                                                                                                   Tertiary education attainment
#> 44                                                                                                                                                                                 Adult participation in learning
#> 45                                                                                                                                                                                              Daily internet use
#> 46                                                                                                                                                                                                 Online shopping
#> 47                                                                                                                                                                                                Renewable energy
#> 48                                                                                                                                                                                        Energy import dependency
#> 49                                                                                                                                                                     Net greenhouse gas emissions per inhabitant
#> 50                                                                                                                                                                                                 Municipal waste
#> 51                                                                                                                                                                               Recycling rate of municipal waste
#> 52                                                                                                                                                                                                  Passenger cars
#> 53                                                                                                                                                                                            Intentional homicide
#> 54                                                                                                                                                                                       GDP per inhabitant in PPS
#> 55                                                                                                                                                                            Research and development expenditure
#> 56                                                                                                                                                                                               Unemployment rate
#> 57                                                                                                                                                                                                 Employment rate
#> 58                                                                                                                                                                          At risk of poverty or social exclusion
#> 59                                                                                                                                                                                               Population growth
#> 60                                                                                                                                                                                              Population density
#> 61                                                                                                                                                                                        Life expectancy at birth
#> 62                                                                                                                                                                                   Tertiary education attainment
#> 63                                                                                                                                                                 Net trade balance of energy products - % of GDP
#> 64                                                                                                                                   Gross fixed capital formation at current prices: Current prices, million euro
#> 65                                                                                                                     Gross fixed capital formation at current prices: Percentage of gross domestic product (GDP)
#> 66                                                                                                                       Real GDP growth rate - volume: Chain linked volumes, percentage change on previous period
#> 67                                                                                                           Real GDP growth rate - volume: Chain linked volumes, percentage change on previous period, per capita
#> 68                                                                                                                                                     Gross domestic product (GDP) at market prices - annual data
#> 69                                                                                                                                                                           Private sector debt, non-consolidated
#> 70                                                                                                                                                 Generation of waste excluding major mineral wastes per GDP unit
#> 71                                                                                                                                        Gross domestic product at market prices: Current prices, euro per capita
#> 72                                                                                                                                           Gross domestic product at market prices: Current prices, million euro
#> 73                                                                                                                                                         Compensation of employees: Current prices, million euro
#> 74                                                                                                                                           Compensation of employees: Percentage of gross domestic product (GDP)
#> 75                                                                                                                                       Terms of trade by items - 5 years % change: Exports of goods and services
#> 76                                                                                                                                                    Terms of trade by items - 5 years % change: Exports of goods
#> 77                                                                                                                                                 Terms of trade by items - 5 years % change: Exports of services
#> 78                                                                                                                               Final consumption expenditure of general government: Current prices, million euro
#> 79                                                                                                                 Final consumption expenditure of general government: Percentage of gross domestic product (GDP)
#> 80                                                                                                                                        Imports of goods and services in % of GDP: Imports of goods and services
#> 81                                                                                                                                                     Imports of goods and services in % of GDP: Imports of goods
#> 82                                                                                                                                                  Imports of goods and services in % of GDP: Imports of services
#> 83                                                            Final consumption expenditure of households and non-profit institutions serving households - annual data: Percentage of gross domestic product (GDP)
#> 84                                          Final consumption expenditure of households and non-profit institutions serving households - annual data: Price index (implicit deflator), 2015=100, national currency
#> 85                                                                                                                                        Exports of goods and services in % of GDP: Exports of goods and services
#> 86                                                                                                                                                     Exports of goods and services in % of GDP: Exports of goods
#> 87                                                                                                                                                  Exports of goods and services in % of GDP: Exports of services
#> 88                                                                                                                                       Gross fixed capital formation (investments): Current prices, million euro
#> 89                                                                                                                         Gross fixed capital formation (investments): Percentage of gross domestic product (GDP)
#> 90                                                                                                                                                                                  Export market shares in volume
#> 91                                                                                                                                          Goods and services, imports and exports: Exports of goods and services
#> 92                                                                                                                                          Goods and services, imports and exports: Imports of goods and services
#> 93                                                                                                                                                                    Private sector credit flow, non-consolidated
#> 94                                                                                        Final consumption expenditure of households and non-profit institutions serving households: Current prices, million euro
#> 95                                                                          Final consumption expenditure of households and non-profit institutions serving households: Percentage of gross domestic product (GDP)
#> 96                                                                                                                     Real GDP per capita: Chain linked volumes, percentage change on previous period, per capita
#> 97                                                                                                                                               Real GDP per capita: Chain linked volumes (2020), euro per capita
#> 98                                                                                                                                               Real GDP per capita: Chain linked volumes (2015), euro per capita
#> 99                                                                                                                                                                Residential construction - annual data, % of GDP
#> 100                                                                                                                                                                     Residential building permits - annual data
#> 101                                                                                                                                        General government total expenditure on law courts: Euro per inhabitant
#> 102                                                                                                                                               General government total expenditure on law courts: Million euro
#> 103                                                                                                             Employees, domestic concept - annual data: Percentage change on previous period (based on persons)
#> 104                                                                                                                                                    Employees, domestic concept - annual data: Thousand persons
#> 105                                                                                                            Employment, domestic concept - annual data: Percentage change on previous period (based on persons)
#> 106                                                                                                                                                   Employment, domestic concept - annual data: Thousand persons
#> 107                                                                                                                                                                           Employment, domestic concept - Total
#> 108                                                                                                                                                       Disposable income of private households by NUTS 2 region
#> 109                                                                                                                                                          Primary income of private households by NUTS 2 region
#> 110                                                                                                                                                     Nominal labour productivity per person employed (ESA 2010)
#> 111                                                                                                                                            Nominal unit labour cost per hour worked: Percentage change (t/t-3)
#> 112                                                                                                                                 Nominal unit labour cost per hour worked: Percentage change on previous period
#> 113                                                                                                                                                                                Nominal unit labour cost growth
#> 114                                                                                                                                             Labour productivity per hour worked - annual data: Index, 2015=100
#> 115                                                                                                                        Labour productivity per hour worked - annual data: Percentage change on previous period
#> 116                                                                                           Labour productivity per person employed and hour worked (EU27_2020=100): Nominal labour productivity per hour worked
#> 117                                                                                                Labour productivity per person employed and hour worked (EU27_2020=100): Nominal labour productivity per person
#> 118                                                                                                                                        Nominal unit labour cost per hour worked - annual data: Index, 2015=100
#> 119                                                                                   Nominal unit labour cost per hour worked - annual data, percentage change and index (2015 = 100): Percentage change (t/t-10)
#> 120                                                                                    Nominal unit labour cost per hour worked - annual data, percentage change and index (2015 = 100): Percentage change (t/t-1)
#> 121                                                                                    Nominal unit labour cost per hour worked - annual data, percentage change and index (2015 = 100): Percentage change (t/t-3)
#> 122                                                                                    Nominal unit labour cost per hour worked - annual data, percentage change and index (2015 = 100): Percentage change (t/t-5)
#> 123                                                                                                                                               Adjusted gross disposable income of households per capita in PPS
#> 124                                                                                                                                                       Non-financial corporations debt, consolidated - % of GDP
#> 125                                                                                                                      Household including non-profit institutions serving households (NPISH) debt, consolidated
#> 126                                                                                                                      Non-financial corporations excluding foreign direct investments credit flow, consolidated
#> 127                                                                                                               Household including non-profit institutions serving households (NPISH) credit flow, consolidated
#> 128                                                                                                                                                                                          Household saving rate
#> 129                                                                                                                                                       Investment by institutional sectors: Business investment
#> 130                                                                                                                                                     Investment by institutional sectors: Government investment
#> 131                                                                                                                                                     Investment by institutional sectors: Households investment
#> 132                                                                                                                                                          Investment by institutional sectors: Total investment
#> 133                                                                                                                                                                       Gross debt-to-income ratio of households
#> 134                                                                                                                                                                               Total general government revenue
#> 135                                                                                                                                                       Total general government expenditure: General government
#> 136                                                                                                                                                       Total general government expenditure: Central government
#> 137                                                                                                                                                         Total general government expenditure: Local government
#> 138                                                                                                                                                    Total general government expenditure: Social security funds
#> 139                                                                                                                                                               General government deficit/surplus: Million euro
#> 140                                                                                                                                 General government deficit/surplus: Percentage of gross domestic product (GDP)
#> 141                                                                                                                                                                 EMU convergence criterion series - annual data
#> 142                                                                                                                                                                                          HICP - inflation rate
#> 143                                                                                                                                                                      HICP - all items - annual average indices
#> 144                                                                                       Core inflation differential vis-à-vis EA: Core inflation differential vis-à-vis the euro area - 20 countries (2023-2025)
#> 145                                                                                       Core inflation differential vis-à-vis EA: Core inflation differential vis-à-vis the euro area - 21 countries (from 2026)
#> 146                                                                                                                                                                                            Price level indices
#> 147                                                                                                                                                                                          GDP per capita in PPS
#> 148                                                                                                                       Purchasing power adjusted GDP per capita: Real expenditure per capita (in PPS_EU27_2020)
#> 149                                                                                                 Purchasing power adjusted GDP per capita: Volume indices of real expenditure per capita (in PPS_EU27_2020=100)
#> 150                                                                                                                                     Current account transactions - goods: credits, debits and balance: Balance
#> 151                                                                                                                                      Current account transactions - goods: credits, debits and balance: Credit
#> 152                                                                                                                                       Current account transactions - goods: credits, debits and balance: Debit
#> 153                                                                                                                            Current account transactions - primary income: credits, debits and balance: Balance
#> 154                                                                                                                             Current account transactions - primary income: credits, debits and balance: Credit
#> 155                                                                                                                              Current account transactions - primary income: credits, debits and balance: Debit
#> 156                                                                                                                          Current account transactions - secondary income: credits, debits and balance: Balance
#> 157                                                                                                                           Current account transactions - secondary income: credits, debits and balance: Credit
#> 158                                                                                                                            Current account transactions - secondary income: credits, debits and balance: Debit
#> 159                                                                                                                                            Current account transactions - credits, debits and balance: Balance
#> 160                                                                                                                                             Current account transactions - credits, debits and balance: Credit
#> 161                                                                                                                                              Current account transactions - credits, debits and balance: Debit
#> 162                                                                                                                                  Current account transactions - services: credits, debits and balance: Balance
#> 163                                                                                                                                   Current account transactions - services: credits, debits and balance: Credit
#> 164                                                                                                                                    Current account transactions - services: credits, debits and balance: Debit
#> 165                                                                                                                                                                                 Outward FDI stocks in % of GDP
#> 166                                                                                                                                                                                  Inward FDI stocks in % of GDP
#> 167                                                                                                                                                                        FDI flows intensity, market integration
#> 168                                                                                                                                                                                        Population on 1 January
#> 169                                                                                                                                      Live births and crude birth rate: Crude birth rate - per thousand persons
#> 170                                                                                                                                                         Live births and crude birth rate: Live births - number
#> 171                                                                                                                                                                             Live births: Live births - females
#> 172                                                                                                                                                                               Live births: Live births - total
#> 173                                                                                                                                                                               Live births: Live births - males
#> 174                                                                                                                                                                   Deaths and crude death rate: Deaths - number
#> 175                                                                                                                                           Deaths and crude death rate: Crude death rate - per thousand persons
#> 176                                                     Population change - crude rates of total change, natural change and net migration plus adjustment: Crude rate of net migration plus statistical adjustment
#> 177                                                                       Population change - crude rates of total change, natural change and net migration plus adjustment: Crude rate of total population change
#> 178                                                                  Population change - crude rates of total change, natural change and net migration plus adjustment: Crude rate of natural change of population
#> 179                                                                                                                                                                                  Deaths by sex: Deaths - total
#> 180                                                                                                                                                                                Deaths by sex: Deaths - females
#> 181                                                                                                                                                                                  Deaths by sex: Deaths - males
#> 182                                                                                                                                                      Population as a percentage of EU27 (from 2020) population
#> 183                                    Population change by NUTS 2 region - Crude rates of total change, natural change and net migration plus adjustment: Crude rate of net migration plus statistical adjustment
#> 184                                                      Population change by NUTS 2 region - Crude rates of total change, natural change and net migration plus adjustment: Crude rate of total population change
#> 185                                                 Population change by NUTS 2 region - Crude rates of total change, natural change and net migration plus adjustment: Crude rate of natural change of population
#> 186                                                                                                                                                                      Proportion of population aged 65 and over
#> 187                                                                                                                                                          Median age by sex: Median age of population - females
#> 188                                                                                                                                                                    Median age by sex: Median age of population
#> 189                                                                                                                                                            Median age by sex: Median age of population - males
#> 190                                                                                                                                              Population by age group: Proportion of population aged 0-14 years
#> 191                                                                                                                                             Population by age group: Proportion of population aged 15-24 years
#> 192                                                                                                                                             Population by age group: Proportion of population aged 25-49 years
#> 193                                                                                                                                             Population by age group: Proportion of population aged 50-64 years
#> 194                                                                                                                                             Population by age group: Proportion of population aged 65-79 years
#> 195                                                                                                                                       Population by age group: Proportion of population aged 80 years and more
#> 196                                                                                                                           Population structure by detailed age group: Proportion of population aged 0-17 years
#> 197                                                                                                                          Population structure by detailed age group: Proportion of population aged 15-24 years
#> 198                                                                                                                          Population structure by detailed age group: Proportion of population aged 25-49 years
#> 199                                                                                                                          Population structure by detailed age group: Proportion of population aged 50-64 years
#> 200                                                                                                                    Population structure by detailed age group: Proportion of population aged 65 years and more
#> 201                                                                                                                                                                                    Population structure by sex
#> 202                                                                                                                                                                                       Old-age-dependency ratio
#> 203                                                                                                                                                                                             Population density
#> 204                                                                                                                                                                            Population density by NUTS 2 region
#> 205                                                                                                                                                    Population without the citizenship of the reporting country
#> 206                                                                                                                                                                                        Foreign-born population
#> 207                                                                                                                                                                       Population on 1 January by NUTS 2 region
#> 208                                                                                                                   Mean age of women at childbirth and at birth of first child: Mean age of women at childbirth
#> 209                                                                                                         Mean age of women at childbirth and at birth of first child: Mean age of women at birth of first child
#> 210                                                                                                                                                                                           Total fertility rate
#> 211                                                                                                                                                                          Total fertility rate by NUTS 2 region
#> 212                                                                                                                                                                       Life expectancy at birth by sex: Females
#> 213                                                                                                                                                                         Life expectancy at birth by sex: Males
#> 214                                                                                                                                                                         Life expectancy at birth by sex: Total
#> 215                                                                                                                                                                                          Infant mortality rate
#> 216                                                                                                                                                     Life expectancy at birth by sex and NUTS 2 region: Females
#> 217                                                                                                                                                       Life expectancy at birth by sex and NUTS 2 region: Males
#> 218                                                                                                                                                       Life expectancy at birth by sex and NUTS 2 region: Total
#> 219                                                                                                                                                                                            Crude marriage rate
#> 220                                                                                                                                        Mean age at first marriage by sex: Mean age at first marriage - females
#> 221                                                                                                                                          Mean age at first marriage by sex: Mean age at first marriage - males
#> 222                                                                                                                                                                                             Crude divorce rate
#> 223                                                                                                                                                                            Immigration: Age in completed years
#> 224                                                                                                                                                                       Immigration: Age reached during the year
#> 225                                                                                                                                                                             Emigration: Age in completed years
#> 226                                                                                                                                                                        Emigration: Age reached during the year
#> 227                                                                                                                                                             Acquisition of citizenship: Age in completed years
#> 228                                                                                                                                                        Acquisition of citizenship: Age reached during the year
#> 229                                                                                                                                          Asylum applicants considered to be unaccompanied minors - annual data
#> 230                                                                                                                                       Asylum applicants by type - annual aggregated data: First time applicant
#> 231                                                                                                                                       Asylum applicants by type - annual aggregated data: Subsequent applicant
#> 232                                                                                                                                                      Asylum applicants by type - annual aggregated data: Total
#> 233                                                                                                First instance decisions on asylum applications by type of decision - annual aggregated data: Negative decision
#> 234                                                                                                First instance decisions on asylum applications by type of decision - annual aggregated data: Positive decision
#> 235                                                                          First instance decisions on asylum applications by type of decision - annual aggregated data: Positive decision - humanitarian status
#> 236                                                                               First instance decisions on asylum applications by type of decision - annual aggregated data: Positive decision - refugee status
#> 237                                                                 First instance decisions on asylum applications by type of decision - annual aggregated data: Positive decision - subsidiary protection status
#> 238                                                                                                            First instance decisions on asylum applications by type of decision - annual aggregated data: Total
#> 239                                                                                                                    Final decisions on asylum applications by type of decision - annual data: Negative decision
#> 240                                                                                                                    Final decisions on asylum applications by type of decision - annual data: Positive decision
#> 241                                                                                              Final decisions on asylum applications by type of decision - annual data: Positive decision - humanitarian status
#> 242                                                                                                   Final decisions on asylum applications by type of decision - annual data: Positive decision - refugee status
#> 243                                                                                     Final decisions on asylum applications by type of decision - annual data: Positive decision - subsidiary protection status
#> 244                                                                                                                                Final decisions on asylum applications by type of decision - annual data: Total
#> 245                                                                                                                                                                                Resettled persons - annual data
#> 246                                                                                                                                                                     First permits by reason: Education reasons
#> 247                                                                                                                                                                    First permits by reason: Employment reasons
#> 248                                                                                                                                                                        First permits by reason: Family reasons
#> 249                                                                                                                                                                          First permits by reason: Other reason
#> 250                                                                                                                                                                                 First permits by reason: Total
#> 251                                                                                                                                     All valid permits by reason on 31 December of each year: Education reasons
#> 252                                                                                                                                        All valid permits by reason on 31 December of each year: Family reasons
#> 253                                                                                                                                          All valid permits by reason on 31 December of each year: Other reason
#> 254                                                                                                                                                 All valid permits by reason on 31 December of each year: Total
#> 255                                                                                                                                                                    Healthy life years at birth by sex: Females
#> 256                                                                                                                                                                      Healthy life years at birth by sex: Males
#> 257                                                                                                                                                                      Healthy life years at birth by sex: Total
#> 258                                                                                                                                                Healthy life expectancy based on self-perceived health: Females
#> 259                                                                                                                                                  Healthy life expectancy based on self-perceived health: Males
#> 260                                                                                                                                                  Healthy life expectancy based on self-perceived health: Total
#> 261                                                                                                                                                       Long-term care (health) expenditure: Euro per inhabitant
#> 262                                                                                                                                                              Long-term care (health) expenditure: Million euro
#> 263                                                                                                                                  Long-term care (health) expenditure: Million purchasing power standards (PPS)
#> 264                                                                                                                Long-term care (health) expenditure: Percentual share of total current health expenditure (CHE)
#> 265                                                                                                                                Long-term care (health) expenditure: Percentage of gross domestic product (GDP)
#> 266                                                                                                                            Long-term care (health) expenditure: Purchasing power standard (PPS) per inhabitant
#> 267                                                                                                                                                             Total health care expenditure: Euro per inhabitant
#> 268                                                                                                                                                                    Total health care expenditure: Million euro
#> 269                                                                                                                                        Total health care expenditure: Million purchasing power standards (PPS)
#> 270                                                                                                                      Total health care expenditure: Percentual share of total current health expenditure (CHE)
#> 271                                                                                                                                      Total health care expenditure: Percentage of gross domestic product (GDP)
#> 272                                                                                                                                  Total health care expenditure: Purchasing power standard (PPS) per inhabitant
#> 273                                                                                                                                                                                                  Hospital beds
#> 274                                                                                                                                                                                          Practising physicians
#> 275                                                                                                                                                                                            Practising dentists
#> 276                                                                                                                                                                                            Licensed physicians
#> 277                                                                                                                                        Discharges from hospitals: Diseases of the circulatory system (I00-I99)
#> 278                                                                                                                                        Discharges from hospitals: Diseases of the respiratory system (J00-J99)
#> 279                                                                                                              Discharges from hospitals: Diseases of the musculoskeletal system and connective tissue (M00-M99)
#> 280                                                                                                                                  Discharges from hospitals: Pregnancy, childbirth and the puerperium (O00-O99)
#> 281                                                                                                                                                                 Death due to drugs dependence, by sex: Females
#> 282                                                                                                                                                                   Death due to drugs dependence, by sex: Males
#> 283                                                                                                                                                                   Death due to drugs dependence, by sex: Total
#> 284                                                                                                                                                                Death due to homicide, assault, by sex: Females
#> 285                                                                                                                                                                  Death due to homicide, assault, by sex: Males
#> 286                                                                                                                                                                  Death due to homicide, assault, by sex: Total
#> 287                                                                                                                                                               Death due to AIDS (HIV-disease), by sex: Females
#> 288                                                                                                                                                                 Death due to AIDS (HIV-disease), by sex: Males
#> 289                                                                                                                                                                 Death due to AIDS (HIV-disease), by sex: Total
#> 290                                                                                                                                                                        Death due to accidents, by sex: Females
#> 291                                                                                                                                                                          Death due to accidents, by sex: Males
#> 292                                                                                                                                                                          Death due to accidents, by sex: Total
#> 293                                                                                                                                                                           Death due to cancer, by sex: Females
#> 294                                                                                                                                                                             Death due to cancer, by sex: Males
#> 295                                                                                                                                                                             Death due to cancer, by sex: Total
#> 296                                                                                                                                                                        Death due to pneumonia, by sex: Females
#> 297                                                                                                                                                                          Death due to pneumonia, by sex: Males
#> 298                                                                                                                                                                          Death due to pneumonia, by sex: Total
#> 299                                                                                                                                                              Suicide death rate by age group: 85 years or over
#> 300                                                                                                                                                           Suicide death rate by age group: From 15 to 19 years
#> 301                                                                                                                                                           Suicide death rate by age group: From 50 to 54 years
#> 302                                                                                                                                                              Death due to transport accidents by NUTS 2 region
#> 303                                                                                                                                                                           Death due to cancer by NUTS 2 region
#> 304                                                                                                                                                         Death due to ischaemic heart diseases by NUTS 2 region
#> 305                                                                                                                                                                           All causes of death by NUTS 2 region
#> 306                                                                                                                                                                        Death due to accidents by NUTS 2 region
#> 307                                                                                                                                    Premature deaths due to exposure to fine particulate matter (PM2.5): Number
#> 308                                                                                                                   Premature deaths due to exposure to fine particulate matter (PM2.5): Per 100,000 inhabitants
#> 309                                                                                                                                       Beneficiaries of disability pensions by pension type: Disability pension
#> 310                                                                                                                                Beneficiaries of disability pensions by pension type: Total disability pensions
#> 311                                                                                                 Beneficiaries of disability pensions by pension type: Early retirement benefit due to reduced capacity to work
#> 312                                                                                                                                                           Beneficiaries of disability pensions by sex: Females
#> 313                                                                                                                                                             Beneficiaries of disability pensions by sex: Males
#> 314                                                                                                                                                             Beneficiaries of disability pensions by sex: Total
#> 315                                                                                                                             Disability employment gap by level of activity limitation and sex: Females, Severe
#> 316                                                                                                                     Disability employment gap by level of activity limitation and sex: Females, Some or severe
#> 317                                                                                                                               Disability employment gap by level of activity limitation and sex: Females, Some
#> 318                                                                                                                               Disability employment gap by level of activity limitation and sex: Males, Severe
#> 319                                                                                                                       Disability employment gap by level of activity limitation and sex: Males, Some or severe
#> 320                                                                                                                                 Disability employment gap by level of activity limitation and sex: Males, Some
#> 321                                                                                                                               Disability employment gap by level of activity limitation and sex: Total, Severe
#> 322                                                                                                                       Disability employment gap by level of activity limitation and sex: Total, Some or severe
#> 323                                                                                                                                 Disability employment gap by level of activity limitation and sex: Total, Some
#> 324                                                                                  Female tertiary education graduates in STEM education fields - % of all tertiary education graduates in STEM education fields
#> 325                                                                                                                                                      Exposure of VET graduates to work-based learning: Females
#> 326                                                                                                                                                        Exposure of VET graduates to work-based learning: Males
#> 327                                                                                                                                                        Exposure of VET graduates to work-based learning: Total
#> 328                                                                                                                             Population (aged 30-34) with tertiary educational attainment level by sex: Females
#> 329                                                                                                                               Population (aged 30-34) with tertiary educational attainment level by sex: Males
#> 330                                                                                                                               Population (aged 30-34) with tertiary educational attainment level by sex: Total
#> 331                                                                                                          Young persons (aged 20-24) with at least upper secondary educational attainment level by sex: Females
#> 332                                                                                                            Young persons (aged 20-24) with at least upper secondary educational attainment level by sex: Males
#> 333                                                                                                            Young persons (aged 20-24) with at least upper secondary educational attainment level by sex: Total
#> 334                                                                                                                  Persons aged 25-64 with at least upper secondary educational attainment level by sex: Females
#> 335                                                                                                                    Persons aged 25-64 with at least upper secondary educational attainment level by sex: Males
#> 336                                                                                                                    Persons aged 25-64 with at least upper secondary educational attainment level by sex: Total
#> 337                                                                                                                  Persons aged 20-24 with at least upper secondary educational attainment level by sex: Females
#> 338                                                                                                                    Persons aged 20-24 with at least upper secondary educational attainment level by sex: Males
#> 339                                                                                                                    Persons aged 20-24 with at least upper secondary educational attainment level by sex: Total
#> 340                                                                                                                  Persons with at most lower secondary educational attainment level by age: From 25 to 34 years
#> 341                                                                                                                  Persons with at most lower secondary educational attainment level by age: From 25 to 64 years
#> 342                                                                                                                  Persons with at most lower secondary educational attainment level by age: From 35 to 44 years
#> 343                                                                                                                  Persons with at most lower secondary educational attainment level by age: From 45 to 54 years
#> 344                                                                                                                  Persons with at most lower secondary educational attainment level by age: From 55 to 64 years
#> 345                                                                                                                Persons aged 25-64 with tertiary educational attainment level by sex and NUTS 2 region: Females
#> 346                                                                                                                  Persons aged 25-64 with tertiary educational attainment level by sex and NUTS 2 region: Males
#> 347                                                                                                                  Persons aged 25-64 with tertiary educational attainment level by sex and NUTS 2 region: Total
#> 348                                                                 Unemployment rates (persons aged 25-64) by educational attainment level: Less than primary, primary and lower secondary education (levels 0-2)
#> 349                                                            Unemployment rates (persons aged 25-64) by educational attainment level: Upper secondary and post-secondary non-tertiary education (levels 3 and 4)
#> 350                                                                                                       Unemployment rates (persons aged 25-64) by educational attainment level: Tertiary education (levels 5-8)
#> 351                                                                                                                                                                  Employment rates of recent graduates: Females
#> 352                                                                                                                                                                    Employment rates of recent graduates: Males
#> 353                                                                                                                                                                    Employment rates of recent graduates: Total
#> 354                                                                                                                                                                                                Employment rate
#> 355                                                                                                                                          Employees with temporary contracts - annual data: From 15 to 24 years
#> 356                                                                                                                                          Employees with temporary contracts - annual data: From 15 to 29 years
#> 357                                                                                                                                          Employees with temporary contracts - annual data: From 15 to 64 years
#> 358                                                                                                                                          Employees with temporary contracts - annual data: From 20 to 64 years
#> 359                                                                                                                                          Employees with temporary contracts - annual data: From 25 to 54 years
#> 360                                                                                                                                          Employees with temporary contracts - annual data: From 55 to 64 years
#> 361                                                                                                                                          Employed persons working part-time - annual data: From 15 to 64 years
#> 362                                                                                                                                          Employed persons working part-time - annual data: From 20 to 64 years
#> 363                                                                                                                                                Unemployment rate: Percentage of population in the labour force
#> 364                                                                                                                                                              Unemployment rate: Percentage of total population
#> 365                                                                                                                                                                            Unemployment rate: Thousand persons
#> 366                                                                                                                                                          Employment rate of non-EU nationals (age group 20-64)
#> 367                                                                                                                            Employment rate by citizenship: EU27 countries (from 2020) except reporting country
#> 368                                                                                                                                                              Employment rate by citizenship: Reporting country
#> 369                                                                                                                           Employment rate by citizenship: Non-EU27 countries (from 2020) nor reporting country
#> 370                                                                                                                                                       Employment rate of low skilled persons (age group 20-64)
#> 371                                                                                                                                         Employed persons being self-employed without employees by sex: Females
#> 372                                                                                                                                           Employed persons being self-employed without employees by sex: Males
#> 373                                                                                                                                           Employed persons being self-employed without employees by sex: Total
#> 374                                                                                                                                                      Employed persons having more than one job by sex: Females
#> 375                                                                                                                                                        Employed persons having more than one job by sex: Males
#> 376                                                                                                                                                        Employed persons having more than one job by sex: Total
#> 377                                                                                                                                                                  Hours worked per week of full-time employment
#> 378                                                                                                                                                                             Jobless households by sex: Females
#> 379                                                                                                                                                                               Jobless households by sex: Males
#> 380                                                                                                                                                                               Jobless households by sex: Total
#> 381                                                                                                                                                                                  Jobless households - children
#> 382                                                                                                                                                 Employment rate (persons aged 15-64) by NUTS 2 region: Females
#> 383                                                                                                                                                   Employment rate (persons aged 15-64) by NUTS 2 region: Males
#> 384                                                                                                                                                   Employment rate (persons aged 15-64) by NUTS 2 region: Total
#> 385                                                                                             Labour costs annual data - NACE Rev. 2: Labour cost for LCI (compensation of employees plus taxes minus subsidies)
#> 386                                                                                                                                             Labour costs annual data - NACE Rev. 2: Wages and salaries (total)
#> 387                                                                                                                             Labour costs annual data - NACE Rev. 2: Labour costs other than wages and salaries
#> 388                                                                                                                                            Labour costs annual data - NACE Rev. 2: Share of non-wage costs (%)
#> 389                                                                                                                                              Persons at risk of poverty or social exclusion: Total, Percentage
#> 390                                                                                                                                        Persons at risk of poverty or social exclusion: Total, Thousand persons
#> 391                                                                                                                                 Persons at risk of poverty or social exclusion: Less than 18 years, Percentage
#> 392                                                                                                                           Persons at risk of poverty or social exclusion: Less than 18 years, Thousand persons
#> 393                                                                                             Inequality of income distribution S80/S20 income quintile share ratio - EU-SILC and ECHP surveys: 65 years or over
#> 394                                                                                           Inequality of income distribution S80/S20 income quintile share ratio - EU-SILC and ECHP surveys: Less than 65 years
#> 395                                                                                                                              Gini coefficient of equivalised disposable income for children (aged less than 18
#> 396                                                                                                                                                 At-risk-of-poverty rate after social transfers by sex: Females
#> 397                                                                                                                                                   At-risk-of-poverty rate after social transfers by sex: Males
#> 398                                                                                                                                                   At-risk-of-poverty rate after social transfers by sex: Total
#> 399                                                                                                                   At-risk-of-poverty rate for pensioners - EU-SILC and ECHP surveys: 18 years or over, Females
#> 400                                                                                                                     At-risk-of-poverty rate for pensioners - EU-SILC and ECHP surveys: 18 years or over, Males
#> 401                                                                                                                     At-risk-of-poverty rate for pensioners - EU-SILC and ECHP surveys: 18 years or over, Total
#> 402                                                                                                                   At-risk-of-poverty rate for pensioners - EU-SILC and ECHP surveys: 65 years or over, Females
#> 403                                                                                                                     At-risk-of-poverty rate for pensioners - EU-SILC and ECHP surveys: 65 years or over, Males
#> 404                                                                                                                     At-risk-of-poverty rate for pensioners - EU-SILC and ECHP surveys: 65 years or over, Total
#> 405                                                                                                          Relative median at-risk-of-poverty gap of elderly people - EU-SILC and ECHP surveys: 65 years or over
#> 406                                                                                                          Relative median at-risk-of-poverty gap of elderly people - EU-SILC and ECHP surveys: 75 years or over
#> 407                                                                                                                           Formal child care by duration and age group: Less than 3 years - no formal childcare
#> 408                                                                                                           Formal child care by duration and age group: Less than 3 years - childcare from 1 to 29 hours weekly
#> 409                                                                                                             Formal child care by duration and age group: Less than 3 years - childcare 30 hours or more weekly
#> 410                                                                                                   Formal child care by duration and age group: Between 3 years and compulsory school age - no formal childcare
#> 411                                                                                   Formal child care by duration and age group: Between 3 years and compulsory school age - childcare from 1 to 29 hours weekly
#> 412                                                                                     Formal child care by duration and age group: Between 3 years and compulsory school age - childcare 30 hours or more weekly
#> 413                                                                                                                                                              Severe material deprivation rate by NUTS 2 region
#> 414                                                                                                                                        Physical and sexual violence to women by age group: From 18 to 29 years
#> 415                                                                                                                                        Physical and sexual violence to women by age group: From 18 to 74 years
#> 416                                                                                                                                        Physical and sexual violence to women by age group: From 30 to 44 years
#> 417                                                                                                                                        Physical and sexual violence to women by age group: From 45 to 64 years
#> 418                                                                                                                                        Physical and sexual violence to women by age group: From 65 to 74 years
#> 419                                                                                                                                                 Expenditure on social protection by type: Administration costs
#> 420                                                                                                                                                    Expenditure on social protection by type: Other expenditure
#> 421                                                                                                                                           Expenditure on social protection by type: Social protection benefits
#> 422                                                                                                                                             Expenditure on social protection per inhabitant at constant prices
#> 423                                                                                                                                                          Expenditure on social protection as percentage of GDP
#> 424                                                                                                                                                         Expenditure on social protection per inhabitant in PPS
#> 425                                                                                                                                                                   Expenditure on pensions as percentage of GDP
#> 426                                                                                                                                                                    Net social benefits by function: Disability
#> 427                                                                                                                                                      Net social benefits by function: Social exclusion, n.e.c.
#> 428                                                                                                                                                               Net social benefits by function: Family/children
#> 429                                                                                                                                                                       Net social benefits by function: Housing
#> 430                                                                                                                                                                       Net social benefits by function: Old age
#> 431                                                                                                                                                          Net social benefits by function: Sickness/health care
#> 432                                                                                                                                                                     Net social benefits by function: Survivors
#> 433                                                                                                                                                                         Net social benefits by function: Total
#> 434                                                                                                                                                                  Net social benefits by function: Unemployment
#> 435                                                                                                                                                          Social benefits by function - million EUR: Disability
#> 436                                                                                                                                            Social benefits by function - million EUR: Social exclusion, n.e.c.
#> 437                                                                                                                                                     Social benefits by function - million EUR: Family/children
#> 438                                                                                                                                                             Social benefits by function - million EUR: Housing
#> 439                                                                                                                                                             Social benefits by function - million EUR: Old age
#> 440                                                                                                                                                Social benefits by function - million EUR: Sickness/health care
#> 441                                                                                                                                                           Social benefits by function - million EUR: Survivors
#> 442                                                                                                                                                               Social benefits by function - million EUR: Total
#> 443                                                                                                                                                        Social benefits by function - million EUR: Unemployment
#> 444                                                                                                                      Social protection receipts by type as percentage of GDP: General government contributions
#> 445                                                                                                                                        Social protection receipts by type as percentage of GDP: Other receipts
#> 446                                                                                                                       Social protection receipts by type as percentage of GDP: Employers' social contributions
#> 447                                                                                                               Social protection receipts by type as percentage of GDP: Protected persons' social contributions
#> 448                                                                                                                                                 Victims of trafficking in human beings by sex: Females, Number
#> 449                                                                                                                       Victims of trafficking in human beings by sex: Females, Per hundred thousand inhabitants
#> 450                                                                                                                                                   Victims of trafficking in human beings by sex: Males, Number
#> 451                                                                                                                         Victims of trafficking in human beings by sex: Males, Per hundred thousand inhabitants
#> 452                                                                                                                                                   Victims of trafficking in human beings by sex: Total, Number
#> 453                                                                                                                         Victims of trafficking in human beings by sex: Total, Per hundred thousand inhabitants
#> 454                                                                                                              Nights spent at tourist accommodation establishments by residents/non-residents: Domestic country
#> 455                                                                                                               Nights spent at tourist accommodation establishments by residents/non-residents: Foreign country
#> 456                                                                                                                         Nights spent at tourist accommodation establishments by residents/non-residents: Total
#> 457                                                                                                                 Nights spent at tourist accommodation establishments by NACE: Hotels and similar accommodation
#> 458                                Nights spent at tourist accommodation establishments by NACE: Hotels; holiday and other short-stay accommodation; camping grounds, recreational vehicle parks and trailer parks
#> 459                                                                                                       Nights spent at tourist accommodation establishments by NACE: Holiday and other short-stay accommodation
#> 460                                        Nights spent at tourist accommodation establishments by NACE: Holiday and other short-stay accommodation; camping grounds, recreational vehicle parks and trailer parks
#> 461                                                                                    Nights spent at tourist accommodation establishments by NACE: Camping grounds, recreational vehicle parks and trailer parks
#> 462                                                                                               Nights spent at tourist accommodation establishments by country/world region of residence of the tourist: Europe
#> 463                                                                           Nights spent at tourist accommodation establishments by country/world region of residence of the tourist: All countries of the world
#> 464                                                                                                                  Arrivals of residents/non-residents at tourist accommodation establishments: Domestic country
#> 465                                                                                                                   Arrivals of residents/non-residents at tourist accommodation establishments: Foreign country
#> 466                                                                                                                             Arrivals of residents/non-residents at tourist accommodation establishments: Total
#> 467                                                                        Net occupancy rate of bed-places and bedrooms in hotels and similar accommodation (NACE Rev. 2, I, 55.1) (from 2012 onwards): Bedplaces
#> 468                                                                         Net occupancy rate of bed-places and bedrooms in hotels and similar accommodation (NACE Rev. 2, I, 55.1) (from 2012 onwards): Bedrooms
#> 469                                                                                                                                                             Number of establishments and bed-places: Bedplaces
#> 470                                                                                                                                                        Number of establishments and bed-places: Establishments
#> 471                                                                                                                                       Number of bed-places by NACE Rev.2 (I): Hotels and similar accommodation
#> 472                                                      Number of bed-places by NACE Rev.2 (I): Hotels; holiday and other short-stay accommodation; camping grounds, recreational vehicle parks and trailer parks
#> 473                                                                                                                             Number of bed-places by NACE Rev.2 (I): Holiday and other short-stay accommodation
#> 474                                                              Number of bed-places by NACE Rev.2 (I): Holiday and other short-stay accommodation; camping grounds, recreational vehicle parks and trailer parks
#> 475                                                                                                          Number of bed-places by NACE Rev.2 (I): Camping grounds, recreational vehicle parks and trailer parks
#> 476                                                                                                                                            Number of establishments and bed-places by NUTS 2 region: Bedplaces
#> 477                                                                                                                                       Number of establishments and bed-places by NUTS 2 region: Establishments
#> 478                                                                                                     Persons participating in tourism for personal purposes by age group - number of tourists: 15 years or over
#> 479                                                                                                     Persons participating in tourism for personal purposes by age group - number of tourists: 65 years or over
#> 480                                                                                                  Persons participating in tourism for personal purposes by age group - number of tourists: From 15 to 24 years
#> 481                                                                                                  Persons participating in tourism for personal purposes by age group - number of tourists: From 25 to 34 years
#> 482                                                                                                  Persons participating in tourism for personal purposes by age group - number of tourists: From 25 to 44 years
#> 483                                                                                                  Persons participating in tourism for personal purposes by age group - number of tourists: From 35 to 44 years
#> 484                                                                                                  Persons participating in tourism for personal purposes by age group - number of tourists: From 45 to 54 years
#> 485                                                                                                  Persons participating in tourism for personal purposes by age group - number of tourists: From 45 to 64 years
#> 486                                                                                                  Persons participating in tourism for personal purposes by age group - number of tourists: From 55 to 64 years
#> 487                                                                                                                        Participation in tourism for personal purposes - % of total population: 1 night or over
#> 488                                                                                                                       Participation in tourism for personal purposes - % of total population: 4 nights or over
#> 489                                                                                                                     Participation in tourism for personal purposes - % of total population: From 1 to 3 nights
#> 490                                                                                                                   Persons participating in tourism for personal purposes - number of tourists: 1 night or over
#> 491                                                                                                                  Persons participating in tourism for personal purposes - number of tourists: 4 nights or over
#> 492                                                                                                                Persons participating in tourism for personal purposes - number of tourists: From 1 to 3 nights
#> 493                                                                                                                                                                             Trips by purpose: Personal reasons
#> 494                                                                                                                                                             Trips by purpose: Holidays, leisure and recreation
#> 495                                                                                                                                                                       Trips by purpose: Other personal reasons
#> 496                                                                                                                                                              Trips by purpose: Visits to friends and relatives
#> 497                                                                                                                                                                       Trips by purpose: Professional, business
#> 498                                                                                                                                                                                        Trips by purpose: Total
#> 499                                                                                                                                                                 Trips by duration of the trip: 1 night or over
#> 500                                                                                                                                                                Trips by duration of the trip: 4 nights or over
#> 501                                                                                                                                                              Trips by duration of the trip: From 1 to 3 nights
#> 502                                                                                                                                                            Trips by duration of the trip: From 15 to 28 nights
#> 503                                                                                                                                                            Trips by duration of the trip: From 29 to 91 nights
#> 504                                                                                                                                                              Trips by duration of the trip: From 4 to 7 nights
#> 505                                                                                                                                                             Trips by duration of the trip: From 8 to 14 nights
#> 506                                                                                                                                                                      Nights spent by purpose: Personal reasons
#> 507                                                                                                                                                      Nights spent by purpose: Holidays, leisure and recreation
#> 508                                                                                                                                                                Nights spent by purpose: Other personal reasons
#> 509                                                                                                                                                       Nights spent by purpose: Visits to friends and relatives
#> 510                                                                                                                                                                Nights spent by purpose: Professional, business
#> 511                                                                                                                                                                                 Nights spent by purpose: Total
#> 512                                                                                                                                                          Nights spent by duration of the trip: 1 night or over
#> 513                                                                                                                                                         Nights spent by duration of the trip: 4 nights or over
#> 514                                                                                                                                                       Nights spent by duration of the trip: From 1 to 3 nights
#> 515                                                                                                                                                     Nights spent by duration of the trip: From 15 to 28 nights
#> 516                                                                                                                                                     Nights spent by duration of the trip: From 29 to 91 nights
#> 517                                                                                                                                                       Nights spent by duration of the trip: From 4 to 7 nights
#> 518                                                                                                                                                      Nights spent by duration of the trip: From 8 to 14 nights
#> 519                                                                                                                                                                                  Average expenditure per night
#> 520                                                                                                                                                                                   Average expenditure per trip
#> 521                                                                                               Share of irrigable and irrigated areas in utilised agricultural area (UAA): Irrigable utilised agricultural area
#> 522                                                                                               Share of irrigable and irrigated areas in utilised agricultural area (UAA): Irrigated utilised agricultural area
#> 523                                                                                                                                                  Agricultural holdings with organic utilised agricultural area
#> 524                                                                                                                                                             Agricultural holdings by legal form: Group holding
#> 525                                                                                                                                                              Agricultural holdings by legal form: Legal person
#> 526                                                                                                                                                            Agricultural holdings by legal form: Natural person
#> 527                                                                                                                                                                     Agricultural holdings by legal form: Total
#> 528                                                                                                                                                          Agricultural holdings by legal form: Common land unit
#> 529                                                                                                                                                                                     Farm land use: Arable land
#> 530                                                                                                                                                                                       Farm land use: Farm area
#> 531                                                                                                                                                                   Farm land use: Permanent grassland - outdoor
#> 532                                                                                                                                                                                 Farm land use: Permanent crops
#> 533                                                                                                                                                                      Farm land use: Utilised agricultural area
#> 534                                                                                  Farm land use: Fully converted and under conversion to organic farming utilised agricultural area (excluding kitchen gardens)
#> 535                                                                                                                                      Share of main land types in utilised agricultural area (UAA): Arable land
#> 536                                                                                                                    Share of main land types in utilised agricultural area (UAA): Permanent grassland - outdoor
#> 537                                                                                                                                  Share of main land types in utilised agricultural area (UAA): Permanent crops
#> 538                                                                                                                Agricultural holdings with livestock: Livestock excluding live horses, asses, mules and hinnies
#> 539                                                                                                                                                      Agricultural holdings with livestock: Live bovine animals
#> 540                                                                                                                                             Agricultural holdings with livestock: Live swine, domestic species
#> 541                                                                                                                                                               Agricultural holdings with livestock: Live sheep
#> 542                                                                                                                                                               Agricultural holdings with livestock: Live goats
#> 543                                                                                                                                                             Agricultural holdings with livestock: Live poultry
#> 544                                                                                                                                                Agricultural holdings with livestock: Rabbits, breeding females
#> 545                                                                                                                                                             Agricultural holdings with livestock: Bees (hives)
#> 546                                                                                                                                                        Agricultural holdings by age of manager: Not applicable
#> 547                                                                                                                                                                 Agricultural holdings by age of manager: Total
#> 548                                                                                                                                                      Agricultural holdings by age of manager: 65 years or over
#> 549                                                                                                                                                    Agricultural holdings by age of manager: Less than 25 years
#> 550                                                                                                                                                   Agricultural holdings by age of manager: From 25 to 34 years
#> 551                                                                                                                                                   Agricultural holdings by age of manager: From 35 to 39 years
#> 552                                                                                                                                                   Agricultural holdings by age of manager: From 40 to 44 years
#> 553                                                                                                                                                   Agricultural holdings by age of manager: From 45 to 54 years
#> 554                                                                                                                                                   Agricultural holdings by age of manager: From 55 to 64 years
#> 555                                                                                                                         Farm labour force: Farm labour force, directly employed by the farm on a regular basis
#> 556                                                                                                                                                   Farm labour force: Sole holder directly employed by the farm
#> 557                                                                                                        Farm labour force: Members of sole holders' family, excluding the holder, directly employed by the farm
#> 558                                                                                                              Farm labour force: Non-family farm labour force, directly employed by the farm on a regular basis
#> 559                                                                                                                                                      Farm labour force: Farm managers, excluding group holding
#> 560                                                                                                                                                                                       Farm labour force: Total
#> 561                                                                                                               Output of the agricultural industry - basic and producer prices: Production value at basic price
#> 562                                                                                                            Output of the agricultural industry - basic and producer prices: Production value at producer price
#> 563                                                                                                    Gross value added of the agricultural industry - basic and producer prices: Production value at basic price
#> 564                                                                                                 Gross value added of the agricultural industry - basic and producer prices: Production value at producer price
#> 565                                                                                                                                     Animal output - basic and producer prices: Production value at basic price
#> 566                                                                                                                                  Animal output - basic and producer prices: Production value at producer price
#> 567                                                                                                                                                           Indicator A of the income from agricultural activity
#> 568                                                                                                                                                                                        Selling prices of maize
#> 569                                                                                                                                                                                       Selling prices of barley
#> 570                                                                                                                                                                      Selling prices of sugar beet (unit value)
#> 571                                                                                                                                                                           Selling prices of main crop potatoes
#> 572                                                                                                                                                                                   Selling prices of soft wheat
#> 573                                                                                                                                                                                         Selling prices of oats
#> 574                                                                                                                                                                   Selling prices of chickens (live 1st choice)
#> 575                                                                                                                                                                                   Selling prices of fresh eggs
#> 576                                                                                                                                                                                        Selling prices of sheep
#> 577                                                                                                                                                                                      Selling prices of piglets
#> 578                                                                                                                                                                                 Selling prices of pigs (light)
#> 579                                                                                                                                                                               Selling prices of raw cow's milk
#> 580                                                                                                                                                                                       Selling prices of calves
#> 581                                                                                                                                  Purchase price indices, total means of agricultural production: Nominal index
#> 582                                                                                                                                     Purchase price indices, total means of agricultural production: Real index
#> 583                                                                                                                                                           Producer price indices, crop products: Nominal index
#> 584                                                                                                                                                              Producer price indices, crop products: Real index
#> 585                                                                                                                                           Producer price indices, total agricultural production: Nominal index
#> 586                                                                                                                                              Producer price indices, total agricultural production: Real index
#> 587                                                                                                                                             Producer price indices, animals and animal products: Nominal index
#> 588                                                                                                                                                Producer price indices, animals and animal products: Real index
#> 589                                                                                                                                                                                           Production of butter
#> 590                                                                                                                                                                                           Production of cheese
#> 591                                                                                                                                                                                       Collection of cow's milk
#> 592                                                                                                                                                                                      Production of milk powder
#> 593                                                                                                                                                                                    Production of milk on farms
#> 594                                                                                                                                                             Production of cow's milk on farms by NUTS 2 region
#> 595                                                                                                                                                       Production of sheepmeat and goat meat in slaughterhouses
#> 596                                                                                                                                                                   Production of bovine meat in slaughterhouses
#> 597                                                                                                                                                                  Production of poultry meat in slaughterhouses
#> 598                                                                                                                                                                       Production of pigmeat in slaughterhouses
#> 599                                                                                                                                                                                           Number of dairy cows
#> 600                                                                                                                                                                                       Number of bovine animals
#> 601                                                                                                                                                                                                 Number of pigs
#> 602                                                                                                                                                                                                Number of sheep
#> 603                                                                                                                                                       Animal populations by NUTS 2 region: Live bovine animals
#> 604                                                                                                                                                                Animal populations by NUTS 2 region: Dairy cows
#> 605                                                                                                                                              Animal populations by NUTS 2 region: Live swine, domestic species
#> 606                                                                                                                                                                Animal populations by NUTS 2 region: Live sheep
#> 607                                                                                                                                                                Animal populations by NUTS 2 region: Live goats
#> 608                                                                                                                                                          Utilised agricultural area by categories: Arable land
#> 609                                                                                                                                                  Utilised agricultural area by categories: Permanent grassland
#> 610                                                                                                                                                      Utilised agricultural area by categories: Kitchen gardens
#> 611                                                                                                                                                      Utilised agricultural area by categories: Permanent crops
#> 612                                                                                                                                           Utilised agricultural area by categories: Utilised agricultural area
#> 613                                                                                                          Final energy consumption by agriculture and forestry sector per hectare of utilised agricultural area
#> 614                                                                                                                Fresh vegetables and strawberries by area: Fresh vegetables (including melons) and strawberries
#> 615                                                                                                                                                            Fresh vegetables and strawberries by area: Tomatoes
#> 616                                                                                                                                                           Fresh vegetables and strawberries by area: Cucumbers
#> 617                                                                                                                                                             Fresh vegetables and strawberries by area: Carrots
#> 618                                                                                                                                                              Fresh vegetables and strawberries by area: Onions
#> 619                                                                                                                                                          Permanent crops for human consumption by area: Apples
#> 620                                                                                                                                                           Permanent crops for human consumption by area: Pears
#> 621                                                                                                                                                        Permanent crops for human consumption by area: Cherries
#> 622                                                                                                                           Permanent crops for human consumption by area: Permanent crops for human consumption
#> 623                                                                                                                                                         Permanent crops for human consumption by area: Oranges
#> 624                                                                                                         Wheat and spelt by area, production and humidity: Area (sown/harvested/production) - thousand hectares
#> 625                                                                                               Wheat and spelt by area, production and humidity: Harvested production in EU standard humidity - thousand tonnes
#> 626                                                                                                                            Wheat and spelt by area, production and humidity: EU standard humidity - percentage
#> 627                                                                                                                                Rape, turnip rape, sunflower seeds and soya by area: Rape and turnip rape seeds
#> 628                                                                                                                                            Rape, turnip rape, sunflower seeds and soya by area: Sunflower seed
#> 629                                                                                                                                                      Rape, turnip rape, sunflower seeds and soya by area: Soya
#> 630                                                                                                                 Root crops and plants harvested green from arable land by area: Temporary grasses and grazings
#> 631                                                                                                              Root crops and plants harvested green from arable land by area: Leguminous plants harvested green
#> 632                                                                                          Root crops and plants harvested green from arable land by area: Other cereals harvested green (excluding green maize)
#> 633                                                                                                             Root crops and plants harvested green from arable land by area: Potatoes (including seed potatoes)
#> 634                                                                                                                    Root crops and plants harvested green from arable land by area: Sugar beet (excluding seed)
#> 635                                                                                                             Green maize by area, production and humidity: Area (sown/harvested/production) - thousand hectares
#> 636                                                                                                   Green maize by area, production and humidity: Harvested production in EU standard humidity - thousand tonnes
#> 637                                                                                                                                Green maize by area, production and humidity: EU standard humidity - percentage
#> 638                                                                                                                  Barley by area, production and humidity: Area (sown/harvested/production) - thousand hectares
#> 639                                                                                                        Barley by area, production and humidity: Harvested production in EU standard humidity - thousand tonnes
#> 640                                                                                                                                     Barley by area, production and humidity: EU standard humidity - percentage
#> 641            Dry pulses and protein crops for the production of grain (including seed and mixtures of cereals and pulses) by area, production and humidity: Area (sown/harvested/production) - thousand hectares
#> 642  Dry pulses and protein crops for the production of grain (including seed and mixtures of cereals and pulses) by area, production and humidity: Harvested production in EU standard humidity - thousand tonnes
#> 643                               Dry pulses and protein crops for the production of grain (including seed and mixtures of cereals and pulses) by area, production and humidity: EU standard humidity - percentage
#> 644                                                                                         Oats and spring cereal mixtures by area, production and humidity: Area (sown/harvested/production) - thousand hectares
#> 645                                                                               Oats and spring cereal mixtures by area, production and humidity: Harvested production in EU standard humidity - thousand tonnes
#> 646                                                                                                            Oats and spring cereal mixtures by area, production and humidity: EU standard humidity - percentage
#> 647                                                                    Cereals for the production of grain (including seed) by area, production and humidity: Area (sown/harvested/production) - thousand hectares
#> 648                                                          Cereals for the production of grain (including seed) by area, production and humidity: Harvested production in EU standard humidity - thousand tonnes
#> 649                                                                                       Cereals for the production of grain (including seed) by area, production and humidity: EU standard humidity - percentage
#> 650                                                                                                                                                                                   Grapes by production: Grapes
#> 651                                                                                                                                                                         Grapes by production: Grapes for wines
#> 652                                                                                                                                                                     Grapes by production: Grapes for table use
#> 653                                                                                                                                                                       Grapes by production: Grapes for raisins
#> 654                                                                                            Grain maize and corn-cob-mix by area, production and humidity: Area (sown/harvested/production) - thousand hectares
#> 655                                                                                  Grain maize and corn-cob-mix by area, production and humidity: Harvested production in EU standard humidity - thousand tonnes
#> 656                                                                                                               Grain maize and corn-cob-mix by area, production and humidity: EU standard humidity - percentage
#> 657                                                                                                                                                                     Olives by production: Olives for table use
#> 658                                                                                                                                                                           Olives by production: Olives for oil
#> 659                                                                                          Rye and winter cereal mixtures by area, production and humidity: Area (sown/harvested/production) - thousand hectares
#> 660                                                                                Rye and winter cereal mixtures by area, production and humidity: Harvested production in EU standard humidity - thousand tonnes
#> 661                                                                                                             Rye and winter cereal mixtures by area, production and humidity: EU standard humidity - percentage
#> 662                                                                                                              Estimated soil loss by water erosion by land cover type: Agricultural areas and natural grassland
#> 663                                                                                                                        Estimated soil loss by water erosion by land cover type: Pastures and natural grassland
#> 664                                                                                                               Estimated soil loss by water erosion by land cover type: Agricultural areas (excluding pastures)
#> 665                                                                                                                  Share of landcover types affected by severe erosion: Agricultural areas and natural grassland
#> 666                                                                                                                            Share of landcover types affected by severe erosion: Pastures and natural grassland
#> 667                                                                                                                   Share of landcover types affected by severe erosion: Agricultural areas (excluding pastures)
#> 668                                                                                                                                                                                  Catches in all fishing region
#> 669                                                                                                                                                                               Fishing Fleet, Number of Vessels
#> 670                                                                                                                                                                                   Fishing fleet, total tonnage
#> 671                                                                                                                                                               Aquaculture production in tonnes and value: Euro
#> 672                                                                                                                                                     Aquaculture production in tonnes and value: Euro per tonne
#> 673                                                                                                                                                 Aquaculture production in tonnes and value: Tonnes live weight
#> 674                                                                                                                          Share of trade with the EU27 (from 2020): Share of exports to EU in total exports (%)
#> 675                                                                                                                        Share of trade with the EU27 (from 2020): Share of imports from EU in total imports (%)
#> 676                                                                                                                                     Trade volume indices, by reporting country: Export volume index (2021=100)
#> 677                                                                                                                                     Trade volume indices, by reporting country: Import volume index (2021=100)
#> 678                                                                                                                                       Trade volume indices, by reporting country: Volume ratio (export/import)
#> 679                                                                                                                             Trade unit value indices, by reporting country: Export unit value index (2021=100)
#> 680                                                                                                                             Trade unit value indices, by reporting country: Import unit value index (2021=100)
#> 681                                                                                                                                 Trade unit value indices, by reporting country: Terms of trade (export/import)
#> 682                                                                                                                    International trade, by reporting country, total product: Trade balance in million ECU/EURO
#> 683                                                                                                                       International trade, by reporting country, total product: Exports in million of ECU/EURO
#> 684                                                                                                                       International trade, by reporting country, total product: Imports in million of ECU/EURO
#> 685                                                                                  International trade of EFTA and enlargement countries, by reporting country, total product: Trade balance in million ECU/EURO
#> 686                                                                                     International trade of EFTA and enlargement countries, by reporting country, total product: Exports in million of ECU/EURO
#> 687                                                                                     International trade of EFTA and enlargement countries, by reporting country, total product: Imports in million of ECU/EURO
#> 688                                                                                                             Intra-EU27 (from 2020) trade, by Member State, total product: Share of exports by Member State (%)
#> 689                                                                                                             Intra-EU27 (from 2020) trade, by Member State, total product: Share of imports by Member State (%)
#> 690                                                                                                                Intra-EU27 (from 2020) trade, by Member State, total product: Trade balance in million ECU/EURO
#> 691                                                                                                                   Intra-EU27 (from 2020) trade, by Member State, total product: Exports in million of ECU/EURO
#> 692                                                                                                                   Intra-EU27 (from 2020) trade, by Member State, total product: Imports in million of ECU/EURO
#> 693                                                                                                             Extra-EU27 (from 2020) trade, by Member State, total product: Share of exports by Member State (%)
#> 694                                                                                                             Extra-EU27 (from 2020) trade, by Member State, total product: Share of imports by Member State (%)
#> 695                                                                                                                Extra-EU27 (from 2020) trade, by Member State, total product: Trade balance in million ECU/EURO
#> 696                                                                                                                   Extra-EU27 (from 2020) trade, by Member State, total product: Exports in million of ECU/EURO
#> 697                                                                                                                   Extra-EU27 (from 2020) trade, by Member State, total product: Imports in million of ECU/EURO
#> 698                                                                                                                                                           Air transport of passengers by country (yearly data)
#> 699                                                                                                                                                                Air transport of goods by country (yearly data)
#> 700                                                                                                                                                                   Air transport of passengers by NUTS 2 region
#> 701                                                                                                                                                                      Air transport of freight by NUTS 2 region
#> 702                                                                                                                                             Goods transport by inland waterways: Million tonne-kilometre (TKM)
#> 703                                                                                                                                                           Goods transport by inland waterways: Thousand tonnes
#> 704                                                                                                                                                                                         Sea transport of goods
#> 705                                                                                                                                                              Maritime transport of passengers by NUTS 2 region
#> 706                                                                                                                                                                 Maritime transport of freight by NUTS 2 region
#> 707                                                                                                                                                                                  Total length of railway lines
#> 708                                                                                                                                                                                   Rail transport of passengers
#> 709                                                                                                                                                         Goods transport by rail: Million tonne-kilometre (TKM)
#> 710                                                                                                                                                                       Goods transport by rail: Thousand tonnes
#> 711                                                                                                                                                                           Total length of motorways: Motorways
#> 712                                                                                                                                                                             Total length of motorways: E-roads
#> 713                                                                                                                                                         Goods transport by road: Million tonne-kilometre (TKM)
#> 714                                                                                                                                                                       Goods transport by road: Thousand tonnes
#> 715                                                                                                                                                                       Rail network by NUTS 2 region: Kilometre
#> 716                                                                                                                                       Rail network by NUTS 2 region: Kilometres per thousand square kilometres
#> 717                                                                                                                                                                  Motorways network by NUTS 2 region: Kilometre
#> 718                                                                                                                                  Motorways network by NUTS 2 region: Kilometres per thousand square kilometres
#> 719                                                                                                                               Share of rail and inland waterways in inland freight transport: Inland waterways
#> 720                                                                                                                                       Share of rail and inland waterways in inland freight transport: Railways
#> 721                                                                                             Share of rail and inland waterways in inland freight transport: Railways, inland waterways - sum of available data
#> 722                                                                                                                Share of buses and trains in inland passenger transport: Motor coaches, buses and trolley buses
#> 723                                                                                                                                                Share of buses and trains in inland passenger transport: Trains
#> 724                                                                                Share of buses and trains in inland passenger transport: Trains, motor coaches, buses and trolley buses - sum of available data
#> 725                                                                                                                                                                  Volume of passenger transport relative to GDP
#> 726                                                                                                                                                          Greenhouse gases emissions from production activities
#> 727                                                                                                                                                      Ammonia emissions from agriculture - % of total emissions
#> 728                                                                                                                                                             Greenhouse gas emissions from agriculture: Methane
#> 729                                                                                                                                            Greenhouse gas emissions from agriculture: Methane (CO2 equivalent)
#> 730                                                                                                                                                      Greenhouse gas emissions from agriculture: Carbon dioxide
#> 731    Greenhouse gas emissions from agriculture: Greenhouse gases (CO2, N2O in CO2 equivalent, CH4 in CO2 equivalent, HFC in CO2 equivalent, PFC in CO2 equivalent, SF6 in CO2 equivalent, NF3 in CO2 equivalent)
#> 732                                                                                                                                                       Greenhouse gas emissions from agriculture: Nitrous oxide
#> 733                                                                                                                                      Greenhouse gas emissions from agriculture: Nitrous oxide (CO2 equivalent)
#> 734                                                                                                                                                                       Domestic material consumption per capita
#> 735                                                                                                                 Environmental tax revenues as share of total taxes: Percentage of gross domestic product (GDP)
#> 736                                                  Environmental tax revenues as share of total taxes: Percentage of total revenues from taxes and social contributions (excluding imputed social contributions)
#> 737                                                                                                                                                                                                   Energy taxes
#> 738                                                                                                                                            Environmental protection investments of total economy: Million euro
#> 739                                                                                                              Environmental protection investments of total economy: Percentage of gross domestic product (GDP)
#> 740                                                                                                        Gross value added in environmental goods and services sector: Chain linked volumes (2020), million euro
#> 741                                                                                                       Gross value added in environmental goods and services sector: Percentage of gross domestic product (GDP)
#> 742                                                                                                                                                             Generation of waste by waste category: Total waste
#> 743                                                                                                                                                          Generation of waste by waste category: Common sludges
#> 744                                                                                                                                          Waste generated by households by year and waste category: Total waste
#> 745                                                                                                                                       Waste generated by households by year and waste category: Common sludges
#> 746                                                                                                                                                                Generation of waste by hazardousness: Hazardous
#> 747                                                                                                                                      Generation of waste by hazardousness: Hazardous and non-hazardous - total
#> 748                                                                                                                                                            Generation of waste by hazardousness: Non-hazardous
#> 749                                                                                                                                                          Landfill rate of waste excluding major mineral wastes
#> 750                                                                                                                                                                                                     Food waste
#> 751                                                                                                                                                                  Recovery rates for packaging waste: Packaging
#> 752                                                                                                                                              Recovery rates for packaging waste: Paper and cardboard packaging
#> 753                                                                                                                                                          Recovery rates for packaging waste: Plastic packaging
#> 754                                                                                                                                                           Recovery rates for packaging waste: Wooden packaging
#> 755                                                                                                                                                         Recovery rates for packaging waste: Metallic packaging
#> 756                                                                                                                                                            Recovery rates for packaging waste: Glass packaging
#> 757                                                                                                                                                            Recovery rates for packaging waste: Other packaging
#> 758                                                                                                                                                                 Recycling rates for packaging waste: Packaging
#> 759                                                                                                                                             Recycling rates for packaging waste: Paper and cardboard packaging
#> 760                                                                                                                                                         Recycling rates for packaging waste: Plastic packaging
#> 761                                                                                                                                                          Recycling rates for packaging waste: Wooden packaging
#> 762                                                                                                                                                        Recycling rates for packaging waste: Metallic packaging
#> 763                                                                                                                                                           Recycling rates for packaging waste: Glass packaging
#> 764                                                                                                                         Water abstracted by sector of use: Water abstraction by agriculture, forestry, fishing
#> 765                                                                                                                       Water abstracted by sector of use: Water abstraction by electricity production - cooling
#> 766                                                                                                                                 Water abstracted by sector of use: Water abstraction by manufacturing industry
#> 767                                                                                                                       Water abstracted by sector of use: Water abstraction by manufacturing industry - cooling
#> 768                                                                                                                                    Water abstracted by sector of use: Water abstraction by public water supply
#> 769                                                                                                                                                     Water abstracted by sector of use: Total gross abstraction
#> 770                                                                                                                                Fresh water abstraction by source per capita - m³ per capita: Fresh groundwater
#> 771                                                                                                                    Fresh water abstraction by source per capita - m³ per capita: Fresh surface and groundwater
#> 772                                                                                                                              Fresh water abstraction by source per capita - m³ per capita: Fresh surface water
#> 773                                                                                                  Sewage sludge production and disposal from urban wastewater (in dry substance (d.s)): Sludge disposal - total
#> 774                                                                                       Sewage sludge production and disposal from urban wastewater (in dry substance (d.s)): Sludge disposal - agricultural use
#> 775                                                                         Sewage sludge production and disposal from urban wastewater (in dry substance (d.s)): Sludge disposal - compost and other applications
#> 776                                                                                           Sewage sludge production and disposal from urban wastewater (in dry substance (d.s)): Sludge disposal - incineration
#> 777                                                                                               Sewage sludge production and disposal from urban wastewater (in dry substance (d.s)): Sludge disposal - landfill
#> 778                                                                                                  Sewage sludge production and disposal from urban wastewater (in dry substance (d.s)): Sludge disposal - other
#> 779                                                                                                Sewage sludge production and disposal from urban wastewater (in dry substance (d.s)): Sludge production - total
#> 780                                                                                                                                                                          Material footprint: Tonnes per capita
#> 781                                                                                                                                                                            Material footprint: Thousand tonnes
#> 782                                                                                                                                                                                             Material footprint
#> 783                                                                                                                                             Final energy consumption by sector: Final consumption - energy use
#> 784                                                                                                                           Final energy consumption by sector: Final consumption - industry sector - energy use
#> 785                                                                                            Final energy consumption by sector: Final consumption - other sectors - commercial and public services - energy use
#> 786                                                                                                                Final energy consumption by sector: Final consumption - other sectors - households - energy use
#> 787                                                                                                                          Final energy consumption by sector: Final consumption - transport sector - energy use
#> 788                                                                                                                                                              Final energy consumption in households per capita
#> 789                                                                                                              Share of renewable energy in gross final energy consumption by sector: Renewable energy - overall
#> 790                                                                                                          Share of renewable energy in gross final energy consumption by sector: Renewable energy - electricity
#> 791                                                                                                  Share of renewable energy in gross final energy consumption by sector: Renewable energy - heating and cooling
#> 792                                                                                                            Share of renewable energy in gross final energy consumption by sector: Renewable energy - transport
#> 793                                                                                                                                                                      Final energy consumption: Index, 2005=100
#> 794                                                                                                                                                     Final energy consumption: Million tonnes of oil equivalent
#> 795                                                                                                                                            Final energy consumption: Tonnes of oil equivalent (TOE) per capita
#> 796                                                                                                                                                                    Primary energy consumption: Index, 2005=100
#> 797                                                                                                                                                   Primary energy consumption: Million tonnes of oil equivalent
#> 798                                                                                                                                          Primary energy consumption: Tonnes of oil equivalent (TOE) per capita
#> 799                                                                                                                                                Energy productivity: Euro per kilogram of oil equivalent (KGOE)
#> 800                                                                                                                            Energy productivity: Purchasing power standard (PPS) per kilogram of oil equivalent
#> 801                                                                                                                                                       Energy import dependency by products: Solid fossil fuels
#> 802                                                                                                                                                              Energy import dependency by products: Natural gas
#> 803                                                                                                                   Energy import dependency by products: Oil and petroleum products (excluding biofuel portion)
#> 804                                                                                                                                                                    Energy import dependency by products: Total
#> 805                                                                                                                                                                          Data centres' electricity consumption
#> 806                                                                                                                      Research and development expenditure by sector of performance: Business enterprise sector
#> 807                                                                                                                               Research and development expenditure by sector of performance: Government sector
#> 808                                                                                                                         Research and development expenditure by sector of performance: Higher education sector
#> 809                                                                                                                       Research and development expenditure by sector of performance: Private non-profit sector
#> 810                                                                                                                                     Research and development expenditure by sector of performance: All sectors
#> 811                                                                                                                                                             Intramural R&D expenditure (GERD) by NUTS 2 region
#> 812                                                                                                                            Total researchers by sector of performance - head count: Business enterprise sector
#> 813                                                                                                                                     Total researchers by sector of performance - head count: Government sector
#> 814                                                                                                                               Total researchers by sector of performance - head count: Higher education sector
#> 815                                                                                                                             Total researchers by sector of performance - head count: Private non-profit sector
#> 816                                                                                                                                           Total researchers by sector of performance - head count: All sectors
#> 817                                                                                                                  Total researchers by sector of performance - full time equivalent: Business enterprise sector
#> 818                                                                                                                           Total researchers by sector of performance - full time equivalent: Government sector
#> 819                                                                                                                     Total researchers by sector of performance - full time equivalent: Higher education sector
#> 820                                                                                                                   Total researchers by sector of performance - full time equivalent: Private non-profit sector
#> 821                                                                                                                                 Total researchers by sector of performance - full time equivalent: All sectors
#> 822                                                                                                                        Research and development personnel by sector of performance: Business enterprise sector
#> 823                                                                                                                                 Research and development personnel by sector of performance: Government sector
#> 824                                                                                                                           Research and development personnel by sector of performance: Higher education sector
#> 825                                                                                                                         Research and development personnel by sector of performance: Private non-profit sector
#> 826                                                                                                                                       Research and development personnel by sector of performance: All sectors
#> 827                                                                                                                                                                    Researchers in all sectors by NUTS 2 region
#> 828                                                                                                                                                                      Share of women researchers in all sectors
#> 829                                                                                                                                Share of women researchers by sector of performance: Business enterprise sector
#> 830                                                                                                                                         Share of women researchers by sector of performance: Government sector
#> 831                                                                                                                                   Share of women researchers by sector of performance: Higher education sector
#> 832                                                                                                                                 Share of women researchers by sector of performance: Private non-profit sector
#> 833                                                                                                                                               Share of women researchers by sector of performance: All sectors
#> 834                                                                                        Share of government allocations for R&D (GBARD) allocated to defence and total civil socio-economic objectives: Defence
#> 835                                                    Share of government allocations for R&D (GBARD) allocated to defence and total civil socio-economic objectives: Total government budget allocations for R&D
#> 836                                                                            Share of government allocations for R&D (GBARD) allocated to defence and total civil socio-economic objectives: Civil budget on R&D
#> 837                                                                                                                                                                                              High-tech exports
#> 838                                   Employed persons in high and medium-high technology manufacturing sectors and knowledge-intensive service sectors (2008-2026): High and medium high-technology manufacturing
#> 839                                              Employed persons in high and medium-high technology manufacturing sectors and knowledge-intensive service sectors (2008-2026): Total knowledge-intensive services
#> 840                                                                                                                                             Employed persons in high-tech sectors by NUTS 2 region (2008-2026)
#> 841                                                                                                                                                      Human resources in science and technology (HRST): Females
#> 842                                                                                                                                                        Human resources in science and technology (HRST): Males
#> 843                                                                                                                                                        Human resources in science and technology (HRST): Total
#> 844                                                                                                                                              Human resources in science and technology (HRST) by NUTS 2 region
#> 845                                                                                          Patent applications to the European Patent Office by applicants' / inventors' country of residence: Applicant, Number
#> 846                                                                         Patent applications to the European Patent Office by applicants' / inventors' country of residence: Applicant, Per million inhabitants
#> 847                                                                                           Patent applications to the European Patent Office by applicants' / inventors' country of residence: Inventor, Number
#> 848                                                                          Patent applications to the European Patent Office by applicants' / inventors' country of residence: Inventor, Per million inhabitants
#> 849                                                                                                                                                                          Level of internet access - households
#> 850                                                                                                                                          Internet use by individuals: Last internet use: in the last 12 months
#> 851                                                                                                                                               Internet use by individuals: Last internet use: in last 3 months
#> 852                                                                                                                                       Internet use by individuals: Individuals who have ever used the internet
#> 853                                                                                                                                                               Internet use by individuals: Internet use: never
#> 854                                                                                                                                                                   Individuals who have never used the internet
#> 855                                                                                                                                                                      Individuals frequently using the internet
#> 856                                                                                                                                                                       Individuals regularly using the internet
#> 857                                                                                                                                          Individuals using the internet for seeking health-related information
#> 858                                                                                                                              Individuals using the internet for looking for a job or sending a job application
#> 859                                                                                                                                            Individuals using the internet for participating in social networks
#> 860                                                                                                                                                   Individuals using the internet for selling goods or services
#> 861                                                                                                                                Individuals using the internet for finding information about goods and services
#> 862                                                                                                                                                      Individuals using the internet for doing an online course
#> 863                                                                                                                                                   Individuals using the internet for sending/receiving e-mails
#> 864                                                                                                                                                            Individuals using the internet for internet banking
#> 865                                                                                                                         Individuals using the internet for buying goods or services: Percentage of individuals
#> 866                                                                                  Individuals using the internet for buying goods or services: Percentage of individuals who used internet within the last year
#> 867                                                                                                                                                      Individuals regularly using the internet by NUTS 2 region
#> 868                                                                                                  Individuals who ordered goods or services over the internet for private use in the last year by NUTS 2 region
#> 869                                                                                                                                     Enterprises having received orders online (at least 1%) - % of enterprises
#> 870                                                                                                                                                                   Share of enterprises' turnover on e-commerce
#> 871                                                                                                                                              Share of enterprises using any business software (ERP, CRM or BI)
#> 872                                                                                                                                           Percentage of the ICT sector in Gross value added: ICT manufacturing
#> 873                                                                                                                                                Percentage of the ICT sector in Gross value added: ICT services
#> 874                                                                                                            Percentage of the ICT sector in Gross value added: Information and Communication Technology - total
#> 875                                                                                                                                  Percentage of the ICT sector personnel in total employment: ICT manufacturing
#> 876                                                                                                                                       Percentage of the ICT sector personnel in total employment: ICT services
#> 877                                                                                                   Percentage of the ICT sector personnel in total employment: Information and Communication Technology - total
#> 878                                                                                                                            Percentage change of value added by ICT sector at current prices: ICT manufacturing
#> 879                                                                                                                                 Percentage change of value added by ICT sector at current prices: ICT services
#> 880                                                                                             Percentage change of value added by ICT sector at current prices: Information and Communication Technology - total
#> 881                                                                                                                                                     High-speed internet coverage, by type of area: Rural areas
#> 882                                                                                                                                                           High-speed internet coverage, by type of area: Total
#> 883                                                                                                     Regional gross domestic product (PPS per inhabitant in % of the EU27 (from 2020) average) by NUTS 2 region
#> 884                                                                                                                                                 Regional gross domestic product by NUTS 2 region: Million euro
#> 885                                                                                                     Regional gross domestic product by NUTS 2 region: Million purchasing power standards (PPS, EU27 from 2020)
#> 886                                                                                       Gross domestic product (GDP) and Gross value added (GVA) in volume by NUTS 2 region: Value added, gross, Index, 2020=100
#> 887                                                                  Gross domestic product (GDP) and Gross value added (GVA) in volume by NUTS 2 region: Value added, gross, Percentage change on previous period
#> 888                                                                  Gross domestic product (GDP) and Gross value added (GVA) in volume by NUTS 2 region: Gross domestic product at market prices, Index, 2020=100
#> 889                                             Gross domestic product (GDP) and Gross value added (GVA) in volume by NUTS 2 region: Gross domestic product at market prices, Percentage change on previous period
#> 890                                                                                                                                                   Death due to diseases of the nervous system, by sex: Females
#> 891                                                                                                                                                     Death due to diseases of the nervous system, by sex: Males
#> 892                                                                                                                                                     Death due to diseases of the nervous system, by sex: Total
#> 893                                                                                                                                                              Death due to transport accidents, by sex: Females
#> 894                                                                                                                                                                Death due to transport accidents, by sex: Males
#> 895                                                                                                                                                                Death due to transport accidents, by sex: Total
#> 896                                                                                                                                                                          Death due to suicide, by sex: Females
#> 897                                                                                                                                                                            Death due to suicide, by sex: Males
#> 898                                                                                                                                                                            Death due to suicide, by sex: Total
#> 899                                                                                                                                                                               Causes of death, by sex: Females
#> 900                                                                                                                                                                                 Causes of death, by sex: Males
#> 901                                                                                                                                                                                 Causes of death, by sex: Total
#> 902                                                                                                                                                            Death due to chronic liver disease, by sex: Females
#> 903                                                                                                                                                              Death due to chronic liver disease, by sex: Males
#> 904                                                                                                                                                              Death due to chronic liver disease, by sex: Total
#> 905                                                                                                                                                                  Death due to alcoholic abuse, by sex: Females
#> 906                                                                                                                                                                    Death due to alcoholic abuse, by sex: Males
#> 907                                                                                                                                                                    Death due to alcoholic abuse, by sex: Total
#> 908                                                                                                                                                                Death due to diabetes mellitus, by sex: Females
#> 909                                                                                                                                                                  Death due to diabetes mellitus, by sex: Males
#> 910                                                                                                                                                                  Death due to diabetes mellitus, by sex: Total
#> 911                                                                                                                                                   Death due to other ischaemic heart diseases, by sex: Females
#> 912                                                                                                                                                     Death due to other ischaemic heart diseases, by sex: Males
#> 913                                                                                                                                                     Death due to other ischaemic heart diseases, by sex: Total
#> 914                                                                                                                Standardised death rate due to tuberculosis, HIV and hepatitis by type of disease: Tuberculosis
#> 915                                                                             Standardised death rate due to tuberculosis, HIV and hepatitis by type of disease: Viral hepatitis and sequelae of viral hepatitis
#> 916                                                                                  Standardised death rate due to tuberculosis, HIV and hepatitis by type of disease: Human immunodeficiency virus [HIV] disease
#> 917                                                                                                                       Standardised death rate due to tuberculosis, HIV and hepatitis by type of disease: Total
#> 918                                                                                                                                                        Standardised death rate due to homicide by sex: Females
#> 919                                                                                                                                                          Standardised death rate due to homicide by sex: Males
#> 920                                                                                                                                                          Standardised death rate due to homicide by sex: Total
#> 921                                                                                                                                                                   Available beds in hospitals by NUTS 2 region
#> 922                                                                                                                        Nights spent at tourist accommodation establishments by NUTS 2 region: Domestic country
#> 923                                                                                                                         Nights spent at tourist accommodation establishments by NUTS 2 region: Foreign country
#> 924                                                                                                                                   Nights spent at tourist accommodation establishments by NUTS 2 region: Total
#> 925                                                                                                                                                  Households that have internet access at home by NUTS 2 region
#> 926                                                                                                                                                 People at risk of poverty or social exclusion by NUTS 2 region
#> 927                                                                                                                  Impact of social transfers (excluding pensions) on poverty reduction by sex and NUTS 2 region
#> 928                                                                                                                  Impact of social transfers (excluding pensions) on poverty reduction by sex and NUTS 2 region
#> 929                                                                                                                      Share of persons at risk of poverty or social exclusion by degree of urbanisation: Cities
#> 930                                                                                                           Share of persons at risk of poverty or social exclusion by degree of urbanisation: Towns and suburbs
#> 931                                                                                                                 Share of persons at risk of poverty or social exclusion by degree of urbanisation: Rural areas
#> 932                                                                                                                                 Severe housing deprivation rate by tenure status: Owner, with mortgage or loan
#> 933                                                                                                                                 Severe housing deprivation rate by tenure status: Tenant, rent at market price
#> 934                                                                                                                                                        Gender employment gap by degree of urbanisation: Cities
#> 935                                                                                                                                             Gender employment gap by degree of urbanisation: Towns and suburbs
#> 936                                                                                                                                                   Gender employment gap by degree of urbanisation: Rural areas
#> 937                                                                                                                                                   Gender employment gap by degree of urbanisation: No response
#> 938                                                                                                                                                         Gender employment gap by degree of urbanisation: Total
#> 939                                                                                                           Individuals who have basic or above basic overall digital skills by sex: Females, 16 to 74 years old
#> 940                                                                                                                       Individuals who have basic or above basic overall digital skills by sex: All individuals
#> 941                                                                                                             Individuals who have basic or above basic overall digital skills by sex: Males, 16 to 74 years old
#> 942                                                                                                                 Share of individuals having at least basic digital skills, by sex: Females, 16 to 74 years old
#> 943                                                                                                                             Share of individuals having at least basic digital skills, by sex: All individuals
#> 944                                                                                                                   Share of individuals having at least basic digital skills, by sex: Males, 16 to 74 years old
#> 945                                                                                                                                                                       Current account balance - 3 year average
#> 946                                                                                                                                                            Net international investment position - annual data
#> 947                                                                                             Share of exports of advanced economies: Percentage of the total of OECD countries and EU Member States not in OECD
#> 948                                                                                                     Share of exports of advanced economies: Percentage of OECD and non-OECD EU countries total - 1-year change
#> 949                                                                                                     Share of exports of advanced economies: Percentage of OECD and non-OECD EU countries total - 3-year change
#> 950                                                                             Share of exports of advanced economies: Percentage of the total of OECD countries and EU Member States not in OECD - 5-year change
#> 951                                                                                                                              Share of exports of advanced economies: Percentage of world total - 1-year change
#> 952                                                                                                                                        General government gross debt (EDP concept), consolidated - annual data
#> 953                                                                                                                              Household debt including non-profit institutions serving households, consolidated
#> 954                                                                                                                                                           Unemployment rate - annual data: From 15 to 24 years
#> 955                                                                                                                                                           Unemployment rate - annual data: From 15 to 74 years
#> 956                                                                                                                                                           Unemployment rate - annual data: From 25 to 74 years
#> 957                                                                                                                                                Labour force participation rate: Percentage of total population
#> 958                                                                                                                                             Labour force participation rate: Percentage point change (t-(t-3))
#> 959                                                                                                                                                                          Current account balance - annual data
#> 960                                                                                                                         Current account, main components, net balance - annual data, % of GDP: Current account
#> 961                                                                                                                                   Current account, main components, net balance - annual data, % of GDP: Goods
#> 962                                                                                                                      Current account, main components, net balance - annual data, % of GDP: Goods and services
#> 963                                                                                                                          Current account, main components, net balance - annual data, % of GDP: Primary income
#> 964                                                                                                                        Current account, main components, net balance - annual data, % of GDP: Secondary income
#> 965                                                                                                                                Current account, main components, net balance - annual data, % of GDP: Services
#> 966                                                                                                                               Current account, main component, credit - annual data, % of GDP: Current account
#> 967                                                                                                                                         Current account, main component, credit - annual data, % of GDP: Goods
#> 968                                                                                                                            Current account, main component, credit - annual data, % of GDP: Goods and services
#> 969                                                                                                                                Current account, main component, credit - annual data, % of GDP: Primary income
#> 970                                                                                                                              Current account, main component, credit - annual data, % of GDP: Secondary income
#> 971                                                                                                                                      Current account, main component, credit - annual data, % of GDP: Services
#> 972                                                                                                                               Current account, main components, debit - annual data, % of GDP: Current account
#> 973                                                                                                                                         Current account, main components, debit - annual data, % of GDP: Goods
#> 974                                                                                                                            Current account, main components, debit - annual data, % of GDP: Goods and services
#> 975                                                                                                                                Current account, main components, debit - annual data, % of GDP: Primary income
#> 976                                                                                                                              Current account, main components, debit - annual data, % of GDP: Secondary income
#> 977                                                                                                                                      Current account, main components, debit - annual data, % of GDP: Services
#> 978                                                                                                                                                                                Financial account - annual data
#> 979                                                                                                                                                  Direct investment liabilities (flows) - annual data, % of GDP
#> 980                                                                                                                                                 Direct investment liabilities (stocks) - annual data, % of GDP
#> 981                                                                                                                                                                                  Capital account - annual data
#> 982                                                                                                                                              Net Lending/Borrowing (current and capital account) - annual data
#> 983                                                                                                                                         Nominal effective exchange rate - 42 trading partners: Index, 2015=100
#> 984                                                                                                                               Nominal effective exchange rate - 42 trading partners: Percentage change (t/t-1)
#> 985                                                                                                                               Nominal effective exchange rate - 42 trading partners: Percentage change (t/t-3)
#> 986                                                                                                                Unit labour cost performance related to the euro area - annual data: Percentage change (t/t-10)
#> 987                                                                                                                 Unit labour cost performance related to the euro area - annual data: Percentage change (t/t-1)
#> 988                                                                                                                                  Nominal effective exchange rate - euro area trading partners: Index, 2015=100
#> 989                                                                                                                        Nominal effective exchange rate - euro area trading partners: Percentage change (t/t-1)
#> 990                                                                                                                        Nominal effective exchange rate - euro area trading partners: Percentage change (t/t-3)
#> 991                                                                                                                                     Real effective exchange rate - index, 42 trading partners: Index, 2015=100
#> 992                                                                                                                                     Real effective exchange rate - index, 42 trading partners: Index, 2020=100
#> 993                                                                                                                                                                      Net external debt - annual data, % of GDP
#> 994                                                                                                                         Net international investment position excluding non-defaultable instruments - % of GDP
#> 995                                                                                                                                                         Export market shares by items - 1 year % change: Goods
#> 996                                                                                                                                            Export market shares by items - 1 year % change: Goods and services
#> 997                                                                                                                                                      Export market shares by items - 1 year % change: Services
#> 998                                                                                                                                                        Export market shares by items - % of world total: Goods
#> 999                                                                                                                                           Export market shares by items - % of world total: Goods and services
#> 1000                                                                                                                                                    Export market shares by items - % of world total: Services
#> 1001                                                                                                                                                                Export market shares - 3 years % change: Goods
#> 1002                                                                                                                                                   Export market shares - 3 years % change: Goods and services
#> 1003                                                                                                                                                             Export market shares - 3 years % change: Services
#> 1004                                                                                                                              Exports of high technology products as a share of total exports, SITC Rev. 4 - %
#> 1005                                                                                                Total financial sector liabilities, non-consolidated - annual data: Percentage of gross domestic product (GDP)
#> 1006                                                                                                      Total financial sector liabilities, non-consolidated - annual data: Percentage change on previous period
#> 1007                                                                                                       Total financial sector liabilities, by sub-sectors, non-consolidated - % of GDP: Financial corporations
#> 1008                                                                                                                 Total financial sector liabilities, by sub-sectors, non-consolidated - % of GDP: Central bank
#> 1009                                                                                              Total financial sector liabilities, by sub-sectors, non-consolidated - % of GDP: Monetary financial institutions
#> 1010                                                   Total financial sector liabilities, by sub-sectors, non-consolidated - % of GDP: Deposit-taking corporations except the central bank and money market funds
#> 1011                                                                                                     Total financial sector liabilities, by sub-sectors, non-consolidated - % of GDP: Non-MMF investment funds
#> 1012                                              Total financial sector liabilities, by sub-sectors, non-consolidated - % of GDP: Other financial intermediaries, except insurance corporations and pension funds
#> 1013                                Total financial sector liabilities, by sub-sectors, non-consolidated - % of GDP: Other financial intermediaries (except ICPFs), financial auxiliaries, CFIs, and money lenders
#> 1014                                                                                                        Total financial sector liabilities, by instruments, non-consolidated - % of GDP: Currency and deposits
#> 1015                                                                          Total financial sector liabilities, by instruments, non-consolidated - % of GDP: Total financial sector liabilities (excluding SDRs)
#> 1016                                                                                                              Total financial sector liabilities, by instruments, non-consolidated - % of GDP: Debt securities
#> 1017                                                                                                                        Total financial sector liabilities, by instruments, non-consolidated - % of GDP: Loans
#> 1018                                                                                            Total financial sector liabilities, by instruments, non-consolidated - % of GDP: Equity and investment fund shares
#> 1019                                                                              Total financial sector liabilities, by instruments, non-consolidated - % of GDP: Insurance, pensions and standardised guarantees
#> 1020                                                                             Total financial sector liabilities, by instruments, non-consolidated - % of GDP: Financial derivatives and employee stock options
#> 1021                                                                                            Total financial sector liabilities, by instruments, non-consolidated - % of GDP: Other accounts receivable/payable
#> 1022                                                                                                                                               Financial sector leverage, debt to equity, non-consolidated - %
#> 1023                                                                                                                  Total financial sector liabilities, consolidated: Percentage of gross domestic product (GDP)
#> 1024                                                                                                                        Total financial sector liabilities, consolidated: Percentage change on previous period
#> 1025                                                                                                           Total financial sector liabilities, by sub-sectors, consolidated - % of GDP: Financial corporations
#> 1026                                                                                                                     Total financial sector liabilities, by sub-sectors, consolidated - % of GDP: Central bank
#> 1027                                                                                                  Total financial sector liabilities, by sub-sectors, consolidated - % of GDP: Monetary financial institutions
#> 1028                                                       Total financial sector liabilities, by sub-sectors, consolidated - % of GDP: Deposit-taking corporations except the central bank and money market funds
#> 1029                                                                                                         Total financial sector liabilities, by sub-sectors, consolidated - % of GDP: Non-MMF investment funds
#> 1030                                                  Total financial sector liabilities, by sub-sectors, consolidated - % of GDP: Other financial intermediaries, except insurance corporations and pension funds
#> 1031                                    Total financial sector liabilities, by sub-sectors, consolidated - % of GDP: Other financial intermediaries (except ICPFs), financial auxiliaries, CFIs, and money lenders
#> 1032                                                                                                            Total financial sector liabilities, by instruments, consolidated - % of GDP: Currency and deposits
#> 1033                                                                              Total financial sector liabilities, by instruments, consolidated - % of GDP: Total financial sector liabilities (excluding SDRs)
#> 1034                                                                                                                  Total financial sector liabilities, by instruments, consolidated - % of GDP: Debt securities
#> 1035                                                                                                                            Total financial sector liabilities, by instruments, consolidated - % of GDP: Loans
#> 1036                                                                                                Total financial sector liabilities, by instruments, consolidated - % of GDP: Equity and investment fund shares
#> 1037                                                                                  Total financial sector liabilities, by instruments, consolidated - % of GDP: Insurance, pensions and standardised guarantees
#> 1038                                                                                 Total financial sector liabilities, by instruments, consolidated - % of GDP: Financial derivatives and employee stock options
#> 1039                                                                                                Total financial sector liabilities, by instruments, consolidated - % of GDP: Other accounts receivable/payable
#> 1040                                                                                                      Private sector debt: debt securities by sectors, non-consolidated - % of GDP: Non-financial corporations
#> 1041                                                                                                                      Private sector debt: debt securities by sectors, non-consolidated - % of GDP: Households
#> 1042                                                                                      Private sector debt: debt securities by sectors, non-consolidated - % of GDP: Non-profit institutions serving households
#> 1043                                                                                                               Private sector debt: loans, by sectors, non-consolidated - % of GDP: Non-financial corporations
#> 1044                                                                                                                               Private sector debt: loans, by sectors, non-consolidated - % of GDP: Households
#> 1045                                                                                               Private sector debt: loans, by sectors, non-consolidated - % of GDP: Non-profit institutions serving households
#> 1046                                                                                                                                                                  Private sector debt, consolidated - % of GDP
#> 1047                                                                                                         Private sector debt: debt securities, by sectors, consolidated - % of GDP: Non-financial corporations
#> 1048                                                                                                                         Private sector debt: debt securities, by sectors, consolidated - % of GDP: Households
#> 1049                                                                                         Private sector debt: debt securities, by sectors, consolidated - % of GDP: Non-profit institutions serving households
#> 1050                                                                                                                   Private sector debt: loans, by sectors, consolidated - % of GDP: Non-financial corporations
#> 1051                                                                                                                                   Private sector debt: loans, by sectors, consolidated - % of GDP: Households
#> 1052                                                                                                   Private sector debt: loans, by sectors, consolidated - % of GDP: Non-profit institutions serving households
#> 1053                                                                                               Private sector credit flow: debt securities by sectors, non-consolidated - % of GDP: Non-financial corporations
#> 1054                                                                                                               Private sector credit flow: debt securities by sectors, non-consolidated - % of GDP: Households
#> 1055                                                                               Private sector credit flow: debt securities by sectors, non-consolidated - % of GDP: Non-profit institutions serving households
#> 1056                                                                                                         Private sector credit flow: loans by sectors, non-consolidated - % of GDP: Non-financial corporations
#> 1057                                                                                                                         Private sector credit flow: loans by sectors, non-consolidated - % of GDP: Households
#> 1058                                                                                         Private sector credit flow: loans by sectors, non-consolidated - % of GDP: Non-profit institutions serving households
#> 1059                                                                                                                                                              Private sector credit flow, consolidated - % GDP
#> 1060                                                                                                   Private sector credit flow: debt securities by sectors, consolidated - % of GDP: Non-financial corporations
#> 1061                                                                                                                   Private sector credit flow: debt securities by sectors, consolidated - % of GDP: Households
#> 1062                                                                                   Private sector credit flow: debt securities by sectors, consolidated - % of GDP: Non-profit institutions serving households
#> 1063                                                                                                             Private sector credit flow: loans by sectors, consolidated - % of GDP: Non-financial corporations
#> 1064                                                                                                                             Private sector credit flow: loans by sectors, consolidated - % of GDP: Households
#> 1065                                                                                             Private sector credit flow: loans by sectors, consolidated - % of GDP: Non-profit institutions serving households
#> 1066                                                                                                                                                                            Unemployment rate - 3 year average
#> 1067                                                                                                  Long-term unemployment rate, % of active population aged 15-74: Percentage of population in the labour force
#> 1068                                                                                                             Long-term unemployment rate, % of active population aged 15-74: Percentage point change (t-(t-3))
#> 1069                                                                                                     Youth unemployment rate - % of active population aged 15-24: Percentage of population in the labour force
#> 1070                                                                                                                Youth unemployment rate - % of active population aged 15-24: Percentage point change (t-(t-3))
#> 1071                            Young persons (aged 15-24) neither in employment nor in education and training - % of total population in private households in the same age group: Percentage of total population
#> 1072                         Young persons (aged 15-24) neither in employment nor in education and training - % of total population in private households in the same age group: Percentage point change (t-(t-3))
#> 1073                                                                                                                                                 Labour force participation rate, aged 15-64 - annual averages
#> 1074                                                                                                                                                             Population aged 15-74 in private households - LFS
#> 1075                                                                                                                                                     People at risk of poverty or social exclusion: Percentage
#> 1076                                                                                                                              People at risk of poverty or social exclusion: Percentage point change (t-(t-3))
#> 1077                                                                                                                                                   People at risk of poverty after social transfer: Percentage
#> 1078                                                                                                                            People at risk of poverty after social transfer: Percentage point change (t-(t-3))
#> 1079                                                                                                                                                  Severely materially and socially deprived people: Percentage
#> 1080                                                                                                                           Severely materially and socially deprived people: Percentage point change (t-(t-3))
#> 1081                                                                                                                                          People living in households with very low work intensity: Percentage
#> 1082                                                                                                                   People living in households with very low work intensity: Percentage point change (t-(t-3))
#> 1083                                                                                                                                                  Gross domestic expenditure on research and development (R&D)
#> 1084                                                                                                                                    General government deficit (-) and surplus (+) - annual data: Million euro
#> 1085                                                                                                      General government deficit (-) and surplus (+) - annual data: Percentage of gross domestic product (GDP)
#> 1086                                                                                                                                  General government gross fixed capital formation - annual data: Million euro
#> 1087                                                                                                    General government gross fixed capital formation - annual data: Percentage of gross domestic product (GDP)
#> 1088                                                                                                                                                     General government gross debt - annual data: Million euro
#> 1089                                                                                                                       General government gross debt - annual data: Percentage of gross domestic product (GDP)
#> 1090                                                                                                                                         Resource productivity: Euro per kilogram, chain linked volumes (2015)
#> 1091                                                                                                                                                                        Resource productivity: Index, 2000=100
#> 1092                                                                                                                                           Resource productivity: Purchasing power standard (PPS) per kilogram
#> 1093                                                                                                                                                                                   Waste generation per capita
#> 1094                                                                                                                                                                      Generation of municipal waste per capita
#> 1095                                                                                                                                                                      Generation of packaging waste per capita
#> 1096                                                                                                                                                              Generation of plastic packaging waste per capita
#> 1097                                                                                                                                                     Recycling rate of all waste excluding major mineral waste
#> 1098                                                                                                                                             Recycling rate of packaging waste by type of packaging: Packaging
#> 1099                                                                                                                         Recycling rate of packaging waste by type of packaging: Paper and cardboard packaging
#> 1100                                                                                                                                     Recycling rate of packaging waste by type of packaging: Plastic packaging
#> 1101                                                                                                                                      Recycling rate of packaging waste by type of packaging: Wooden packaging
#> 1102                                                                                                                                    Recycling rate of packaging waste by type of packaging: Metallic packaging
#> 1103                                                                                                                                       Recycling rate of packaging waste by type of packaging: Glass packaging
#> 1104                                                                                                                                                                                    Circular material use rate
#> 1105                                                                                                                                                                 Consumption footprint - single weighted score
#> 1106                                                                                                                                                                                    Material import dependency
#> 1107                                                                                                             Persons at risk of monetary poverty after social transfers - EU-SILC and ECHP surveys: Percentage
#> 1108                                                                                                       Persons at risk of monetary poverty after social transfers - EU-SILC and ECHP surveys: Thousand persons
#> 1109                                                                                Persons at risk of monetary poverty after social transfers by citizenship: EU27 countries (from 2020) except reporting country
#> 1110                                                                                                                  Persons at risk of monetary poverty after social transfers by citizenship: Reporting country
#> 1111                                                                               Persons at risk of monetary poverty after social transfers by citizenship: Non-EU27 countries (from 2020) nor reporting country
#> 1112                                                                                                                           Severe material and social deprivation rate by age group and sex: Total, Percentage
#> 1113                                                                                                                     Severe material and social deprivation rate by age group and sex: Total, Thousand persons
#> 1114                                                                                                              Severe material and social deprivation rate by age group and sex: Less than 18 years, Percentage
#> 1115                                                                                                        Severe material and social deprivation rate by age group and sex: Less than 18 years, Thousand persons
#> 1116                                                                                                       Persons living in households with very low work intensity, by age group: Less than 18 years, Percentage
#> 1117                                                                                                         Persons living in households with very low work intensity, by age group: Less than 18 years, Thousand
#> 1118                                                                                                       Persons living in households with very low work intensity, by age group: Less than 65 years, Percentage
#> 1119                                                                                                         Persons living in households with very low work intensity, by age group: Less than 65 years, Thousand
#> 1120                                                                                                                                                                               In work at-risk-of-poverty rate
#> 1121                                                                                                                                                     Housing cost overburden rate by poverty status: Above 60%
#> 1122                                                                                                                                                     Housing cost overburden rate by poverty status: Below 60%
#> 1123                                                                                                                                                         Housing cost overburden rate by poverty status: Total
#> 1124                                                                                                                                     Self-reported unmet need for medical examination and care by sex: Females
#> 1125                                                                                                                                       Self-reported unmet need for medical examination and care by sex: Males
#> 1126                                                                                                                                       Self-reported unmet need for medical examination and care by sex: Total
#> 1127                                                                                                                                                                        Relative median at-risk-of-poverty gap
#> 1128                                                                                                                                                  Severe housing deprivation rate by poverty status: Above 60%
#> 1129                                                                                                                                                  Severe housing deprivation rate by poverty status: Below 60%
#> 1130                                                                                                                                                      Severe housing deprivation rate by poverty status: Total
#> 1131                                                                                                                                                             Obesity rate by body mass index (BMI): Overweight
#> 1132                                                                                                                                                                  Obesity rate by body mass index (BMI): Obese
#> 1133                                                                                                                                                              Obesity rate by body mass index (BMI): Pre-obese
#> 1134                                                                                                              Agricultural real factor income per annual work unit (AWU): Chain linked volumes, index 2020=100
#> 1135                                                                                      Agricultural real factor income per annual work unit (AWU): Chain linked volumes (2020), euro per annual work unit (AWU)
#> 1136                                                                                                                              Government support to agricultural research and development: Euro per inhabitant
#> 1137                                                                                                                                     Government support to agricultural research and development: Million euro
#> 1138                                                                                                                                                                                    Area under organic farming
#> 1139                                                                                                                                                     Ammonia emissions from agriculture: Kilograms per hectare
#> 1140                                                                                                                                                                     Ammonia emissions from agriculture: Tonne
#> 1141                                                                                                                                                Area at risk of severe soil erosion by water: Square kilometre
#> 1142                                                                                                                                                      Area at risk of severe soil erosion by water: Percentage
#> 1143                                                                                                                                       Share of people with good or very good perceived health by sex: Females
#> 1144                                                                                                                                         Share of people with good or very good perceived health by sex: Males
#> 1145                                                                                                                                         Share of people with good or very good perceived health by sex: Total
#> 1146                                                                                                                                       Standardised preventable and treatable mortality: Preventable mortality
#> 1147                                                                                                                                                       Standardised preventable and treatable mortality: Total
#> 1148                                                                                                                                         Standardised preventable and treatable mortality: Treatable mortality
#> 1149                                                                                                                                                  Fatal accidents at work per 100 000 workers, by sex: Females
#> 1150                                                                                                                                                    Fatal accidents at work per 100 000 workers, by sex: Males
#> 1151                                                                                                                                                    Fatal accidents at work per 100 000 workers, by sex: Total
#> 1152                                                                                                         Population living in households considering that they suffer from noise, by poverty status: Above 60%
#> 1153                                                                                                         Population living in households considering that they suffer from noise, by poverty status: Below 60%
#> 1154                                                                                                             Population living in households considering that they suffer from noise, by poverty status: Total
#> 1155                                                                                                                                                      Road traffic deaths, by type of roads: Motorways, Number
#> 1156                                                                                                                                     Road traffic deaths, by type of roads: Motorways, Per 100,000 inhabitants
#> 1157                                                                                                                                                    Road traffic deaths, by type of roads: Rural roads, Number
#> 1158                                                                                                                                   Road traffic deaths, by type of roads: Rural roads, Per 100,000 inhabitants
#> 1159                                                                                                                                                    Road traffic deaths, by type of roads: Urban roads, Number
#> 1160                                                                                                                                   Road traffic deaths, by type of roads: Urban roads, Per 100,000 inhabitants
#> 1161                                                                                                                                                          Road traffic deaths, by type of roads: Total, Number
#> 1162                                                                                                                                         Road traffic deaths, by type of roads: Total, Per 100,000 inhabitants
#> 1163                                                                                                                                                        Road traffic deaths, by type of roads: Unknown, Number
#> 1164                                                                                                                                       Road traffic deaths, by type of roads: Unknown, Per 100,000 inhabitants
#> 1165                                                                                                                                                     Early leavers from education and training by sex: Females
#> 1166                                                                                                                                                       Early leavers from education and training by sex: Males
#> 1167                                                                                                                                                       Early leavers from education and training by sex: Total
#> 1168                                                                                                 Early leavers from education and training by citizenship: EU27 countries (from 2020) except reporting country
#> 1169                                                                                                                                   Early leavers from education and training by citizenship: Reporting country
#> 1170                                                                                                Early leavers from education and training by citizenship: Non-EU27 countries (from 2020) nor reporting country
#> 1171                                                                                                                                        Persons aged 25-34 with tertiary educational attainment level: Females
#> 1172                                                                                                                                          Persons aged 25-34 with tertiary educational attainment level: Males
#> 1173                                                                                                                                          Persons aged 25-34 with tertiary educational attainment level: Total
#> 1174                                                                                                                         Participation in early childhood education by sex (children aged 3 and over): Females
#> 1175                                                                                                                           Participation in early childhood education by sex (children aged 3 and over): Males
#> 1176                                                                                                                           Participation in early childhood education by sex (children aged 3 and over): Total
#> 1177                                                                                                                            Low achieving 15-year-olds in reading, mathematics and science by sex: Mathematics
#> 1178                                                                                                                                Low achieving 15-year-olds in reading, mathematics and science by sex: Reading
#> 1179                                                                                                                                Low achieving 15-year-olds in reading, mathematics and science by sex: Science
#> 1180                                                                                                                                                               Adult participation in learning by sex: Females
#> 1181                                                                                                                                                                 Adult participation in learning by sex: Males
#> 1182                                                                                                                                                                 Adult participation in learning by sex: Total
#> 1183                                                                                                                                                                             Gender pay gap in unadjusted form
#> 1184                                                                                                                                                Gender employment gap, by type of employment: Employed persons
#> 1185                                                                                                                              Gender employment gap, by type of employment: Employed persons working part-time
#> 1186                                                                                                                        Gender employment gap, by type of employment: Employed persons with temporary contract
#> 1187                                                                                                                         Gender employment gap, by type of employment: Underemployed persons working part-time
#> 1188                                                        Persons outside the labour force due to caring responsibilities by sex: Females, Percentage of population outside the labour force and wanting to work
#> 1189                                                                                               Persons outside the labour force due to caring responsibilities by sex: Females, Percentage of total population
#> 1190                                                          Persons outside the labour force due to caring responsibilities by sex: Males, Percentage of population outside the labour force and wanting to work
#> 1191                                                                                                 Persons outside the labour force due to caring responsibilities by sex: Males, Percentage of total population
#> 1192                                                          Persons outside the labour force due to caring responsibilities by sex: Total, Percentage of population outside the labour force and wanting to work
#> 1193                                                                                                 Persons outside the labour force due to caring responsibilities by sex: Total, Percentage of total population
#> 1194                                                                                                                                               Population connected to at least secondary wastewater treatment
#> 1195                                                                                                                                   Population unable to keep home adequately warm by poverty status: Above 60%
#> 1196                                                                                                                                   Population unable to keep home adequately warm by poverty status: Below 60%
#> 1197                                                                                                                                       Population unable to keep home adequately warm by poverty status: Total
#> 1198                                                                                                                                         Investment share of GDP by institutional sectors: Business investment
#> 1199                                                                                                                                       Investment share of GDP by institutional sectors: Government investment
#> 1200                                                                                                                                       Investment share of GDP by institutional sectors: Households investment
#> 1201                                                                                                                                            Investment share of GDP by institutional sectors: Total investment
#> 1202                                                                                                                      Young persons neither in employment nor in education and training (NEET) by sex: Females
#> 1203                                                                                                                        Young persons neither in employment nor in education and training (NEET) by sex: Males
#> 1204                                                                                                                        Young persons neither in employment nor in education and training (NEET) by sex: Total
#> 1205                                                                  Young persons neither in employment nor in education and training (NEET) by citizenship: EU27 countries (from 2020) except reporting country
#> 1206                                                                                                    Young persons neither in employment nor in education and training (NEET) by citizenship: Reporting country
#> 1207                                                                 Young persons neither in employment nor in education and training (NEET) by citizenship: Non-EU27 countries (from 2020) nor reporting country
#> 1208                                                                                                                                                                               Employment rate by sex: Females
#> 1209                                                                                                                                                                                 Employment rate by sex: Males
#> 1210                                                                                                                                                                                 Employment rate by sex: Total
#> 1211                                                                                                                                                                   Long-term unemployment rate by sex: Females
#> 1212                                                                                                                                                                     Long-term unemployment rate by sex: Males
#> 1213                                                                                                                                                                     Long-term unemployment rate by sex: Total
#> 1214                                                                                                                                       Gross domestic expenditure on R&D by sector: Business enterprise sector
#> 1215                                                                                                                                                Gross domestic expenditure on R&D by sector: Government sector
#> 1216                                                                                                                                          Gross domestic expenditure on R&D by sector: Higher education sector
#> 1217                                                                                                                                        Gross domestic expenditure on R&D by sector: Private non-profit sector
#> 1218                                                                                                                                                      Gross domestic expenditure on R&D by sector: All sectors
#> 1219                                                                                                                                                           R&D personnel by sector: Business enterprise sector
#> 1220                                                                                                                                                                    R&D personnel by sector: Government sector
#> 1221                                                                                                                                                              R&D personnel by sector: Higher education sector
#> 1222                                                                                                                                                            R&D personnel by sector: Private non-profit sector
#> 1223                                                                                                                                                                          R&D personnel by sector: All sectors
#> 1224                                                                                                                                                 Air emissions intensity of manufacturing: Particulates < 10µm
#> 1225                                                                                                                                                Air emissions intensity of manufacturing: Particulates < 2.5µm
#> 1226                                                                                                                                                                                   Income quintile share ratio
#> 1227                                                                                                                                                             Income share of the bottom 40 % of the population
#> 1228                                                                                                    Population reporting occurrence of crime, violence or vandalism in their area by poverty status: Above 60%
#> 1229                                                                                                    Population reporting occurrence of crime, violence or vandalism in their area by poverty status: Below 60%
#> 1230                                                                                                        Population reporting occurrence of crime, violence or vandalism in their area by poverty status: Total
#> 1231                                                                                                                               Housing cost overburden rate by degree of urbanisation - EU-SILC survey: Cities
#> 1232                                                                                                                    Housing cost overburden rate by degree of urbanisation - EU-SILC survey: Towns and suburbs
#> 1233                                                                                                                          Housing cost overburden rate by degree of urbanisation - EU-SILC survey: Rural areas
#> 1234                                                                                     Economic losses from weather- and climate-related extremes: Thirty-year average, Euro per inhabitant (at constant prices)
#> 1235                                                                                              Economic losses from weather- and climate-related extremes: Thirty-year average, Million euro at constant prices
#> 1236                                                                                            Economic losses from weather- and climate-related extremes: Annual value, Euro per inhabitant (at constant prices)
#> 1237                                                                                                     Economic losses from weather- and climate-related extremes: Annual value, Million euro at constant prices
#> 1238                                                                                                                                                                      Marine protected areas: Square kilometre
#> 1239                                                                                                                                                                            Marine protected areas: Percentage
#> 1240                                                                                                                                                  Surface of the terrestrial protected areas: Square kilometre
#> 1241                                                                                                                                                        Surface of the terrestrial protected areas: Percentage
#> 1242                                                                                                                                                                   General government gross debt: Million euro
#> 1243                                                                                                                                     General government gross debt: Percentage of gross domestic product (GDP)
#> 1244                                                                                                                                                            Share of environmental taxes in total tax revenues
#> 1245                                                                                    Population having neither a bath, nor a shower, nor indoor flushing toilet in their household by poverty status: Above 60%
#> 1246                                                                                    Population having neither a bath, nor a shower, nor indoor flushing toilet in their household by poverty status: Below 60%
#> 1247                                                                                        Population having neither a bath, nor a shower, nor indoor flushing toilet in their household by poverty status: Total
#> 1248                                                                                                                                                                        Gender employment gap by NUTS 2 region
#> 1249                                                                                                                                                                                       At-risk-of-poverty rate
#> 1250                                                                                                                                                           At-risk-of-poverty threshold for a single household
#> 1251                                                                                                                                                                   Severe material and social deprivation rate
#> 1252                                                                                                                                                          Persistent-at-risk-of-poverty rate: 65 years or over
#> 1253                                                                                                                                                        Persistent-at-risk-of-poverty rate: Less than 18 years
#> 1254                                                                                                                                                       Persistent-at-risk-of-poverty rate: From 18 to 24 years
#> 1255                                                                                                                                                       Persistent-at-risk-of-poverty rate: From 25 to 49 years
#> 1256                                                                                                                                                       Persistent-at-risk-of-poverty rate: From 50 to 64 years
#> 1257                                                                                                                                                                             Inequality of income distribution
#> 1258                                                                                                                                                               Children at risk of poverty or social exclusion
#> 1259                                                                                                                          Impact of social transfers (excluding pensions) on poverty reduction by sex: Females
#> 1260                                                                                                                            Impact of social transfers (excluding pensions) on poverty reduction by sex: Males
#> 1261                                                                                                                            Impact of social transfers (excluding pensions) on poverty reduction by sex: Total
#> 1262                                                                                                                               At risk-of-poverty rate for the population living in (quasi-)jobless households
#> 1263                                                                                                                                                                               In-work at-risk-of-poverty rate
#> 1264                                                                                                                                                   Early leavers from education and training (age group 18-24)
#> 1265                                                                                                                                                                    Youth unemployment ratio (age group 15-24)
#> 1266                                                                                                                                                                    Youth unemployment ratio (age group 15-24)
#> 1267                                                                                                 Young persons neither in employment nor in education and training (NEET) by sex: Females, From 15 to 24 years
#> 1268                                                                                                 Young persons neither in employment nor in education and training (NEET) by sex: Females, From 15 to 29 years
#> 1269                                                                                                   Young persons neither in employment nor in education and training (NEET) by sex: Males, From 15 to 24 years
#> 1270                                                                                                   Young persons neither in employment nor in education and training (NEET) by sex: Males, From 15 to 29 years
#> 1271                                                                                                   Young persons neither in employment nor in education and training (NEET) by sex: Total, From 15 to 24 years
#> 1272                                                                                                   Young persons neither in employment nor in education and training (NEET) by sex: Total, From 15 to 29 years
#> 1273                                                                                                                                                             Employment rate of older workers, age group 55-64
#> 1274                                                                                                                                                 At risk of poverty or social exclusion rate for elderly (65+)
#> 1275                                                                                                                                                     Median relative income of elderly people - EU-SILC survey
#> 1276                                                                                                                                                                                   Aggregate replacement ratio
#> 1277                                                                                                                                                     Self-reported unmet need for medical care by sex: Females
#> 1278                                                                                                                                                       Self-reported unmet need for medical care by sex: Males
#> 1279                                                                                                                                                       Self-reported unmet need for medical care by sex: Total
#> 1280                                                                                                                                                                              Healthy life years at 65 - males
#> 1281                                                                                                                                                                            Healthy life years at 65 - females
#> 1282                                                                                                                                                                                  Housing cost overburden rate
#> 1283                                                                                                                                                    Tertiary educational attainment (age group 30-34): Females
#> 1284                                                                                                                                                      Tertiary educational attainment (age group 30-34): Males
#> 1285                                                                                                                                                      Tertiary educational attainment (age group 30-34): Total
#> 1286                                                                                                                                                                                     Overall employment growth
#> 1287                                                                                                                                                                                         Gender employment gap
#> 1288                                                                                                                                                                       Youth employment rate (age group 20-29)
#> 1289                                                                                                                                                                                     Part-time employment rate
#> 1290                                                                                                                                            Temporary employees as percentage of the total number of employees
#> 1291                                                                                                                                                                             Unemployment rate by sex: Females
#> 1292                                                                                                                                                                               Unemployment rate by sex: Males
#> 1293                                                                                                                                                                               Unemployment rate by sex: Total
#> 1294                                                                                                                                                                       Youth unemployment rate by sex: Females
#> 1295                                                                                                                                                                         Youth unemployment rate by sex: Males
#> 1296                                                                                                                                                                         Youth unemployment rate by sex: Total
#> 1297                                                                                                                                Involuntary temporary employment: Job only available with a temporary contract
#> 1298                                                                                                                                                      Involuntary temporary employment: No permanent job found
#> 1299                                                                                                                                                                                                Newly employed
#> 1300                                                                                                                                                                 At-risk of poverty rate of unemployed persons
#> 1301                                                                                                                                                              Tax rate on low wage earners - Unemployment trap
#> 1302                                                                                         Percentage of population (age group 25-64) in private households with at least upper secondary educational attainment
#> 1303                                                                                                                          Distribution of population by household types - EU-SILC survey: Three or more adults
#> 1304                                                                                                                                     Distribution of population by household types - EU-SILC survey: One adult
#> 1305                                                                                                              Distribution of population by household types - EU-SILC survey: Two adults younger than 65 years
#> 1306                                                                                                                              At-risk-of-poverty rate before social transfers by sex - EU-SILC survey: Females
#> 1307                                                                                                                                At-risk-of-poverty rate before social transfers by sex - EU-SILC survey: Males
#> 1308                                                                                                                                At-risk-of-poverty rate before social transfers by sex - EU-SILC survey: Total
#> 1309                                                                                                                          At-risk-of-poverty rate before social transfers by age group - EU-SILC survey: Total
#> 1310                                                                                                               At-risk-of-poverty rate before social transfers by age group - EU-SILC survey: 65 years or over
#> 1311                                                                                                             At-risk-of-poverty rate before social transfers by age group - EU-SILC survey: Less than 18 years
#> 1312                                                                                                            At-risk-of-poverty rate before social transfers by age group - EU-SILC survey: From 18 to 64 years
#> 1313                                                                                                                                                 People at risk of poverty or social exclusion by sex: Females
#> 1314                                                                                                                                                   People at risk of poverty or social exclusion by sex: Males
#> 1315                                                                                                                                                   People at risk of poverty or social exclusion by sex: Total
#> 1316                                                                                                                                                                       At-risk-of-poverty rate by sex: Females
#> 1317                                                                                                                                                                         At-risk-of-poverty rate by sex: Males
#> 1318                                                                                                                                                                         At-risk-of-poverty rate by sex: Total
#> 1319                                                                                                                                                  At-risk-of-poverty rate by age group - EU-SILC survey: Total
#> 1320                                                                                                                                       At-risk-of-poverty rate by age group - EU-SILC survey: 65 years or over
#> 1321                                                                                                                                     At-risk-of-poverty rate by age group - EU-SILC survey: Less than 18 years
#> 1322                                                                                                                                    At-risk-of-poverty rate by age group - EU-SILC survey: From 18 to 24 years
#> 1323                                                                                                                                    At-risk-of-poverty rate by age group - EU-SILC survey: From 25 to 49 years
#> 1324                                                                                                                                    At-risk-of-poverty rate by age group - EU-SILC survey: From 50 to 64 years
#> 1325                                                                                                                                                      At-risk-of-poverty threshold - EU-SILC survey: One adult
#> 1326                                                                                                                                                     At-risk-of-poverty threshold - EU-SILC survey: Two adults
#> 1327                                                                                                             At-risk-of-poverty threshold - EU-SILC survey: Two adults with two children younger than 14 years
#> 1328                                                                                                                                                   Severe material and social deprivation rate by sex: Females
#> 1329                                                                                                                                                     Severe material and social deprivation rate by sex: Males
#> 1330                                                                                                                                                     Severe material and social deprivation rate by sex: Total
#> 1331                                                                                                                                      People living in households with very low work intensity by sex: Females
#> 1332                                                                                                                                        People living in households with very low work intensity by sex: Males
#> 1333                                                                                                                                        People living in households with very low work intensity by sex: Total
#> 1334                                                                                                                                           Children (aged less than 18) at risk of poverty or social exclusion
#> 1335                                                                                                                                      At-risk-of poverty rate for children (aged less than 18) by sex: Females
#> 1336                                                                                                                                        At-risk-of poverty rate for children (aged less than 18) by sex: Males
#> 1337                                                                                                                                        At-risk-of poverty rate for children (aged less than 18) by sex: Total
#> 1338                                                                                                                Children (aged less than 18) living in households with very low work intensity by sex: Females
#> 1339                                                                                                                  Children (aged less than 18) living in households with very low work intensity by sex: Males
#> 1340                                                                                                                  Children (aged less than 18) living in households with very low work intensity by sex: Total
#> 1341                                                                                                                  Severe material and social deprivation rate for children (aged less than 18) by sex: Females
#> 1342                                                                                                                    Severe material and social deprivation rate for children (aged less than 18) by sex: Males
#> 1343                                                                                                                    Severe material and social deprivation rate for children (aged less than 18) by sex: Total
#> 1344                                                                                                                                Relative median at-risk-of-poverty risk gap - EU-SILC survey: 16 years or over
#> 1345                                                                                                                                Relative median at-risk-of-poverty risk gap - EU-SILC survey: 18 years or over
#> 1346                                                                                                                                Relative median at-risk-of-poverty risk gap - EU-SILC survey: 65 years or over
#> 1347                                                                                                                                Relative median at-risk-of-poverty risk gap - EU-SILC survey: 75 years or over
#> 1348                                                                                                                              Relative median at-risk-of-poverty risk gap - EU-SILC survey: Less than 16 years
#> 1349                                                                                                                              Relative median at-risk-of-poverty risk gap - EU-SILC survey: Less than 18 years
#> 1350                                                                                                                             Relative median at-risk-of-poverty risk gap - EU-SILC survey: From 16 to 64 years
#> 1351                                                                                                                                                         Income quintile share ratio (S80/S20) by sex: Females
#> 1352                                                                                                                                                           Income quintile share ratio (S80/S20) by sex: Males
#> 1353                                                                                                                                                           Income quintile share ratio (S80/S20) by sex: Total
#> 1354                                                                                                            At-risk-of-poverty rate anchored at a fixed moment in time (2019) by sex - EU-SILC survey: Females
#> 1355                                                                                                              At-risk-of-poverty rate anchored at a fixed moment in time (2019) by sex - EU-SILC survey: Males
#> 1356                                                                                                              At-risk-of-poverty rate anchored at a fixed moment in time (2019) by sex - EU-SILC survey: Total
#> 1357                                                                                                        At-risk-of-poverty rate anchored at a fixed moment in time (2019) by age group - EU-SILC survey: Total
#> 1358                                                                                             At-risk-of-poverty rate anchored at a fixed moment in time (2019) by age group - EU-SILC survey: 65 years or over
#> 1359                                                                                           At-risk-of-poverty rate anchored at a fixed moment in time (2019) by age group - EU-SILC survey: Less than 18 years
#> 1360                                                                                          At-risk-of-poverty rate anchored at a fixed moment in time (2019) by age group - EU-SILC survey: From 18 to 64 years
#> 1361                                                                                                                                                                   Employment rate by age: From 15 to 24 years
#> 1362                                                                                                                                                                   Employment rate by age: From 15 to 64 years
#> 1363                                                                                                                                                                   Employment rate by age: From 20 to 64 years
#> 1364                                                                                                                                                                   Employment rate by age: From 25 to 54 years
#> 1365                                                                                                                                                                   Employment rate by age: From 55 to 64 years
#> 1366                                                                                                                                                               In-work at-risk-of-poverty rate by sex: Females
#> 1367                                                                                                                                                                 In-work at-risk-of-poverty rate by sex: Males
#> 1368                                                                                                                                                                 In-work at-risk-of-poverty rate by sex: Total
#> 1369                                                                                                                                                                                 Activity rate by sex: Females
#> 1370                                                                                                                                                                                   Activity rate by sex: Males
#> 1371                                                                                                                                                                                   Activity rate by sex: Total
#> 1372                                                                                                                                                                     Activity rate by age: From 15 to 24 years
#> 1373                                                                                                                                                                     Activity rate by age: From 15 to 64 years
#> 1374                                                                                                                                                                     Activity rate by age: From 20 to 64 years
#> 1375                                                                                                                                                                     Activity rate by age: From 25 to 54 years
#> 1376                                                                                                                                                                     Activity rate by age: From 55 to 64 years
#> 1377                                                                                                                                           Persistent at-risk-of poverty rate by sex - EU-SILC survey: Females
#> 1378                                                                                                                                             Persistent at-risk-of poverty rate by sex - EU-SILC survey: Males
#> 1379                                                                                                                                             Persistent at-risk-of poverty rate by sex - EU-SILC survey: Total
#> 1380                                                                                                                                       Persistent at-risk-of poverty rate by age group - EU-SILC survey: Total
#> 1381                                                                                                                            Persistent at-risk-of poverty rate by age group - EU-SILC survey: 65 years or over
#> 1382                                                                                                                          Persistent at-risk-of poverty rate by age group - EU-SILC survey: Less than 18 years
#> 1383                                                                                                                         Persistent at-risk-of poverty rate by age group - EU-SILC survey: From 18 to 24 years
#> 1384                                                                                                                                         Relative median poverty risk gap by age group - EU-SILC survey: Total
#> 1385                                                                                                                              Relative median poverty risk gap by age group - EU-SILC survey: 65 years or over
#> 1386                                                                                                                            Relative median poverty risk gap by age group - EU-SILC survey: Less than 18 years
#> 1387                                                                                                                           Relative median poverty risk gap by age group - EU-SILC survey: From 18 to 64 years
#> 1388                                                                                                                                                    Material Deprivation rate by sex - EU-SILC survey: Females
#> 1389                                                                                                                                                      Material Deprivation rate by sex - EU-SILC survey: Males
#> 1390                                                                                                                                                      Material Deprivation rate by sex - EU-SILC survey: Total
#> 1391                                                                                                                                                Material Deprivation rate by age group - EU-SILC survey: Total
#> 1392                                                                                                                                     Material Deprivation rate by age group - EU-SILC survey: 65 years or over
#> 1393                                                                                                                                   Material Deprivation rate by age group - EU-SILC survey: Less than 18 years
#> 1394                                                                                                                                  Material Deprivation rate by age group - EU-SILC survey: From 18 to 64 years
#> 1395                                                                                                                                         At-risk-of poverty rate by detailed age group - EU-SILC survey: Total
#> 1396                                                                                                                              At-risk-of poverty rate by detailed age group - EU-SILC survey: 65 years or over
#> 1397                                                                                                                            At-risk-of poverty rate by detailed age group - EU-SILC survey: Less than 18 years
#> 1398                                                                                                                           At-risk-of poverty rate by detailed age group - EU-SILC survey: From 18 to 24 years
#> 1399                                                                                                                           At-risk-of poverty rate by detailed age group - EU-SILC survey: From 25 to 54 years
#> 1400                                                                                                                           At-risk-of poverty rate by detailed age group - EU-SILC survey: From 55 to 64 years
#> 1401                                                                                                                              At-risk-of poverty rate by household type - EU-SILC survey: Three or more adults
#> 1402                                                                                                                                         At-risk-of poverty rate by household type - EU-SILC survey: One adult
#> 1403                                                                                                                  At-risk-of poverty rate by household type - EU-SILC survey: Two adults younger than 65 years
#> 1404                                                                          At-risk-of-poverty rate of households without dependent children by work intensity - EU-SILC survey: Very low work intensity (0-0.2)
#> 1405                                                                            At-risk-of-poverty rate of households without dependent children by work intensity - EU-SILC survey: Low work intensity (0.2-0.45)
#> 1406                                                                      At-risk-of-poverty rate of households without dependent children by work intensity - EU-SILC survey: Not very low work intensity (0.2-1)
#> 1407                                                                        At-risk-of-poverty rate of households without dependent children by work intensity - EU-SILC survey: Medium work intensity (0.45-0.55)
#> 1408                                                                          At-risk-of-poverty rate of households without dependent children by work intensity - EU-SILC survey: High work intensity (0.55-0.85)
#> 1409                                                                        At-risk-of-poverty rate of households without dependent children by work intensity - EU-SILC survey: Very high work intensity (0.85-1)
#> 1410                                                                   At-risk-of-poverty rate of households with at least one dependent child by work intensity - EU-SILC survey: Very low work intensity (0-0.2)
#> 1411                                                                     At-risk-of-poverty rate of households with at least one dependent child by work intensity - EU-SILC survey: Low work intensity (0.2-0.45)
#> 1412                                                               At-risk-of-poverty rate of households with at least one dependent child by work intensity - EU-SILC survey: Not very low work intensity (0.2-1)
#> 1413                                                                 At-risk-of-poverty rate of households with at least one dependent child by work intensity - EU-SILC survey: Medium work intensity (0.45-0.55)
#> 1414                                                                   At-risk-of-poverty rate of households with at least one dependent child by work intensity - EU-SILC survey: High work intensity (0.55-0.85)
#> 1415                                                                 At-risk-of-poverty rate of households with at least one dependent child by work intensity - EU-SILC survey: Very high work intensity (0.85-1)
#> 1416                                                                                                                   At-risk-of poverty rate by most frequent activity status - EU-SILC survey: Employed persons
#> 1417                                                                                             At-risk-of poverty rate by most frequent activity status - EU-SILC survey: Other persons outside the labour force
#> 1418                                                                                                               At-risk-of poverty rate by most frequent activity status - EU-SILC survey: Not employed persons
#> 1419                                                                                                                         At-risk-of poverty rate by most frequent activity status - EU-SILC survey: Population
#> 1420                                                                                                                    At-risk-of poverty rate by most frequent activity status - EU-SILC survey: Retired persons
#> 1421                                                                                                                 At-risk-of poverty rate by most frequent activity status - EU-SILC survey: Unemployed persons
#> 1422                                                                                                                                              At-risk-of poverty rate by tenure status - EU-SILC survey: Owner
#> 1423                                                                                                                                             At-risk-of poverty rate by tenure status - EU-SILC survey: Tenant
#> 1424                                                                                                                                              At-risk-of poverty rate by tenure status - EU-SILC survey: Total
#> 1425                                                                                                                                Dispersion around the at-risk-of-poverty threshold - EU-SILC survey: Below 40%
#> 1426                                                                                                                                Dispersion around the at-risk-of-poverty threshold - EU-SILC survey: Below 50%
#> 1427                                                                                                                                Dispersion around the at-risk-of-poverty threshold - EU-SILC survey: Below 60%
#> 1428                                                                                                                                Dispersion around the at-risk-of-poverty threshold - EU-SILC survey: Below 70%
#> 1429                                                                                                                                                                Depth of material deprivation - EU-SILC survey
#> 1430                                                                                                                                                 Housing cost overburden rate by sex - EU-SILC survey: Females
#> 1431                                                                                                                                                   Housing cost overburden rate by sex - EU-SILC survey: Males
#> 1432                                                                                                                                                   Housing cost overburden rate by sex - EU-SILC survey: Total
#> 1433                                                                                                                                             Housing cost overburden rate by age group - EU-SILC survey: Total
#> 1434                                                                                                                                  Housing cost overburden rate by age group - EU-SILC survey: 65 years or over
#> 1435                                                                                                                                Housing cost overburden rate by age group - EU-SILC survey: Less than 18 years
#> 1436                                                                                                                               Housing cost overburden rate by age group - EU-SILC survey: From 18 to 64 years
#> 1437                                                                                                                              Housing cost overburden rate by income quintile - EU-SILC survey: First quintile
#> 1438                                                                                                                             Housing cost overburden rate by income quintile - EU-SILC survey: Second quintile
#> 1439                                                                                                                              Housing cost overburden rate by income quintile - EU-SILC survey: Third quintile
#> 1440                                                                                                                             Housing cost overburden rate by income quintile - EU-SILC survey: Fourth quintile
#> 1441                                                                                                                              Housing cost overburden rate by income quintile - EU-SILC survey: Fifth quintile
#> 1442                                                                                                                                    Housing cost overburden rate by poverty status - EU-SILC survey: Above 60%
#> 1443                                                                                                                                    Housing cost overburden rate by poverty status - EU-SILC survey: Below 60%
#> 1444                                                                                                                                        Housing cost overburden rate by poverty status - EU-SILC survey: Total
#> 1445                                                                                                                  Housing cost overburden rate by tenure status - EU-SILC survey: Owner, with mortgage or loan
#> 1446                                                                                                Housing cost overburden rate by tenure status - EU-SILC survey: Owner, no outstanding mortgage or housing loan
#> 1447                                                                                                         Housing cost overburden rate by tenure status - EU-SILC survey: Tenant, rent at reduced price or free
#> 1448                                                                                                                  Housing cost overburden rate by tenure status - EU-SILC survey: Tenant, rent at market price
#> 1449                                                                                                                         Housing cost overburden rate by household type - EU-SILC survey: Three or more adults
#> 1450                                                                                                                                    Housing cost overburden rate by household type - EU-SILC survey: One adult
#> 1451                                                                                                                                   Housing cost overburden rate by household type - EU-SILC survey: Two adults
#> 1452                                                                                                                                                            Overcrowding rate by sex - EU-SILC survey: Females
#> 1453                                                                                                                                                              Overcrowding rate by sex - EU-SILC survey: Males
#> 1454                                                                                                                                                              Overcrowding rate by sex - EU-SILC survey: Total
#> 1455                                                                                                                                                        Overcrowding rate by age group - EU-SILC survey: Total
#> 1456                                                                                                                                             Overcrowding rate by age group - EU-SILC survey: 65 years or over
#> 1457                                                                                                                                           Overcrowding rate by age group - EU-SILC survey: Less than 18 years
#> 1458                                                                                                                                          Overcrowding rate by age group - EU-SILC survey: From 18 to 64 years
#> 1459                                                                                                                                               Overcrowding rate by poverty status - EU-SILC survey: Above 60%
#> 1460                                                                                                                                               Overcrowding rate by poverty status - EU-SILC survey: Below 60%
#> 1461                                                                                                                                                   Overcrowding rate by poverty status - EU-SILC survey: Total
#> 1462                                                                                                                             Overcrowding rate by tenure status - EU-SILC survey: Owner, with mortgage or loan
#> 1463                                                                                                           Overcrowding rate by tenure status - EU-SILC survey: Owner, no outstanding mortgage or housing loan
#> 1464                                                                                                                    Overcrowding rate by tenure status - EU-SILC survey: Tenant, rent at reduced price or free
#> 1465                                                                                                                             Overcrowding rate by tenure status - EU-SILC survey: Tenant, rent at market price
#> 1466                                                                                                                                          Overcrowding rate by degree of urbanisation - EU-SILC survey: Cities
#> 1467                                                                                                                               Overcrowding rate by degree of urbanisation - EU-SILC survey: Towns and suburbs
#> 1468                                                                                                                                     Overcrowding rate by degree of urbanisation - EU-SILC survey: Rural areas
#> 1469                                                                                                                                    Overcrowding rate by household type - EU-SILC survey: Three or more adults
#> 1470                                                                                                                                               Overcrowding rate by household type - EU-SILC survey: One adult
#> 1471                                                                                                                                              Overcrowding rate by household type - EU-SILC survey: Two adults
#> 1472                                                                                                              Overcrowding rate by sex - population without single-person households - EU-SILC survey: Females
#> 1473                                                                                                                Overcrowding rate by sex - population without single-person households - EU-SILC survey: Males
#> 1474                                                                                                                Overcrowding rate by sex - population without single-person households - EU-SILC survey: Total
#> 1475                                                                                                          Overcrowding rate by age group - population without single-person households - EU-SILC survey: Total
#> 1476                                                                                               Overcrowding rate by age group - population without single-person households - EU-SILC survey: 65 years or over
#> 1477                                                                                             Overcrowding rate by age group - population without single-person households - EU-SILC survey: Less than 18 years
#> 1478                                                                                            Overcrowding rate by age group - population without single-person households - EU-SILC survey: From 18 to 64 years
#> 1479                                                                                                 Overcrowding rate by poverty status - population without single-person households - EU-SILC survey: Above 60%
#> 1480                                                                                                 Overcrowding rate by poverty status - population without single-person households - EU-SILC survey: Below 60%
#> 1481                                                                                                     Overcrowding rate by poverty status - population without single-person households - EU-SILC survey: Total
#> 1482                                                                                                                                                             Gini coefficient of equivalised disposable income
#> 1483                                                                                                                                   In-work at-risk-of-poverty rate by working time - EU-SILC survey: Full-time
#> 1484                                                                                                                                   In-work at-risk-of-poverty rate by working time - EU-SILC survey: Part-time
#> 1485                                                                                                                                         Housing deprivation rate by number of item - EU-SILC survey: No items
#> 1486                                                                                                                                           Housing deprivation rate by number of item - EU-SILC survey: 1 item
#> 1487                                                                                                                                          Housing deprivation rate by number of item - EU-SILC survey: 2 items
#> 1488                                                                                                                                          Housing deprivation rate by number of item - EU-SILC survey: 3 items
#> 1489                                                                                                                                          Housing deprivation rate by number of item - EU-SILC survey: 4 items
#> 1490                                   Share of total population living in a dwelling with a leaking roof, damp walls, floors or foundation, or rot in window frames of floor - EU-SILC survey: Above 60%, Females
#> 1491                                     Share of total population living in a dwelling with a leaking roof, damp walls, floors or foundation, or rot in window frames of floor - EU-SILC survey: Above 60%, Males
#> 1492                                     Share of total population living in a dwelling with a leaking roof, damp walls, floors or foundation, or rot in window frames of floor - EU-SILC survey: Above 60%, Total
#> 1493                                   Share of total population living in a dwelling with a leaking roof, damp walls, floors or foundation, or rot in window frames of floor - EU-SILC survey: Below 60%, Females
#> 1494                                     Share of total population living in a dwelling with a leaking roof, damp walls, floors or foundation, or rot in window frames of floor - EU-SILC survey: Below 60%, Males
#> 1495                                     Share of total population living in a dwelling with a leaking roof, damp walls, floors or foundation, or rot in window frames of floor - EU-SILC survey: Below 60%, Total
#> 1496                                       Share of total population living in a dwelling with a leaking roof, damp walls, floors or foundation, or rot in window frames of floor - EU-SILC survey: Total, Females
#> 1497                                         Share of total population living in a dwelling with a leaking roof, damp walls, floors or foundation, or rot in window frames of floor - EU-SILC survey: Total, Males
#> 1498                                         Share of total population living in a dwelling with a leaking roof, damp walls, floors or foundation, or rot in window frames of floor - EU-SILC survey: Total, Total
#> 1499                                                                                                     Share of total population having neither a bath, nor a shower in their dwelling - EU-SILC survey: Females
#> 1500                                                                                                       Share of total population having neither a bath, nor a shower in their dwelling - EU-SILC survey: Males
#> 1501                                                                                                       Share of total population having neither a bath, nor a shower in their dwelling - EU-SILC survey: Total
#> 1502                                                                                     Share of total population not having indoor flushing toilet for the sole use of their household - EU-SILC survey: Females
#> 1503                                                                                       Share of total population not having indoor flushing toilet for the sole use of their household - EU-SILC survey: Males
#> 1504                                                                                       Share of total population not having indoor flushing toilet for the sole use of their household - EU-SILC survey: Total
#> 1505                                                                                                                    Share of total population considering their dwelling as too dark - EU-SILC survey: Females
#> 1506                                                                                                                      Share of total population considering their dwelling as too dark - EU-SILC survey: Males
#> 1507                                                                                                                      Share of total population considering their dwelling as too dark - EU-SILC survey: Total
#> 1508                                                                                                                               Median of the housing cost burden distribution by sex - EU-SILC survey: Females
#> 1509                                                                                                                                 Median of the housing cost burden distribution by sex - EU-SILC survey: Males
#> 1510                                                                                                                                 Median of the housing cost burden distribution by sex - EU-SILC survey: Total
#> 1511                                                                                                                           Median of the housing cost burden distribution by age group - EU-SILC survey: Total
#> 1512                                                                                                                Median of the housing cost burden distribution by age group - EU-SILC survey: 65 years or over
#> 1513                                                                                                              Median of the housing cost burden distribution by age group - EU-SILC survey: Less than 18 years
#> 1514                                                                                                             Median of the housing cost burden distribution by age group - EU-SILC survey: From 18 to 64 years
#> 1515                                                                                                                  Median of the housing cost burden distribution by poverty status - EU-SILC survey: Above 60%
#> 1516                                                                                                                  Median of the housing cost burden distribution by poverty status - EU-SILC survey: Below 60%
#> 1517                                                                                                                      Median of the housing cost burden distribution by poverty status - EU-SILC survey: Total
#> 1518                                                                                                             Median of the housing cost burden distribution by degree of urbanisation - EU-SILC survey: Cities
#> 1519                                                                                                  Median of the housing cost burden distribution by degree of urbanisation - EU-SILC survey: Towns and suburbs
#> 1520                                                                                                        Median of the housing cost burden distribution by degree of urbanisation - EU-SILC survey: Rural areas
#> 1521                                                                                                                                      At-risk-of-poverty rate of older people by sex - EU-SILC survey: Females
#> 1522                                                                                                                                        At-risk-of-poverty rate of older people by sex - EU-SILC survey: Males
#> 1523                                                                                                                                        At-risk-of-poverty rate of older people by sex - EU-SILC survey: Total
#> 1524                                                                                                              At-risk-of-poverty rate of older people by detailed age group - EU-SILC survey: 60 years or over
#> 1525                                                                                                              At-risk-of-poverty rate of older people by detailed age group - EU-SILC survey: 65 years or over
#> 1526                                                                                                              At-risk-of-poverty rate of older people by detailed age group - EU-SILC survey: 75 years or over
#> 1527                                                                                                            At-risk-of-poverty rate of older people by detailed age group - EU-SILC survey: Less than 60 years
#> 1528                                                                                                            At-risk-of-poverty rate of older people by detailed age group - EU-SILC survey: Less than 65 years
#> 1529                                                                                                            At-risk-of-poverty rate of older people by detailed age group - EU-SILC survey: Less than 75 years
#> 1530                                                                                                                                      Median relative income of elderly people (60+) - EU-SILC survey: Females
#> 1531                                                                                                                                        Median relative income of elderly people (60+) - EU-SILC survey: Males
#> 1532                                                                                                                                        Median relative income of elderly people (60+) - EU-SILC survey: Total
#> 1533                                                                                                                    Aggregate replacement ratio for pensions (excluding other social benefits) by sex: Females
#> 1534                                                                                                                      Aggregate replacement ratio for pensions (excluding other social benefits) by sex: Males
#> 1535                                                                                                                      Aggregate replacement ratio for pensions (excluding other social benefits) by sex: Total
#> 1536                                                                                                                                                  Income inequality for older people - EU-SILC survey: Females
#> 1537                                                                                                                                                    Income inequality for older people - EU-SILC survey: Males
#> 1538                                                                                                                                                    Income inequality for older people - EU-SILC survey: Total
#> 1539                                                                                                                         Relative median poverty risk gap of elderly people - EU-SILC survey: 65 years or over
#> 1540                                                                                                                         Relative median poverty risk gap of elderly people - EU-SILC survey: 75 years or over
#> 1541                                                                                                                                              At-risk-of-poverty rate for pensioners - EU-SILC survey: Females
#> 1542                                                                                                                                                At-risk-of-poverty rate for pensioners - EU-SILC survey: Males
#> 1543                                                                                                                                                At-risk-of-poverty rate for pensioners - EU-SILC survey: Total
#> 1544                                                                                                                            At-risk-of-poverty rate of elderly people by tenure status - EU-SILC survey: Owner
#> 1545                                                                                                                           At-risk-of-poverty rate of elderly people by tenure status - EU-SILC survey: Tenant
#> 1546                                                                                                                            At-risk-of-poverty rate of elderly people by tenure status - EU-SILC survey: Total
#> 1547                                                                                                             Dispersion around the at-risk-of-poverty threshold for elderly people - EU-SILC survey: Below 40%
#> 1548                                                                                                             Dispersion around the at-risk-of-poverty threshold for elderly people - EU-SILC survey: Below 50%
#> 1549                                                                                                             Dispersion around the at-risk-of-poverty threshold for elderly people - EU-SILC survey: Below 60%
#> 1550                                                                                                             Dispersion around the at-risk-of-poverty threshold for elderly people - EU-SILC survey: Below 70%
#> 1551                                                                                                                   Gender differences in the at-risk-of-poverty rate by age - EU-SILC survey: 65 years or over
#> 1552                                                                                                                 Gender differences in the at-risk-of-poverty rate by age - EU-SILC survey: Less than 65 years
#> 1553                                                                                                                            Gender differences in the relative income of elderly people (65+) - EU-SILC survey
#> 1554                                                                                         Gender differences in the aggregate replacement ratio for pensions (excluding other social benefits) - EU-SILC survey
#> 1555                                                                                                                  Gender differences in the relative income of older people - EU-SILC survey: 60 years or over
#> 1556                                                                                                                  Gender differences in the relative income of older people - EU-SILC survey: 75 years or over
#> 1557                                                                                                                                                                       Out-of-pocket expenditure on healthcare
#> 1558                                                                                                                                                                  Healthy life years at age 65 by sex: Females
#> 1559                                                                                                                                                                    Healthy life years at age 65 by sex: Males
#> 1560                                                                                                                                                                    Healthy life years at age 65 by sex: Total
#> 1561                                                                                                                                                                            Gender gap in part-time employment
#> 1562                                                                                                                                                                 Unemployment rate by age: From 15 to 24 years
#> 1563                                                                                                                                                                 Unemployment rate by age: From 15 to 74 years
#> 1564                                                                                                                                                                 Unemployment rate by age: From 20 to 64 years
#> 1565                                                                                                                                                                 Unemployment rate by age: From 25 to 29 years
#> 1566                                                                                                                                                                 Unemployment rate by age: From 25 to 54 years
#> 1567                                                                                                                                                                 Unemployment rate by age: From 55 to 64 years
#> 1568                                                                                                                                                             Employed persons by job tenure: 60 months or over
#> 1569                                                                                                                                                           Employed persons by job tenure: From 0 to 11 months
#> 1570                                                                                                                                                          Employed persons by job tenure: From 12 to 23 months
#> 1571                                                                                                                                                          Employed persons by job tenure: From 24 to 59 months
#> 1572                                                                                                                                                                   Employed persons by job tenure: No response
#> 1573                                                                                                                                                                         Employed persons by job tenure: Total
#> 1574                                                                                                                      Labour transitions from temporary to permanent contracts by sex -3-year average: Females
#> 1575                                                                                                                        Labour transitions from temporary to permanent contracts by sex -3-year average: Males
#> 1576                                                                                                                        Labour transitions from temporary to permanent contracts by sex -3-year average: Total
#> 1577                                                                                                                                                   People at risk of poverty or social exclusion by age: Total
#> 1578                                                                                                                                        People at risk of poverty or social exclusion by age: 18 years or over
#> 1579                                                                                                                                        People at risk of poverty or social exclusion by age: 65 years or over
#> 1580                                                                                                                                      People at risk of poverty or social exclusion by age: Less than 18 years
#> 1581                                                                                                                                       People at risk of poverty or social exclusion by age: Less than 6 years
#> 1582                                                                                                                                     People at risk of poverty or social exclusion by age: From 12 to 17 years
#> 1583                                                                                                                                     People at risk of poverty or social exclusion by age: From 18 to 64 years
#> 1584                                                                                                                                      People at risk of poverty or social exclusion by age: From 6 to 11 years
#> 1585                                                                                                                                                           Children aged less than 3 years in formal childcare
#> 1586                                                                                                                                                            General government expenditure by function: Health
#> 1587                                                                                                                                                         General government expenditure by function: Education
#> 1588                                                                                                                                                 General government expenditure by function: Social protection
#> 1589                                                                                                                             Share of main livestock types in total livestock units (LSU): Live bovine animals
#> 1590                                                                                                                    Share of main livestock types in total livestock units (LSU): Live swine, domestic species
#> 1591                                                                                                                                      Share of main livestock types in total livestock units (LSU): Live sheep
#> 1592                                                                                                                                      Share of main livestock types in total livestock units (LSU): Live goats
#> 1593                                                                                                                                    Share of main livestock types in total livestock units (LSU): Live poultry
#> 1594                                                                                                                       Share of main livestock types in total livestock units (LSU): Rabbits, breeding females
#>                                                                                                               unit
#> 1                                                                                               Index, EU-27 = 100
#> 2                                                                                            EUR at current prices
#> 3                                                                                    % change on the previous year
#> 4                                                                                               Index, EU-27 = 100
#> 5                                                                                                         % of GDP
#> 6                                                                                                         % of GDP
#> 7                                                                                                         % of GDP
#> 8                                                                                                         % of GDP
#> 9                                                                                                         % of GDP
#> 10                                                                                                        % of GDP
#> 11                                                                                                        % of GDP
#> 12                                                                                Annual average rate of change, %
#> 13                                                                                               Index, 2015 = 100
#> 14                                                                                                    EUR per year
#> 15                                                                        % of men's average gross hourly earnings
#> 16                                                                                           % of the labour force
#> 17                                                                             % of the labour force aged 15 to 24
#> 18                                                                                           % of the labour force
#> 19                                                                               % of the population aged 20 to 64
#> 20                                                                                               Percentage points
#> 21                                                                                                 % of employment
#> 22                                                                                         % of 15 to 29 year olds
#> 23                                                                                             % of the population
#> 24                                                                                             % of the population
#> 25                                                                                                    EUR per year
#> 26                                                                                    0 = equal, 100 = one has all
#> 27                                                                                                           Ratio
#> 28                                                                                             % of the population
#> 29                                                                                             % of the population
#> 30                                                                                             % of the population
#> 31                                                                                            Persons on 1 January
#> 32                                                                                           Per 1,000 inhabitants
#> 33                                                                               Live births per 1,000 inhabitants
#> 34                                                                                           Live births per woman
#> 35                                                                                           Per 1,000 inhabitants
#> 36                                                                                                           Years
#> 37                                                                   People aged 65 and over per 100 aged 15 to 64
#> 38                                                                                                           Years
#> 39                                                                                                           Years
#> 40                                                                                    Deaths per 1,000 live births
#> 41                                                                                                        % of GDP
#> 42                                                                                         % of 18 to 24 year olds
#> 43                                                                                         % of 25 to 34 year olds
#> 44                                                                                         % of 25 to 64 year olds
#> 45                                                                                       % of people aged 16 to 74
#> 46                                                                                       % of people aged 16 to 74
#> 47                                                                             % of gross final energy consumption
#> 48                                                                                     % of gross available energy
#> 49                                                                                        Tonnes of CO2 equivalent
#> 50                                                                                        Kilograms per inhabitant
#> 51                                                                                            % of municipal waste
#> 52                                                                                           Per 1,000 inhabitants
#> 53                                                                                         Per 100,000 inhabitants
#> 54                                                                                          % of the EU-27 average
#> 55                                                                                                        % of GDP
#> 56                                                                                           % of the labour force
#> 57                                                                               % of the population aged 20 to 64
#> 58                                                                                             % of the population
#> 59                                                                                           Per 1,000 inhabitants
#> 60                                                                                    Persons per square kilometre
#> 61                                                                                                           Years
#> 62                                                                                         % of 25 to 64 year olds
#> 63                                                                                                                
#> 64                                                                                    Current prices, million euro
#> 65                                                                      Percentage of gross domestic product (GDP)
#> 66                                                      Chain linked volumes, percentage change on previous period
#> 67                                          Chain linked volumes, percentage change on previous period, per capita
#> 68                                                      Chain linked volumes, percentage change on previous period
#> 69                                                                      Percentage of gross domestic product (GDP)
#> 70                                                        Kilograms per thousand euro, chain linked volumes (2010)
#> 71                                                                                 Current prices, euro per capita
#> 72                                                                                    Current prices, million euro
#> 73                                                                                    Current prices, million euro
#> 74                                                                      Percentage of gross domestic product (GDP)
#> 75                                Price index - percentage change (t/t-5), based on 2015=100 and national currency
#> 76                                Price index - percentage change (t/t-5), based on 2015=100 and national currency
#> 77                                Price index - percentage change (t/t-5), based on 2015=100 and national currency
#> 78                                                                                    Current prices, million euro
#> 79                                                                      Percentage of gross domestic product (GDP)
#> 80                                                                      Percentage of gross domestic product (GDP)
#> 81                                                                      Percentage of gross domestic product (GDP)
#> 82                                                                      Percentage of gross domestic product (GDP)
#> 83                                                                      Percentage of gross domestic product (GDP)
#> 84                                                    Price index (implicit deflator), 2015=100, national currency
#> 85                                                                      Percentage of gross domestic product (GDP)
#> 86                                                                      Percentage of gross domestic product (GDP)
#> 87                                                                      Percentage of gross domestic product (GDP)
#> 88                                                                                    Current prices, million euro
#> 89                                                                      Percentage of gross domestic product (GDP)
#> 90                                                      Chain linked volumes, percentage change on previous period
#> 91                                                                                    Current prices, million euro
#> 92                                                                                    Current prices, million euro
#> 93                                                                      Percentage of gross domestic product (GDP)
#> 94                                                                                    Current prices, million euro
#> 95                                                                      Percentage of gross domestic product (GDP)
#> 96                                          Chain linked volumes, percentage change on previous period, per capita
#> 97                                                                    Chain linked volumes (2020), euro per capita
#> 98                                                                    Chain linked volumes (2015), euro per capita
#> 99                                                                      Percentage of gross domestic product (GDP)
#> 100                                                                             Square metres per 1000 inhabitants
#> 101                                                                                            Euro per inhabitant
#> 102                                                                                                   Million euro
#> 103                                                        Percentage change on previous period (based on persons)
#> 104                                                                                               Thousand persons
#> 105                                                        Percentage change on previous period (based on persons)
#> 106                                                                                               Thousand persons
#> 107                                                                                               Thousand persons
#> 108                                                       Million purchasing power standards (PPS, EU27 from 2020)
#> 109                                                       Million purchasing power standards (PPS, EU27 from 2020)
#> 110             Percentage of EU27 (from 2020) total (based on million purchasing power standards), current prices
#> 111                                                                                      Percentage change (t/t-3)
#> 112                                                                           Percentage change on previous period
#> 113                                                                           Percentage change on previous period
#> 114                                                                                                Index, 2015=100
#> 115                                                                           Percentage change on previous period
#> 116             Percentage of EU27 (from 2020) total (based on million purchasing power standards), current prices
#> 117             Percentage of EU27 (from 2020) total (based on million purchasing power standards), current prices
#> 118                                                                                                Index, 2015=100
#> 119                                                                                     Percentage change (t/t-10)
#> 120                                                                                      Percentage change (t/t-1)
#> 121                                                                                      Percentage change (t/t-3)
#> 122                                                                                      Percentage change (t/t-5)
#> 123                                                Purchasing power standard (PPS, EU27 from 2020), per inhabitant
#> 124                                                                     Percentage of gross domestic product (GDP)
#> 125                                                                 Percentage of gross adjusted disposable income
#> 126                                                                   Percentage of stocks (closing balance sheet)
#> 127                                                                   Percentage of stocks (closing balance sheet)
#> 128                                                                                                     Percentage
#> 129                                                                                                     Percentage
#> 130                                                                                                     Percentage
#> 131                                                                                                     Percentage
#> 132                                                                                                     Percentage
#> 133                                                                                                     Percentage
#> 134                                                                     Percentage of gross domestic product (GDP)
#> 135                                                                     Percentage of gross domestic product (GDP)
#> 136                                                                     Percentage of gross domestic product (GDP)
#> 137                                                                     Percentage of gross domestic product (GDP)
#> 138                                                                     Percentage of gross domestic product (GDP)
#> 139                                                                                                   Million euro
#> 140                                                                     Percentage of gross domestic product (GDP)
#> 141                                                                                           Percentage per annum
#> 142                                                                                  Annual average rate of change
#> 143                                                                                           Annual average index
#> 144                                 Core inflation differential vis-à-vis the euro area - 20 countries (2023-2025)
#> 145                                 Core inflation differential vis-à-vis the euro area - 21 countries (from 2026)
#> 146                                                                                             Index, EU-27 = 100
#> 147                                                                                             Index, EU-27 = 100
#> 148                                                 Purchasing power standard (PPS, EU27 from 2020) per inhabitant
#> 149                                                                                                     Percentage
#> 150                                                                                                   Million euro
#> 151                                                                                                   Million euro
#> 152                                                                                                   Million euro
#> 153                                                                                                   Million euro
#> 154                                                                                                   Million euro
#> 155                                                                                                   Million euro
#> 156                                                                                                   Million euro
#> 157                                                                                                   Million euro
#> 158                                                                                                   Million euro
#> 159                                                                                                   Million euro
#> 160                                                                                                   Million euro
#> 161                                                                                                   Million euro
#> 162                                                                                                   Million euro
#> 163                                                                                                   Million euro
#> 164                                                                                                   Million euro
#> 165                                                                                                               
#> 166                                                                                                               
#> 167                                                                     Percentage of gross domestic product (GDP)
#> 168                                                                                                               
#> 169                                                                                                               
#> 170                                                                                                               
#> 171                                                                                                               
#> 172                                                                                                               
#> 173                                                                                                               
#> 174                                                                                                               
#> 175                                                                                                               
#> 176                                                                                              Per 1,000 persons
#> 177                                                                                              Per 1,000 persons
#> 178                                                                                              Per 1,000 persons
#> 179                                                                                                               
#> 180                                                                                                               
#> 181                                                                                                               
#> 182                                                                                                               
#> 183                                                                                              Per 1,000 persons
#> 184                                                                                              Per 1,000 persons
#> 185                                                                                              Per 1,000 persons
#> 186                                                                                 Percentage of total population
#> 187                                                                                                          Years
#> 188                                                                                                          Years
#> 189                                                                                                          Years
#> 190                                                                                 Percentage of total population
#> 191                                                                                 Percentage of total population
#> 192                                                                                 Percentage of total population
#> 193                                                                                 Percentage of total population
#> 194                                                                                 Percentage of total population
#> 195                                                                                 Percentage of total population
#> 196                                                                                 Percentage of total population
#> 197                                                                                 Percentage of total population
#> 198                                                                                 Percentage of total population
#> 199                                                                                 Percentage of total population
#> 200                                                                                 Percentage of total population
#> 201                                                                                              Women per 100 men
#> 202                                                                  People aged 65 and over per 100 aged 15 to 64
#> 203                                                                                   Persons per square kilometre
#> 204                                                                                   Persons per square kilometre
#> 205                                                                                                         Number
#> 206                                                                                                         Number
#> 207                                                                                                         Number
#> 208                                                                                                          Years
#> 209                                                                                                          Years
#> 210                                                                                          Live births per woman
#> 211                                                                                                         Number
#> 212                                                                                                           Year
#> 213                                                                                                           Year
#> 214                                                                                                           Year
#> 215                                                                                   Deaths per 1,000 live births
#> 216                                                                                                           Year
#> 217                                                                                                           Year
#> 218                                                                                                           Year
#> 219                                                                                              Per 1,000 persons
#> 220                                                                                                          Years
#> 221                                                                                                          Years
#> 222                                                                                              Per 1,000 persons
#> 223                                                                                                         Number
#> 224                                                                                                         Number
#> 225                                                                                                         Number
#> 226                                                                                                         Number
#> 227                                                                                                         Number
#> 228                                                                                                         Number
#> 229                                                                                                         Person
#> 230                                                                                                         Person
#> 231                                                                                                         Person
#> 232                                                                                                         Person
#> 233                                                                                                         Person
#> 234                                                                                                         Person
#> 235                                                                                                         Person
#> 236                                                                                                         Person
#> 237                                                                                                         Person
#> 238                                                                                                         Person
#> 239                                                                                                         Person
#> 240                                                                                                         Person
#> 241                                                                                                         Person
#> 242                                                                                                         Person
#> 243                                                                                                         Person
#> 244                                                                                                         Person
#> 245                                                                                                         Person
#> 246                                                                                                         Person
#> 247                                                                                                         Person
#> 248                                                                                                         Person
#> 249                                                                                                         Person
#> 250                                                                                                         Person
#> 251                                                                                                         Person
#> 252                                                                                                         Person
#> 253                                                                                                         Person
#> 254                                                                                                         Person
#> 255                                                                                                           Year
#> 256                                                                                                           Year
#> 257                                                                                                           Year
#> 258                                                                                                           Year
#> 259                                                                                                           Year
#> 260                                                                                                           Year
#> 261                                                                                            Euro per inhabitant
#> 262                                                                                                   Million euro
#> 263                                                                       Million purchasing power standards (PPS)
#> 264                                                     Percentual share of total current health expenditure (CHE)
#> 265                                                                     Percentage of gross domestic product (GDP)
#> 266                                                                 Purchasing power standard (PPS) per inhabitant
#> 267                                                                                            Euro per inhabitant
#> 268                                                                                                   Million euro
#> 269                                                                       Million purchasing power standards (PPS)
#> 270                                                     Percentual share of total current health expenditure (CHE)
#> 271                                                                     Percentage of gross domestic product (GDP)
#> 272                                                                 Purchasing power standard (PPS) per inhabitant
#> 273                                                                               Per hundred thousand inhabitants
#> 274                                                                               Per hundred thousand inhabitants
#> 275                                                                               Per hundred thousand inhabitants
#> 276                                                                               Per hundred thousand inhabitants
#> 277                                                                               Per hundred thousand inhabitants
#> 278                                                                               Per hundred thousand inhabitants
#> 279                                                                               Per hundred thousand inhabitants
#> 280                                                                               Per hundred thousand inhabitants
#> 281                                                                                        Per 100,000 inhabitants
#> 282                                                                                        Per 100,000 inhabitants
#> 283                                                                                        Per 100,000 inhabitants
#> 284                                                                                        Per 100,000 inhabitants
#> 285                                                                                        Per 100,000 inhabitants
#> 286                                                                                        Per 100,000 inhabitants
#> 287                                                                                        Per 100,000 inhabitants
#> 288                                                                                        Per 100,000 inhabitants
#> 289                                                                                        Per 100,000 inhabitants
#> 290                                                                                        Per 100,000 inhabitants
#> 291                                                                                        Per 100,000 inhabitants
#> 292                                                                                        Per 100,000 inhabitants
#> 293                                                                                        Per 100,000 inhabitants
#> 294                                                                                        Per 100,000 inhabitants
#> 295                                                                                        Per 100,000 inhabitants
#> 296                                                                                        Per 100,000 inhabitants
#> 297                                                                                        Per 100,000 inhabitants
#> 298                                                                                        Per 100,000 inhabitants
#> 299                                                                                        Per 100,000 inhabitants
#> 300                                                                                        Per 100,000 inhabitants
#> 301                                                                                        Per 100,000 inhabitants
#> 302                                                                                        Per 100,000 inhabitants
#> 303                                                                                        Per 100,000 inhabitants
#> 304                                                                                        Per 100,000 inhabitants
#> 305                                                                                        Per 100,000 inhabitants
#> 306                                                                                        Per 100,000 inhabitants
#> 307                                                                                                         Number
#> 308                                                                                        Per 100,000 inhabitants
#> 309                                                                                                         Person
#> 310                                                                                                         Person
#> 311                                                                                                         Person
#> 312                                                                                                         Person
#> 313                                                                                                         Person
#> 314                                                                                                         Person
#> 315                                                                                               Percentage point
#> 316                                                                                               Percentage point
#> 317                                                                                               Percentage point
#> 318                                                                                               Percentage point
#> 319                                                                                               Percentage point
#> 320                                                                                               Percentage point
#> 321                                                                                               Percentage point
#> 322                                                                                               Percentage point
#> 323                                                                                               Percentage point
#> 324                                                                                                     Percentage
#> 325                                                                                                     Percentage
#> 326                                                                                                     Percentage
#> 327                                                                                                     Percentage
#> 328                                                                                                     Percentage
#> 329                                                                                                     Percentage
#> 330                                                                                                     Percentage
#> 331                                                                                                     Percentage
#> 332                                                                                                     Percentage
#> 333                                                                                                     Percentage
#> 334                                                                                                     Percentage
#> 335                                                                                                     Percentage
#> 336                                                                                                     Percentage
#> 337                                                                                                     Percentage
#> 338                                                                                                     Percentage
#> 339                                                                                                     Percentage
#> 340                                                                                                     Percentage
#> 341                                                                                                     Percentage
#> 342                                                                                                     Percentage
#> 343                                                                                                     Percentage
#> 344                                                                                                     Percentage
#> 345                                                                                                     Percentage
#> 346                                                                                                     Percentage
#> 347                                                                                                     Percentage
#> 348                                                                                                     Percentage
#> 349                                                                                                     Percentage
#> 350                                                                                                     Percentage
#> 351                                                                                                     Percentage
#> 352                                                                                                     Percentage
#> 353                                                                                                     Percentage
#> 354                                                                                 Percentage of total population
#> 355                                                                                 Percentage of total employment
#> 356                                                                                 Percentage of total employment
#> 357                                                                                 Percentage of total employment
#> 358                                                                                 Percentage of total employment
#> 359                                                                                 Percentage of total employment
#> 360                                                                                 Percentage of total employment
#> 361                                                                                 Percentage of total employment
#> 362                                                                                 Percentage of total employment
#> 363                                                                   Percentage of population in the labour force
#> 364                                                                                 Percentage of total population
#> 365                                                                                               Thousand persons
#> 366                                                                                                     Percentage
#> 367                                                                                                     Percentage
#> 368                                                                                                     Percentage
#> 369                                                                                                     Percentage
#> 370                                                                                                     Percentage
#> 371                                                                                                     Percentage
#> 372                                                                                                     Percentage
#> 373                                                                                                     Percentage
#> 374                                                                                                     Percentage
#> 375                                                                                                     Percentage
#> 376                                                                                                     Percentage
#> 377                                                                                                           Hour
#> 378                                                                                                     Percentage
#> 379                                                                                                     Percentage
#> 380                                                                                                     Percentage
#> 381                                                                                                     Percentage
#> 382                                                                                                     Percentage
#> 383                                                                                                     Percentage
#> 384                                                                                                     Percentage
#> 385                                                                                                           Euro
#> 386                                                                                                           Euro
#> 387                                                                                                           Euro
#> 388                                                                                                           Euro
#> 389                                                                                                     Percentage
#> 390                                                                                               Thousand persons
#> 391                                                                                                     Percentage
#> 392                                                                                               Thousand persons
#> 393                                                                                                          Ratio
#> 394                                                                                                          Ratio
#> 395                                                                                   0 = equal, 100 = one has all
#> 396                                                                                                     Percentage
#> 397                                                                                                     Percentage
#> 398                                                                                                     Percentage
#> 399                                                                                                     Percentage
#> 400                                                                                                     Percentage
#> 401                                                                                                     Percentage
#> 402                                                                                                     Percentage
#> 403                                                                                                     Percentage
#> 404                                                                                                     Percentage
#> 405                                                                                                     Percentage
#> 406                                                                                                     Percentage
#> 407                                                                                                     Percentage
#> 408                                                                                                     Percentage
#> 409                                                                                                     Percentage
#> 410                                                                                                     Percentage
#> 411                                                                                                     Percentage
#> 412                                                                                                     Percentage
#> 413                                                                                                     Percentage
#> 414                                                                                                     Percentage
#> 415                                                                                                     Percentage
#> 416                                                                                                     Percentage
#> 417                                                                                                     Percentage
#> 418                                                                                                     Percentage
#> 419                                                                                Percentage of total expenditure
#> 420                                                                                Percentage of total expenditure
#> 421                                                                                Percentage of total expenditure
#> 422                                                                  Euro per inhabitant (at constant 2010 prices)
#> 423                                                                     Percentage of gross domestic product (GDP)
#> 424                                                                 Purchasing power standard (PPS) per inhabitant
#> 425                                                                     Percentage of gross domestic product (GDP)
#> 426                                                                                                   Million euro
#> 427                                                                                                   Million euro
#> 428                                                                                                   Million euro
#> 429                                                                                                   Million euro
#> 430                                                                                                   Million euro
#> 431                                                                                                   Million euro
#> 432                                                                                                   Million euro
#> 433                                                                                                   Million euro
#> 434                                                                                                   Million euro
#> 435                                                                                                               
#> 436                                                                                                               
#> 437                                                                                                               
#> 438                                                                                                               
#> 439                                                                                                               
#> 440                                                                                                               
#> 441                                                                                                               
#> 442                                                                                                               
#> 443                                                                                                               
#> 444                                                                     Percentage of gross domestic product (GDP)
#> 445                                                                     Percentage of gross domestic product (GDP)
#> 446                                                                     Percentage of gross domestic product (GDP)
#> 447                                                                     Percentage of gross domestic product (GDP)
#> 448                                                                                                         Number
#> 449                                                                               Per hundred thousand inhabitants
#> 450                                                                                                         Number
#> 451                                                                               Per hundred thousand inhabitants
#> 452                                                                                                         Number
#> 453                                                                               Per hundred thousand inhabitants
#> 454                                                                                                         Number
#> 455                                                                                                         Number
#> 456                                                                                                         Number
#> 457                                                                                                         Number
#> 458                                                                                                         Number
#> 459                                                                                                         Number
#> 460                                                                                                         Number
#> 461                                                                                                         Number
#> 462                                                                                                         Number
#> 463                                                                                                         Number
#> 464                                                                                                         Number
#> 465                                                                                                         Number
#> 466                                                                                                         Number
#> 467                                                                                                     Percentage
#> 468                                                                                                     Percentage
#> 469                                                                                                         Number
#> 470                                                                                                         Number
#> 471                                                                                                         Number
#> 472                                                                                                         Number
#> 473                                                                                                         Number
#> 474                                                                                                         Number
#> 475                                                                                                         Number
#> 476                                                                                                         Number
#> 477                                                                                                         Number
#> 478                                                                                                         Number
#> 479                                                                                                         Number
#> 480                                                                                                         Number
#> 481                                                                                                         Number
#> 482                                                                                                         Number
#> 483                                                                                                         Number
#> 484                                                                                                         Number
#> 485                                                                                                         Number
#> 486                                                                                                         Number
#> 487                                                                                 Percentage of total population
#> 488                                                                                 Percentage of total population
#> 489                                                                                 Percentage of total population
#> 490                                                                                                         Number
#> 491                                                                                                         Number
#> 492                                                                                                         Number
#> 493                                                                                                         Number
#> 494                                                                                                         Number
#> 495                                                                                                         Number
#> 496                                                                                                         Number
#> 497                                                                                                         Number
#> 498                                                                                                         Number
#> 499                                                                                                         Number
#> 500                                                                                                         Number
#> 501                                                                                                         Number
#> 502                                                                                                         Number
#> 503                                                                                                         Number
#> 504                                                                                                         Number
#> 505                                                                                                         Number
#> 506                                                                                                         Number
#> 507                                                                                                         Number
#> 508                                                                                                         Number
#> 509                                                                                                         Number
#> 510                                                                                                         Number
#> 511                                                                                                         Number
#> 512                                                                                                         Number
#> 513                                                                                                         Number
#> 514                                                                                                         Number
#> 515                                                                                                         Number
#> 516                                                                                                         Number
#> 517                                                                                                         Number
#> 518                                                                                                         Number
#> 519                                                                                                           Euro
#> 520                                                                                                           Euro
#> 521                                                                                                     Percentage
#> 522                                                                                                     Percentage
#> 523                                                                                                        Holding
#> 524                                                                                                        Holding
#> 525                                                                                                        Holding
#> 526                                                                                                        Holding
#> 527                                                                                                        Holding
#> 528                                                                                                        Holding
#> 529                                                                                                        Hectare
#> 530                                                                                                        Hectare
#> 531                                                                                                        Hectare
#> 532                                                                                                        Hectare
#> 533                                                                                                        Hectare
#> 534                                                                                                        Hectare
#> 535                                                                                                     Percentage
#> 536                                                                                                     Percentage
#> 537                                                                                                     Percentage
#> 538                                                                                                        Holding
#> 539                                                                                                        Holding
#> 540                                                                                                        Holding
#> 541                                                                                                        Holding
#> 542                                                                                                        Holding
#> 543                                                                                                        Holding
#> 544                                                                                                        Holding
#> 545                                                                                                        Holding
#> 546                                                                                                        Holding
#> 547                                                                                                        Holding
#> 548                                                                                                        Holding
#> 549                                                                                                        Holding
#> 550                                                                                                        Holding
#> 551                                                                                                        Holding
#> 552                                                                                                        Holding
#> 553                                                                                                        Holding
#> 554                                                                                                        Holding
#> 555                                                                                                         Person
#> 556                                                                                                         Person
#> 557                                                                                                         Person
#> 558                                                                                                         Person
#> 559                                                                                                         Person
#> 560                                                                                                         Person
#> 561                                                                                                   Million euro
#> 562                                                                                                   Million euro
#> 563                                                                                                   Million euro
#> 564                                                                                                   Million euro
#> 565                                                                                                   Million euro
#> 566                                                                                                   Million euro
#> 567                                                                                                Index, 2020=100
#> 568                                                                                                           Euro
#> 569                                                                                                           Euro
#> 570                                                                                                           Euro
#> 571                                                                                                           Euro
#> 572                                                                                                           Euro
#> 573                                                                                                           Euro
#> 574                                                                                                           Euro
#> 575                                                                                                           Euro
#> 576                                                                                                           Euro
#> 577                                                                                                           Euro
#> 578                                                                                                           Euro
#> 579                                                                                                           Euro
#> 580                                                                                                           Euro
#> 581                                                                                                Index, 2020=100
#> 582                                                                                                Index, 2020=100
#> 583                                                                                                Index, 2020=100
#> 584                                                                                                Index, 2020=100
#> 585                                                                                                Index, 2020=100
#> 586                                                                                                Index, 2020=100
#> 587                                                                                                Index, 2020=100
#> 588                                                                                                Index, 2020=100
#> 589                                                                                                Thousand tonnes
#> 590                                                                                                Thousand tonnes
#> 591                                                                                                Thousand tonnes
#> 592                                                                                                Thousand tonnes
#> 593                                                                                                Thousand tonnes
#> 594                                                                                                Thousand tonnes
#> 595                                                                                                Thousand tonnes
#> 596                                                                                                Thousand tonnes
#> 597                                                                                                Thousand tonnes
#> 598                                                                                                Thousand tonnes
#> 599                                                                                       Thousand heads (animals)
#> 600                                                                                       Thousand heads (animals)
#> 601                                                                                       Thousand heads (animals)
#> 602                                                                                       Thousand heads (animals)
#> 603                                                                                       Thousand heads (animals)
#> 604                                                                                       Thousand heads (animals)
#> 605                                                                                       Thousand heads (animals)
#> 606                                                                                       Thousand heads (animals)
#> 607                                                                                       Thousand heads (animals)
#> 608                                                                                              Thousand hectares
#> 609                                                                                              Thousand hectares
#> 610                                                                                              Thousand hectares
#> 611                                                                                              Thousand hectares
#> 612                                                                                              Thousand hectares
#> 613                                                                        Kilograms of oil equivalent per hectare
#> 614                                                                                              Thousand hectares
#> 615                                                                                              Thousand hectares
#> 616                                                                                              Thousand hectares
#> 617                                                                                              Thousand hectares
#> 618                                                                                              Thousand hectares
#> 619                                                                                              Thousand hectares
#> 620                                                                                              Thousand hectares
#> 621                                                                                              Thousand hectares
#> 622                                                                                              Thousand hectares
#> 623                                                                                              Thousand hectares
#> 624                                                                                                               
#> 625                                                                                                               
#> 626                                                                                                               
#> 627                                                                                              Thousand hectares
#> 628                                                                                              Thousand hectares
#> 629                                                                                              Thousand hectares
#> 630                                                                                              Thousand hectares
#> 631                                                                                              Thousand hectares
#> 632                                                                                              Thousand hectares
#> 633                                                                                              Thousand hectares
#> 634                                                                                              Thousand hectares
#> 635                                                                                                               
#> 636                                                                                                               
#> 637                                                                                                               
#> 638                                                                                                               
#> 639                                                                                                               
#> 640                                                                                                               
#> 641                                                                                                               
#> 642                                                                                                               
#> 643                                                                                                               
#> 644                                                                                                               
#> 645                                                                                                               
#> 646                                                                                                               
#> 647                                                                                                               
#> 648                                                                                                               
#> 649                                                                                                               
#> 650                                                                                                Thousand tonnes
#> 651                                                                                                Thousand tonnes
#> 652                                                                                                Thousand tonnes
#> 653                                                                                                Thousand tonnes
#> 654                                                                                                               
#> 655                                                                                                               
#> 656                                                                                                               
#> 657                                                                                                Thousand tonnes
#> 658                                                                                                Thousand tonnes
#> 659                                                                                                               
#> 660                                                                                                               
#> 661                                                                                                               
#> 662                                                                                             Tonnes per hectare
#> 663                                                                                             Tonnes per hectare
#> 664                                                                                             Tonnes per hectare
#> 665                                                                                                     Percentage
#> 666                                                                                                     Percentage
#> 667                                                                                                     Percentage
#> 668                                                                                             Tonnes live weight
#> 669                                                                                                         Number
#> 670                                                                                             Gross tonnage (GT)
#> 671                                                                                                           Euro
#> 672                                                                                                 Euro per tonne
#> 673                                                                                             Tonnes live weight
#> 674                                                                                                               
#> 675                                                                                                               
#> 676                                                                                                               
#> 677                                                                                                               
#> 678                                                                                                               
#> 679                                                                                                               
#> 680                                                                                                               
#> 681                                                                                                               
#> 682                                                                                                   Million euro
#> 683                                                                                                   Million euro
#> 684                                                                                                   Million euro
#> 685                                                                                                               
#> 686                                                                                                               
#> 687                                                                                                               
#> 688                                                                                                               
#> 689                                                                                                               
#> 690                                                                                                               
#> 691                                                                                                               
#> 692                                                                                                               
#> 693                                                                                                               
#> 694                                                                                                               
#> 695                                                                                                               
#> 696                                                                                                               
#> 697                                                                                                               
#> 698                                                                                                      Passenger
#> 699                                                                                                          Tonne
#> 700                                                                                            Thousand passengers
#> 701                                                                                                Thousand tonnes
#> 702                                                                                  Million tonne-kilometre (TKM)
#> 703                                                                                                Thousand tonnes
#> 704                                                                                                Thousand tonnes
#> 705                                                                                            Thousand passengers
#> 706                                                                                                Thousand tonnes
#> 707                                                                                                      Kilometre
#> 708                                                                               Millions of passenger-kilometres
#> 709                                                                                  Million tonne-kilometre (TKM)
#> 710                                                                                                Thousand tonnes
#> 711                                                                                                      Kilometre
#> 712                                                                                                      Kilometre
#> 713                                                                                  Million tonne-kilometre (TKM)
#> 714                                                                                                Thousand tonnes
#> 715                                                                                                      Kilometre
#> 716                                                                      Kilometres per thousand square kilometres
#> 717                                                                                                      Kilometre
#> 718                                                                      Kilometres per thousand square kilometres
#> 719                                                                                                     Percentage
#> 720                                                                                                     Percentage
#> 721                                                                                                     Percentage
#> 722                                                                                                     Percentage
#> 723                                                                                                     Percentage
#> 724                                                                                                     Percentage
#> 725                                                                                                Index, 2015=100
#> 726                                                                                           Kilograms per capita
#> 727                                                                                                     Percentage
#> 728                                                                                                     Percentage
#> 729                                                                                                     Percentage
#> 730                                                                                                     Percentage
#> 731                                                                                                     Percentage
#> 732                                                                                                     Percentage
#> 733                                                                                                     Percentage
#> 734                                                                                              Tonnes per capita
#> 735                                                                     Percentage of gross domestic product (GDP)
#> 736      Percentage of total revenues from taxes and social contributions (excluding imputed social contributions)
#> 737                                                                                                   Million euro
#> 738                                                                                                   Million euro
#> 739                                                                     Percentage of gross domestic product (GDP)
#> 740                                                                      Chain linked volumes (2020), million euro
#> 741                                                                     Percentage of gross domestic product (GDP)
#> 742                                                                                                          Tonne
#> 743                                                                                                          Tonne
#> 744                                                                                                          Tonne
#> 745                                                                                                          Tonne
#> 746                                                                                           Kilograms per capita
#> 747                                                                                           Kilograms per capita
#> 748                                                                                           Kilograms per capita
#> 749                                                                                                     Percentage
#> 750                                                                                           Kilograms per capita
#> 751                                                                                                     Percentage
#> 752                                                                                                     Percentage
#> 753                                                                                                     Percentage
#> 754                                                                                                     Percentage
#> 755                                                                                                     Percentage
#> 756                                                                                                     Percentage
#> 757                                                                                                     Percentage
#> 758                                                                           Percentage (2025 target and onwards)
#> 759                                                                           Percentage (2025 target and onwards)
#> 760                                                                           Percentage (2025 target and onwards)
#> 761                                                                           Percentage (2025 target and onwards)
#> 762                                                                           Percentage (2025 target and onwards)
#> 763                                                                           Percentage (2025 target and onwards)
#> 764                                                                                           Million cubic metres
#> 765                                                                                           Million cubic metres
#> 766                                                                                           Million cubic metres
#> 767                                                                                           Million cubic metres
#> 768                                                                                           Million cubic metres
#> 769                                                                                           Million cubic metres
#> 770                                                                                    Cubic metres per inhabitant
#> 771                                                                                    Cubic metres per inhabitant
#> 772                                                                                    Cubic metres per inhabitant
#> 773                                                                                                Thousand tonnes
#> 774                                                                                                Thousand tonnes
#> 775                                                                                                Thousand tonnes
#> 776                                                                                                Thousand tonnes
#> 777                                                                                                Thousand tonnes
#> 778                                                                                                Thousand tonnes
#> 779                                                                                                Thousand tonnes
#> 780                                                                                              Tonnes per capita
#> 781                                                                                                Thousand tonnes
#> 782                                                                                              Tonnes per capita
#> 783                                                                              Thousand tonnes of oil equivalent
#> 784                                                                              Thousand tonnes of oil equivalent
#> 785                                                                              Thousand tonnes of oil equivalent
#> 786                                                                              Thousand tonnes of oil equivalent
#> 787                                                                              Thousand tonnes of oil equivalent
#> 788                                                                              Kilogram of oil equivalent (KGOE)
#> 789                                                                                                     Percentage
#> 790                                                                                                     Percentage
#> 791                                                                                                     Percentage
#> 792                                                                                                     Percentage
#> 793                                                                                                Index, 2005=100
#> 794                                                                               Million tonnes of oil equivalent
#> 795                                                                      Tonnes of oil equivalent (TOE) per capita
#> 796                                                                                                Index, 2005=100
#> 797                                                                               Million tonnes of oil equivalent
#> 798                                                                      Tonnes of oil equivalent (TOE) per capita
#> 799                                                                     Euro per kilogram of oil equivalent (KGOE)
#> 800                                                 Purchasing power standard (PPS) per kilogram of oil equivalent
#> 801                                                                                                     Percentage
#> 802                                                                                                     Percentage
#> 803                                                                                                     Percentage
#> 804                                                                                                     Percentage
#> 805                                                                                                  Gigawatt-hour
#> 806                                                                     Percentage of gross domestic product (GDP)
#> 807                                                                     Percentage of gross domestic product (GDP)
#> 808                                                                     Percentage of gross domestic product (GDP)
#> 809                                                                     Percentage of gross domestic product (GDP)
#> 810                                                                     Percentage of gross domestic product (GDP)
#> 811                                                                     Percentage of gross domestic product (GDP)
#> 812                                                                                                     Head count
#> 813                                                                                                     Head count
#> 814                                                                                                     Head count
#> 815                                                                                                     Head count
#> 816                                                                                                     Head count
#> 817                                                                                     Full-time equivalent (FTE)
#> 818                                                                                     Full-time equivalent (FTE)
#> 819                                                                                     Full-time equivalent (FTE)
#> 820                                                                                     Full-time equivalent (FTE)
#> 821                                                                                     Full-time equivalent (FTE)
#> 822                         Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 823                         Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 824                         Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 825                         Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 826                         Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 827                                       Percentage of total employment - numerator in full-time equivalent (FTE)
#> 828                                                                Percentage based on full-time equivalents (FTE)
#> 829                                                                            Percentage based on head count (HC)
#> 830                                                                            Percentage based on head count (HC)
#> 831                                                                            Percentage based on head count (HC)
#> 832                                                                            Percentage based on head count (HC)
#> 833                                                                            Percentage based on head count (HC)
#> 834                                                                                      Percentage of total GBARD
#> 835                                                                                      Percentage of total GBARD
#> 836                                                                                      Percentage of total GBARD
#> 837                                                                                                     Percentage
#> 838                                                                                 Percentage of total employment
#> 839                                                                                 Percentage of total employment
#> 840                                                                                 Percentage of total employment
#> 841                                                                   Percentage of population in the labour force
#> 842                                                                   Percentage of population in the labour force
#> 843                                                                   Percentage of population in the labour force
#> 844                                                                   Percentage of population in the labour force
#> 845                                                                                                         Number
#> 846                                                                                        Per million inhabitants
#> 847                                                                                                         Number
#> 848                                                                                        Per million inhabitants
#> 849                                                                                       Percentage of households
#> 850                                                                                      Percentage of individuals
#> 851                                                                                      Percentage of individuals
#> 852                                                                                      Percentage of individuals
#> 853                                                                                      Percentage of individuals
#> 854                                                                                      Percentage of individuals
#> 855                                                                                      Percentage of individuals
#> 856                                                                                      Percentage of individuals
#> 857                                                                                      Percentage of individuals
#> 858                                                                                      Percentage of individuals
#> 859                                                                                      Percentage of individuals
#> 860                                                                                      Percentage of individuals
#> 861                                                                                      Percentage of individuals
#> 862                                                                                      Percentage of individuals
#> 863                                                                                      Percentage of individuals
#> 864                                                                                      Percentage of individuals
#> 865                                                                                      Percentage of individuals
#> 866                                               Percentage of individuals who used internet within the last year
#> 867                                                                                      Percentage of individuals
#> 868                                                                                      Percentage of individuals
#> 869                                                                                      Percentage of enterprises
#> 870                                                                                         Percentage of turnover
#> 871                                                                                      Percentage of enterprises
#> 872                                                                                                               
#> 873                                                                                                               
#> 874                                                                                                               
#> 875                                                                                                               
#> 876                                                                                                               
#> 877                                                                                                               
#> 878                                                                                                               
#> 879                                                                                                               
#> 880                                                                                                               
#> 881                                                                                       Percentage of households
#> 882                                                                                       Percentage of households
#> 883  Purchasing power standard (PPS, EU27 from 2020), per inhabitant in percentage of the EU27 (from 2020) average
#> 884                                                                                                   Million euro
#> 885                                                       Million purchasing power standards (PPS, EU27 from 2020)
#> 886                                                                                                Index, 2020=100
#> 887                                                                           Percentage change on previous period
#> 888                                                                                                Index, 2020=100
#> 889                                                                           Percentage change on previous period
#> 890                                                                                        Per 100,000 inhabitants
#> 891                                                                                        Per 100,000 inhabitants
#> 892                                                                                        Per 100,000 inhabitants
#> 893                                                                                        Per 100,000 inhabitants
#> 894                                                                                        Per 100,000 inhabitants
#> 895                                                                                        Per 100,000 inhabitants
#> 896                                                                                        Per 100,000 inhabitants
#> 897                                                                                        Per 100,000 inhabitants
#> 898                                                                                        Per 100,000 inhabitants
#> 899                                                                                        Per 100,000 inhabitants
#> 900                                                                                        Per 100,000 inhabitants
#> 901                                                                                        Per 100,000 inhabitants
#> 902                                                                                        Per 100,000 inhabitants
#> 903                                                                                        Per 100,000 inhabitants
#> 904                                                                                        Per 100,000 inhabitants
#> 905                                                                                        Per 100,000 inhabitants
#> 906                                                                                        Per 100,000 inhabitants
#> 907                                                                                        Per 100,000 inhabitants
#> 908                                                                                        Per 100,000 inhabitants
#> 909                                                                                        Per 100,000 inhabitants
#> 910                                                                                        Per 100,000 inhabitants
#> 911                                                                                        Per 100,000 inhabitants
#> 912                                                                                        Per 100,000 inhabitants
#> 913                                                                                        Per 100,000 inhabitants
#> 914                                                                                        Per 100,000 inhabitants
#> 915                                                                                        Per 100,000 inhabitants
#> 916                                                                                        Per 100,000 inhabitants
#> 917                                                                                        Per 100,000 inhabitants
#> 918                                                                                        Per 100,000 inhabitants
#> 919                                                                                        Per 100,000 inhabitants
#> 920                                                                                        Per 100,000 inhabitants
#> 921                                                                               Per hundred thousand inhabitants
#> 922                                                                                                         Number
#> 923                                                                                                         Number
#> 924                                                                                                         Number
#> 925                                                                                       Percentage of households
#> 926                                                                                 Percentage of total population
#> 927                                                                                                     Percentage
#> 928                                                                                                     Percentage
#> 929                                                                                                     Percentage
#> 930                                                                                                     Percentage
#> 931                                                                                                     Percentage
#> 932                                                                                                     Percentage
#> 933                                                                                                     Percentage
#> 934                                                                                                     Percentage
#> 935                                                                                                     Percentage
#> 936                                                                                                     Percentage
#> 937                                                                                                     Percentage
#> 938                                                                                                     Percentage
#> 939                                                                                      Percentage of individuals
#> 940                                                                                      Percentage of individuals
#> 941                                                                                      Percentage of individuals
#> 942                                                                                      Percentage of individuals
#> 943                                                                                      Percentage of individuals
#> 944                                                                                      Percentage of individuals
#> 945                                                                         Percentage of GDP - three-year average
#> 946                                                                     Percentage of gross domestic product (GDP)
#> 947                                     Percentage of the total of OECD countries and EU Member States not in OECD
#> 948                                             Percentage of OECD and non-OECD EU countries total - 1-year change
#> 949                                             Percentage of OECD and non-OECD EU countries total - 3-year change
#> 950                     Percentage of the total of OECD countries and EU Member States not in OECD - 5-year change
#> 951                                                                      Percentage of world total - 1-year change
#> 952                                                                     Percentage of gross domestic product (GDP)
#> 953                                                                     Percentage of gross domestic product (GDP)
#> 954                                                                   Percentage of population in the labour force
#> 955                                                                   Percentage of population in the labour force
#> 956                                                                   Percentage of population in the labour force
#> 957                                                                                 Percentage of total population
#> 958                                                                              Percentage point change (t-(t-3))
#> 959                                                                     Percentage of gross domestic product (GDP)
#> 960                                                                     Percentage of gross domestic product (GDP)
#> 961                                                                     Percentage of gross domestic product (GDP)
#> 962                                                                     Percentage of gross domestic product (GDP)
#> 963                                                                     Percentage of gross domestic product (GDP)
#> 964                                                                     Percentage of gross domestic product (GDP)
#> 965                                                                     Percentage of gross domestic product (GDP)
#> 966                                                                     Percentage of gross domestic product (GDP)
#> 967                                                                     Percentage of gross domestic product (GDP)
#> 968                                                                     Percentage of gross domestic product (GDP)
#> 969                                                                     Percentage of gross domestic product (GDP)
#> 970                                                                     Percentage of gross domestic product (GDP)
#> 971                                                                     Percentage of gross domestic product (GDP)
#> 972                                                                     Percentage of gross domestic product (GDP)
#> 973                                                                     Percentage of gross domestic product (GDP)
#> 974                                                                     Percentage of gross domestic product (GDP)
#> 975                                                                     Percentage of gross domestic product (GDP)
#> 976                                                                     Percentage of gross domestic product (GDP)
#> 977                                                                     Percentage of gross domestic product (GDP)
#> 978                                                                     Percentage of gross domestic product (GDP)
#> 979                                                                     Percentage of gross domestic product (GDP)
#> 980                                                                     Percentage of gross domestic product (GDP)
#> 981                                                                     Percentage of gross domestic product (GDP)
#> 982                                                                     Percentage of gross domestic product (GDP)
#> 983                                                                                                Index, 2015=100
#> 984                                                                                      Percentage change (t/t-1)
#> 985                                                                                      Percentage change (t/t-3)
#> 986                                                                                     Percentage change (t/t-10)
#> 987                                                                                      Percentage change (t/t-1)
#> 988                                                                                                Index, 2015=100
#> 989                                                                                      Percentage change (t/t-1)
#> 990                                                                                      Percentage change (t/t-3)
#> 991                                                                                                Index, 2015=100
#> 992                                                                                                Index, 2020=100
#> 993                                                                     Percentage of gross domestic product (GDP)
#> 994                                                                     Percentage of gross domestic product (GDP)
#> 995                                                                      Percentage of world total - 1-year change
#> 996                                                                      Percentage of world total - 1-year change
#> 997                                                                      Percentage of world total - 1-year change
#> 998                                                                                      Percentage of world total
#> 999                                                                                      Percentage of world total
#> 1000                                                                                     Percentage of world total
#> 1001                                                                     Percentage of world total - 3 year change
#> 1002                                                                     Percentage of world total - 3 year change
#> 1003                                                                     Percentage of world total - 3 year change
#> 1004                                                                                                    Percentage
#> 1005                                                                    Percentage of gross domestic product (GDP)
#> 1006                                                                          Percentage change on previous period
#> 1007                                                                    Percentage of gross domestic product (GDP)
#> 1008                                                                    Percentage of gross domestic product (GDP)
#> 1009                                                                    Percentage of gross domestic product (GDP)
#> 1010                                                                    Percentage of gross domestic product (GDP)
#> 1011                                                                    Percentage of gross domestic product (GDP)
#> 1012                                                                    Percentage of gross domestic product (GDP)
#> 1013                                                                    Percentage of gross domestic product (GDP)
#> 1014                                                                    Percentage of gross domestic product (GDP)
#> 1015                                                                    Percentage of gross domestic product (GDP)
#> 1016                                                                    Percentage of gross domestic product (GDP)
#> 1017                                                                    Percentage of gross domestic product (GDP)
#> 1018                                                                    Percentage of gross domestic product (GDP)
#> 1019                                                                    Percentage of gross domestic product (GDP)
#> 1020                                                                    Percentage of gross domestic product (GDP)
#> 1021                                                                    Percentage of gross domestic product (GDP)
#> 1022                                                                                                    Percentage
#> 1023                                                                    Percentage of gross domestic product (GDP)
#> 1024                                                                          Percentage change on previous period
#> 1025                                                                    Percentage of gross domestic product (GDP)
#> 1026                                                                    Percentage of gross domestic product (GDP)
#> 1027                                                                    Percentage of gross domestic product (GDP)
#> 1028                                                                    Percentage of gross domestic product (GDP)
#> 1029                                                                    Percentage of gross domestic product (GDP)
#> 1030                                                                    Percentage of gross domestic product (GDP)
#> 1031                                                                    Percentage of gross domestic product (GDP)
#> 1032                                                                    Percentage of gross domestic product (GDP)
#> 1033                                                                    Percentage of gross domestic product (GDP)
#> 1034                                                                    Percentage of gross domestic product (GDP)
#> 1035                                                                    Percentage of gross domestic product (GDP)
#> 1036                                                                    Percentage of gross domestic product (GDP)
#> 1037                                                                    Percentage of gross domestic product (GDP)
#> 1038                                                                    Percentage of gross domestic product (GDP)
#> 1039                                                                    Percentage of gross domestic product (GDP)
#> 1040                                                                    Percentage of gross domestic product (GDP)
#> 1041                                                                    Percentage of gross domestic product (GDP)
#> 1042                                                                    Percentage of gross domestic product (GDP)
#> 1043                                                                    Percentage of gross domestic product (GDP)
#> 1044                                                                    Percentage of gross domestic product (GDP)
#> 1045                                                                    Percentage of gross domestic product (GDP)
#> 1046                                                                    Percentage of gross domestic product (GDP)
#> 1047                                                                    Percentage of gross domestic product (GDP)
#> 1048                                                                    Percentage of gross domestic product (GDP)
#> 1049                                                                    Percentage of gross domestic product (GDP)
#> 1050                                                                    Percentage of gross domestic product (GDP)
#> 1051                                                                    Percentage of gross domestic product (GDP)
#> 1052                                                                    Percentage of gross domestic product (GDP)
#> 1053                                                                    Percentage of gross domestic product (GDP)
#> 1054                                                                    Percentage of gross domestic product (GDP)
#> 1055                                                                    Percentage of gross domestic product (GDP)
#> 1056                                                                    Percentage of gross domestic product (GDP)
#> 1057                                                                    Percentage of gross domestic product (GDP)
#> 1058                                                                    Percentage of gross domestic product (GDP)
#> 1059                                                                    Percentage of gross domestic product (GDP)
#> 1060                                                                    Percentage of gross domestic product (GDP)
#> 1061                                                                    Percentage of gross domestic product (GDP)
#> 1062                                                                    Percentage of gross domestic product (GDP)
#> 1063                                                                    Percentage of gross domestic product (GDP)
#> 1064                                                                    Percentage of gross domestic product (GDP)
#> 1065                                                                    Percentage of gross domestic product (GDP)
#> 1066                                              Percentage of population in the labour force, three-year average
#> 1067                                                                  Percentage of population in the labour force
#> 1068                                                                             Percentage point change (t-(t-3))
#> 1069                                                                  Percentage of population in the labour force
#> 1070                                                                             Percentage point change (t-(t-3))
#> 1071                                                                                Percentage of total population
#> 1072                                                                             Percentage point change (t-(t-3))
#> 1073                                                                                              Thousand persons
#> 1074                                                                                              Thousand persons
#> 1075                                                                                                    Percentage
#> 1076                                                                             Percentage point change (t-(t-3))
#> 1077                                                                                                    Percentage
#> 1078                                                                             Percentage point change (t-(t-3))
#> 1079                                                                                                    Percentage
#> 1080                                                                             Percentage point change (t-(t-3))
#> 1081                                                                                                    Percentage
#> 1082                                                                             Percentage point change (t-(t-3))
#> 1083                                                                    Percentage of gross domestic product (GDP)
#> 1084                                                                                                  Million euro
#> 1085                                                                    Percentage of gross domestic product (GDP)
#> 1086                                                                                                  Million euro
#> 1087                                                                    Percentage of gross domestic product (GDP)
#> 1088                                                                                                  Million euro
#> 1089                                                                    Percentage of gross domestic product (GDP)
#> 1090                                                                Euro per kilogram, chain linked volumes (2015)
#> 1091                                                                                               Index, 2000=100
#> 1092                                                                  Purchasing power standard (PPS) per kilogram
#> 1093                                                                                          Kilograms per capita
#> 1094                                                                                          Kilograms per capita
#> 1095                                                                                          Kilograms per capita
#> 1096                                                                                          Kilograms per capita
#> 1097                                                                                                    Percentage
#> 1098                                                                          Percentage (2025 target and onwards)
#> 1099                                                                          Percentage (2025 target and onwards)
#> 1100                                                                          Percentage (2025 target and onwards)
#> 1101                                                                          Percentage (2025 target and onwards)
#> 1102                                                                          Percentage (2025 target and onwards)
#> 1103                                                                          Percentage (2025 target and onwards)
#> 1104                                                                                                    Percentage
#> 1105                                                                                            Planetary Boundary
#> 1106                                                                                                    Percentage
#> 1107                                                                                                    Percentage
#> 1108                                                                                              Thousand persons
#> 1109                                                                                                    Percentage
#> 1110                                                                                                    Percentage
#> 1111                                                                                                    Percentage
#> 1112                                                                                                    Percentage
#> 1113                                                                                              Thousand persons
#> 1114                                                                                                    Percentage
#> 1115                                                                                              Thousand persons
#> 1116                                                                                                    Percentage
#> 1117                                                                                                      Thousand
#> 1118                                                                                                    Percentage
#> 1119                                                                                                      Thousand
#> 1120                                                                                                    Percentage
#> 1121                                                                                                    Percentage
#> 1122                                                                                                    Percentage
#> 1123                                                                                                    Percentage
#> 1124                                                                                                    Percentage
#> 1125                                                                                                    Percentage
#> 1126                                                                                                    Percentage
#> 1127                                                                                                    Percentage
#> 1128                                                                                                    Percentage
#> 1129                                                                                                    Percentage
#> 1130                                                                                                    Percentage
#> 1131                                                                                                    Percentage
#> 1132                                                                                                    Percentage
#> 1133                                                                                                    Percentage
#> 1134                                                                          Chain linked volumes, index 2020=100
#> 1135                                                  Chain linked volumes (2020), euro per annual work unit (AWU)
#> 1136                                                                                           Euro per inhabitant
#> 1137                                                                                                  Million euro
#> 1138                                                                Percentage of total utilised agricultural area
#> 1139                                                                                         Kilograms per hectare
#> 1140                                                                                                         Tonne
#> 1141                                                                                              Square kilometre
#> 1142                                                                                                    Percentage
#> 1143                                                                                                    Percentage
#> 1144                                                                                                    Percentage
#> 1145                                                                                                    Percentage
#> 1146                                                                                       Per 100,000 inhabitants
#> 1147                                                                                       Per 100,000 inhabitants
#> 1148                                                                                       Per 100,000 inhabitants
#> 1149                                                                                                Incidence rate
#> 1150                                                                                                Incidence rate
#> 1151                                                                                                Incidence rate
#> 1152                                                                                                    Percentage
#> 1153                                                                                                    Percentage
#> 1154                                                                                                    Percentage
#> 1155                                                                                                        Number
#> 1156                                                                                       Per 100,000 inhabitants
#> 1157                                                                                                        Number
#> 1158                                                                                       Per 100,000 inhabitants
#> 1159                                                                                                        Number
#> 1160                                                                                       Per 100,000 inhabitants
#> 1161                                                                                                        Number
#> 1162                                                                                       Per 100,000 inhabitants
#> 1163                                                                                                        Number
#> 1164                                                                                       Per 100,000 inhabitants
#> 1165                                                                                                    Percentage
#> 1166                                                                                                    Percentage
#> 1167                                                                                                    Percentage
#> 1168                                                                                                    Percentage
#> 1169                                                                                                    Percentage
#> 1170                                                                                                    Percentage
#> 1171                                                                                                    Percentage
#> 1172                                                                                                    Percentage
#> 1173                                                                                                    Percentage
#> 1174                                                                                                    Percentage
#> 1175                                                                                                    Percentage
#> 1176                                                                                                    Percentage
#> 1177                                                                                                    Percentage
#> 1178                                                                                                    Percentage
#> 1179                                                                                                    Percentage
#> 1180                                                                                                    Percentage
#> 1181                                                                                                    Percentage
#> 1182                                                                                                    Percentage
#> 1183                                                                                                    Percentage
#> 1184                                                                                              Percentage point
#> 1185                                                                                              Percentage point
#> 1186                                                                                              Percentage point
#> 1187                                                                                              Percentage point
#> 1188                                         Percentage of population outside the labour force and wanting to work
#> 1189                                                                                Percentage of total population
#> 1190                                         Percentage of population outside the labour force and wanting to work
#> 1191                                                                                Percentage of total population
#> 1192                                         Percentage of population outside the labour force and wanting to work
#> 1193                                                                                Percentage of total population
#> 1194                                                                                                    Percentage
#> 1195                                                                                                    Percentage
#> 1196                                                                                                    Percentage
#> 1197                                                                                                    Percentage
#> 1198                                                                                                    Percentage
#> 1199                                                                                                    Percentage
#> 1200                                                                                                    Percentage
#> 1201                                                                                                    Percentage
#> 1202                                                                                Percentage of total population
#> 1203                                                                                Percentage of total population
#> 1204                                                                                Percentage of total population
#> 1205                                                                                                    Percentage
#> 1206                                                                                                    Percentage
#> 1207                                                                                                    Percentage
#> 1208                                                                                Percentage of total population
#> 1209                                                                                Percentage of total population
#> 1210                                                                                Percentage of total population
#> 1211                                                                  Percentage of population in the labour force
#> 1212                                                                  Percentage of population in the labour force
#> 1213                                                                  Percentage of population in the labour force
#> 1214                                                                    Percentage of gross domestic product (GDP)
#> 1215                                                                    Percentage of gross domestic product (GDP)
#> 1216                                                                    Percentage of gross domestic product (GDP)
#> 1217                                                                    Percentage of gross domestic product (GDP)
#> 1218                                                                    Percentage of gross domestic product (GDP)
#> 1219                        Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 1220                        Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 1221                        Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 1222                        Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 1223                        Percentage of population in the labour force - numerator in full-time equivalent (FTE)
#> 1224                                                                   Grams per euro, chain linked volumes (2020)
#> 1225                                                                   Grams per euro, chain linked volumes (2020)
#> 1226                                                                                                         Ratio
#> 1227                                                                                                              
#> 1228                                                                                                    Percentage
#> 1229                                                                                                    Percentage
#> 1230                                                                                                    Percentage
#> 1231                                                                                                    Percentage
#> 1232                                                                                                    Percentage
#> 1233                                                                                                    Percentage
#> 1234                                                                      Euro per inhabitant (at constant prices)
#> 1235                                                                               Million euro at constant prices
#> 1236                                                                      Euro per inhabitant (at constant prices)
#> 1237                                                                               Million euro at constant prices
#> 1238                                                                                              Square kilometre
#> 1239                                                                                                    Percentage
#> 1240                                                                                              Square kilometre
#> 1241                                                                                                    Percentage
#> 1242                                                                                                  Million euro
#> 1243                                                                    Percentage of gross domestic product (GDP)
#> 1244     Percentage of total revenues from taxes and social contributions (excluding imputed social contributions)
#> 1245                                                                                                    Percentage
#> 1246                                                                                                    Percentage
#> 1247                                                                                                    Percentage
#> 1248                                                                                                    Percentage
#> 1249                                                                                                    Percentage
#> 1250                                                                               Purchasing power standard (PPS)
#> 1251                                                                                                    Percentage
#> 1252                                                                                                    Percentage
#> 1253                                                                                                    Percentage
#> 1254                                                                                                    Percentage
#> 1255                                                                                                    Percentage
#> 1256                                                                                                    Percentage
#> 1257                                                                                                         Ratio
#> 1258                                                                                                    Percentage
#> 1259                                                                                                    Percentage
#> 1260                                                                                                    Percentage
#> 1261                                                                                                    Percentage
#> 1262                                                                                                    Percentage
#> 1263                                                                                                    Percentage
#> 1264                                                                                                    Percentage
#> 1265                                                                                                    Percentage
#> 1266                                                                                                    Percentage
#> 1267                                                                                                    Percentage
#> 1268                                                                                                    Percentage
#> 1269                                                                                                    Percentage
#> 1270                                                                                                    Percentage
#> 1271                                                                                                    Percentage
#> 1272                                                                                                    Percentage
#> 1273                                                                                Percentage of total population
#> 1274                                                                                                    Percentage
#> 1275                                                                                                         Ratio
#> 1276                                                                                                         Ratio
#> 1277                                                                                                    Percentage
#> 1278                                                                                                    Percentage
#> 1279                                                                                                    Percentage
#> 1280                                                                                                          Year
#> 1281                                                                                                          Year
#> 1282                                                                                                    Percentage
#> 1283                                                                                                    Percentage
#> 1284                                                                                                    Percentage
#> 1285                                                                                                    Percentage
#> 1286                                                       Percentage change on previous period (based on persons)
#> 1287                                                                                             Percentage points
#> 1288                                                                                                    Percentage
#> 1289                                                                                Percentage of total employment
#> 1290                                                                                       Percentage of employees
#> 1291                                                                  Percentage of population in the labour force
#> 1292                                                                  Percentage of population in the labour force
#> 1293                                                                  Percentage of population in the labour force
#> 1294                                                                  Percentage of population in the labour force
#> 1295                                                                  Percentage of population in the labour force
#> 1296                                                                  Percentage of population in the labour force
#> 1297                                                                                       Percentage of employees
#> 1298                                                                                       Percentage of employees
#> 1299                                                                                                    Percentage
#> 1300                                                                                                    Percentage
#> 1301                                                                                                    Percentage
#> 1302                                                                                                    Percentage
#> 1303                                                                                                    Percentage
#> 1304                                                                                                    Percentage
#> 1305                                                                                                    Percentage
#> 1306                                                                                                    Percentage
#> 1307                                                                                                    Percentage
#> 1308                                                                                                    Percentage
#> 1309                                                                                                    Percentage
#> 1310                                                                                                    Percentage
#> 1311                                                                                                    Percentage
#> 1312                                                                                                    Percentage
#> 1313                                                                                                    Percentage
#> 1314                                                                                                    Percentage
#> 1315                                                                                                    Percentage
#> 1316                                                                                                    Percentage
#> 1317                                                                                                    Percentage
#> 1318                                                                                                    Percentage
#> 1319                                                                                                    Percentage
#> 1320                                                                                                    Percentage
#> 1321                                                                                                    Percentage
#> 1322                                                                                                    Percentage
#> 1323                                                                                                    Percentage
#> 1324                                                                                                    Percentage
#> 1325                                                                               Purchasing power standard (PPS)
#> 1326                                                                               Purchasing power standard (PPS)
#> 1327                                                                               Purchasing power standard (PPS)
#> 1328                                                                                                    Percentage
#> 1329                                                                                                    Percentage
#> 1330                                                                                                    Percentage
#> 1331                                                                                                    Percentage
#> 1332                                                                                                    Percentage
#> 1333                                                                                                    Percentage
#> 1334                                                                                                    Percentage
#> 1335                                                                                                    Percentage
#> 1336                                                                                                    Percentage
#> 1337                                                                                                    Percentage
#> 1338                                                                                                    Percentage
#> 1339                                                                                                    Percentage
#> 1340                                                                                                    Percentage
#> 1341                                                                                                    Percentage
#> 1342                                                                                                    Percentage
#> 1343                                                                                                    Percentage
#> 1344                                                                                                    Percentage
#> 1345                                                                                                    Percentage
#> 1346                                                                                                    Percentage
#> 1347                                                                                                    Percentage
#> 1348                                                                                                    Percentage
#> 1349                                                                                                    Percentage
#> 1350                                                                                                    Percentage
#> 1351                                                                                                         Ratio
#> 1352                                                                                                         Ratio
#> 1353                                                                                                         Ratio
#> 1354                                                                                                    Percentage
#> 1355                                                                                                    Percentage
#> 1356                                                                                                    Percentage
#> 1357                                                                                                    Percentage
#> 1358                                                                                                    Percentage
#> 1359                                                                                                    Percentage
#> 1360                                                                                                    Percentage
#> 1361                                                                                Percentage of total population
#> 1362                                                                                Percentage of total population
#> 1363                                                                                Percentage of total population
#> 1364                                                                                Percentage of total population
#> 1365                                                                                Percentage of total population
#> 1366                                                                                                    Percentage
#> 1367                                                                                                    Percentage
#> 1368                                                                                                    Percentage
#> 1369                                                                                Percentage of total population
#> 1370                                                                                Percentage of total population
#> 1371                                                                                Percentage of total population
#> 1372                                                                                Percentage of total population
#> 1373                                                                                Percentage of total population
#> 1374                                                                                Percentage of total population
#> 1375                                                                                Percentage of total population
#> 1376                                                                                Percentage of total population
#> 1377                                                                                                    Percentage
#> 1378                                                                                                    Percentage
#> 1379                                                                                                    Percentage
#> 1380                                                                                                    Percentage
#> 1381                                                                                                    Percentage
#> 1382                                                                                                    Percentage
#> 1383                                                                                                    Percentage
#> 1384                                                                                                    Percentage
#> 1385                                                                                                    Percentage
#> 1386                                                                                                    Percentage
#> 1387                                                                                                    Percentage
#> 1388                                                                                                    Percentage
#> 1389                                                                                                    Percentage
#> 1390                                                                                                    Percentage
#> 1391                                                                                                    Percentage
#> 1392                                                                                                    Percentage
#> 1393                                                                                                    Percentage
#> 1394                                                                                                    Percentage
#> 1395                                                                                                    Percentage
#> 1396                                                                                                    Percentage
#> 1397                                                                                                    Percentage
#> 1398                                                                                                    Percentage
#> 1399                                                                                                    Percentage
#> 1400                                                                                                    Percentage
#> 1401                                                                                                    Percentage
#> 1402                                                                                                    Percentage
#> 1403                                                                                                    Percentage
#> 1404                                                                                                    Percentage
#> 1405                                                                                                    Percentage
#> 1406                                                                                                    Percentage
#> 1407                                                                                                    Percentage
#> 1408                                                                                                    Percentage
#> 1409                                                                                                    Percentage
#> 1410                                                                                                    Percentage
#> 1411                                                                                                    Percentage
#> 1412                                                                                                    Percentage
#> 1413                                                                                                    Percentage
#> 1414                                                                                                    Percentage
#> 1415                                                                                                    Percentage
#> 1416                                                                                                    Percentage
#> 1417                                                                                                    Percentage
#> 1418                                                                                                    Percentage
#> 1419                                                                                                    Percentage
#> 1420                                                                                                    Percentage
#> 1421                                                                                                    Percentage
#> 1422                                                                                                    Percentage
#> 1423                                                                                                    Percentage
#> 1424                                                                                                    Percentage
#> 1425                                                                                                    Percentage
#> 1426                                                                                                    Percentage
#> 1427                                                                                                    Percentage
#> 1428                                                                                                    Percentage
#> 1429                                                                                                       Average
#> 1430                                                                                                    Percentage
#> 1431                                                                                                    Percentage
#> 1432                                                                                                    Percentage
#> 1433                                                                                                    Percentage
#> 1434                                                                                                    Percentage
#> 1435                                                                                                    Percentage
#> 1436                                                                                                    Percentage
#> 1437                                                                                                    Percentage
#> 1438                                                                                                    Percentage
#> 1439                                                                                                    Percentage
#> 1440                                                                                                    Percentage
#> 1441                                                                                                    Percentage
#> 1442                                                                                                    Percentage
#> 1443                                                                                                    Percentage
#> 1444                                                                                                    Percentage
#> 1445                                                                                                    Percentage
#> 1446                                                                                                    Percentage
#> 1447                                                                                                    Percentage
#> 1448                                                                                                    Percentage
#> 1449                                                                                                    Percentage
#> 1450                                                                                                    Percentage
#> 1451                                                                                                    Percentage
#> 1452                                                                                                    Percentage
#> 1453                                                                                                    Percentage
#> 1454                                                                                                    Percentage
#> 1455                                                                                                    Percentage
#> 1456                                                                                                    Percentage
#> 1457                                                                                                    Percentage
#> 1458                                                                                                    Percentage
#> 1459                                                                                                    Percentage
#> 1460                                                                                                    Percentage
#> 1461                                                                                                    Percentage
#> 1462                                                                                                    Percentage
#> 1463                                                                                                    Percentage
#> 1464                                                                                                    Percentage
#> 1465                                                                                                    Percentage
#> 1466                                                                                                    Percentage
#> 1467                                                                                                    Percentage
#> 1468                                                                                                    Percentage
#> 1469                                                                                                    Percentage
#> 1470                                                                                                    Percentage
#> 1471                                                                                                    Percentage
#> 1472                                                                                                    Percentage
#> 1473                                                                                                    Percentage
#> 1474                                                                                                    Percentage
#> 1475                                                                                                    Percentage
#> 1476                                                                                                    Percentage
#> 1477                                                                                                    Percentage
#> 1478                                                                                                    Percentage
#> 1479                                                                                                    Percentage
#> 1480                                                                                                    Percentage
#> 1481                                                                                                    Percentage
#> 1482                                                                                  0 = equal, 100 = one has all
#> 1483                                                                                                    Percentage
#> 1484                                                                                                    Percentage
#> 1485                                                                                                    Percentage
#> 1486                                                                                                    Percentage
#> 1487                                                                                                    Percentage
#> 1488                                                                                                    Percentage
#> 1489                                                                                                    Percentage
#> 1490                                                                                                    Percentage
#> 1491                                                                                                    Percentage
#> 1492                                                                                                    Percentage
#> 1493                                                                                                    Percentage
#> 1494                                                                                                    Percentage
#> 1495                                                                                                    Percentage
#> 1496                                                                                                    Percentage
#> 1497                                                                                                    Percentage
#> 1498                                                                                                    Percentage
#> 1499                                                                                                    Percentage
#> 1500                                                                                                    Percentage
#> 1501                                                                                                    Percentage
#> 1502                                                                                Percentage of total population
#> 1503                                                                                Percentage of total population
#> 1504                                                                                Percentage of total population
#> 1505                                                                                Percentage of total population
#> 1506                                                                                Percentage of total population
#> 1507                                                                                Percentage of total population
#> 1508                                                                                                    Percentage
#> 1509                                                                                                    Percentage
#> 1510                                                                                                    Percentage
#> 1511                                                                                                    Percentage
#> 1512                                                                                                    Percentage
#> 1513                                                                                                    Percentage
#> 1514                                                                                                    Percentage
#> 1515                                                                                                    Percentage
#> 1516                                                                                                    Percentage
#> 1517                                                                                                    Percentage
#> 1518                                                                                                    Percentage
#> 1519                                                                                                    Percentage
#> 1520                                                                                                    Percentage
#> 1521                                                                                                    Percentage
#> 1522                                                                                                    Percentage
#> 1523                                                                                                    Percentage
#> 1524                                                                                                    Percentage
#> 1525                                                                                                    Percentage
#> 1526                                                                                                    Percentage
#> 1527                                                                                                    Percentage
#> 1528                                                                                                    Percentage
#> 1529                                                                                                    Percentage
#> 1530                                                                                                         Ratio
#> 1531                                                                                                         Ratio
#> 1532                                                                                                         Ratio
#> 1533                                                                                                         Ratio
#> 1534                                                                                                         Ratio
#> 1535                                                                                                         Ratio
#> 1536                                                                                                         Ratio
#> 1537                                                                                                         Ratio
#> 1538                                                                                                         Ratio
#> 1539                                                                                                    Percentage
#> 1540                                                                                                    Percentage
#> 1541                                                                                                    Percentage
#> 1542                                                                                                    Percentage
#> 1543                                                                                                    Percentage
#> 1544                                                                                                    Percentage
#> 1545                                                                                                    Percentage
#> 1546                                                                                                    Percentage
#> 1547                                                                                                    Percentage
#> 1548                                                                                                    Percentage
#> 1549                                                                                                    Percentage
#> 1550                                                                                                    Percentage
#> 1551                                                                                             Percentage points
#> 1552                                                                                             Percentage points
#> 1553                                                                                                              
#> 1554                                                                                                        Number
#> 1555                                                                                                              
#> 1556                                                                                                              
#> 1557                                                    Percentual share of total current health expenditure (CHE)
#> 1558                                                                                                          Year
#> 1559                                                                                                          Year
#> 1560                                                                                                          Year
#> 1561                                                                                Percentage of total employment
#> 1562                                                                                                    Percentage
#> 1563                                                                                                    Percentage
#> 1564                                                                                                    Percentage
#> 1565                                                                                                    Percentage
#> 1566                                                                                                    Percentage
#> 1567                                                                                                    Percentage
#> 1568                                                                                                    Percentage
#> 1569                                                                                                    Percentage
#> 1570                                                                                                    Percentage
#> 1571                                                                                                    Percentage
#> 1572                                                                                                    Percentage
#> 1573                                                                                                    Percentage
#> 1574                                                                                                    Percentage
#> 1575                                                                                                    Percentage
#> 1576                                                                                                    Percentage
#> 1577                                                                                                    Percentage
#> 1578                                                                                                    Percentage
#> 1579                                                                                                    Percentage
#> 1580                                                                                                    Percentage
#> 1581                                                                                                    Percentage
#> 1582                                                                                                    Percentage
#> 1583                                                                                                    Percentage
#> 1584                                                                                                    Percentage
#> 1585                                                                                                    Percentage
#> 1586                                                                    Percentage of gross domestic product (GDP)
#> 1587                                                                    Percentage of gross domestic product (GDP)
#> 1588                                                                    Percentage of gross domestic product (GDP)
#> 1589                                                                                                    Percentage
#> 1590                                                                                                    Percentage
#> 1591                                                                                                    Percentage
#> 1592                                                                                                    Percentage
#> 1593                                                                                                    Percentage
#> 1594                                                                                                    Percentage
```
