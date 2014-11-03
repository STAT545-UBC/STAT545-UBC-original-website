# Download the raw data
cat(file = "lotr_raw.tsv",
	RCurl::getURL("http://bit.ly/lotr_raw-tsv", followlocation = TRUE))
