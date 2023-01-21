# install custom packages not on cran

cd "$instpath_R"
instpkg_cust interactiveSSH 4b8af95035326a42542cefb186ab0237c827a31f5286bbbe40c0ad933f0d4e3d
instpkg_cust rsyncFacility 5cb3d8e1e9d367eb9d50aea963f9958841eed0987707892314b8549cd899e5fc
instpkg_cust remoteFunctionSSH 8a8e49572ad0e99e8c56149c63329a951766b7a0c232452f3006b4c39870a42e
instpkg_cust clusterSSH 78d7ff6205cb96b25335dfb0a96dfc3bcbefed22b10c48809285e7f7ce750f79

instpkg_cust exforParser 09104fd60025c4d655d7fad1306a2afc2f049c6293136ed4e4a48652f80eba63
instpkg_cust MongoEXFOR cf4c020ea89d3cc2fa10c1298c98c8c4260bdd0708e88501a0d7bcf94b907ed7
instpkg_cust jsonExforUtils e856b7734bd99b81ba02cd002236590b31094ef0d91eb811200c0dc22b2885d7
#instpkg_cust talysExforMapping 5ac8f35314ff5c411cf4409ac48339b35784ac8de250be1de246ed90c0362cef
instpkg_cust_alt2 talysExforMapping version-20Jan2023
#instpkg_cust TALYSeval 963bc700027d16f33c06bb9194bf95b1e1512b6eeddfc05190d1a3ce32ae4f88
instpkg_cust_alt2 TALYSeval version-20Jan2023
instpkg_cust exforUncertainty c917f70ac4520a0aef2cca8479e8e28644c8ab3c1062d439a7af9fad2d25a38a
#instpkg_cust_alt nucdataBaynet reduced_gp
#instpkg_cust_alt nucdataBaynet dev
instpkg_cust_alt2 nucdataBaynet version-09Jan2023

instpkg_cust_alt clusterTALYS master

if [ "$keep_Rcodes" != "yes" ]; then
    rm -rf "$instpath_R"
fi
