DROP TABLE IF EXISTS wcf1_search_index;
CREATE TABLE wcf1_search_index (
	objectTypeID INT(10) NOT NULL,
	objectID INT(10) NOT NULL,
	subject VARCHAR(255) NOT NULL DEFAULT '',
	message MEDIUMTEXT,
	metaData MEDIUMTEXT,
	time INT(10) NOT NULL DEFAULT 0,
	userID INT(10) NOT NULL DEFAULT 0,
	username VARCHAR(255) NOT NULL DEFAULT '',
	UNIQUE KEY (objectTypeID, objectID),
	FULLTEXT INDEX (subject, message, metaData),
	FULLTEXT INDEX (subject),
	KEY (userID),
	KEY (username)
);

DROP TABLE IF EXISTS wcf1_search_keyword;
CREATE TABLE wcf1_search_keyword (
	keywordID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	keyword VARCHAR(255) NOT NULL,
	searches INT(10) NOT NULL DEFAULT 0,
	lastSearchTime INT(10) NOT NULL DEFAULT 0,
	KEY (keyword)
);