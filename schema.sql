-- database schema for the polymarket project
-- looking into trades and returns that we can get

-- check that the db is there
CREATE DATABASE IF NOT EXISTS polymarket;
USE polymarket;

-- table for storing the individual wallet addresses and information about them
CREATE TABLE IF NOT EXISTS wallets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    wallet_address VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(255),
    pseudonym VARCHAR(255),
    bio TEXT,
    profile_image VARCHAR(500),
    profile_image_optimized VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_scraped TIMESTAMP DEFAULT NULL,
	most_recent_trade_datetime DATETIME DEFAULT NULL,
	most_recent_10_transactions_hash VARCHAR(64) DEFAULT NULL,
	failed_to_scrape TINYINT(1) DEFAULT 0,
    need_to_update_trades TINYINT(1) DEFAULT 0,
    INDEX idx_wallet_address (wallet_address),
    INDEX idx_wallets_need_to_update_trades (need_to_update_trades)
    INDEX idx_name (name),
    INDEX idx_pseudonym (pseudonym),
    INDEX idx_last_scraped (last_scraped),
    INDEX idx_most_recent_trade_datetime (most_recent_trade_datetime),
    INDEX idx_most_recent_10_transactions_hash (most_recent_10_transactions_hash)
);

-- table for storing all of the outcomes of markets that are possible
CREATE TABLE IF NOT EXISTS outcomes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    outcome_value VARCHAR(2048) NOT NULL,
    outcome_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    outcome_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_outcome_value (outcome_value(255)),
    INDEX idx_outcome_value (outcome_value(255))
);

-- information about all of the markets that are in the database
CREATE TABLE IF NOT EXISTS markets (
    id VARCHAR(100) PRIMARY KEY,
    question TEXT NOT NULL,
    slug VARCHAR(255),
    category VARCHAR(255),
    description TEXT,
    active TINYINT(1) DEFAULT 0,
    closed TINYINT(1) DEFAULT 0,
    featured TINYINT(1) DEFAULT 0,
    approved TINYINT(1) DEFAULT 0,
    archived TINYINT(1) DEFAULT 0,
    restricted TINYINT(1) DEFAULT 0,
    ready TINYINT(1) DEFAULT 0,
    funded TINYINT(1) DEFAULT 0,
    deploying TINYINT(1) DEFAULT 0,
    pendingDeployment TINYINT(1) DEFAULT 0,
    marketType VARCHAR(100),
    formatType VARCHAR(100),
    conditionId VARCHAR(255) UNIQUE,
    creator VARCHAR(255),
    updatedBy VARCHAR(255),
    marketMakerAddress VARCHAR(255),
    volume DECIMAL(20, 8),
    volumeNum DECIMAL(20, 8),
    volume24hr DECIMAL(20, 8),
    volume1wk DECIMAL(20, 8),
    volume1mo DECIMAL(20, 8),
    volume1yr DECIMAL(20, 8),
    volumeAmm DECIMAL(20, 8),
    volumeClob DECIMAL(20, 8),
    volume1moAmm DECIMAL(20, 8),
    volume1moClob DECIMAL(20, 8),
    volume1wkAmm DECIMAL(20, 8),
    volume1wkClob DECIMAL(20, 8),
    volume1yrAmm DECIMAL(20, 8),
    volume1yrClob DECIMAL(20, 8),
    liquidity DECIMAL(20, 8),
    liquidityNum DECIMAL(20, 8),
    liquidityAmm DECIMAL(20, 8),
    liquidityClob DECIMAL(20, 8),
    bestBid DECIMAL(20, 8),
    bestAsk DECIMAL(20, 8),
    lastTradePrice DECIMAL(20, 8),
    spread DECIMAL(20, 8),
    competitive DECIMAL(20, 8),
    oneHourPriceChange DECIMAL(20, 8),
    oneDayPriceChange DECIMAL(20, 8),
    oneWeekPriceChange DECIMAL(20, 8),
    oneMonthPriceChange DECIMAL(20, 8),
    oneYearPriceChange DECIMAL(20, 8),
    highest_timestamp BIGINT DEFAULT 0,
    last_10_transactions_hash VARCHAR(64) DEFAULT NULL,
    scraped TINYINT(1) DEFAULT 0,
    error_scraping_trades TINYINT(1) DEFAULT 0,
    clearBookOnStart TINYINT(1) DEFAULT 0,
    fpmmLive TINYINT(1) DEFAULT 0,
    cyom TINYINT(1) DEFAULT 0,
    manualActivation TINYINT(1) DEFAULT 0,
    negRiskOther TINYINT(1) DEFAULT 0,
    hasReviewedDates TINYINT(1) DEFAULT 0,
    holdingRewardsEnabled TINYINT(1) DEFAULT 0,
    feesEnabled TINYINT(1) DEFAULT 0,
    rfqEnabled TINYINT(1) DEFAULT 0,
    pagerDutyNotificationEnabled TINYINT(1) DEFAULT 0,
    notificationsEnabled TINYINT(1) DEFAULT 0,
    rewardsMinSize DECIMAL(20, 8),
    rewardsMaxSpread DECIMAL(20, 8),
    lowerBound DECIMAL(20, 8),
    upperBound DECIMAL(20, 8),
    mailchimpTag VARCHAR(255),
    twitterCardImage VARCHAR(500),
    icon VARCHAR(2000),
    image VARCHAR(2000),
    umaResolutionStatuses TEXT,
    resolutionSource TEXT,
    startDate DATETIME,
    endDate DATETIME,
    endDateIso DATE,
    createdAt DATETIME,
    updatedAt DATETIME,
    closedTime DATETIME,
    readyForCron DATETIME,
    submitted_by_wallet_id INT,
    resolvedBy_wallet_id INT,
    FOREIGN KEY (submitted_by_wallet_id) REFERENCES wallets(id) ON DELETE SET NULL,
    FOREIGN KEY (resolvedBy_wallet_id) REFERENCES wallets(id) ON DELETE SET NULL,
    INDEX idx_slug (slug),
    INDEX idx_category (category),
    INDEX idx_active (active),
    INDEX idx_closed (closed),
    INDEX idx_featured (featured),
    INDEX idx_condition_id (conditionId),
    INDEX idx_volume (volume),
    INDEX idx_liquidity (liquidity),
    INDEX idx_highest_timestamp (highest_timestamp),
    INDEX idx_scraped (scraped),
    INDEX idx_error_scraping_trades (error_scraping_trades),
    INDEX idx_start_date (startDate),
    INDEX idx_end_date (endDate),
    INDEX idx_created_at (createdAt),
    INDEX idx_updated_at (updatedAt)
);

-- table for storing the events that are in the database
CREATE TABLE IF NOT EXISTS events (
    id VARCHAR(100) PRIMARY KEY,
    title VARCHAR(255),
    subtitle VARCHAR(255),
    description TEXT,
    ticker VARCHAR(100),
    slug VARCHAR(255),
    active TINYINT(1) DEFAULT 0,
    closed TINYINT(1) DEFAULT 0,
    archived TINYINT(1) DEFAULT 0,
    featured TINYINT(1) DEFAULT 0,
    restricted TINYINT(1) DEFAULT 0,
    new TINYINT(1) DEFAULT 0,
    eventType VARCHAR(100),
    recurrence VARCHAR(100),
    layout VARCHAR(100),
    commentsEnabled TINYINT(1) DEFAULT 0,
    volume DECIMAL(20, 8),
    volume24hr DECIMAL(20, 8),
    liquidity DECIMAL(20, 8),
    competitive DECIMAL(20, 8),
    commentCount INT,
    icon VARCHAR(2000),
    image VARCHAR(2000),
    cgAssetName VARCHAR(255),
    pythTokenID VARCHAR(255),
    startDate DATETIME,
    createdAt DATETIME,
    updatedAt DATETIME,
    publishedAt DATETIME,
    createdBy VARCHAR(255),
    updatedBy VARCHAR(255),
    INDEX idx_ticker (ticker),
    INDEX idx_slug (slug),
    INDEX idx_title (title(255)),
    INDEX idx_active (active),
    INDEX idx_closed (closed),
    INDEX idx_volume (volume),
    INDEX idx_liquidity (liquidity),
    INDEX idx_start_date (startDate),
    INDEX idx_created_at (createdAt)
);

-- table for storing the series that are in the database
CREATE TABLE IF NOT EXISTS series (
    id VARCHAR(100) PRIMARY KEY,
    ticker VARCHAR(100),
    slug VARCHAR(255),
    title VARCHAR(255),
    subtitle VARCHAR(255),
    description TEXT,
    active TINYINT(1) DEFAULT 0,
    closed TINYINT(1) DEFAULT 0,
    archived TINYINT(1) DEFAULT 0,
    featured TINYINT(1) DEFAULT 0,
    restricted TINYINT(1) DEFAULT 0,
    new TINYINT(1) DEFAULT 0,
    seriesType VARCHAR(100),
    recurrence VARCHAR(100),
    layout VARCHAR(100),
    commentsEnabled TINYINT(1) DEFAULT 0,
    volume DECIMAL(20, 8),
    volume24hr DECIMAL(20, 8),
    liquidity DECIMAL(20, 8),
    competitive DECIMAL(20, 8),
    commentCount INT,
    icon VARCHAR(2000),
    image VARCHAR(2000),
    cgAssetName VARCHAR(255),
    pythTokenID VARCHAR(255),
    startDate DATETIME,
    createdAt DATETIME,
    updatedAt DATETIME,
    publishedAt DATETIME,
    createdBy VARCHAR(255),
    updatedBy VARCHAR(255),
    INDEX idx_ticker (ticker),
    INDEX idx_slug (slug),
    INDEX idx_title (title(255)),
    INDEX idx_active (active),
    INDEX idx_closed (closed),
    INDEX idx_volume (volume),
    INDEX idx_liquidity (liquidity),
    INDEX idx_start_date (startDate),
    INDEX idx_created_at (createdAt)
);

-- the mapping between the markets and the events that they belong to
CREATE TABLE IF NOT EXISTS market_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    market_id VARCHAR(100) NOT NULL,
    event_id VARCHAR(100) NOT NULL,
    market_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    market_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (market_id) REFERENCES markets(id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    UNIQUE KEY unique_market_event (market_id, event_id),
    INDEX idx_market_id (market_id),
    INDEX idx_event_id (event_id)
);

-- the mapping between the events and the series that they belong to
CREATE TABLE IF NOT EXISTS event_series (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id VARCHAR(100) NOT NULL,
    series_id VARCHAR(100) NOT NULL,
    event_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    event_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    FOREIGN KEY (series_id) REFERENCES series(id) ON DELETE CASCADE,
    UNIQUE KEY unique_event_series (event_id, series_id),
    INDEX idx_event_id (event_id),
    INDEX idx_series_id (series_id)
);

-- the mapping between the markets and the outcomes that they have
CREATE TABLE IF NOT EXISTS market_outcomes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    market_id VARCHAR(100) NOT NULL,
    outcome_id INT NOT NULL,
    clob_token_id VARCHAR(100) NOT NULL,
    outcome_price DECIMAL(65,30) DEFAULT NULL,
    outcome_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    outcome_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (market_id) REFERENCES markets(id) ON DELETE CASCADE,
    FOREIGN KEY (outcome_id) REFERENCES outcomes(id) ON DELETE CASCADE,
    UNIQUE KEY unique_market_outcome (market_id, outcome_id),
    INDEX idx_market_id (market_id),
    INDEX idx_outcome_id (outcome_id),
    INDEX idx_clob_token_id (clob_token_id)
);

-- table for storing the different types of trades that can be made
CREATE TABLE IF NOT EXISTS trade_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trade_type_value VARCHAR(50) NOT NULL UNIQUE
);

-- table for storing the trades that are made on the markets
CREATE TABLE IF NOT EXISTS market_sourced_trades (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    transaction_hash VARCHAR(66) NOT NULL,
    condition_id VARCHAR(255) NOT NULL,
    
    -- the individual trade details
    size DECIMAL(20,8) NOT NULL,
    price DECIMAL(10,8) NOT NULL,
    timestamp BIGINT NOT NULL,
    block_timestamp DATETIME NULL,
    side VARCHAR(10) NOT NULL,
    proxy_wallet VARCHAR(42) NOT NULL,
    asset VARCHAR(100) NOT NULL,
    outcome_id INT NOT NULL,
    outcome_index INT NOT NULL,
    trade_type_id INT DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (outcome_id) REFERENCES outcomes(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (trade_type_id) REFERENCES trade_types(id) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (proxy_wallet) REFERENCES wallets(wallet_address) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_transaction_hash (transaction_hash),
    INDEX idx_timestamp (timestamp),
    INDEX idx_condition_id (condition_id),
    INDEX idx_proxy_wallet (proxy_wallet),
    INDEX idx_asset (asset),
    INDEX idx_outcome_id (outcome_id),
    INDEX idx_trade_type_id (trade_type_id)
);

-- table for storing the detailed trade activity data
-- which are the trades that we get live
CREATE TABLE IF NOT EXISTS activity_trades (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    transaction_hash VARCHAR(66) NOT NULL,
    condition_id VARCHAR(255) NOT NULL,
    
    -- individual trade details
    size DECIMAL(20,8) NOT NULL,
    price DECIMAL(10,8) NOT NULL,
    timestamp BIGINT NOT NULL,
    block_timestamp DATETIME NULL,
    side VARCHAR(10) NOT NULL,
    proxy_wallet VARCHAR(42) NOT NULL,
    asset VARCHAR(100) NOT NULL,
    outcome_id INT NOT NULL,
    outcome_index INT NOT NULL,
    trade_type_id INT DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (outcome_id) REFERENCES outcomes(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (trade_type_id) REFERENCES trade_types(id) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (proxy_wallet) REFERENCES wallets(wallet_address) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_transaction_hash (transaction_hash),
    INDEX idx_timestamp (timestamp),
    INDEX idx_condition_id (condition_id),
    INDEX idx_proxy_wallet (proxy_wallet),
    INDEX idx_asset (asset),
    INDEX idx_outcome_id (outcome_id),
    INDEX idx_trade_type_id (trade_type_id)
);

-- table for storing the different tags that are used on the markets
CREATE TABLE IF NOT EXISTS tags (
    id VARCHAR(50) PRIMARY KEY,
    label VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    force_show TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_label (label),
    INDEX idx_slug (slug),
    INDEX idx_force_show (force_show)
);

-- the mapping between the markets and the tags that they have
CREATE TABLE IF NOT EXISTS market_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    market_id VARCHAR(100) NOT NULL,
    tag_id VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (market_id) REFERENCES markets(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
    UNIQUE KEY unique_market_tag (market_id, tag_id),
    INDEX idx_market_id (market_id),
    INDEX idx_tag_id (tag_id)
);

-- a view for easy analysis of the markets
CREATE OR REPLACE VIEW market_summary AS
SELECT 
    m.id,
    m.question,
    m.slug,
    m.category,
    m.active,
    m.closed,
    m.featured,
    m.volume,
    m.liquidity,
    m.startDate,
    m.endDate,
    m.createdAt,
    m.updatedAt,
    w1.wallet_address as submitted_by_address,
    w2.wallet_address as resolved_by_address,
    e.title as event_title,
    e.ticker as event_ticker,
    s.title as series_title,
    s.ticker as series_ticker,
    mo1.clob_token_id as outcome_1_token_id,
    o1.outcome_value as outcome_1_value,
    mo2.clob_token_id as outcome_2_token_id,
    o2.outcome_value as outcome_2_value
FROM markets m
LEFT JOIN wallets w1 ON m.submitted_by_wallet_id = w1.id
LEFT JOIN wallets w2 ON m.resolvedBy_wallet_id = w2.id
LEFT JOIN market_events me ON m.id = me.market_id
LEFT JOIN events e ON me.event_id = e.id
LEFT JOIN event_series es ON e.id = es.event_id
LEFT JOIN series s ON es.series_id = s.id
LEFT JOIN market_outcomes mo1 ON m.id = mo1.market_id AND mo1.id = (SELECT MIN(id) FROM market_outcomes WHERE market_id = m.id)
LEFT JOIN outcomes o1 ON mo1.outcome_id = o1.id
LEFT JOIN market_outcomes mo2 ON m.id = mo2.market_id AND mo2.id = (SELECT MAX(id) FROM market_outcomes WHERE market_id = m.id)
LEFT JOIN outcomes o2 ON mo2.outcome_id = o2.id;



