library(dplyr)
# can replace this URL with the raw data from the git repo
rawDataUrl <- "http://pub.data.gov.bc.ca/datasets/176284/BC_Liquor_Store_Product_Price_List.csv"
bcl <- read.csv(rawDataUrl, stringsAsFactors = FALSE)
products <- c("BEER", "REFRESHMENT BEVERAGE", "SPIRITS", "WINE")
bcl <- dplyr::filter(bcl, PRODUCT_CLASS_NAME %in% products) %>%
  dplyr::select(-PRODUCT_TYPE_NAME, -PRODUCT_SKU_NO, -PRODUCT_BASE_UPC_NO,
                -PRODUCT_LITRES_PER_CONTAINER, -PRD_CONTAINER_PER_SELL_UNIT,
                -PRODUCT_SUB_CLASS_NAME) %>%
  rename(Type = PRODUCT_CLASS_NAME,
         Subtype = PRODUCT_MINOR_CLASS_NAME,
         Name = PRODUCT_LONG_NAME,
         Country = PRODUCT_COUNTRY_ORIGIN_NAME,
         Alcohol_Content = PRODUCT_ALCOHOL_PERCENT,
         Price = CURRENT_DISPLAY_PRICE,
         Sweetness = SWEETNESS_CODE)
bcl$Type <- sub("^REFRESHMENT BEVERAGE$", "REFRESHMENT", bcl$Type)
