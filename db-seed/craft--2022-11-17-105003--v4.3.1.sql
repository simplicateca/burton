-- MariaDB dump 10.19  Distrib 10.6.9-MariaDB, for Linux (x86_64)
--
-- Host: mysql    Database: project
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `id` int NOT NULL,
  `ownerId` int DEFAULT NULL,
  `countryCode` varchar(255) NOT NULL,
  `administrativeArea` varchar(255) DEFAULT NULL,
  `locality` varchar(255) DEFAULT NULL,
  `dependentLocality` varchar(255) DEFAULT NULL,
  `postalCode` varchar(255) DEFAULT NULL,
  `sortingCode` varchar(255) DEFAULT NULL,
  `addressLine1` varchar(255) DEFAULT NULL,
  `addressLine2` varchar(255) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `organizationTaxId` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_zmhhcjozqzhkmiukkoakbywxipksrimsbsmj` (`ownerId`),
  CONSTRAINT `fk_zlicxelhrbradqioydzwfdvsplhyposcxgyq` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zmhhcjozqzhkmiukkoakbywxipksrimsbsmj` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `pluginId` int DEFAULT NULL,
  `heading` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `unread` tinyint(1) NOT NULL DEFAULT '1',
  `dateRead` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_zdltkutskimfveymtukmqddanjcijvcjawal` (`userId`,`unread`,`dateRead`,`dateCreated`),
  KEY `idx_ektbtrnmwjuqnqwgbeekxrqacqbznkhpwiwh` (`dateRead`),
  KEY `fk_eloityraqrfqirblzdcjuvcdletctzybmezn` (`pluginId`),
  CONSTRAINT `fk_eloityraqrfqirblzdcjuvcdletctzybmezn` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_fciwwjjlcxvjammpimszfcjjmpuimqpydtie` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sessionId` int NOT NULL,
  `volumeId` int NOT NULL,
  `uri` text,
  `size` bigint unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `isDir` tinyint(1) DEFAULT '0',
  `recordId` int DEFAULT NULL,
  `isSkipped` tinyint(1) DEFAULT '0',
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_qgdqznxjhitdwahbxexkshqfrzobegrwniay` (`sessionId`,`volumeId`),
  KEY `idx_eyycekafphnhzzabtjleprqawgrwoguzaaoa` (`volumeId`),
  CONSTRAINT `fk_fstjchhvmlzctuyejbtvnmtnycxbtoccnesg` FOREIGN KEY (`sessionId`) REFERENCES `assetindexingsessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_guvcnhkevvhakzqvmzchlrzcdcjrubxxlwkk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assetindexingsessions`
--

DROP TABLE IF EXISTS `assetindexingsessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexingsessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `indexedVolumes` text,
  `totalEntries` int DEFAULT NULL,
  `processedEntries` int NOT NULL DEFAULT '0',
  `cacheRemoteImages` tinyint(1) DEFAULT NULL,
  `isCli` tinyint(1) DEFAULT '0',
  `actionRequired` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int NOT NULL,
  `volumeId` int DEFAULT NULL,
  `folderId` int NOT NULL,
  `uploaderId` int DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `alt` text,
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_groskrrddyloswtgorcsmfslodlstlizapqb` (`filename`,`folderId`),
  KEY `idx_oxturroqckrpvhhxvgpfjwjyoztxuhcbbgac` (`folderId`),
  KEY `idx_rofchejvkqupucuofsekvcrrbnjhozwshcqi` (`volumeId`),
  KEY `fk_kockpddmebxblogbfaflexkkooylvngyzwnr` (`uploaderId`),
  CONSTRAINT `fk_doewhxgqpxgptneoeudtbfbzfbgspfcdjmho` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_fivnbglihqniephakqiutjpwoypxwtbjidrn` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_hpflsrhyhbwkducsbneofhhixnkczpxfbmqx` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_kockpddmebxblogbfaflexkkooylvngyzwnr` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tqhifefwimwhxkyynvaywleltjbaurxqtrvp` (`groupId`),
  KEY `fk_ebzytbdzgcsmqdcqzkuakujhufiimqepwizv` (`parentId`),
  CONSTRAINT `fk_afkvglnwvvuhmuwyzvtjjedpbbtxqbilyhln` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ebzytbdzgcsmqdcqzkuakujhufiimqepwizv` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_jvsxvrrdwuscwdatdappzrwfvfkqxpmoumol` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bkwjshsivhlfkgmvmmqsjhysdwcvoqkwggvz` (`name`),
  KEY `idx_xfuwbanlkscgwcqxyfahhrdeflskdlnuargj` (`handle`),
  KEY `idx_fcbjgmrxjcuazpzgetbvlzkzuvigmmbqdohj` (`structureId`),
  KEY `idx_fpzxrsjbtvvujwdntxltioudrjuevdjnsqfb` (`fieldLayoutId`),
  KEY `idx_lfwktahpxjzqardroekmsodxswjpeqvgzwib` (`dateDeleted`),
  CONSTRAINT `fk_lbqrelpgnxtmwnycejeuagivnudqfzbhwzfk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_uqypmkwvxwrffeqdokvwpabfmbxsoibpidqq` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_lbxrlwjvwnqniatdoztvesicvcznqgqddziz` (`groupId`,`siteId`),
  KEY `idx_jvugizqzfuzpmkrhhnjczrbimwqugxdusjce` (`siteId`),
  CONSTRAINT `fk_cyvzdybnbhckhkktyprirznlmdpjhnsiwepi` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_yrpwqqrpjlskjqrjwpxnqxhcbesheljwhwiq` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `idx_mvbgscddxzbkujwxwrbjpnavonwntolegdib` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_pqcdgsrmwybsydajbofdwecjugbtpwnhzbkd` (`siteId`),
  KEY `fk_wzpegrnmezhkxgfxbanwgjdssbutuxtjlnch` (`userId`),
  CONSTRAINT `fk_gekgxanaymhcuusiyfgxwwhenejjuszgijtb` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pqcdgsrmwybsydajbofdwecjugbtpwnhzbkd` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wzpegrnmezhkxgfxbanwgjdssbutuxtjlnch` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `idx_vnzqkmffexnzqhqzusdkfuvksooyzuyybwtt` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_ygixcaggougyxqvxiuifkqngjubhopqgbsms` (`siteId`),
  KEY `fk_keirizffsawldpftjniifaxivjzquufebish` (`fieldId`),
  KEY `fk_ubnlfomyzxhtyemvxlzbrbnturiylxuhgklh` (`userId`),
  CONSTRAINT `fk_keirizffsawldpftjniifaxivjzquufebish` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ubnlfomyzxhtyemvxlzbrbnturiylxuhgklh` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_urweoxradbdokyyawrvikvlxzdvvtjgfbwoh` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ygixcaggougyxqvxiuifkqngjubhopqgbsms` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_showBlockMeta_cvrpdgoz` tinyint(1) DEFAULT NULL,
  `field_fragmentType_rdkrtdam` varchar(255) DEFAULT NULL,
  `field_dek` text,
  `field_eMsgLayout_zfkvvptv` varchar(255) DEFAULT NULL,
  `field_color_kgjpyuvd` varchar(7) DEFAULT NULL,
  `field_code_jcmiyhiw` text,
  `field_text_qieovwoa` text,
  `field_summary_wtwwruam` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_cauweygjwdkcelsuxusaqyzarxojmoncsbtf` (`elementId`,`siteId`),
  KEY `idx_rzcnqktjrocfvvtfemqkohulzqqbdvikmiki` (`siteId`),
  KEY `idx_aljsgijdzzfdosjrkukmilbjkycyafepzfaq` (`title`),
  CONSTRAINT `fk_aabbijcjuhyoszwkypiglxjzzioemhvctkhs` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_adxsphlbkicfuypcfrozvvwanlvkejjgnabe` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_ejwkiziblhpnrkqhhawouwmydjqohvuibugm` (`userId`),
  CONSTRAINT `fk_ejwkiziblhpnrkqhhawouwmydjqohvuibugm` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vwyfrycbmytyrhetokbmevcrbhzzuugllolk` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dolphiq_redirects`
--

DROP TABLE IF EXISTS `dolphiq_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dolphiq_redirects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceUrl` varchar(255) DEFAULT NULL,
  `destinationUrl` varchar(255) DEFAULT NULL,
  `statusCode` varchar(255) DEFAULT NULL,
  `hitCount` int unsigned NOT NULL DEFAULT '0',
  `hitAt` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cbtrzciyadzcvaewjxkrawkiqdwyxbxapxks` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dolphiq_redirects_catch_all_urls`
--

DROP TABLE IF EXISTS `dolphiq_redirects_catch_all_urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dolphiq_redirects_catch_all_urls` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL DEFAULT '',
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `hitCount` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int DEFAULT NULL,
  `creatorId` int DEFAULT NULL,
  `provisional` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_sbtetfromdmhwtpkqcorcmfzwnfteqbphsst` (`creatorId`,`provisional`),
  KEY `idx_duaqcwtroqjhrkrpdqafdmpqlcfppfxkslbc` (`saved`),
  KEY `fk_udevycmqhnycgvkhgzgxrnuhxalchrlzfarf` (`canonicalId`),
  CONSTRAINT `fk_asjavuvqowtldkmztuylssjelctusnvxpwdv` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_udevycmqhnycgvkhgzgxrnuhxalchrlzfarf` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int DEFAULT NULL,
  `draftId` int DEFAULT NULL,
  `revisionId` int DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateLastMerged` datetime DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_rthxskqgjuoowgldthvhwzepmnealgcgsozj` (`dateDeleted`),
  KEY `idx_eopwoqxtbfsbhdxukchzwhgsidzyyogthvcv` (`fieldLayoutId`),
  KEY `idx_sdgzprxmwqpcuthynmzmaxkxpfrubrufxoci` (`type`),
  KEY `idx_uzqnbiquqlgwioernxuwwvcedyluishzuheb` (`enabled`),
  KEY `idx_iaaozzcrhxmodslldnkkvcdknnzvkelwpvjw` (`archived`,`dateCreated`),
  KEY `idx_yxesahnvoecnbbtjtnzjiiyipzrsplcvkuyj` (`archived`,`dateDeleted`,`draftId`,`revisionId`,`canonicalId`),
  KEY `idx_pjffzvbkqjiojmqlecspuajfifjotjnbcgic` (`archived`,`dateDeleted`,`draftId`,`revisionId`,`canonicalId`,`enabled`),
  KEY `fk_wocsrrsljsovkwxmbpoybszqakssutvfiezr` (`canonicalId`),
  KEY `fk_eynpftazhzhkxvqlnnuvxclzkxdeviwzhmvr` (`draftId`),
  KEY `fk_mqolcenqcquvcngqbvupvzgfakfibmtwcoes` (`revisionId`),
  CONSTRAINT `fk_eynpftazhzhkxvqlnnuvxclzkxdeviwzhmvr` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mqolcenqcquvcngqbvupvzgfakfibmtwcoes` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qandppaemmtwrgofjppgcptodxuvjzzuuubw` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_wocsrrsljsovkwxmbpoybszqakssutvfiezr` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_lzecstyvkxrkvzxbemdflgxiirpcjaxtkbat` (`elementId`,`siteId`),
  KEY `idx_zbwlggcoxlhuhjpsaixikzeskpikbuaiztgy` (`siteId`),
  KEY `idx_wyqjsxwaxooalopiisfeyeeuwnrkaqgkirst` (`slug`,`siteId`),
  KEY `idx_dvusbtquaazaywxxhhsqdosthopijsacmhxh` (`enabled`),
  KEY `idx_slktsngkvjjsauiogojobrfecnllkdtdwvcs` (`uri`,`siteId`),
  CONSTRAINT `fk_faciprapappteajjflaxdhawblyuvxtxzahe` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_hkbegahrtttaiucmpzzvsuhecpvxlrfyznbw` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int NOT NULL,
  `sectionId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `typeId` int NOT NULL,
  `authorId` int DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_idhvrizgzuovvxhtnhgjggdxzpibuzguluqd` (`postDate`),
  KEY `idx_rmhlsvcsbbtveejrdpfyjqupfqqujafyomxo` (`expiryDate`),
  KEY `idx_lxmvkeollgrzamwormnzsmbgerjfkrmnzryf` (`authorId`),
  KEY `idx_htbfkhugjfmrypjazjovqqlvfliksicgvhcs` (`sectionId`),
  KEY `idx_rxguitwidokdpnhlajpqvgbwmoeuuainkpsy` (`typeId`),
  KEY `fk_lzcsjznhbzwyvyhhutpnptocxjmnznmmgqlp` (`parentId`),
  CONSTRAINT `fk_epfiabzhezlfglqrflamnzmfewuqkphnzhaw` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_gcopgqijesrmvllwreggeeolzgxytrakcgzy` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_iwsaltxswllvhzyewqkliedqjiqlyunjaqkj` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_lzcsjznhbzwyvyhhutpnptocxjmnznmmgqlp` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_onamcbgnpqqojtkmsnejuwffmawvbkrnejbi` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_oagcjrzytsjavobapsvspdxnjsatqekgupse` (`name`,`sectionId`),
  KEY `idx_cjalyfewtcgjnlgkytopackqpdlrsnltbnqq` (`handle`,`sectionId`),
  KEY `idx_yfpbobdvkwjusywjgvrlihqzdebdysudhkvx` (`sectionId`),
  KEY `idx_xzzlsnfpepxddekstayrhbxybfvfemlkxzee` (`fieldLayoutId`),
  KEY `idx_udavzisvcrtwxovbuaozxetrxzewpfiwicjj` (`dateDeleted`),
  CONSTRAINT `fk_lykrudhjzfxckqxovjhtmhriymyhmkfodxau` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ooqqjsntsowggxakkigjajgwspointwbxpbm` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_cwstrzfobkezwsrdubsrtqhqbqfrikjyocwt` (`name`),
  KEY `idx_dkjxwqtvogjgqnmghspqnrctrzovadsvebjm` (`dateDeleted`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `tabId` int NOT NULL,
  `fieldId` int NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_abuwoksjykbbfguajsluvqdrfrzncbgfdtjl` (`layoutId`,`fieldId`),
  KEY `idx_amghivhiwbfqiiyybeemdesuuwseokgesena` (`sortOrder`),
  KEY `idx_vkapnnplzmnsrujxhgtgfcytnrwiclhhpopk` (`tabId`),
  KEY `idx_vadljgxbutecamebifaoksanbupyrjahnuvl` (`fieldId`),
  CONSTRAINT `fk_gffjfdzyocqzkcqkmcgzmzdrmchtrdfozvnd` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_licnoemixwodvrryjmjfteaenebjudsavxzs` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_uwznfebcmjtntatyfxbpqmjmqfgnkpsmvrmx` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=789 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_pioucjwkizqjynaplyyqipawdvzipkzxxfjj` (`dateDeleted`),
  KEY `idx_ykjodgxvdpyecaavjovlmmzmggjcseynvmjg` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `settings` text,
  `elements` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_glzhnciwthxiwlxsbqeyskshjaibmspxpmmg` (`sortOrder`),
  KEY `idx_qvrdenpbnmomgkbfvuusoiqjhgqgtjrfdwle` (`layoutId`),
  CONSTRAINT `fk_bubyprkruzcjjzhqdgellcsarlreulqlckdj` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `columnSuffix` char(8) DEFAULT NULL,
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_blrvjwzuaqegpmretsfzuenuxvnmgmjfvhqb` (`handle`,`context`),
  KEY `idx_pbhbjdqlawvklpscyhzqnpzjihgyhjmzexuv` (`groupId`),
  KEY `idx_rmjsbibfxadjmpurossziympxzcuxaiunedf` (`context`),
  CONSTRAINT `fk_wkrjnpkvtthdmufkzdtprcjplvixhyrbsdgg` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fmc_contactform`
--

DROP TABLE IF EXISTS `fmc_contactform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fmc_contactform` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_yourName_jpvcvecw` text,
  `field_emailAddress_ajyaynxy` varchar(255) DEFAULT NULL,
  `field_message_dwsxhbyj` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ebluhshbcrvncrnnwocwoiigpsqbcczulztu` (`elementId`,`siteId`),
  KEY `fk_pjxxqbyeqphffaeuouspjflniumygsbsxyus` (`siteId`),
  CONSTRAINT `fk_mxcasefnfgxslbnqizgkayuxujvjcwaythut` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pjxxqbyeqphffaeuouspjflniumygsbsxyus` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fmc_newslettersubscription`
--

DROP TABLE IF EXISTS `fmc_newslettersubscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fmc_newslettersubscription` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_email_atpppbqx` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_qtodgiawjkjwjheygxttbzypiltasdpcqrdj` (`elementId`,`siteId`),
  KEY `fk_eufyxdizxhlwavijlhtvfnbgqkallhhqhjxr` (`siteId`),
  CONSTRAINT `fk_eufyxdizxhlwavijlhtvfnbgqkallhhqhjxr` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pqbeaesiqjdkjyyhfumvdnguqjoqmzvjtgag` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_emailtemplates`
--

DROP TABLE IF EXISTS `formie_emailtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_emailtemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `template` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_forms`
--

DROP TABLE IF EXISTS `formie_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_forms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(64) NOT NULL,
  `fieldContentTable` varchar(74) NOT NULL,
  `settings` mediumtext,
  `templateId` int DEFAULT NULL,
  `submitActionEntryId` int DEFAULT NULL,
  `submitActionEntrySiteId` int DEFAULT NULL,
  `defaultStatusId` int DEFAULT NULL,
  `dataRetention` enum('forever','minutes','hours','days','weeks','months','years') NOT NULL DEFAULT 'forever',
  `dataRetentionValue` int DEFAULT NULL,
  `userDeletedAction` enum('retain','delete') NOT NULL DEFAULT 'retain',
  `fileUploadsAction` enum('retain','delete') NOT NULL DEFAULT 'retain',
  `fieldLayoutId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_zidzuipqsteshgeuhtcgjoelzxivtdpxllgx` (`templateId`),
  KEY `idx_ooubyphjguhtzwyqgitvflrsavchruzwswfk` (`defaultStatusId`),
  KEY `idx_ttltrzaeckyuqsykjdpnlkgbktvyyjqlppuw` (`submitActionEntryId`),
  KEY `idx_hdgehloukhqckbjszajjtjpritvfizxlcetv` (`submitActionEntrySiteId`),
  KEY `idx_hospygsustahjuapogkskubczdohexjmzywf` (`fieldLayoutId`),
  CONSTRAINT `fk_awbhibkzbdthtpfnxvrlgswjfbyxhfnhxloo` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bomvqxlevovlurrbftwiiyihoyczdydraudv` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_msqazphxytgsqoyvwrxmfkqpxnoohjpvbuka` FOREIGN KEY (`submitActionEntryId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_oltcdcouvstczvdbheaaplearorlprycajmj` FOREIGN KEY (`defaultStatusId`) REFERENCES `formie_statuses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_qsdwbxnufftssbcpnmtvedxavdurzzatrywz` FOREIGN KEY (`templateId`) REFERENCES `formie_formtemplates` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_formtemplates`
--

DROP TABLE IF EXISTS `formie_formtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_formtemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `template` varchar(255) DEFAULT NULL,
  `useCustomTemplates` tinyint(1) DEFAULT '1',
  `outputCssLayout` tinyint(1) DEFAULT '1',
  `outputCssTheme` tinyint(1) DEFAULT '1',
  `outputJsBase` tinyint(1) DEFAULT '1',
  `outputJsTheme` tinyint(1) DEFAULT '1',
  `outputCssLocation` varchar(255) DEFAULT NULL,
  `outputJsLocation` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gnnmzsvqwfqszuwmlksmntfeefuevxkobliv` (`fieldLayoutId`),
  CONSTRAINT `fk_lpkgkdgthygtwcldrkzayydcgrjohykdapea` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_integrations`
--

DROP TABLE IF EXISTS `formie_integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_integrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `enabled` varchar(255) NOT NULL DEFAULT 'true',
  `settings` text,
  `cache` longtext,
  `tokenId` int DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_nested`
--

DROP TABLE IF EXISTS `formie_nested`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_nested` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_kyowthioicgpmrmycdzdvvlgajfzmykgssej` (`fieldId`),
  KEY `idx_sirperbkqmfjzsqycmemwpfxtczsttzmuoxa` (`fieldLayoutId`),
  CONSTRAINT `fk_bpshephbrapwiydrippimkwvahvyiycfbyto` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_igkyjuqgpiphovjdfecwqhngjviidgdzohlz` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_nestedfieldrows`
--

DROP TABLE IF EXISTS `formie_nestedfieldrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_nestedfieldrows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ownerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_wuhjwrcxnqjrpdxerlfgophvurutpydshobn` (`ownerId`),
  KEY `idx_cilsbnjmoxidkxxpkirmjprmtqokpwrvciwl` (`fieldId`),
  KEY `idx_wyhkqkxbhhxultkuypdmomizhwkobrgeyttf` (`sortOrder`),
  CONSTRAINT `fk_cokqmwvimcoxndtisramysjmvubrtczvqopi` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_iwadigwyzakxyuyerfarfpazrpeahfeliiad` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_uqohobudcemtdfylebaupofxdkooaxkvdrhd` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_notifications`
--

DROP TABLE IF EXISTS `formie_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `formId` int NOT NULL,
  `templateId` int DEFAULT NULL,
  `pdfTemplateId` int DEFAULT NULL,
  `name` text NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `subject` text,
  `recipients` enum('email','conditions') NOT NULL DEFAULT 'email',
  `to` text,
  `toConditions` text,
  `cc` text,
  `bcc` text,
  `replyTo` text,
  `replyToName` text,
  `from` text,
  `fromName` text,
  `sender` text,
  `content` text,
  `attachFiles` tinyint(1) DEFAULT '1',
  `attachPdf` tinyint(1) DEFAULT '0',
  `attachAssets` text,
  `enableConditions` tinyint(1) DEFAULT '0',
  `conditions` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_nozzbggqynwyyllfspfwpdkvkqrbgmfpdxcs` (`formId`),
  KEY `idx_itpuyyefwhtnehqjgpaaddqkorxcnvpqaaox` (`templateId`),
  KEY `fk_wfgyfhmmldgtjrcamichyfzhexpklbfzhnrk` (`pdfTemplateId`),
  CONSTRAINT `fk_goghjbxwkrivvtqfoillnvasecsljuzvfyjm` FOREIGN KEY (`templateId`) REFERENCES `formie_emailtemplates` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_jqzwbeyflxsgmqvlplziedvsbibvtwrxvfyc` FOREIGN KEY (`formId`) REFERENCES `formie_forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wfgyfhmmldgtjrcamichyfzhexpklbfzhnrk` FOREIGN KEY (`pdfTemplateId`) REFERENCES `formie_pdftemplates` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_pagesettings`
--

DROP TABLE IF EXISTS `formie_pagesettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_pagesettings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int NOT NULL,
  `fieldLayoutTabId` int NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wtcpcrcrskqqbqzokbpggwvnxpixlwatyabb` (`fieldLayoutTabId`),
  KEY `idx_jbvnpryqpybjiekpnrzbjzijuelneoboltqa` (`fieldLayoutId`),
  CONSTRAINT `fk_crscumihdteqrhyghyvoutahvciucuxwhwvk` FOREIGN KEY (`fieldLayoutTabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_peqduyywuogfvryyhrloqbxwthhdmcsuayao` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_payments`
--

DROP TABLE IF EXISTS `formie_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `integrationId` int NOT NULL,
  `submissionId` int NOT NULL,
  `fieldId` int NOT NULL,
  `subscriptionId` int DEFAULT NULL,
  `amount` decimal(14,4) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `status` enum('pending','redirect','success','failed','processing') NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `message` text,
  `note` mediumtext,
  `response` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_pwgxmwqythtvzhsrjpxtaiygnsxmpllsqnih` (`integrationId`),
  KEY `idx_ztktwanatsdawbxmhpskwxwwezsvtrcvcwkq` (`fieldId`),
  KEY `idx_imutwcdddluvgemdmitvsfpfkfejynoqjndi` (`reference`),
  KEY `fk_vacnexkfyaoqfczyhgesjkfbsxknubvrrqlg` (`submissionId`),
  KEY `fk_yaevxdeegtgndxkifvuhoujllhzfbxkuftel` (`subscriptionId`),
  CONSTRAINT `fk_vacnexkfyaoqfczyhgesjkfbsxknubvrrqlg` FOREIGN KEY (`submissionId`) REFERENCES `formie_submissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_yaevxdeegtgndxkifvuhoujllhzfbxkuftel` FOREIGN KEY (`subscriptionId`) REFERENCES `formie_payments_subscriptions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ygkflbzllaslwtjizvohgcypkamgbfmrtvun` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zylarxcryeknsmjvviqevtcqvvajyjwtwqqj` FOREIGN KEY (`integrationId`) REFERENCES `formie_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_payments_plans`
--

DROP TABLE IF EXISTS `formie_payments_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_payments_plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `integrationId` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `planData` text,
  `isArchived` tinyint(1) NOT NULL,
  `dateArchived` datetime DEFAULT NULL,
  `sortOrder` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mcqpewjsgbdxznomhcxlmwvtejpgutuyeewg` (`handle`),
  KEY `idx_oztrggujuertcvlxkkiacxlzxdganqgzgtgb` (`integrationId`),
  KEY `idx_qgbrjobokxsvkdxmxzlznnkqlwihuioakdrz` (`reference`),
  CONSTRAINT `fk_razhrfarcrccqucpxpkwiworzvuufrpsdhrk` FOREIGN KEY (`integrationId`) REFERENCES `formie_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_payments_subscriptions`
--

DROP TABLE IF EXISTS `formie_payments_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_payments_subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `integrationId` int DEFAULT NULL,
  `submissionId` int DEFAULT NULL,
  `fieldId` int DEFAULT NULL,
  `planId` int DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `subscriptionData` text,
  `trialDays` int NOT NULL,
  `nextPaymentDate` datetime DEFAULT NULL,
  `hasStarted` tinyint(1) NOT NULL DEFAULT '1',
  `isSuspended` tinyint(1) NOT NULL DEFAULT '0',
  `dateSuspended` datetime DEFAULT NULL,
  `isCanceled` tinyint(1) NOT NULL,
  `dateCanceled` datetime DEFAULT NULL,
  `isExpired` tinyint(1) NOT NULL,
  `dateExpired` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_xxhbklismjqohtajabeixuznzqviqeoaptbb` (`integrationId`),
  KEY `idx_mhfhavagnzcuggapvopemxivpzgzwngjfmio` (`submissionId`),
  KEY `idx_azklyqnqbartqxftmmxungqdgxaxamscnubu` (`fieldId`),
  KEY `idx_ufxefhakymclrwioftwkohkfqewddbmgwtqh` (`planId`),
  KEY `idx_tqwusviyeesebsupumicnlllxyaymigwealj` (`reference`),
  KEY `idx_mnxjzfurlbgzdugynnfjjmufgwwqimhcacev` (`nextPaymentDate`),
  KEY `idx_iqmapqqtoxsqbxnfoadyyogkunarbzlzhddo` (`dateExpired`),
  KEY `idx_ndvwndhtztoesrtqoqvsurunojsivduxmdup` (`dateExpired`),
  CONSTRAINT `fk_eckuaxdjsyyblborskapndbprdlxzfqndpnc` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_hzzjuczdkmyiryqmommuobxtugvnhkfghdsz` FOREIGN KEY (`submissionId`) REFERENCES `formie_submissions` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_ncnckajrzkmwoexddrqpakzszfhszbujhmru` FOREIGN KEY (`integrationId`) REFERENCES `formie_integrations` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_xrpothtxsbwjlyuouneuhgoyitlndcwniays` FOREIGN KEY (`planId`) REFERENCES `formie_payments_plans` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_pdftemplates`
--

DROP TABLE IF EXISTS `formie_pdftemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_pdftemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `template` varchar(255) NOT NULL,
  `filenameFormat` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_relations`
--

DROP TABLE IF EXISTS `formie_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_iqocbipageutvfemryxnxgwmzsdznlctmntd` (`sourceId`,`sourceSiteId`,`targetId`),
  KEY `idx_xuqrmthqfnbgbdxdcvvfrqyzeqesmhdllcun` (`sourceId`),
  KEY `idx_ysfwrryiognpltplzetlbmfepvdtzvbostrr` (`targetId`),
  KEY `idx_gqmkyaephpfduyztuioxqdcpxovshjndebnq` (`sourceSiteId`),
  CONSTRAINT `fk_clngdltpajwzxyxlohjzfrsdvcmsvuvyhxfa` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_roxhwlfydmgefoxetbvgqaqzapmwfczdswxy` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_vomgwzvkficlrsemutthiavwmczibzgmeuhc` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_rows`
--

DROP TABLE IF EXISTS `formie_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_rows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int NOT NULL,
  `fieldLayoutFieldId` int NOT NULL,
  `row` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_rteqqnlevqcsblvyjblszjarvzqlalogmfcl` (`fieldLayoutFieldId`),
  KEY `idx_hcrvldpnooxxrdskmbrshmltqsurkziygheo` (`fieldLayoutId`),
  CONSTRAINT `fk_hbksrfvmgnyxlinnqdgchzchojapnniwnjkp` FOREIGN KEY (`fieldLayoutFieldId`) REFERENCES `fieldlayoutfields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_krqztmvfjbciepgnrvaybdqftsndphcyfdbu` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_sentnotifications`
--

DROP TABLE IF EXISTS `formie_sentnotifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_sentnotifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `formId` int DEFAULT NULL,
  `submissionId` int DEFAULT NULL,
  `notificationId` int DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `replyTo` varchar(255) DEFAULT NULL,
  `replyToName` varchar(255) DEFAULT NULL,
  `from` varchar(255) DEFAULT NULL,
  `fromName` varchar(255) DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `body` mediumtext,
  `htmlBody` mediumtext,
  `info` text,
  `success` tinyint(1) DEFAULT NULL,
  `message` text,
  `dateCreated` datetime DEFAULT NULL,
  `dateUpdated` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_zbyhuyfuimhnccblvbfdqmdlmcozlbborhdq` (`formId`),
  KEY `fk_tnknfgiatuighazsgswuetcsnvqmpfknszns` (`submissionId`),
  KEY `fk_qwzohvrhrmnaornhukwplsmapaqirqjdccai` (`notificationId`),
  CONSTRAINT `fk_qwzohvrhrmnaornhukwplsmapaqirqjdccai` FOREIGN KEY (`notificationId`) REFERENCES `formie_notifications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_shpmlyyutvdetygnsgnamxwwsquskqzxmzbj` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tnknfgiatuighazsgswuetcsnvqmpfknszns` FOREIGN KEY (`submissionId`) REFERENCES `formie_submissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zbyhuyfuimhnccblvbfdqmdlmcozlbborhdq` FOREIGN KEY (`formId`) REFERENCES `formie_forms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_statuses`
--

DROP TABLE IF EXISTS `formie_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `color` enum('green','orange','red','blue','yellow','pink','purple','turquoise','light','grey','black') NOT NULL DEFAULT 'green',
  `description` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `isDefault` tinyint(1) DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_stencils`
--

DROP TABLE IF EXISTS `formie_stencils`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_stencils` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `data` mediumtext,
  `templateId` int DEFAULT NULL,
  `submitActionEntryId` int DEFAULT NULL,
  `submitActionEntrySiteId` int DEFAULT NULL,
  `defaultStatusId` int DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_xmrkmbqmzkrdjluujgpddzsyvxfvvsktrbfg` (`templateId`),
  KEY `idx_hyztedwiwdyhgzcwlztbxztydlinptqlrrsi` (`defaultStatusId`),
  CONSTRAINT `fk_gzauoemnaepmkgsagvbjwlwaqkxgdwxlxzcv` FOREIGN KEY (`defaultStatusId`) REFERENCES `formie_statuses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_oahzphgmcjchwcxhitbiropcggorujavtqur` FOREIGN KEY (`templateId`) REFERENCES `formie_formtemplates` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_submissions`
--

DROP TABLE IF EXISTS `formie_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_submissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `formId` int NOT NULL,
  `statusId` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `isIncomplete` tinyint(1) DEFAULT '0',
  `isSpam` tinyint(1) DEFAULT '0',
  `spamReason` text,
  `spamClass` varchar(255) DEFAULT NULL,
  `snapshot` text,
  `ipAddress` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gezkjrzaalwcfdvkzorppyjdeiswavgpzhzt` (`formId`),
  KEY `idx_hjfnrmhxtdyrvdgvinsawhbmjtkyfwruijvq` (`statusId`),
  KEY `idx_cvdruaebcxqfmaewqxejapspzelimdfuhrzw` (`userId`),
  CONSTRAINT `fk_dytsmgejschkrllgtnwimhdtumkkmmjyglyq` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_tknyywqiereadnpefpdrygzzknmhgsshdfvf` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ukxzamqcnczujegrqhmclshzyjyrhccqpwdr` FOREIGN KEY (`formId`) REFERENCES `formie_forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vltlkvlziumkwehfnkgayhvfeutxjvhjgolc` FOREIGN KEY (`statusId`) REFERENCES `formie_statuses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_syncfields`
--

DROP TABLE IF EXISTS `formie_syncfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_syncfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `syncId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ioaraderojfgoqixufteklrxgndeopedcjxl` (`syncId`,`fieldId`),
  KEY `fk_wirfsacibuofnglgpnojjtducxkpvuoozxew` (`fieldId`),
  CONSTRAINT `fk_jkiqecpvbcmzketpmtbvvrtaxmoypxqmzslm` FOREIGN KEY (`syncId`) REFERENCES `formie_syncs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wirfsacibuofnglgpnojjtducxkpvuoozxew` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_syncs`
--

DROP TABLE IF EXISTS `formie_syncs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_syncs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_tokens`
--

DROP TABLE IF EXISTS `formie_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `accessToken` text,
  `secret` text,
  `endOfLife` varchar(255) DEFAULT NULL,
  `refreshToken` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tazzscuyeuxlxqvawxmitpemalbhprqivqwt` (`name`),
  KEY `idx_keobqxokbuupvcdakqsidmnlqbgxkiunnebv` (`handle`),
  KEY `idx_gqwfmfzhwdrnrnqkadefegpknqsvcnivazkh` (`fieldLayoutId`),
  KEY `idx_gpytvceynaeeieeeegpenclgvtslamjrzdpt` (`sortOrder`),
  CONSTRAINT `fk_vyteuzpcvrddjhggvbzcjxfkliqsprpzppuy` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_xskjatebgqntoxlagdikfptlomvimujpagyy` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_gbhjnxllyecvmvqnzxdbjwhomymajldinexo` (`accessToken`),
  UNIQUE KEY `idx_avulocwsfpikwqjqqjofdwddxxmrfhylozll` (`name`),
  KEY `fk_csiqzxxkmonngjmuvnxnajudgaywcstolxwc` (`schemaId`),
  CONSTRAINT `fk_csiqzxxkmonngjmuvnxnajudgaywcstolxwc` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imagetransformindex`
--

DROP TABLE IF EXISTS `imagetransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagetransformindex` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assetId` int NOT NULL,
  `transformer` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `transformString` varchar(255) NOT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_rgblebrpzwykrhmhmwnyhulrvxmrwqgnrktx` (`assetId`,`transformString`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imagetransforms`
--

DROP TABLE IF EXISTS `imagetransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagetransforms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `parameterChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lqyjuobsrfzgomawznvzkwpblxesuxgnoiba` (`name`),
  KEY `idx_sjdwvrrogynhrspeppwbmnsgvkkczbkyqdwk` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knockknock_logins`
--

DROP TABLE IF EXISTS `knockknock_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knockknock_logins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ipAddress` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `loginPath` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lenz_linkfield`
--

DROP TABLE IF EXISTS `lenz_linkfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lenz_linkfield` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `type` varchar(63) DEFAULT NULL,
  `linkedUrl` text,
  `linkedId` int DEFAULT NULL,
  `linkedSiteId` int DEFAULT NULL,
  `linkedTitle` varchar(255) DEFAULT NULL,
  `payload` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_atzsziecnfavkxbpyiejtyfivskobgyzdnsm` (`elementId`,`siteId`,`fieldId`),
  KEY `idx_uzvycpctfbkedlytirsruzeqsxsjphxvkgbn` (`fieldId`),
  KEY `idx_uuygjmmmyarggptpirtnvjyxebxunmxoqxao` (`siteId`),
  KEY `fk_pdtakpvoskdulfeywnujtpwhiimvlskobosi` (`linkedId`),
  KEY `fk_ijjhpemhswcukhogllblzbqgfezdhuzknyfz` (`linkedSiteId`),
  CONSTRAINT `fk_eufyriorpwacewqbnhycevwrupynhsgrfdil` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ijjhpemhswcukhogllblzbqgfezdhuzknyfz` FOREIGN KEY (`linkedSiteId`) REFERENCES `sites` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_pdtakpvoskdulfeywnujtpwhiimvlskobosi` FOREIGN KEY (`linkedId`) REFERENCES `elements` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_taubwfllpdnhisrnkvozhpvrnqroswwtabxx` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int NOT NULL,
  `primaryOwnerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_brwbipysqkmevgjxejzvjlnzrhhgroftoydd` (`primaryOwnerId`),
  KEY `idx_kpkyfytjnvsdaujfqgglrirtwnldmliapagf` (`fieldId`),
  KEY `idx_qoqldauvbisirhainotarfusgapgnexhyzoq` (`typeId`),
  CONSTRAINT `fk_bwxclwqdlbkjkrppcgwarvyufnmxkuzcxwdw` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_clnletenldjefulcrfdrnualwvrdnzrbdsuh` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cwjvxmedehokqjwngvbnmwetkbyzwiyhdpdo` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nxiljtpyicryraoibynfbexqqekufiawkgsf` FOREIGN KEY (`primaryOwnerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks_owners`
--

DROP TABLE IF EXISTS `matrixblocks_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks_owners` (
  `blockId` int NOT NULL,
  `ownerId` int NOT NULL,
  `sortOrder` smallint unsigned NOT NULL,
  PRIMARY KEY (`blockId`,`ownerId`),
  KEY `fk_kvejbjqtzsfyqerahuhdrzguntqmzocfpbjz` (`ownerId`),
  CONSTRAINT `fk_kvejbjqtzsfyqerahuhdrzguntqmzocfpbjz` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ulpzmxgktbjpmzojwryqxohmekfoqcmqgvap` FOREIGN KEY (`blockId`) REFERENCES `matrixblocks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_pkglaoftevnscqdxstmzcxkfnftttcrqslhb` (`name`,`fieldId`),
  KEY `idx_zkrvhfuvngiwajeibgoirsmxhitmngmphtzk` (`handle`,`fieldId`),
  KEY `idx_ythrctragspjueajdmkfoonjcvituaqtangw` (`fieldId`),
  KEY `idx_njityuqrmtyhccpiacsvbglurtndkekirnbk` (`fieldLayoutId`),
  CONSTRAINT `fk_ounewugodwxolwsifbmcjcpicjhokegfsbwp` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qffovehepxotkktnvmjvxlxgaeqnrwcerael` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_chunks`
--

DROP TABLE IF EXISTS `matrixcontent_chunks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_chunks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_code_identifier_ajvokjou` text,
  `field_code_caption_sqjwhpfm` text,
  `field_code_code_sbypotws` text,
  `field_form_identifier_nqcgwseh` text,
  `field_form_recipient_qicypfxo` varchar(255) DEFAULT NULL,
  `field_table_caption_ckfsdsda` text,
  `field_table_table_dhajqazy` text,
  `field_table_identifier_luuslhqe` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_fbautuvsewcotfwzgbjfikwsiirlwevpljss` (`elementId`,`siteId`),
  KEY `fk_kpzqgbznejmyukzvrndtcpyqamwidrmbomjb` (`siteId`),
  CONSTRAINT `fk_kpzqgbznejmyukzvrndtcpyqamwidrmbomjb` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_vhlxwrxbktcjicsqzjzjmtsyqihwwqnomftm` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_contentbuilder`
--

DROP TABLE IF EXISTS `matrixcontent_contentbuilder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_contentbuilder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_contentRepeater_bg_ngczrvyg` varchar(255) DEFAULT NULL,
  `field_contentRepeater_spacing_vdailebf` varchar(255) DEFAULT NULL,
  `field_contentRepeater_variant_ulxtrpcp` varchar(255) DEFAULT NULL,
  `field_contentRepeater_text` text,
  `field_media_externalMedia_uhslrpql` text,
  `field_media_variant_grrnasml` varchar(255) DEFAULT NULL,
  `field_media_spacing_lcpsbupz` varchar(255) DEFAULT NULL,
  `field_media_text_lriaudff` text,
  `field_media_bg_qbjriieh` varchar(255) DEFAULT NULL,
  `field_entries_order_ympxzups` varchar(255) DEFAULT NULL,
  `field_entries_limit_xctinfgl` int DEFAULT NULL,
  `field_entries_method_eqfrdkfb` varchar(255) DEFAULT NULL,
  `field_entries_card_odhcrdvx` varchar(255) DEFAULT NULL,
  `field_entries_text` text,
  `field_entries_bg_ccgrpbfv` varchar(255) DEFAULT NULL,
  `field_entries_perPage_pmubvmbx` int DEFAULT NULL,
  `field_entries_contentType_wzxkluqz` varchar(255) DEFAULT NULL,
  `field_entries_variant_mljzpfmg` varchar(255) DEFAULT NULL,
  `field_entries_spacing_sotrfnux` varchar(255) DEFAULT NULL,
  `field_textImage_text` text,
  `field_textImage_variant_payanbyx` varchar(255) DEFAULT NULL,
  `field_textImage_bg_cpekkbhk` varchar(255) DEFAULT NULL,
  `field_textImage_widget_mdoonwrh` varchar(255) DEFAULT NULL,
  `field_textImage_spacing_eqfigngd` varchar(255) DEFAULT NULL,
  `field_text_bg_dqtdfrpw` varchar(255) DEFAULT NULL,
  `field_text_text` text,
  `field_text_variant_qfgjxwao` varchar(255) DEFAULT NULL,
  `field_text_spacing_lhqmhzea` varchar(255) DEFAULT NULL,
  `field_fragment_spacing_gslywyag` varchar(255) DEFAULT NULL,
  `field_fragment_bg_nfwtlclo` varchar(255) DEFAULT NULL,
  `field_fragment_text_ahimykba` text,
  `field_fragment_chunk_lrlikkza` varchar(255) DEFAULT NULL,
  `field_textText_bg_mgtiyjak` varchar(255) DEFAULT NULL,
  `field_textText_text2` text,
  `field_textText_text` text,
  `field_textText_spacing_kvbxevci` varchar(255) DEFAULT NULL,
  `field_textText_variant_rkmoflxj` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_hyqxcjchxobcarmucgkpackbqygjkpwypiad` (`elementId`,`siteId`),
  KEY `fk_qhdejbagomiqkpevfkittuwwsdgajzilyxag` (`siteId`),
  CONSTRAINT `fk_qhdejbagomiqkpevfkittuwwsdgajzilyxag` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_vvquxbyawuuvqxzhxhufpjxfohdpkxmamrgb` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_headerbuilder`
--

DROP TABLE IF EXISTS `matrixcontent_headerbuilder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_headerbuilder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_text_text` text,
  `field_text_variant_ntqzccqg` varchar(255) DEFAULT NULL,
  `field_text_spacing_gloywvje` varchar(255) DEFAULT NULL,
  `field_text_headline` text,
  `field_text_bg_unpwravq` varchar(255) DEFAULT NULL,
  `field_media_spacing_kqtbfzex` varchar(255) DEFAULT NULL,
  `field_media_bg_cyumhlrq` varchar(255) DEFAULT NULL,
  `field_media_widget_kjrfytpr` varchar(255) DEFAULT NULL,
  `field_media_text_ijcdahuf` text,
  `field_media_headline_gmdbuezd` text,
  `field_media_variant_lkocjylo` varchar(255) DEFAULT NULL,
  `field_textImage_widget_gquevifw` varchar(255) DEFAULT NULL,
  `field_textImage_variant_udmwrcap` varchar(255) DEFAULT NULL,
  `field_textImage_spacing_xfkxramj` varchar(255) DEFAULT NULL,
  `field_textImage_headline` text,
  `field_textImage_text` text,
  `field_textImage_bg_rqyqbtbd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_hnlqjofjkxuywnujbhjomcnwjjqptjtjwyzy` (`elementId`,`siteId`),
  KEY `fk_otccfitstzxhvwhofptrwnvxncdotztysegl` (`siteId`),
  CONSTRAINT `fk_otccfitstzxhvwhofptrwnvxncdotztysegl` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xxgcvmrlfwsepaztxjtdngnqseenpmddgurr` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_sidebarbuilder`
--

DROP TABLE IF EXISTS `matrixcontent_sidebarbuilder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_sidebarbuilder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_textImage_text_tjslxfvc` text,
  `field_textImage_bg_qwymistc` varchar(255) DEFAULT NULL,
  `field_textImage_variant_xzyekbfe` varchar(255) DEFAULT NULL,
  `field_textImage_spacing_tbjdznwk` varchar(255) DEFAULT NULL,
  `field_textImage_widget_uhlqqmzz` varchar(255) DEFAULT NULL,
  `field_text_spacing_imzhlgvq` varchar(255) DEFAULT NULL,
  `field_text_widget_vpnhxvtr` varchar(255) DEFAULT NULL,
  `field_text_bg_yxvtjfiq` varchar(255) DEFAULT NULL,
  `field_text_variant_kvgukfcy` varchar(255) DEFAULT NULL,
  `field_text_text_jnelsrsi` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_xfakspkldmlkzczrbmomjhondjoqzuzkrsgw` (`elementId`,`siteId`),
  KEY `fk_rlprnwqzlvyqkdnrhhyfrzpwvsdcjflgtilb` (`siteId`),
  CONSTRAINT `fk_crltzalmyqzedkmzkkwjoleveksiucnrjnjp` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rlprnwqzlvyqkdnrhhyfrzpwvsdcjflgtilb` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixfieldpreview_blocktypes_config`
--

DROP TABLE IF EXISTS `matrixfieldpreview_blocktypes_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixfieldpreview_blocktypes_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `blockTypeId` int NOT NULL,
  `fieldId` int NOT NULL,
  `previewImageId` int DEFAULT NULL,
  `description` varchar(1024) NOT NULL DEFAULT '',
  `categoryId` int DEFAULT NULL,
  `sortOrder` smallint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_trupzslttjuokwwsetupgefpvoqeddvpgpnb` (`fieldId`),
  KEY `fk_yzntozjizibfnkudioaxzvcetaqthrlhwrpl` (`blockTypeId`),
  KEY `fk_fekqwztjnmaqlvixqaahtslcoppxvsdmtllq` (`previewImageId`),
  KEY `fk_blhaclcipmelmyiubodzohnblaoxpziniamt` (`categoryId`),
  CONSTRAINT `fk_blhaclcipmelmyiubodzohnblaoxpziniamt` FOREIGN KEY (`categoryId`) REFERENCES `matrixfieldpreview_category` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_fekqwztjnmaqlvixqaahtslcoppxvsdmtllq` FOREIGN KEY (`previewImageId`) REFERENCES `assets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_trupzslttjuokwwsetupgefpvoqeddvpgpnb` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_yzntozjizibfnkudioaxzvcetaqthrlhwrpl` FOREIGN KEY (`blockTypeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixfieldpreview_category`
--

DROP TABLE IF EXISTS `matrixfieldpreview_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixfieldpreview_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` varchar(1024) NOT NULL DEFAULT '',
  `sortOrder` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixfieldpreview_fields_config`
--

DROP TABLE IF EXISTS `matrixfieldpreview_fields_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixfieldpreview_fields_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `fieldId` int NOT NULL,
  `enablePreviews` tinyint(1) DEFAULT NULL,
  `enableTakeover` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vnmuhohndggelethbkeqapkuyxbhbqrrqcxc` (`fieldId`),
  CONSTRAINT `fk_vnmuhohndggelethbkeqapkuyxbhbqrrqcxc` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sdgqmdkxewcyiyuazuguoffdbguwvipqhqcz` (`track`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_navs`
--

DROP TABLE IF EXISTS `navigation_navs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_navs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `instructions` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `maxNodes` int DEFAULT NULL,
  `maxNodesSettings` text,
  `permissions` text,
  `fieldLayoutId` int DEFAULT NULL,
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ibnoaixafjioiawmiuwrpqwutbmfbesputtf` (`handle`),
  KEY `idx_mugcgrdcglorslyxdgjtxbvnezikckawemkt` (`structureId`),
  KEY `idx_gotkwyntasiknomzhwclhafemmtbhjvneezh` (`fieldLayoutId`),
  KEY `idx_jngqbhbnqchaxyvdcargrsfruqsujlxmentp` (`dateDeleted`),
  CONSTRAINT `fk_kqceopalpkhgabvivlmzpwcipokhmbgvkmep` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_sdwuifwmoroucxoddxigidpqgayjtnidxqeh` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_navs_sites`
--

DROP TABLE IF EXISTS `navigation_navs_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_navs_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `navId` int NOT NULL,
  `siteId` int NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_zqklhyczbcoeloujwknxghyhiinviakjolbs` (`navId`,`siteId`),
  KEY `idx_pubxibhdhrxlkmvqcazumigvtwvynahonjre` (`siteId`),
  CONSTRAINT `fk_mxpesfjkwknjxgonhrmunduhzrbzhxhfpjxz` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_qqoprujjhkluvzgrugygsewmqlucdsgkfeib` FOREIGN KEY (`navId`) REFERENCES `navigation_navs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_nodes`
--

DROP TABLE IF EXISTS `navigation_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_nodes` (
  `id` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `navId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `classes` varchar(255) DEFAULT NULL,
  `urlSuffix` varchar(255) DEFAULT NULL,
  `customAttributes` text,
  `data` text,
  `newWindow` tinyint(1) DEFAULT '0',
  `deletedWithNav` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gqflxonafttxtmhltmorwhkerpjyggvnozgq` (`navId`),
  KEY `fk_ymxughxsfyuhpcxcdpqvlrcaetbrvuihpvnv` (`elementId`),
  CONSTRAINT `fk_ooljqsrgaiumcinodvbytnobvxgjuqfyyeys` FOREIGN KEY (`navId`) REFERENCES `navigation_navs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pmerwtjewhjyzsfutcozqivrahykfpyqcdsl` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ymxughxsfyuhpcxcdpqvlrcaetbrvuihpvnv` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','trial','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_froiruixllptwxkaurvgyzcqyqttlkyntisi` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int NOT NULL,
  `ttr` int NOT NULL,
  `delay` int NOT NULL DEFAULT '0',
  `priority` int unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int DEFAULT NULL,
  `progress` smallint NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `idx_qtokcxxotwavkhjifodrphujsxkwlythucrv` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `idx_kfeovckokfrqvsivfmliubcehqwqdoyucpyd` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=892 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_pgjsvuwmvoexrelieqemlzgjmqcbycksclcx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `idx_rhhcyzkhkfghmsydgpdapselyhjadfqjjaqu` (`sourceId`),
  KEY `idx_shfxfhekqtgzanunciznfgjbiggjjizkzmtk` (`targetId`),
  KEY `idx_yiazxjfjqpckummrgzubwbxxwlxgscvdzzri` (`sourceSiteId`),
  CONSTRAINT `fk_ajglqckgbqgtgqtwmthtpglzdfxuddnvylvt` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_txkundkdpncwdnpwlqlurwrkmtmwcwihrfmz` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_velzfnwktvaqrrxxwwopvlrkkmbsvqtvzncf` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wuvbqsefmrydzadrssphedqjscehvmqfjbzo` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `num` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_evxmzavwsxkdezqnuqznsroacyfrxfxswxoi` (`canonicalId`,`num`),
  KEY `fk_jgidnalhubhsucpshpvsjoouclikboeqvfwa` (`creatorId`),
  CONSTRAINT `fk_jgidnalhubhsucpshpvsjoouclikboeqvfwa` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_zleujuffiduzzdjggopoymrbaeqppeymwuav` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `idx_ojveihzmgshsxismydkdxqwcbakxgrdajbxp` (`keywords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_kennpzbihvnurcijsnatmktxplsiqbuhwilo` (`handle`),
  KEY `idx_gcxknrjayunlewsmdoiwlnoxanknvubnxfmr` (`name`),
  KEY `idx_rkjfbmllwtspntvpuxuccdnnldmqlliwgfla` (`structureId`),
  KEY `idx_qsfybstfbhublnoymrevzikcxwlzhpndktky` (`dateDeleted`),
  CONSTRAINT `fk_pydspenvdnoqdmiapjtnsvpgfylhhqisrnax` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_zuwfztssujuevpmiqrjxqkxhpohkponxrdhi` (`sectionId`,`siteId`),
  KEY `idx_fwirjeplbvfptgtmplypmzijdcptpmaacqsd` (`siteId`),
  CONSTRAINT `fk_yrpnqrfaxehtxurcuvdhtwizrqxkpwxixmts` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zosnweqvdqdwqgvhfjwluaqvwhnxybdcoyxn` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seomatic_metabundles`
--

DROP TABLE IF EXISTS `seomatic_metabundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seomatic_metabundles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(255) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `typeId` int DEFAULT NULL,
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int DEFAULT NULL,
  `sourceAltSiteSettings` text,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text,
  `metaSiteVars` text,
  `metaSitemapVars` text,
  `metaContainers` text,
  `redirectsContainer` text,
  `frontendTemplatesContainer` text,
  `metaBundleSettings` text,
  PRIMARY KEY (`id`),
  KEY `idx_edrxcmqbxsweexxlicrzreqszochcqqjekol` (`sourceBundleType`),
  KEY `idx_dwhhsncehqfgfyvznnqlhzkjdpanumlvtibr` (`sourceId`),
  KEY `idx_iymzthtzeararvtsjpbenlaaqnzfubllmkaa` (`sourceSiteId`),
  KEY `idx_mjbroywlhhbaiibcyswxnseijvslngbfmwzh` (`sourceHandle`),
  CONSTRAINT `fk_bvixueayuyriuqqrklrvdmdxyfictmllwohw` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_qjnvurjfrabwiuaoufeuyichjatyklovzsxl` (`uid`),
  KEY `idx_neogyweqgqrdirsbhszmekkhtgwqdppwdtzm` (`token`),
  KEY `idx_tvktenwsobtxvjpndtxszkfoudvsewopohfn` (`dateUpdated`),
  KEY `idx_nfgtvhjgpgenzwetpsecppmzqgbdtzqpsxyz` (`userId`),
  CONSTRAINT `fk_fypcydkhpefsdtmhmmztiatozrvxrhcgvpbe` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sherlock`
--

DROP TABLE IF EXISTS `sherlock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sherlock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `siteId` int NOT NULL,
  `highSecurityLevel` tinyint(1) NOT NULL,
  `pass` tinyint(1) NOT NULL,
  `warning` tinyint(1) NOT NULL,
  `results` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_mmduauecpcbunizgufrhwmscbujjedmsxaht` (`siteId`),
  CONSTRAINT `fk_nqhyyoqukhrbvgfqzfimbbomicymbmoetzvo` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ugqurtnkmixmxgzhrgcgcgdfpivkaalkunot` (`userId`,`message`),
  CONSTRAINT `fk_lgxrvjjjsqbbqshpwckkhbsfpqpajvxlehup` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ixlscrldyzzwykmkdjexusvfdscyixqadkum` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` varchar(255) NOT NULL DEFAULT 'true',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_stnqgrnhsoobvwqdrjdacgxmkoddvgfcrpqg` (`dateDeleted`),
  KEY `idx_crdmxmlrunpaaifkpgbvkjsyhlpemfgndpwx` (`handle`),
  KEY `idx_zcdiusqopakwqvcvbmmfvfnffwwgykbvmrau` (`sortOrder`),
  KEY `fk_wyssaydrbqklliwhmqnazqldddcrvuslwzoi` (`groupId`),
  CONSTRAINT `fk_wyssaydrbqklliwhmqnazqldddcrvuslwzoi` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sprig_playgrounds`
--

DROP TABLE IF EXISTS `sprig_playgrounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sprig_playgrounds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `component` text,
  `variables` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stc_1_items`
--

DROP TABLE IF EXISTS `stc_1_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stc_1_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_headline` text,
  `field_text` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ojxqxyliamkexnortzhmlaxnuspfnexiviej` (`elementId`,`siteId`),
  KEY `fk_fowlbgwywdfzojefzryqdrxikbxpyneofkrt` (`siteId`),
  CONSTRAINT `fk_fowlbgwywdfzojefzryqdrxikbxpyneofkrt` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pkmqguuuyuxfhyeygwobivljyerjblvarcdf` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `root` int unsigned DEFAULT NULL,
  `lft` int unsigned NOT NULL,
  `rgt` int unsigned NOT NULL,
  `level` smallint unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uaktinokvhyklpvvkczdtnscoatjrpyygima` (`structureId`,`elementId`),
  KEY `idx_zzeprqiemeoysxlbbnotmzsuvalskxticvho` (`root`),
  KEY `idx_xjoqtpmiswmovrgglvoalhqmwefewqucecrh` (`lft`),
  KEY `idx_jnwxhxgidsbodyuzazequkhknyeymzqsrtfv` (`rgt`),
  KEY `idx_infrdzwswyoqxraezpdtkwvmcxcehiqilgeo` (`level`),
  KEY `idx_pyjbrkeffdfkpndgscjjgydmkcqjnipteajz` (`elementId`),
  CONSTRAINT `fk_hdbxdosgcqrppaxaofqkdwljttzphgbgabvt` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_xthozdlplvrqmnrjojwbpxiliasaxejrgqbu` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_plqrlybohqwsygltjpwcfuwzdvhwwshajwkr` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supertableblocks`
--

DROP TABLE IF EXISTS `supertableblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supertableblocks` (
  `id` int NOT NULL,
  `primaryOwnerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_uchjvvbvimydndhlqizorykwbzoybxczzvao` (`primaryOwnerId`),
  KEY `idx_fpxjtqpdznjfqpsnjzwwwwyrqcoxvbbjfosc` (`fieldId`),
  KEY `idx_iwrnbkdscekwjzbawhfcpbgmtxxscrivfgzs` (`typeId`),
  CONSTRAINT `fk_bbsriyvgftdgebxtkaldldszeklczwdbtrgu` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_etkzwpaweroavsvyqxtmgqaxczxmjwzfowyo` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_golhayxqgonmkecgrqxhtkemyxoarlwbpxin` FOREIGN KEY (`primaryOwnerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qsitvhztcpioeqlwjwpirbxcagxoksybbvqe` FOREIGN KEY (`typeId`) REFERENCES `supertableblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supertableblocks_owners`
--

DROP TABLE IF EXISTS `supertableblocks_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supertableblocks_owners` (
  `blockId` int NOT NULL,
  `ownerId` int NOT NULL,
  `sortOrder` smallint unsigned NOT NULL,
  PRIMARY KEY (`blockId`,`ownerId`),
  KEY `fk_kwndezgpltanvrkcgxrjvdvzojyifzcoukds` (`ownerId`),
  CONSTRAINT `fk_alhhseewpunxllrlvoihoqqbieeebxibovfr` FOREIGN KEY (`blockId`) REFERENCES `supertableblocks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_kwndezgpltanvrkcgxrjvdvzojyifzcoukds` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supertableblocktypes`
--

DROP TABLE IF EXISTS `supertableblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supertableblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_spmifkkkxcyixfawscbjpdvoonsvrvtxdfiy` (`fieldId`),
  KEY `idx_cmzrziocwxuyaewhmclfdfemarennxevjmbi` (`fieldLayoutId`),
  CONSTRAINT `fk_jxzhvjlojelsgqqiazhexnrixgyfbqwutqfx` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wwdkbglxtagnjbztgsquxttmxkfqzwgtsltv` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_zacctnysylxsetwzugmfuksypzskzbbgzbke` (`key`,`language`),
  KEY `idx_nshvzvaedkmuocazsgcssbdnlowfmkzyflbt` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_dyhzurwlfcbqinkchrsofpcuvxvewdrlzebn` (`name`),
  KEY `idx_xhcctdjalphoophgqvscifcvdpoqqotehwyu` (`handle`),
  KEY `idx_gzlxsuuhimmndducjtqgzxsmnffisapekstx` (`dateDeleted`),
  KEY `fk_gnoqvluubazhvvhambidehvamfojtaryotdl` (`fieldLayoutId`),
  CONSTRAINT `fk_gnoqvluubazhvvhambidehvamfojtaryotdl` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_zgrxuyyzcsonjaqhylrqtdydmludotkguwmd` (`groupId`),
  CONSTRAINT `fk_jjvthuywpjbcwiqmlrxclzltyhcsncfmcvwg` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zbzqkzzaiboxqhzxlpaajpopritjdtkyllxv` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint unsigned DEFAULT NULL,
  `usageCount` tinyint unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_owlgkoodroqztqdtirdgspnuadtrxdapbsjh` (`token`),
  KEY `idx_firqgnzoclloahdfvanremcjauytzhrnoauz` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_wmckyqeigpnthxdjtwutcdxwugiahflrgmkt` (`handle`),
  KEY `idx_uhwozfnxlsoyxgrakqrbtqetesiwsoavkmph` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vdgcgazezcqkxicmpvzzghcsrhjgujybmbkg` (`groupId`,`userId`),
  KEY `idx_cwortrpoxpvbxlcuvlodfpowfbpytffzojmm` (`userId`),
  CONSTRAINT `fk_eyachgvsjjdevvqlzvspzvdpaqlqxqvlbykm` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_xlvpsfsgkguwadzwudcysdrhyafterpjevjw` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_gtqolubtrgpfokerytrrnwiwjhrkmxjzkanb` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `groupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sagxzdbensgogzwzktegyadqksjacpmdkepk` (`permissionId`,`groupId`),
  KEY `idx_xxsfayytvwxnvbwwanyncuqphhekhiiyhhvx` (`groupId`),
  CONSTRAINT `fk_nrlyszcamwyqnjpbbvogpnragxkgtvipvcig` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rcemurgmxcflrkmzhihcgqycgszczrgxcuby` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mgtsxguxcfsditwiorrfumcwfpjliqvpytvs` (`permissionId`,`userId`),
  KEY `idx_otpsgaamfmqqpzpuznikybwjlujdikpipova` (`userId`),
  CONSTRAINT `fk_rkhhuvorgsbnucwdxkabkxmhjjwiwfxjdfau` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rlgrurdvlfjxtajipavusewmchbgksgzfdmw` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `fk_qowkrexcuitlftioxlemlfxdxbzhkqiansai` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `photoId` int DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_gjayxyijuegjhxpjyfjxfyhftvsagmooflgp` (`active`),
  KEY `idx_goqeebmrhwufuhlgpyinjwexpimfirrgzwdp` (`locked`),
  KEY `idx_jtihgcghwldyibramnrxyvuoqwzniatefzqu` (`pending`),
  KEY `idx_lvzxvimvztmvsolezpkesdowkfhtxxinudla` (`suspended`),
  KEY `idx_xlyzgzyzjfhwaodflvizngpdbtbceizkimly` (`verificationCode`),
  KEY `idx_ifqtpxyasbvvwfxcworiayldtzlrfiacsdmt` (`email`),
  KEY `idx_agaskkyrwozrnchvsmuaozlecvthgjhtdogl` (`username`),
  KEY `fk_ewjsmnlwmqfdqhgambbfpketoquvdpztjrzu` (`photoId`),
  CONSTRAINT `fk_ewjsmnlwmqfdqhgambbfpketoquvdpztjrzu` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_oisrcxpacyqrpcgulqthblhslhcbuqcgyhax` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int DEFAULT NULL,
  `volumeId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_zzykzvhqnkqibvbxiunwgbvewxrkqnjnxzpq` (`name`,`parentId`,`volumeId`),
  KEY `idx_lpwcvexguufkwzcdxasfhbdqpicxmhvngwct` (`parentId`),
  KEY `idx_ksxjcsditaxylkvrrnrwecelmfpchvcbsvrj` (`volumeId`),
  CONSTRAINT `fk_ajcyvuoimaviaccsuniyntbybtvzeybshxde` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ggncmneatghutqmkwsxcomkggqtpdogxgxjx` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fs` varchar(255) NOT NULL,
  `transformFs` varchar(255) DEFAULT NULL,
  `transformSubpath` varchar(255) DEFAULT NULL,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_zwuttleeauoqrcqrwurraybzsahdwvqentan` (`name`),
  KEY `idx_vcfysvunjidnozxdfxdtsmsarbbgmfpbqlxw` (`handle`),
  KEY `idx_mfixyeomyfqdfibtfmjofnyyacsrposqbmue` (`fieldLayoutId`),
  KEY `idx_srrmxleikhjppnowrhdukrmcweqxiagjkwmn` (`dateDeleted`),
  CONSTRAINT `fk_qzsfihnnvbtxxkctmitfuhuwihcemettfhyo` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `colspan` tinyint DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_hwxtovevfzfqosqqsmxpjudpxtlhncjfwhzd` (`userId`),
  CONSTRAINT `fk_zekxbrflbpuvhahqhykfccaovtmutxdqzuma` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-17 10:50:04
-- MariaDB dump 10.19  Distrib 10.6.9-MariaDB, for Linux (x86_64)
--
-- Host: mysql    Database: project
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assetindexingsessions`
--

LOCK TABLES `assetindexingsessions` WRITE;
/*!40000 ALTER TABLE `assetindexingsessions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assetindexingsessions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedattributes` VALUES (16,1,'fullName','2022-11-17 05:27:35',0,16),(17,1,'postDate','2022-11-16 06:48:32',0,16),(17,1,'slug','2022-11-16 06:48:31',0,16),(17,1,'title','2022-11-16 06:48:27',0,16),(17,1,'uri','2022-11-16 06:48:31',0,16),(19,1,'postDate','2022-11-16 06:49:25',0,16),(19,1,'slug','2022-11-16 06:48:42',0,16),(19,1,'title','2022-11-16 06:48:42',0,16),(19,1,'uri','2022-11-16 06:48:42',0,16),(26,1,'postDate','2022-11-16 06:50:19',0,16),(26,1,'slug','2022-11-16 08:01:18',0,16),(26,1,'title','2022-11-16 21:22:04',0,16),(26,1,'uri','2022-11-16 06:50:15',0,16),(28,1,'fieldLayoutId','2022-11-16 10:16:55',0,16),(28,1,'postDate','2022-11-16 06:50:37',0,16),(28,1,'slug','2022-11-16 19:08:17',0,16),(28,1,'title','2022-11-16 21:11:31',0,16),(28,1,'typeId','2022-11-16 10:16:55',0,16),(28,1,'uri','2022-11-16 19:08:17',0,16),(38,1,'fieldLayoutId','2022-11-16 20:46:17',0,16),(38,1,'postDate','2022-11-16 09:56:25',0,16),(38,1,'slug','2022-11-16 09:56:46',0,16),(38,1,'title','2022-11-16 09:56:24',0,16),(38,1,'typeId','2022-11-16 20:46:17',0,16),(38,1,'uri','2022-11-16 09:56:25',0,16),(47,1,'slug','2022-11-16 10:07:53',0,16),(47,1,'title','2022-11-16 10:09:35',0,16),(47,1,'uri','2022-11-16 10:07:53',0,16),(88,1,'postDate','2022-11-16 11:28:34',0,16),(88,1,'slug','2022-11-16 11:28:32',0,16),(88,1,'title','2022-11-16 11:28:32',0,16),(88,1,'uri','2022-11-16 11:28:32',0,16),(130,1,'postDate','2022-11-16 20:33:49',0,16),(130,1,'slug','2022-11-16 20:33:22',0,16),(130,1,'title','2022-11-16 20:33:23',0,16),(130,1,'uri','2022-11-16 20:33:23',0,16),(133,1,'postDate','2022-11-16 20:34:27',0,16),(133,1,'slug','2022-11-16 20:34:12',0,16),(133,1,'title','2022-11-16 20:34:19',0,16),(133,1,'uri','2022-11-16 20:34:12',0,16);
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedfields` VALUES (16,1,3,'2022-11-17 05:27:35',0,16),(17,1,2,'2022-11-17 05:59:06',0,16),(17,1,18,'2022-11-17 04:34:36',0,16),(19,1,2,'2022-11-17 06:06:58',0,16),(19,1,18,'2022-11-16 21:20:12',0,16),(23,1,61,'2022-11-17 06:06:58',0,16),(23,1,63,'2022-11-16 10:35:02',0,16),(26,1,4,'2022-11-16 06:50:05',0,16),(26,1,16,'2022-11-16 21:25:43',0,16),(28,1,2,'2022-11-17 10:44:59',0,16),(28,1,9,'2022-11-16 11:28:51',0,16),(28,1,18,'2022-11-16 11:27:42',0,16),(28,1,21,'2022-11-17 10:49:11',0,16),(29,1,105,'2022-11-16 11:28:51',0,16),(29,1,106,'2022-11-16 11:28:51',0,16),(38,1,2,'2022-11-16 20:46:32',0,16),(38,1,21,'2022-11-16 20:46:17',0,16),(47,1,7,'2022-11-16 10:07:37',0,16),(79,1,113,'2022-11-17 04:34:36',0,16),(79,1,114,'2022-11-17 04:34:36',0,16),(88,1,4,'2022-11-16 11:28:17',0,16),(90,1,101,'2022-11-17 10:44:59',0,16),(90,1,102,'2022-11-16 11:37:29',0,16),(90,1,104,'2022-11-16 11:29:07',0,16),(102,1,83,'2022-11-16 11:39:06',0,16),(102,1,128,'2022-11-17 10:49:11',0,16),(130,1,7,'2022-11-16 20:33:49',0,16),(133,1,2,'2022-11-17 07:54:40',0,16),(133,1,7,'2022-11-16 20:34:27',0,16),(165,1,91,'2022-11-16 21:20:12',0,16),(184,1,137,'2022-11-17 06:10:16',0,16),(216,1,23,'2022-11-17 06:09:47',0,16),(260,1,84,'2022-11-17 07:54:39',0,16);
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,'Alert Message','2022-11-16 06:42:36','2022-11-16 06:42:51','233a3457-805a-491a-a1d0-ae98a0d74698',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,1,'Alert Message','2022-11-16 06:42:36','2022-11-16 06:42:36','caf864ab-5004-4241-b64d-69c39d99396d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,3,1,'Alert Message','2022-11-16 06:42:36','2022-11-16 06:42:36','c5e3b6d6-416b-4611-b146-0d337c91f37c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,4,1,'Error 404','2022-11-16 06:42:36','2022-11-16 06:42:51','45463612-dd41-485a-b50a-a40a28c8a832',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,5,1,'Error 404','2022-11-16 06:42:36','2022-11-16 06:42:36','37285854-9713-474c-ae4b-09a7ef1a65a3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,6,1,'Error 404','2022-11-16 06:42:36','2022-11-16 06:42:36','eb7073a1-4483-4a80-82d2-28e4fd708812',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,7,1,'Search','2022-11-16 06:42:36','2022-11-16 06:42:52','c3596e12-cb74-433a-8266-94c59c5abbbb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,8,1,'Search','2022-11-16 06:42:37','2022-11-16 06:42:37','834b5c88-9ced-43c7-9103-e902f0e8c406',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,9,1,'Search','2022-11-16 06:42:37','2022-11-16 06:42:37','638d9ba5-26b7-49c4-a7f2-f37af377fa87',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,10,1,'Alert Message','2022-11-16 06:42:51','2022-11-16 06:42:51','fd12b687-d4cf-4b02-bc35-f3788d21fe9e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,11,1,'Alert Message','2022-11-16 06:42:51','2022-11-16 06:42:51','b263ab29-31bc-4827-a324-9ca0db8def01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,12,1,'Error 404','2022-11-16 06:42:51','2022-11-16 06:42:51','ba0333e0-9594-4d3a-b9a1-f14c16275c1e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,13,1,'Error 404','2022-11-16 06:42:51','2022-11-16 06:42:51','e1e8681d-0421-4c62-9e11-3d1204780ceb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,14,1,'Search','2022-11-16 06:42:52','2022-11-16 06:42:52','b1816c13-fcb5-4deb-ac17-3fcf8161521e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,15,1,'Search','2022-11-16 06:42:52','2022-11-16 06:42:52','48580822-be27-447c-8521-d251e4dd0934',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,16,1,NULL,'2022-11-16 06:42:55','2022-11-17 05:27:35','e17715f1-e874-4e4b-bf90-4611fc0d4451',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,17,1,'Home','2022-11-16 06:48:23','2022-11-17 05:59:06','4519275c-a93c-4d29-a81f-60e02a77a63a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,18,1,'Home','2022-11-16 06:48:32','2022-11-16 06:48:32','3946f2e4-5450-44a6-8517-3abb0b405676',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,19,1,'News','2022-11-16 06:48:39','2022-11-17 06:06:58','2169541a-bbb8-42e6-a9fb-646c2d0796c1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,24,1,'News','2022-11-16 06:49:25','2022-11-16 06:49:25','f31356f3-dedc-4982-9b76-ad43db1828be',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,26,1,'Signup for our Newsletter','2022-11-16 06:49:52','2022-11-16 21:25:43','aaba1315-66ac-4d86-a706-8dca1bbf2421',NULL,'{\"refpath\":\"_sections/fragments/basicFragments.json\",\"value\":\"subscribe\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"\"}',NULL,NULL,NULL,NULL,'<h3 class=\"rd-h3\" style=\"text-align: center\">Signup for our Newsletter</h3>',NULL),(22,27,1,'Newsletter Sign-up','2022-11-16 06:50:19','2022-11-16 06:50:19','da058649-5e4a-4864-986d-a6d2b466a2df',NULL,'{\"refpath\":\"_sections/fragments/basicFragments.json\",\"value\":\"subscribe\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"\"}',NULL,NULL,NULL,NULL,NULL,NULL),(23,28,1,'Contact','2022-11-16 06:50:23','2022-11-17 10:49:11','0eb7fdc6-e362-4e1c-907c-5c53b8ef632f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,34,1,'Newsletter Subscription','2022-11-16 06:51:38','2022-11-16 06:51:38','a46942dd-1851-4463-9037-74f1a2493628',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,35,1,'Contact Form','2022-11-16 06:52:08','2022-11-17 06:22:43','3a8b4066-f00e-4be1-98cd-be6947e6f3f7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,37,1,'Newsletter Sign-up','2022-11-16 08:01:18','2022-11-16 08:01:18','9ae76284-31b2-4c6d-b4e3-de227d731545',NULL,'{\"refpath\":\"_sections/fragments/basicFragments.json\",\"value\":\"subscribe\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"\"}',NULL,NULL,NULL,NULL,NULL,NULL),(30,38,1,'Privacy Policy','2022-11-16 09:56:14','2022-11-16 20:46:32','604e51c7-c7ae-4a32-b8c0-d8801da60459',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,39,1,'Privacy Policy','2022-11-16 09:56:25','2022-11-16 09:56:25','dc3aaacc-8d62-4adf-a8bf-e763bbcc8fb7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,41,1,'Privacy Policy','2022-11-16 09:56:46','2022-11-16 09:56:46','aec7c55f-efcc-4d58-a677-a74118e4a13a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,42,1,'Privacy Policy','2022-11-16 09:57:13','2022-11-16 20:46:32','67cc933c-698e-493c-9f57-2fcbca11d7d7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,43,1,'Contact','2022-11-16 09:57:18','2022-11-17 10:49:11','6bb2c729-d9c6-46d9-b580-cf0f723fa46c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,44,1,'Home','2022-11-16 09:57:31','2022-11-17 05:59:06','01867038-a9b8-41e7-820e-30c0bc2bc655',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,44,2,'Home','2022-11-16 09:57:31','2022-11-16 09:57:31','9c718d04-85e5-438e-8b4d-7032a858336a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,45,1,'News','2022-11-16 09:57:34','2022-11-17 06:06:58','fde0e4a5-ace0-4bff-b117-e10a50475899',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,45,2,'News','2022-11-16 09:57:34','2022-11-16 09:57:34','90d7b820-85ae-45bc-8186-0d00c724db28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,46,1,'Contact','2022-11-16 09:57:36','2022-11-17 10:49:11','feaf9b7c-18d8-4462-a17c-7acf017effc4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,46,2,'Contact Us','2022-11-16 09:57:36','2022-11-16 09:57:36','f766d3d1-e587-432a-8876-d01ff81b2196',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,47,1,'News Story with a Medium Title','2022-11-16 10:07:00','2022-11-16 10:09:34','3fd00194-ce1c-4513-af70-758570c3b12a',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cum sciret confestim esse moriendum eamque mortem ardentiore studio peteret, quam Epicurus voluptatem petendam putat.</p>',NULL,NULL,NULL,NULL,NULL),(43,48,1,'A News Story','2022-11-16 10:07:53','2022-11-16 10:07:53','b1cf65e5-ae33-42f0-8f72-af317617a02b',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cum sciret confestim esse moriendum eamque mortem ardentiore studio peteret, quam Epicurus voluptatem petendam putat.</p>',NULL,NULL,NULL,NULL,NULL),(45,50,1,'News Story with an Average Length Title','2022-11-16 10:08:43','2022-11-16 10:08:43','95075dc3-405f-4164-950d-567ec8a1f4c1',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cum sciret confestim esse moriendum eamque mortem ardentiore studio peteret, quam Epicurus voluptatem petendam putat.</p>',NULL,NULL,NULL,NULL,NULL),(47,52,1,'News Story with a Medium Title','2022-11-16 10:09:34','2022-11-16 10:09:34','0af21ade-74ef-451b-8681-934cddbeca26',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cum sciret confestim esse moriendum eamque mortem ardentiore studio peteret, quam Epicurus voluptatem petendam putat.</p>',NULL,NULL,NULL,NULL,NULL),(52,69,1,'News','2022-11-16 10:35:02','2022-11-16 10:35:02','69afb016-a768-4aff-862c-8379c5d5d67b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,80,1,'Home','2022-11-16 11:27:17','2022-11-16 11:27:17','1530f99d-350e-4dd2-8261-bbf1a5182277',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(58,88,1,'Common Chunk','2022-11-16 11:28:12','2022-11-16 11:28:34','b623f11f-6dd7-43d4-94ba-f40140fde655',NULL,'{\"refpath\":\"_sections/fragments/basicFragments.json\",\"value\":\"chunk\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"\"}',NULL,NULL,NULL,NULL,NULL,NULL),(59,89,1,'Common Chunk','2022-11-16 11:28:34','2022-11-16 11:28:34','1ebe431f-4ac8-4aba-bce9-d40464268e1a',NULL,'{\"refpath\":\"_sections/fragments/basicFragments.json\",\"value\":\"chunk\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"\"}',NULL,NULL,NULL,NULL,NULL,NULL),(73,130,1,'News Story','2022-11-16 20:33:16','2022-11-16 20:33:55','a8f4421d-e0fb-4302-bbf5-b21551e7a02f',NULL,NULL,'<p>This is an example of too much content in a dek. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Hinc ceteri particulas arripere conati suam quisque videro voluit afferre sententiam. Itaque haec cum illis est dissensio, cum Peripateticis nulla sane. Apud ceteros autem philosophos, qui quaesivit aliquid, tacet; Me ipsum esse dicerem, inquam, nisi mihi viderer habere bene cognitam voluptatem et satis firme conceptam animo atque comprehensam. Satisne vobis videor pro meo iure in vestris auribus commentatus? Hoc loco discipulos quaerere videtur, ut, qui asoti esse velint, philosophi ante fiant. Atqui haec patefactio quasi rerum opertarum, cum quid quidque sit aperitur, definitio est. Duo Reges: constructio interrete.<br /></p>',NULL,NULL,NULL,NULL,NULL),(74,131,1,'News Story','2022-11-16 20:33:49','2022-11-16 20:33:49','315f122f-37c9-4590-bd50-e9ccc828610b',NULL,NULL,'<p>This is an example of too much content in a dek. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Hinc ceteri particulas arripere conati suam quisque videro voluit afferre sententiam. Itaque haec cum illis est dissensio, cum Peripateticis nulla sane. Apud ceteros autem philosophos, qui quaesivit aliquid, tacet; Me ipsum esse dicerem, inquam, nisi mihi viderer habere bene cognitam voluptatem et satis firme conceptam animo atque comprehensam. Satisne vobis videor pro meo iure in vestris auribus commentatus? Hoc loco discipulos quaerere videtur, ut, qui asoti esse velint, philosophi ante fiant. Atqui haec patefactio quasi rerum opertarum, cum quid quidque sit aperitur, definitio est. Duo Reges: constructio interrete.<br /></p>',NULL,NULL,NULL,NULL,NULL),(75,132,1,'News Story','2022-11-16 20:33:55','2022-11-16 20:33:55','4e19afdd-8af8-4be3-b8c2-a16ad44d47be',NULL,NULL,'<p>This is an example of too much content in a dek. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Hinc ceteri particulas arripere conati suam quisque videro voluit afferre sententiam. Itaque haec cum illis est dissensio, cum Peripateticis nulla sane. Apud ceteros autem philosophos, qui quaesivit aliquid, tacet; Me ipsum esse dicerem, inquam, nisi mihi viderer habere bene cognitam voluptatem et satis firme conceptam animo atque comprehensam. Satisne vobis videor pro meo iure in vestris auribus commentatus? Hoc loco discipulos quaerere videtur, ut, qui asoti esse velint, philosophi ante fiant. Atqui haec patefactio quasi rerum opertarum, cum quid quidque sit aperitur, definitio est. Duo Reges: constructio interrete.<br /></p>',NULL,NULL,NULL,NULL,NULL),(76,133,1,'News Story With a Much Longer Title Than You Might Normally Expect','2022-11-16 20:33:57','2022-11-17 07:54:39','a3399580-dfd8-46e0-b70d-fc30454d3c0b',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ad bona praeterita redeamus. Nonne igitur tibi videntur, inquit, mala? Duo Reges: constructio interrete. Videamus animi partes, quarum est conspectus illustrior;</p>',NULL,NULL,NULL,NULL,NULL),(77,134,1,'News Story With a Much Longer Title Than You Might Normally Expect','2022-11-16 20:34:27','2022-11-16 20:34:27','041ff2da-9119-4770-8ecd-4cde4fb3a29e',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ad bona praeterita redeamus. Nonne igitur tibi videntur, inquit, mala? Duo Reges: constructio interrete. Videamus animi partes, quarum est conspectus illustrior;</p>',NULL,NULL,NULL,NULL,NULL),(81,145,1,'News','2022-11-16 20:38:14','2022-11-16 20:38:14','4dcd3498-8d9a-43c5-ae88-37048a1d6c8e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(83,148,1,'Privacy Policy','2022-11-16 20:46:17','2022-11-16 20:46:17','e1af9a8b-eeea-490c-a319-071a29b0a54d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(85,154,1,'Privacy Policy','2022-11-16 20:46:32','2022-11-16 20:46:32','324f5a1f-f494-46b1-91fa-3a434aa3c8bc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(89,166,1,'News','2022-11-16 21:14:23','2022-11-16 21:14:23','397f937e-92ab-43b3-b56f-5487a6ba652b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(91,171,1,'News','2022-11-16 21:20:12','2022-11-16 21:20:12','830219a7-13ee-4631-a228-9af4136bbc10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(93,175,1,'Signup for our Newsletter','2022-11-16 21:22:04','2022-11-16 21:22:04','5793ae9c-f8f6-44e2-ab72-1618263a08ff',NULL,'{\"refpath\":\"_sections/fragments/basicFragments.json\",\"value\":\"subscribe\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"\"}',NULL,NULL,NULL,NULL,NULL,NULL),(95,177,1,'Signup for our Newsletter','2022-11-16 21:25:43','2022-11-16 21:25:43','28fe1e9a-c007-4240-b13f-6b495b207e19',NULL,'{\"refpath\":\"_sections/fragments/basicFragments.json\",\"value\":\"subscribe\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"\"}',NULL,NULL,NULL,NULL,'<h3 class=\"rd-h3\" style=\"text-align: center\">Signup for our Newsletter</h3>',NULL),(97,185,1,'Contact','2022-11-16 22:52:33','2022-11-16 22:52:33','0e0ac1e3-f952-47a7-9e78-322d5ac7e679',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(99,192,1,'Home','2022-11-17 04:34:36','2022-11-17 04:34:36','1d9b7f28-a886-4003-9542-7a91aa32d367',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(102,217,1,'Contact','2022-11-17 05:23:42','2022-11-17 05:23:42','f12eefed-3753-4998-aeae-6590dab4678f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(105,234,1,'Home','2022-11-17 05:59:06','2022-11-17 05:59:06','a4318c92-444d-4ff7-a9b6-80d7ee04767d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(107,239,1,'News','2022-11-17 06:06:58','2022-11-17 06:06:58','b58a3334-ce5a-478b-907b-c051135187da',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(108,243,1,'Contact','2022-11-17 06:09:47','2022-11-17 06:09:47','de505a0d-808f-4581-bb92-f5fda9749575',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(110,252,1,'Contact','2022-11-17 06:10:16','2022-11-17 06:10:16','043b2242-fd8f-40ad-8a85-2c79e5dc1b2e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(112,261,1,'News Story With a Much Longer Title Than You Might Normally Expect','2022-11-17 07:45:17','2022-11-17 07:45:17','d4d0066d-3324-47c8-bd7a-4e5c3e26e29b',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ad bona praeterita redeamus. Nonne igitur tibi videntur, inquit, mala? Duo Reges: constructio interrete. Videamus animi partes, quarum est conspectus illustrior;</p>',NULL,NULL,NULL,NULL,NULL),(114,265,1,'News Story With a Much Longer Title Than You Might Normally Expect','2022-11-17 07:54:40','2022-11-17 07:54:40','12fd52f8-35d5-4ee3-a49e-a908567cda5c',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ad bona praeterita redeamus. Nonne igitur tibi videntur, inquit, mala? Duo Reges: constructio interrete. Videamus animi partes, quarum est conspectus illustrior;</p>',NULL,NULL,NULL,NULL,NULL),(116,269,1,'Contact','2022-11-17 10:02:11','2022-11-17 10:02:11','d8b54cce-b67e-42df-a72e-f91c7c8fbf0e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(118,276,1,'Contact','2022-11-17 10:21:55','2022-11-17 10:21:55','7665208e-6186-4345-9415-15e393ad8673',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(120,283,1,'Contact','2022-11-17 10:36:54','2022-11-17 10:36:54','107eb0b3-19a8-4af3-a898-42fddd2bf494',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(122,290,1,'Contact','2022-11-17 10:37:11','2022-11-17 10:37:11','c88ec168-ca4c-4ac7-b046-3de7b596a6ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(124,297,1,'Contact','2022-11-17 10:44:59','2022-11-17 10:44:59','3c975f35-e0b0-45e2-9deb-1a1fe70bef81',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(126,304,1,'Contact','2022-11-17 10:49:11','2022-11-17 10:49:11','1ff2c196-6140-41df-8a75-b33384da0d6e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `dolphiq_redirects`
--

LOCK TABLES `dolphiq_redirects` WRITE;
/*!40000 ALTER TABLE `dolphiq_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dolphiq_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `dolphiq_redirects_catch_all_urls`
--

LOCK TABLES `dolphiq_redirects_catch_all_urls` WRITE;
/*!40000 ALTER TABLE `dolphiq_redirects_catch_all_urls` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dolphiq_redirects_catch_all_urls` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,25,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:36','2022-11-16 06:42:51',NULL,NULL,'94bdad1e-afb2-47a5-9989-239400a5ca34'),(2,1,NULL,1,25,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,NULL,'462e814a-007d-44c3-aa9e-ae190e0bdb26'),(3,1,NULL,2,25,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,NULL,'d2d4f6d7-ad2a-4a6e-afd9-483f872165e0'),(4,NULL,NULL,NULL,28,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:36','2022-11-16 06:42:51',NULL,NULL,'457cef34-7e59-4810-9e3b-451ff0540b51'),(5,4,NULL,3,28,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,NULL,'dd2edb9e-6cdf-4711-a733-ba3b67e5e614'),(6,4,NULL,4,28,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,NULL,'9ef7ee1b-3141-4b33-88e7-1133485ca40f'),(7,NULL,NULL,NULL,31,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:36','2022-11-16 06:42:52',NULL,NULL,'435a7d04-115c-4a6b-9847-cbc03e114514'),(8,7,NULL,5,31,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,NULL,'9a5b133e-c2a4-4ccf-9e9d-70451bf716c0'),(9,7,NULL,6,31,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,NULL,'4ef7c312-6d5f-4f41-a937-88ba012fbc07'),(10,1,NULL,7,25,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:51','2022-11-16 06:42:51',NULL,NULL,'10855404-ffff-4a42-8951-5eb35d88131c'),(11,1,NULL,8,25,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:51','2022-11-16 06:42:51',NULL,NULL,'e72b0c16-19ac-4870-9fb3-cf5d310661fe'),(12,4,NULL,9,28,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:51','2022-11-16 06:42:51',NULL,NULL,'cc0de382-118a-4edd-8d5e-29c45bd85f2f'),(13,4,NULL,10,28,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:51','2022-11-16 06:42:51',NULL,NULL,'f2e23c23-d1a4-443f-8404-2ba1ab8f5672'),(14,7,NULL,11,31,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:52','2022-11-16 06:42:52',NULL,NULL,'635378a1-6e44-45f1-a723-1f990867a69d'),(15,7,NULL,12,31,'craft\\elements\\Entry',1,0,'2022-11-16 06:42:52','2022-11-16 06:42:52',NULL,NULL,'84ec16a6-bb95-4d59-9e36-b4c8514886cb'),(16,NULL,NULL,NULL,37,'craft\\elements\\User',1,0,'2022-11-16 06:42:55','2022-11-17 05:27:35',NULL,NULL,'61870b78-bcc7-437c-b23d-b17e45d9d7a2'),(17,NULL,NULL,NULL,30,'craft\\elements\\Entry',1,0,'2022-11-16 06:48:22','2022-11-17 05:59:06',NULL,NULL,'7060d93a-bab2-4c61-96fb-dff01632f930'),(18,17,NULL,13,30,'craft\\elements\\Entry',1,0,'2022-11-16 06:48:32','2022-11-16 06:48:32',NULL,NULL,'54967802-fad5-4786-88c1-b4a6a8f47105'),(19,NULL,NULL,NULL,30,'craft\\elements\\Entry',1,0,'2022-11-16 06:48:39','2022-11-17 06:06:58',NULL,NULL,'e6b5616e-9f80-4be6-988d-ce7895fb93de'),(20,NULL,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:48:47','2022-11-16 06:48:47',NULL,'2022-11-16 06:48:50','343599b1-fc50-47ae-9f2f-010ad3300f64'),(21,NULL,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:48:49','2022-11-16 06:48:49',NULL,'2022-11-16 06:48:57','253bc2e9-fa15-4a08-a4a5-e98951cb1907'),(22,NULL,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:48:57','2022-11-16 06:48:57',NULL,'2022-11-16 06:48:59','4e10a4c7-45c5-4901-ad6e-432e99ea8639'),(23,NULL,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:48:59','2022-11-17 06:06:58',NULL,NULL,'5e8cfdb8-e858-4f25-a59c-641c576d277e'),(24,19,NULL,14,30,'craft\\elements\\Entry',1,0,'2022-11-16 06:49:25','2022-11-16 06:49:25',NULL,NULL,'b718c77e-1ef1-4130-b1f9-44539adfb9b6'),(25,23,NULL,15,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:48:59','2022-11-16 06:49:25',NULL,NULL,'a2ea1d4b-c9d7-43b2-8272-04a5cf5544de'),(26,NULL,NULL,NULL,5,'craft\\elements\\Entry',1,0,'2022-11-16 06:49:52','2022-11-16 21:25:43',NULL,NULL,'168a3d11-8f13-452f-8c80-b7e69fb5fdd3'),(27,26,NULL,16,5,'craft\\elements\\Entry',1,0,'2022-11-16 06:50:19','2022-11-16 06:50:19',NULL,NULL,'a572167e-d300-44cd-b192-a8e9bcc82a01'),(28,NULL,NULL,NULL,23,'craft\\elements\\Entry',1,0,'2022-11-16 06:50:23','2022-11-17 10:49:11',NULL,NULL,'c4fc4f6f-8a79-4d35-81e8-6660d660c639'),(29,NULL,NULL,NULL,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:50:33','2022-11-16 11:28:51',NULL,NULL,'efd4dec9-de7d-4db5-8619-92af7d35f617'),(31,29,NULL,18,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:50:33','2022-11-16 06:50:37',NULL,NULL,'3b7ccc1e-476c-4a3c-b679-e6ead1815d1c'),(33,29,NULL,20,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:50:33','2022-11-16 06:50:46',NULL,NULL,'b5b422ab-0e33-4431-985f-2906923dca56'),(34,NULL,NULL,NULL,39,'verbb\\formie\\elements\\Form',1,0,'2022-11-16 06:51:38','2022-11-16 06:51:38',NULL,NULL,'234256a5-e09f-4241-b669-7224fd3ca605'),(35,NULL,NULL,NULL,40,'verbb\\formie\\elements\\Form',1,0,'2022-11-16 06:52:08','2022-11-17 06:22:43',NULL,NULL,'61c5bb74-9601-4136-a973-babd4059bead'),(37,26,NULL,21,5,'craft\\elements\\Entry',1,0,'2022-11-16 08:01:18','2022-11-16 08:01:18',NULL,NULL,'6e47377a-a405-4c26-a0ec-a0d03f1647b2'),(38,NULL,NULL,NULL,23,'craft\\elements\\Entry',1,0,'2022-11-16 09:56:14','2022-11-16 20:46:32',NULL,NULL,'215ed064-cdcf-4787-a23a-2fb9be2bf390'),(39,38,NULL,22,30,'craft\\elements\\Entry',1,0,'2022-11-16 09:56:25','2022-11-16 09:56:25',NULL,NULL,'00f50bfd-8650-4e64-8fdb-77ba3f4bfa82'),(41,38,NULL,23,30,'craft\\elements\\Entry',1,0,'2022-11-16 09:56:46','2022-11-16 09:56:46',NULL,NULL,'10b560f5-6bd9-41f1-b714-035dfe386d5b'),(42,NULL,NULL,NULL,42,'verbb\\navigation\\elements\\Node',1,0,'2022-11-16 09:57:13','2022-11-16 20:46:32',NULL,NULL,'feacb442-e736-4a66-b225-8c7a20600154'),(43,NULL,NULL,NULL,42,'verbb\\navigation\\elements\\Node',1,0,'2022-11-16 09:57:18','2022-11-17 10:49:11',NULL,NULL,'15254ae1-6b99-4b4f-bcbb-94de94d12dae'),(44,NULL,NULL,NULL,41,'verbb\\navigation\\elements\\Node',1,0,'2022-11-16 09:57:31','2022-11-17 05:59:06',NULL,NULL,'1e654acb-1c20-4baf-aa67-4a9ead154a6c'),(45,NULL,NULL,NULL,41,'verbb\\navigation\\elements\\Node',1,0,'2022-11-16 09:57:34','2022-11-17 06:06:58',NULL,NULL,'8bdec7f7-bba0-40bf-9436-cb0649e99e55'),(46,NULL,NULL,NULL,41,'verbb\\navigation\\elements\\Node',1,0,'2022-11-16 09:57:36','2022-11-17 10:49:11',NULL,NULL,'9a9b712d-67aa-4f1d-9fc5-b70377750a1a'),(47,NULL,NULL,NULL,34,'craft\\elements\\Entry',1,0,'2022-11-16 10:07:00','2022-11-16 10:09:34',NULL,NULL,'d9b9ba75-f2aa-4e73-a935-5bcd65a32720'),(48,47,NULL,24,34,'craft\\elements\\Entry',1,0,'2022-11-16 10:07:53','2022-11-16 10:07:53',NULL,NULL,'9a9f5d59-faa8-4952-8758-f1cdce36cdf9'),(50,47,NULL,25,34,'craft\\elements\\Entry',1,0,'2022-11-16 10:08:43','2022-11-16 10:08:43',NULL,NULL,'b616aa34-082c-4d07-9bc4-ce3b08781cc2'),(52,47,NULL,26,34,'craft\\elements\\Entry',1,0,'2022-11-16 10:09:34','2022-11-16 10:09:34',NULL,NULL,'d16d525d-4dd4-46d5-aefa-cf0bba65ca91'),(54,NULL,NULL,NULL,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:10:20','2022-11-16 10:10:20',NULL,'2022-11-16 10:10:29','1551cb7e-196b-482d-a4c0-70266884f450'),(55,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:16:29','2022-11-16 10:16:29',NULL,'2022-11-16 10:16:34','9bb4b646-9a34-4fa1-8d5e-604a8f2e72bb'),(56,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:16:37','2022-11-16 10:16:37',NULL,'2022-11-16 10:16:42','b34d5567-1020-4427-aefc-0aa785590b88'),(57,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:16:42','2022-11-16 10:16:42',NULL,'2022-11-16 10:16:43','06cd5cb6-ef10-4d83-bae9-7e3085e6da37'),(58,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:16:43','2022-11-16 10:16:43',NULL,'2022-11-16 10:16:49','092522c0-e7d3-4ee0-904a-264b370c3983'),(60,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:16:55','2022-11-16 10:16:55',NULL,'2022-11-16 11:27:42','6109e0ae-6127-4db2-bd24-ff0a3126bc30'),(62,60,NULL,28,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:16:55','2022-11-16 10:16:55',NULL,'2022-11-16 11:27:42','f87b3fcc-46ac-4827-9078-a6a09162b4c3'),(63,29,NULL,29,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:50:33','2022-11-16 10:16:55',NULL,NULL,'84bb0a4d-ac29-42ba-b736-0ebe780327bf'),(65,60,NULL,31,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:16:55','2022-11-16 10:17:10',NULL,'2022-11-16 11:27:42','0801db47-a524-4d19-a696-13181dda474e'),(66,29,NULL,32,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:50:33','2022-11-16 10:17:10',NULL,NULL,'656a0e73-315f-447a-b065-b7fc30284457'),(69,19,NULL,33,30,'craft\\elements\\Entry',1,0,'2022-11-16 10:35:02','2022-11-16 10:35:02',NULL,NULL,'42f130a6-d352-41a4-8ae4-974dd638e971'),(70,23,NULL,34,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:35:02','2022-11-16 10:35:02',NULL,NULL,'22bba141-2947-4b34-a9e1-d0f10cb05c31'),(72,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:26:59','2022-11-16 11:26:59',NULL,'2022-11-16 11:27:03','2b3b9745-e2cf-4ce2-ae3d-a338359aadbe'),(73,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:27:03','2022-11-16 11:27:03',NULL,'2022-11-16 11:27:04','b13b4a08-1908-4bb9-9f2f-b3334095a593'),(74,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:27:04','2022-11-16 11:27:04',NULL,'2022-11-16 11:27:06','0bb53848-d5de-493d-9947-837cf07a7ca4'),(75,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:27:06','2022-11-16 11:27:06',NULL,'2022-11-16 11:27:08','79151d54-3403-4e81-8d10-24c077f300ae'),(76,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:27:08','2022-11-16 11:27:08',NULL,'2022-11-16 11:27:10','768a664b-a799-4a23-bb06-330fb6af8cc5'),(77,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:27:10','2022-11-16 11:27:10',NULL,'2022-11-16 11:27:17','9cad946d-e329-4a39-ac66-7df36ae3fae6'),(79,NULL,NULL,NULL,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:27:17','2022-11-17 04:34:36',NULL,NULL,'faf970d8-967f-4b0b-bbc2-c882dbbeee88'),(80,17,NULL,35,30,'craft\\elements\\Entry',1,0,'2022-11-16 11:27:17','2022-11-16 11:27:17',NULL,NULL,'4dc3bb8e-a92e-4100-91eb-e52ae336aad5'),(81,79,NULL,36,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:27:17','2022-11-16 11:27:17',NULL,NULL,'6c918a0a-cba7-4401-bac4-2d98476b9c98'),(84,29,NULL,38,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 06:50:33','2022-11-16 11:27:42',NULL,NULL,'8915cf1c-5b22-4e88-80fd-ab4e02d1386f'),(88,NULL,NULL,NULL,5,'craft\\elements\\Entry',1,0,'2022-11-16 11:28:12','2022-11-16 11:28:34',NULL,NULL,'e71f30f2-539a-425c-be35-740848f25acd'),(89,88,NULL,39,5,'craft\\elements\\Entry',1,0,'2022-11-16 11:28:34','2022-11-16 11:28:34',NULL,NULL,'4e17f741-1b3b-45a6-8dd1-40f7706d2708'),(90,NULL,NULL,NULL,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 10:44:59',NULL,NULL,'4033fa4e-faba-4ca1-babd-73681d19df1a'),(92,90,NULL,41,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 11:28:51',NULL,NULL,'43d70f2e-29ac-406e-804d-8b9ed448b559'),(93,29,NULL,42,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 11:28:51',NULL,NULL,'2a48744d-d96c-4c37-9839-c9ee19bcaa1e'),(97,90,NULL,44,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:29:07','2022-11-16 11:29:07',NULL,NULL,'2309c0eb-efc2-4bb1-bdcd-6b54ff716997'),(98,29,NULL,45,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 11:29:07',NULL,NULL,'354c81c4-93df-42f2-8957-93bc254b176c'),(100,NULL,NULL,NULL,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:34:54','2022-11-16 11:34:54',NULL,'2022-11-16 11:34:59','c60e7668-d4d8-414f-a741-d049aaccdb6c'),(102,NULL,NULL,NULL,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:35:02','2022-11-17 10:49:11',NULL,NULL,'fe0bda39-0d65-464f-97dd-c6fd954b8f7b'),(104,90,NULL,47,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:29:07','2022-11-16 11:35:02',NULL,NULL,'c9a2bf88-0fe7-481b-b832-eb4fdbadcf88'),(105,102,NULL,48,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:35:02','2022-11-16 11:35:02',NULL,NULL,'dfe0755f-a8a5-4a61-a151-ed33281e3079'),(106,29,NULL,49,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 11:35:02',NULL,NULL,'cc41e400-67b5-4f7b-91c5-04749a038e80'),(110,90,NULL,51,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:37:29','2022-11-16 11:37:29',NULL,NULL,'f5018404-3137-418b-9237-ee4d92e22268'),(111,102,NULL,52,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:35:02','2022-11-16 11:37:29',NULL,NULL,'16d64dbe-c46a-400b-8ab8-bd47cee3c8a9'),(112,29,NULL,53,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 11:37:29',NULL,NULL,'928f7452-0670-44e7-ba7a-d1fecaee57df'),(116,90,NULL,55,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:37:29','2022-11-16 11:37:49',NULL,NULL,'f4ad21f2-be6e-482d-b689-d74cb40d2eb2'),(117,102,NULL,56,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:37:49','2022-11-16 11:37:49',NULL,NULL,'a429cf91-1f77-4188-bd90-d2562b36b4b7'),(118,29,NULL,57,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 11:37:49',NULL,NULL,'2fee0d20-9814-4836-8eac-8b070f833518'),(122,90,NULL,59,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:37:29','2022-11-16 11:39:06',NULL,NULL,'bd5eabdb-8cb1-4903-9f26-85298c4bcd91'),(123,102,NULL,60,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:39:06','2022-11-16 11:39:06',NULL,NULL,'3aae624a-28c6-45a9-81d9-9ca447156cbc'),(124,29,NULL,61,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 11:39:06',NULL,NULL,'89ae4fe5-c101-4002-a146-a9dc5e63218f'),(127,90,NULL,63,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:37:29','2022-11-16 19:08:17',NULL,NULL,'3ea5726f-0175-423a-aaa7-f2596baaac43'),(128,102,NULL,64,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:39:06','2022-11-16 19:08:17',NULL,NULL,'c0ce6197-edc0-46bf-aaa7-133690e026e4'),(129,29,NULL,65,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 19:08:17',NULL,NULL,'513c5d14-4a92-49b0-80cb-5ad0f343c2cf'),(130,NULL,NULL,NULL,34,'craft\\elements\\Entry',1,0,'2022-11-16 20:33:16','2022-11-16 20:33:55',NULL,NULL,'093046be-c863-4204-ade8-6f68b44d84ad'),(131,130,NULL,66,34,'craft\\elements\\Entry',1,0,'2022-11-16 20:33:49','2022-11-16 20:33:49',NULL,NULL,'91a04535-3cdc-4453-8910-bc4c5ce66d4d'),(132,130,NULL,67,34,'craft\\elements\\Entry',1,0,'2022-11-16 20:33:55','2022-11-16 20:33:55',NULL,NULL,'48d029df-bc0a-485b-9c36-03af2385af4e'),(133,NULL,NULL,NULL,34,'craft\\elements\\Entry',1,0,'2022-11-16 20:33:57','2022-11-17 07:54:39',NULL,NULL,'1661ab94-5899-4e5d-a9ae-b6bb053ad312'),(134,133,NULL,68,34,'craft\\elements\\Entry',1,0,'2022-11-16 20:34:27','2022-11-16 20:34:27',NULL,NULL,'3466f05f-fdf2-4e0f-97c3-c0c13f9f128b'),(138,90,NULL,70,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:37:49','2022-11-16 20:37:49',NULL,NULL,'f76cec00-94b1-40ea-b440-0c6f7817935e'),(139,102,NULL,71,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:39:06','2022-11-16 20:37:49',NULL,NULL,'5c00a475-4d30-45d8-9095-363705703a46'),(140,29,NULL,72,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 20:37:49',NULL,NULL,'e731f376-a6a0-440c-9328-5a0732469e58'),(142,90,NULL,74,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:37:49','2022-11-16 20:38:11',NULL,NULL,'14483a3d-332f-4223-8055-a32e77d72ea9'),(143,102,NULL,75,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:39:06','2022-11-16 20:38:11',NULL,NULL,'56d77ab6-c67d-4a5d-a0da-50c1ec8bbfe1'),(144,29,NULL,76,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 20:38:11',NULL,NULL,'257efd4a-5392-4ae6-90cd-b4d0f5abb329'),(145,19,NULL,77,30,'craft\\elements\\Entry',1,0,'2022-11-16 20:38:14','2022-11-16 20:38:14',NULL,NULL,'b6696dac-151c-477b-8c2c-25f01cf3ee52'),(146,23,NULL,78,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:35:02','2022-11-16 20:38:14',NULL,NULL,'869621b1-a1ff-4f49-9f5d-b0a855095cf3'),(148,38,NULL,79,23,'craft\\elements\\Entry',1,0,'2022-11-16 20:46:17','2022-11-16 20:46:17',NULL,NULL,'aca88218-e476-4847-99f5-5f5ce75fb789'),(150,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:46:29','2022-11-16 20:46:29',NULL,'2022-11-16 20:46:32','82cdc1cd-1a47-4ae1-b7d4-cea8b84f834f'),(153,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:46:32','2022-11-16 20:46:32',NULL,NULL,'56e978c6-f70c-4ff0-8d5c-873610dc4241'),(154,38,NULL,80,23,'craft\\elements\\Entry',1,0,'2022-11-16 20:46:32','2022-11-16 20:46:32',NULL,NULL,'444cdf2b-773f-4225-9801-1321d6f60043'),(155,153,NULL,81,16,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:46:32','2022-11-16 20:46:32',NULL,NULL,'f1c302eb-7936-4f2c-a5d1-3557a2d15f09'),(158,90,NULL,83,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:37:49','2022-11-16 21:11:31',NULL,NULL,'62d776cc-6f33-4ab5-a54b-8b10af5bcd6c'),(159,102,NULL,84,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:39:06','2022-11-16 21:11:31',NULL,NULL,'1b60ea74-7294-4909-baea-da55f8e1fbc8'),(160,29,NULL,85,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 21:11:31',NULL,NULL,'dadf47bc-50e2-4024-89e8-b3aa5bbadbc2'),(162,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 21:14:17','2022-11-16 21:14:17',NULL,'2022-11-16 21:14:20','cccf18ff-5597-4f7f-b85b-829ad8bde2fe'),(163,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 21:14:20','2022-11-16 21:14:20',NULL,'2022-11-16 21:14:23','24797c60-b510-4675-a80a-a3ba8a69b77a'),(165,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 21:14:23','2022-11-16 21:20:12',NULL,NULL,'4f9d3869-de7b-49d6-9e2f-64fd117ef7ae'),(166,19,NULL,86,30,'craft\\elements\\Entry',1,0,'2022-11-16 21:14:23','2022-11-16 21:14:23',NULL,NULL,'6623187d-ee60-4f49-bb09-6b38c566c24b'),(167,165,NULL,87,17,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 21:14:23','2022-11-16 21:14:23',NULL,NULL,'3fdbf8c5-6f5e-4d44-8c55-9ce7e6c27bf1'),(168,23,NULL,88,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:35:02','2022-11-16 21:14:23',NULL,NULL,'477abeea-4713-4ec1-8075-d4d4a2ca6758'),(171,19,NULL,89,30,'craft\\elements\\Entry',1,0,'2022-11-16 21:20:12','2022-11-16 21:20:12',NULL,NULL,'d100ddee-ab96-413f-ae67-6e21fe31b209'),(172,165,NULL,90,17,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 21:20:12','2022-11-16 21:20:12',NULL,NULL,'e4b5cf56-286a-494d-99de-c7ecd0b3ceb2'),(173,23,NULL,91,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 10:35:02','2022-11-16 21:20:12',NULL,NULL,'cc47aa9f-97ec-43f7-afdb-4b88e6fbc33f'),(175,26,NULL,92,5,'craft\\elements\\Entry',1,0,'2022-11-16 21:22:04','2022-11-16 21:22:04',NULL,NULL,'bbaa065a-1804-48b8-b84d-24fc340912ec'),(177,26,NULL,93,5,'craft\\elements\\Entry',1,0,'2022-11-16 21:25:43','2022-11-16 21:25:43',NULL,NULL,'6872ec4c-7eca-4b5b-a99c-bd2a58ab2601'),(179,NULL,NULL,NULL,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 22:52:16','2022-11-16 22:52:16',NULL,'2022-11-16 22:52:20','c369bd51-58f7-4c10-aac9-c08bf1030dd5'),(180,NULL,NULL,NULL,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 22:52:20','2022-11-16 22:52:20',NULL,'2022-11-16 22:52:23','d9df4379-9334-4841-8aca-c21e149ec4af'),(181,NULL,NULL,NULL,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 22:52:23','2022-11-16 22:52:23',NULL,'2022-11-16 22:52:26','06d2bca6-3342-4daa-bfed-718ab4e92b51'),(182,NULL,NULL,NULL,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 22:52:26','2022-11-16 22:52:26',NULL,'2022-11-16 22:52:31','ca453a6c-f834-481b-8897-b14cdf950354'),(184,NULL,NULL,NULL,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 22:52:33','2022-11-17 06:10:16',NULL,NULL,'4253da81-8434-4bff-b3ce-d46a8c7e44db'),(185,28,NULL,94,23,'craft\\elements\\Entry',1,0,'2022-11-16 22:52:33','2022-11-16 22:52:33',NULL,NULL,'6368504e-5a8a-43ab-8cf2-aeefc1c27422'),(186,90,NULL,95,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:37:49','2022-11-16 22:52:33',NULL,NULL,'0ebb1ebb-d868-42e7-96c9-28f475b0fb9d'),(187,102,NULL,96,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:39:06','2022-11-16 22:52:33',NULL,NULL,'671d9a7d-ccdc-44ce-bef7-10516b2bde9b'),(188,184,NULL,97,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 22:52:33','2022-11-16 22:52:33',NULL,NULL,'842ba2a2-1fc6-4fc4-9e0e-b5af51df5f14'),(189,29,NULL,98,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-16 22:52:33',NULL,NULL,'3f503b30-4850-4d14-8ef1-ac4fbb2fc3da'),(192,17,NULL,99,30,'craft\\elements\\Entry',1,0,'2022-11-17 04:34:36','2022-11-17 04:34:36',NULL,NULL,'ca3b2a12-ca54-4e4f-af38-de92912c181e'),(193,79,NULL,100,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 04:34:36','2022-11-17 04:34:36',NULL,NULL,'09ce2ac4-f7fe-4337-9527-66b0cd4481ed'),(195,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:12:49','2022-11-17 05:12:49',NULL,'2022-11-17 05:12:52','77316377-d678-4b4c-8683-0c70abf4ae3f'),(196,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:12:52','2022-11-17 05:12:52',NULL,'2022-11-17 05:15:16','6267888b-368d-4acb-8932-df2dfa09fbcb'),(197,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 05:12:52','2022-11-17 05:12:52',NULL,'2022-11-17 05:15:16','3e63110d-1ea5-4530-8ec9-357b8bb1cb43'),(198,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:15:16','2022-11-17 05:15:16',NULL,'2022-11-17 05:15:22','405abd44-8175-472f-8c39-cc7932fe3eed'),(199,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 05:15:16','2022-11-17 05:15:16',NULL,'2022-11-17 05:15:22','c3d09c1a-88eb-4293-9db2-9b82c93d8464'),(200,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:15:22','2022-11-17 05:15:22',NULL,'2022-11-17 05:15:25','f3a50bae-cd68-4bdc-9d68-8a64b5ee1200'),(201,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 05:15:22','2022-11-17 05:15:22',NULL,'2022-11-17 05:15:25','1e461210-bfeb-4c12-86bf-daba15ac99b4'),(204,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 05:17:35','2022-11-17 05:17:35',NULL,'2022-11-17 05:17:38','b9c528d5-8738-47dc-b969-41baae828c51'),(207,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:23:28','2022-11-17 05:23:28',NULL,'2022-11-17 05:23:30','06457df7-f27a-459d-ac66-8ef15fa58f13'),(208,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:23:30','2022-11-17 05:23:30',NULL,'2022-11-17 05:23:34','f414efcc-68ee-4472-bdfe-ce905da86abf'),(209,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 05:23:30','2022-11-17 05:23:30',NULL,'2022-11-17 05:23:34','9d122a8b-4a71-4d35-81b4-efbeac58fb2b'),(210,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:23:34','2022-11-17 05:23:34',NULL,'2022-11-17 05:23:40','717399bd-3954-45fe-b0d1-023d3f8629a5'),(211,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 05:23:34','2022-11-17 05:23:34',NULL,'2022-11-17 05:23:40','0f52bdc2-3e55-4734-8c56-a2086bfdc30e'),(212,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 05:23:34','2022-11-17 05:23:34',NULL,'2022-11-17 05:23:40','593441a8-7aca-4614-a8fe-eac2459ccdb3'),(213,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:23:40','2022-11-17 05:23:40',NULL,'2022-11-17 05:23:42','ddfc5e50-5fa1-46fa-8d8e-6cdce1e0bbfd'),(214,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 05:23:40','2022-11-17 05:23:40',NULL,'2022-11-17 05:23:42','52968ad8-9bd8-4557-9e41-3dc2bf7379dc'),(216,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:23:42','2022-11-17 06:09:47',NULL,'2022-11-17 06:10:16','f2c448d1-1178-4a64-9ce2-30a1571532da'),(217,28,NULL,101,23,'craft\\elements\\Entry',1,0,'2022-11-17 05:23:42','2022-11-17 05:23:42',NULL,NULL,'e13992e7-74b5-42ba-8927-58422c8d47f6'),(218,90,NULL,102,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:37:49','2022-11-17 05:23:42',NULL,NULL,'7b74291e-0af1-4020-9637-d5fbd6d77ab8'),(219,216,NULL,103,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:23:42','2022-11-17 05:23:42',NULL,'2022-11-17 06:10:16','7ac56bb8-fbc5-4cb5-a195-b4bfb3d66b1b'),(220,102,NULL,104,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:39:06','2022-11-17 05:23:42',NULL,NULL,'b4190322-d9f6-40c7-97c7-f8e7f2ee3b26'),(221,184,NULL,105,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 22:52:33','2022-11-17 05:23:42',NULL,NULL,'b9349b0e-e34f-49b0-8b9f-6638142cc00b'),(222,29,NULL,106,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 05:23:42',NULL,NULL,'c391a5d6-bc69-4f61-9d22-a6c795c0dafd'),(225,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 05:24:09','2022-11-17 05:24:09',NULL,'2022-11-17 05:24:17','08a00398-dd88-4cf3-b2d3-64eda0b49bfc'),(228,NULL,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:58:43','2022-11-17 05:58:43',NULL,'2022-11-17 05:58:48','664e4c32-c1f3-4ef2-a838-f97395460d2f'),(229,NULL,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:58:48','2022-11-17 05:58:48',NULL,'2022-11-17 05:58:52','089fa525-91c2-48d9-b301-396fceb14806'),(230,NULL,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:58:52','2022-11-17 05:58:52',NULL,'2022-11-17 05:59:00','f799f681-1fdf-4a12-8930-3261be8e66e9'),(231,NULL,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:59:00','2022-11-17 05:59:00',NULL,'2022-11-17 05:59:02','bfa21125-3ab6-4f00-abe2-815448cd5581'),(233,NULL,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:59:06','2022-11-17 05:59:06',NULL,NULL,'a382d08c-b8f3-4449-9ab3-9c98700c0172'),(234,17,NULL,107,30,'craft\\elements\\Entry',1,0,'2022-11-17 05:59:06','2022-11-17 05:59:06',NULL,NULL,'5d3de124-770f-4480-9c70-5fa4a04eaaf5'),(235,79,NULL,108,21,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 04:34:36','2022-11-17 05:59:06',NULL,NULL,'853e0d61-bad5-4e7f-8cc4-cbe3f7fadc87'),(236,233,NULL,109,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 05:59:06','2022-11-17 05:59:06',NULL,NULL,'321f624e-4215-497b-ab6a-fe993669e4e7'),(239,19,NULL,110,30,'craft\\elements\\Entry',1,0,'2022-11-17 06:06:58','2022-11-17 06:06:58',NULL,NULL,'417c206c-e02b-4ff2-84bc-8b7716c72066'),(240,165,NULL,111,17,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 21:20:12','2022-11-17 06:06:58',NULL,NULL,'d2dbae3b-b59e-47c8-83e6-30c400d54c70'),(241,23,NULL,112,9,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 06:06:58','2022-11-17 06:06:58',NULL,NULL,'88348fdc-e727-4698-8005-91b556f4478b'),(242,NULL,NULL,NULL,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 06:09:47','2022-11-17 06:09:47',NULL,'2022-11-17 06:10:16','01424a76-2b3c-4b96-99b7-ee1d33f1246a'),(243,28,NULL,113,23,'craft\\elements\\Entry',1,0,'2022-11-17 06:09:47','2022-11-17 06:09:47',NULL,NULL,'e45ae856-2195-46ff-b48d-dc495f761745'),(244,90,NULL,114,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:37:49','2022-11-17 06:09:47',NULL,NULL,'96089198-f61b-4a0d-94ae-278cef34d826'),(245,216,NULL,115,2,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 06:09:47','2022-11-17 06:09:47',NULL,'2022-11-17 06:10:16','994aac72-8152-4176-8075-43d147692238'),(246,242,NULL,116,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2022-11-17 06:09:47','2022-11-17 06:09:47',NULL,'2022-11-17 06:10:16','71ac5e06-37aa-46b3-a935-b01b5d6e1b72'),(247,102,NULL,117,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:39:06','2022-11-17 06:09:47',NULL,NULL,'fb7e5d81-9e52-43af-ba0d-211421a1d448'),(248,184,NULL,118,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 22:52:33','2022-11-17 06:09:47',NULL,NULL,'8a49fbac-c271-465d-85d8-77727f842170'),(249,29,NULL,119,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 06:09:47',NULL,NULL,'45c54ab7-ae71-490f-bdbd-63d495609e7d'),(252,28,NULL,120,23,'craft\\elements\\Entry',1,0,'2022-11-17 06:10:16','2022-11-17 06:10:16',NULL,NULL,'545e364f-cf6d-4852-89a8-d94cb91f762c'),(253,90,NULL,121,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:37:49','2022-11-17 06:10:16',NULL,NULL,'98ddd414-abc8-43be-98df-3b5f050240cb'),(254,102,NULL,122,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:39:06','2022-11-17 06:10:16',NULL,NULL,'e293ca41-7ba0-412b-8a17-7b0bc060c6d4'),(255,184,NULL,123,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 06:10:16','2022-11-17 06:10:16',NULL,NULL,'20a92cf8-8f8f-45d3-a2bf-e9170fab35fe'),(256,29,NULL,124,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 06:10:16',NULL,NULL,'32f95663-a4d2-41e4-b9e3-7f58010ed18a'),(258,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 07:44:47','2022-11-17 07:44:47',NULL,'2022-11-17 07:45:09','750c81b7-b8ed-4b30-bbfe-cb48896d44c1'),(260,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 07:45:17','2022-11-17 07:54:39',NULL,NULL,'f93359d5-5cb0-414f-9f95-127cd957773c'),(261,133,NULL,125,34,'craft\\elements\\Entry',1,0,'2022-11-17 07:45:17','2022-11-17 07:45:17',NULL,NULL,'48ebf91c-d770-4f67-a4cd-c98fe632bc43'),(262,260,NULL,126,16,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 07:45:17','2022-11-17 07:45:17',NULL,NULL,'98d057da-2806-4528-87c6-ba083bf9581b'),(265,133,NULL,127,34,'craft\\elements\\Entry',1,0,'2022-11-17 07:54:39','2022-11-17 07:54:40',NULL,NULL,'9e3d909c-e168-4e1f-834a-93591fe32b29'),(266,260,NULL,128,16,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 07:54:39','2022-11-17 07:54:40',NULL,NULL,'2378268e-8ebf-4a1c-bab3-a8c143ee4472'),(269,28,NULL,129,23,'craft\\elements\\Entry',1,0,'2022-11-17 10:02:11','2022-11-17 10:02:11',NULL,NULL,'1dbf6577-a416-460f-bc9d-cdfad3d9bcaa'),(270,90,NULL,130,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 20:37:49','2022-11-17 10:02:11',NULL,NULL,'993bdae6-a774-4e4d-901a-5ac62b2a501b'),(271,102,NULL,131,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:02:11','2022-11-17 10:02:11',NULL,NULL,'407ee66d-bcf8-4518-a091-3002822c07a3'),(272,184,NULL,132,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 06:10:16','2022-11-17 10:02:11',NULL,NULL,'97a36291-9266-4104-9ff0-b117aef12b43'),(273,29,NULL,133,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 10:02:11',NULL,NULL,'4788383c-d03c-4097-b225-5e4a159c27c6'),(276,28,NULL,134,23,'craft\\elements\\Entry',1,0,'2022-11-17 10:21:55','2022-11-17 10:21:55',NULL,NULL,'f12d025b-99b4-4fe4-a1cf-dd330a7852ea'),(277,90,NULL,135,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:21:55','2022-11-17 10:21:55',NULL,NULL,'f80331fd-368e-4195-89c2-fcebb457d724'),(278,102,NULL,136,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:02:11','2022-11-17 10:21:55',NULL,NULL,'6fda3b49-d795-4913-bf85-d06a6fb790b8'),(279,184,NULL,137,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 06:10:16','2022-11-17 10:21:55',NULL,NULL,'ad4fcdbb-317b-4edf-8b5d-5a74df10195b'),(280,29,NULL,138,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 10:21:55',NULL,NULL,'c7a203f8-edea-431d-af60-a3cae380803c'),(283,28,NULL,139,23,'craft\\elements\\Entry',1,0,'2022-11-17 10:36:54','2022-11-17 10:36:54',NULL,NULL,'ae57f5ff-d25c-4a13-bdf1-501cb3e19f0d'),(284,90,NULL,140,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:36:54','2022-11-17 10:36:54',NULL,NULL,'b6f0f9c7-fedf-475e-889c-36fcb2b2225d'),(285,102,NULL,141,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:02:11','2022-11-17 10:36:54',NULL,NULL,'02a3f4c0-49f3-40b7-bea0-bf991af95d1b'),(286,184,NULL,142,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 06:10:16','2022-11-17 10:36:54',NULL,NULL,'da13ef75-c2e0-4dab-95cc-d2b0d71655c9'),(287,29,NULL,143,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 10:36:54',NULL,NULL,'02036aa7-6b83-4f6d-ba98-74ea34dd03f6'),(290,28,NULL,144,23,'craft\\elements\\Entry',1,0,'2022-11-17 10:37:11','2022-11-17 10:37:11',NULL,NULL,'cb6b22cc-5dea-4933-bb70-cc280381caa9'),(291,90,NULL,145,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:36:54','2022-11-17 10:37:11',NULL,NULL,'397d1caa-964f-4668-ae65-e62e3467139d'),(292,102,NULL,146,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:37:11','2022-11-17 10:37:11',NULL,NULL,'24da5f5f-0609-4f57-b990-50dabbd3f390'),(293,184,NULL,147,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 06:10:16','2022-11-17 10:37:11',NULL,NULL,'09d9e553-c0b1-41a3-b581-a71176e66575'),(294,29,NULL,148,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 10:37:11',NULL,NULL,'cd0b87dd-af40-4c89-b17e-6967bebdfb7a'),(297,28,NULL,149,23,'craft\\elements\\Entry',1,0,'2022-11-17 10:44:59','2022-11-17 10:44:59',NULL,NULL,'2487a72d-ffbf-4f57-8673-e75fad613d23'),(298,90,NULL,150,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:44:59','2022-11-17 10:44:59',NULL,NULL,'ea138e1f-ad8b-447a-8a79-a42a91c5d234'),(299,102,NULL,151,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:37:11','2022-11-17 10:44:59',NULL,NULL,'5d484285-61d5-4c81-a0bf-549d42581130'),(300,184,NULL,152,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 06:10:16','2022-11-17 10:44:59',NULL,NULL,'6a26fb59-afe4-4c7f-ab77-a02e1684b0fd'),(301,29,NULL,153,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 10:44:59',NULL,NULL,'4b54babc-5148-419e-84fd-970ada4a7721'),(304,28,NULL,154,23,'craft\\elements\\Entry',1,0,'2022-11-17 10:49:11','2022-11-17 10:49:11',NULL,NULL,'286fbd83-136a-4f95-bfef-2d726ae38ecd'),(305,90,NULL,155,19,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:44:59','2022-11-17 10:49:11',NULL,NULL,'c4b7c29e-8294-44a4-9e09-559d2f708a8d'),(306,102,NULL,156,15,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 10:49:11','2022-11-17 10:49:11',NULL,NULL,'84fdc241-301c-473c-a966-d6e441c8a50d'),(307,184,NULL,157,43,'craft\\elements\\MatrixBlock',1,0,'2022-11-17 06:10:16','2022-11-17 10:49:11',NULL,NULL,'de522d60-26a9-46de-9c88-d09707c5c936'),(308,29,NULL,158,20,'craft\\elements\\MatrixBlock',1,0,'2022-11-16 11:28:51','2022-11-17 10:49:11',NULL,NULL,'3b1c27ff-c33b-4fd0-ac62-c04ebd3582b5');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,'alert-message',NULL,1,'2022-11-16 06:42:36','2022-11-16 06:42:36','f128276e-da20-4ac8-8bf5-9c5f9af1f7be'),(2,2,1,'alert-message',NULL,1,'2022-11-16 06:42:36','2022-11-16 06:42:36','8014e8ec-19d4-47ca-8322-2bb2cf84236a'),(3,3,1,'alert-message',NULL,1,'2022-11-16 06:42:36','2022-11-16 06:42:36','43c106a7-b09a-4731-9e8d-478f2e7978b2'),(4,4,1,'error-404',NULL,1,'2022-11-16 06:42:36','2022-11-16 06:42:36','db60695f-2b13-4a3d-84d3-298604233930'),(5,5,1,'error-404',NULL,1,'2022-11-16 06:42:36','2022-11-16 06:42:36','0e49e1cf-c3f9-43a0-ba2e-95b7ff16b161'),(6,6,1,'error-404',NULL,1,'2022-11-16 06:42:36','2022-11-16 06:42:36','95d6c539-7077-4d9b-a407-e9ed118e14e4'),(7,7,1,'search','search',1,'2022-11-16 06:42:36','2022-11-16 06:42:36','055e7aa4-3cd1-462d-b93f-1b32ae989eb0'),(8,8,1,'search','search',1,'2022-11-16 06:42:36','2022-11-16 06:42:36','8e51209f-96c9-4cc5-9405-d83722fdf627'),(9,9,1,'search','search',1,'2022-11-16 06:42:37','2022-11-16 06:42:37','300b82cc-e0ae-4a80-925e-c1027381b409'),(10,10,1,'alert-message',NULL,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','e95ecc0d-ff8e-4635-8dbd-688aeb9b9fc0'),(11,11,1,'alert-message',NULL,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','f0bda2b3-d58d-4c53-a2c5-2ec1c481b515'),(12,12,1,'error-404',NULL,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','0a055f60-f607-4b44-b49a-5f0e57eee19f'),(13,13,1,'error-404',NULL,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','e2d87fc8-a8c0-4b8c-b909-e1f1674c5250'),(14,14,1,'search','search',1,'2022-11-16 06:42:52','2022-11-16 06:42:52','97368fb6-2054-416f-b2e9-2c3ba31162c9'),(15,15,1,'search','search',1,'2022-11-16 06:42:52','2022-11-16 06:42:52','d6af7fa7-5f8a-45d4-a4e4-dec46c0b916c'),(16,16,1,NULL,NULL,1,'2022-11-16 06:42:55','2022-11-16 06:42:55','bad8249e-3057-4dfa-a350-6a5c3415856a'),(17,17,1,'__home__','__home__',1,'2022-11-16 06:48:22','2022-11-16 06:48:31','37e0ec66-f15f-4ca4-a033-8bed7fe4561d'),(18,18,1,'__home__','__home__',1,'2022-11-16 06:48:32','2022-11-16 06:48:32','4a1dd613-0a66-4e4e-b44f-1598e5e6416e'),(19,19,1,'news','news',1,'2022-11-16 06:48:39','2022-11-16 06:48:42','375b0e2e-79fd-41cc-9588-090c6f88fbef'),(20,20,1,NULL,NULL,1,'2022-11-16 06:48:47','2022-11-16 06:48:47','ddc9e7ac-62dc-4ea5-ac7d-199aad32156d'),(21,21,1,NULL,NULL,1,'2022-11-16 06:48:49','2022-11-16 06:48:49','068c08b4-76b9-4b43-8005-4b9841038cf8'),(22,22,1,NULL,NULL,1,'2022-11-16 06:48:57','2022-11-16 06:48:57','3424db3b-c998-4fba-aa91-6af8b8b8cb99'),(23,23,1,NULL,NULL,1,'2022-11-16 06:48:59','2022-11-16 06:48:59','ff2e5c1a-2832-4f5b-9b2d-ed49c9ce568e'),(24,24,1,'news','news',1,'2022-11-16 06:49:25','2022-11-16 06:49:25','0350dcb5-7787-42bb-a078-8dd7165d5ae1'),(25,25,1,NULL,NULL,1,'2022-11-16 06:49:25','2022-11-16 06:49:25','6c9979fa-5307-4121-b149-fbca73c95aa5'),(26,26,1,'newsletter-subscribe','fragments/newsletter-subscribe',1,'2022-11-16 06:49:52','2022-11-16 08:01:18','f3370ade-96a5-4ee8-a07a-e9c25f5b5798'),(27,27,1,'newsletter-sign-up','fragments/newsletter-sign-up',1,'2022-11-16 06:50:19','2022-11-16 06:50:19','050255b6-9784-4827-a7e1-88696f8c3942'),(28,28,1,'contact','contact',1,'2022-11-16 06:50:23','2022-11-16 19:08:17','b2fa1adb-8c8a-4b1d-987e-f767a6741676'),(29,29,1,NULL,NULL,1,'2022-11-16 06:50:33','2022-11-16 06:50:33','fbdfcd7c-5964-4233-8aa0-3ebd3b98b35d'),(31,31,1,NULL,NULL,1,'2022-11-16 06:50:37','2022-11-16 06:50:37','36dd264c-745a-4899-a88a-b91917e6d0a3'),(33,33,1,NULL,NULL,1,'2022-11-16 06:50:46','2022-11-16 06:50:46','ee40f26d-bb05-4851-ab25-560006e75ff8'),(34,34,1,NULL,NULL,1,'2022-11-16 06:51:38','2022-11-16 06:51:38','397a8955-ccde-4f72-a534-46c19f2fae86'),(35,35,1,NULL,NULL,1,'2022-11-16 06:52:08','2022-11-16 06:52:08','87d33270-9a6f-4d73-bcc0-07a655ae9259'),(37,37,1,'newsletter-subscribe','fragments/newsletter-subscribe',1,'2022-11-16 08:01:18','2022-11-16 08:01:18','33b017d6-d2a2-410a-88b5-58c6ab48de98'),(38,38,1,'privacy','privacy',1,'2022-11-16 09:56:14','2022-11-16 09:56:46','5701e8cb-2eac-43de-9091-f97043b7bbd8'),(39,39,1,'privacy-policy','privacy-policy',1,'2022-11-16 09:56:25','2022-11-16 09:56:25','950070db-8a17-437a-89e4-82911ec8d458'),(41,41,1,'privacy','privacy',1,'2022-11-16 09:56:46','2022-11-16 09:56:46','1725a1c3-1040-4674-9ab0-4ab2d9c27282'),(42,42,1,'1',NULL,1,'2022-11-16 09:57:13','2022-11-16 09:57:21','f492866d-7154-4de9-9d97-83f6f3109173'),(43,43,1,'1',NULL,1,'2022-11-16 09:57:18','2022-11-16 09:57:21','7e1876ce-1dd0-4944-b414-42373ce6953e'),(44,44,1,'1',NULL,1,'2022-11-16 09:57:31','2022-11-16 09:57:42','a4e11cdf-b25a-4879-9e1b-58844095ae1e'),(45,44,2,'1',NULL,1,'2022-11-16 09:57:31','2022-11-16 09:57:42','c892ceda-98a1-4418-aae7-ab41776ca58a'),(46,45,1,'1',NULL,1,'2022-11-16 09:57:34','2022-11-16 09:57:42','b584eb08-2926-48a0-bba4-79e27e847b55'),(47,45,2,'1',NULL,1,'2022-11-16 09:57:34','2022-11-16 09:57:42','f9a68e2b-7b2e-4901-8a00-9ca4f251df9f'),(48,46,1,'1',NULL,1,'2022-11-16 09:57:36','2022-11-16 09:57:42','ccb2667a-0520-4aaa-8b6a-17ae58d8ee29'),(49,46,2,'1',NULL,1,'2022-11-16 09:57:36','2022-11-16 09:57:42','a8e97251-2f2d-4442-a507-a5d776a9d521'),(50,47,1,'a-news-story','news/a-news-story',1,'2022-11-16 10:07:00','2022-11-16 10:07:53','5ab841b0-926f-4c12-828e-6a44bd305c91'),(51,48,1,'a-news-story','news/a-news-story',1,'2022-11-16 10:07:53','2022-11-16 10:07:53','f8018c37-9c2f-4030-8c8f-1e776aa703ed'),(53,50,1,'a-news-story','news/a-news-story',1,'2022-11-16 10:08:43','2022-11-16 10:08:43','22f1d088-a4a4-4555-b968-af45f84a7d2f'),(55,52,1,'a-news-story','news/a-news-story',1,'2022-11-16 10:09:34','2022-11-16 10:09:34','f7b082af-610a-4900-9477-ff4faeb0d6df'),(57,54,1,NULL,NULL,1,'2022-11-16 10:10:20','2022-11-16 10:10:20','06e99efc-5c31-4adf-9138-1d8a9ca2181e'),(58,55,1,NULL,NULL,1,'2022-11-16 10:16:29','2022-11-16 10:16:29','a4ef6c67-0185-4cdd-8bc1-37fd213edb48'),(59,56,1,NULL,NULL,1,'2022-11-16 10:16:37','2022-11-16 10:16:37','2170e3c0-da65-4c4e-ae3f-58e78e3cb28b'),(60,57,1,NULL,NULL,1,'2022-11-16 10:16:42','2022-11-16 10:16:42','85efd5c4-8638-414f-b93b-e499750bb6b4'),(61,58,1,NULL,NULL,1,'2022-11-16 10:16:43','2022-11-16 10:16:43','beb5a56f-4d6b-4cd7-b648-85cb6b080eae'),(63,60,1,NULL,NULL,1,'2022-11-16 10:16:55','2022-11-16 10:16:55','e148fd8c-3d7e-437d-b526-2991fd2e3757'),(65,62,1,NULL,NULL,1,'2022-11-16 10:16:55','2022-11-16 10:16:55','8718d0a6-7424-4c2e-a378-5dfd6b7a1cb6'),(66,63,1,NULL,NULL,1,'2022-11-16 10:16:55','2022-11-16 10:16:55','250e19f2-ce77-4722-96ea-0aa795d4983a'),(68,65,1,NULL,NULL,1,'2022-11-16 10:17:10','2022-11-16 10:17:10','6a3e2dae-33f0-4052-ab72-fd6071bd301a'),(69,66,1,NULL,NULL,1,'2022-11-16 10:17:10','2022-11-16 10:17:10','e69ca5b6-5369-4bd7-9fdf-d7019d5719e1'),(72,69,1,'news','news',1,'2022-11-16 10:35:02','2022-11-16 10:35:02','480efb4c-13ab-47d9-a4c6-87141ac25274'),(73,70,1,NULL,NULL,1,'2022-11-16 10:35:02','2022-11-16 10:35:02','e3ec5bb4-f237-4386-b705-96f9c54f9cd3'),(75,72,1,NULL,NULL,1,'2022-11-16 11:26:59','2022-11-16 11:26:59','5dffa268-ce07-420b-a93c-4f722720e879'),(76,73,1,NULL,NULL,1,'2022-11-16 11:27:03','2022-11-16 11:27:03','ab957e86-ab47-4d38-b870-509d2ec546bc'),(77,74,1,NULL,NULL,1,'2022-11-16 11:27:04','2022-11-16 11:27:04','f4ecd063-113c-4849-b970-9874a3a9f814'),(78,75,1,NULL,NULL,1,'2022-11-16 11:27:06','2022-11-16 11:27:06','fb9ac80b-e332-4e8c-9908-588ecd6b4136'),(79,76,1,NULL,NULL,1,'2022-11-16 11:27:08','2022-11-16 11:27:08','52e43403-a006-4704-8bd8-c0d6fc989220'),(80,77,1,NULL,NULL,1,'2022-11-16 11:27:10','2022-11-16 11:27:10','7228ed87-415c-4db7-ba95-904a44718379'),(82,79,1,NULL,NULL,1,'2022-11-16 11:27:17','2022-11-16 11:27:17','cee1cdbe-bc7d-473d-9acd-97cc38680dc0'),(83,80,1,'__home__','__home__',1,'2022-11-16 11:27:17','2022-11-16 11:27:17','a5bab73a-9fd6-4b43-a81f-3fe6943664c1'),(84,81,1,NULL,NULL,1,'2022-11-16 11:27:17','2022-11-16 11:27:17','347c7fc9-5c63-4ac9-a0f1-01d32a8360ea'),(87,84,1,NULL,NULL,1,'2022-11-16 11:27:42','2022-11-16 11:27:42','f6169959-6572-4f18-ac8b-f82d9e43b822'),(91,88,1,'common-chunk','fragments/common-chunk',1,'2022-11-16 11:28:12','2022-11-16 11:28:32','8882cfec-ebed-41e7-b6a1-8f4230f45ba2'),(92,89,1,'common-chunk','fragments/common-chunk',1,'2022-11-16 11:28:34','2022-11-16 11:28:34','6639de11-4b98-44f5-bcd6-7ba24b9c4519'),(93,90,1,NULL,NULL,1,'2022-11-16 11:28:51','2022-11-16 11:28:51','64e988b5-8d12-4e24-8a99-37470ac115db'),(95,92,1,NULL,NULL,1,'2022-11-16 11:28:51','2022-11-16 11:28:51','fb60a5ab-4045-4b87-b5dc-c88f51549e90'),(96,93,1,NULL,NULL,1,'2022-11-16 11:28:51','2022-11-16 11:28:51','ee8097b7-f4c3-4459-bb72-54a0e40c2608'),(100,97,1,NULL,NULL,1,'2022-11-16 11:29:07','2022-11-16 11:29:07','d8f1734a-b8ad-4f61-939a-5e57002db2ae'),(101,98,1,NULL,NULL,1,'2022-11-16 11:29:07','2022-11-16 11:29:07','f93dd9e9-0af0-4b99-a82e-8efcddb9819d'),(103,100,1,NULL,NULL,1,'2022-11-16 11:34:54','2022-11-16 11:34:54','fbec0a3d-a545-4681-8ec5-559f0b079a73'),(105,102,1,NULL,NULL,1,'2022-11-16 11:35:02','2022-11-16 11:35:02','b764bfbb-026b-491c-9d3d-cda52d15016d'),(107,104,1,NULL,NULL,1,'2022-11-16 11:35:02','2022-11-16 11:35:02','1af7092d-51e8-4934-a137-1e38c3d231bc'),(108,105,1,NULL,NULL,1,'2022-11-16 11:35:02','2022-11-16 11:35:02','53ffe1a1-0b10-45b4-b11c-22ef1cbe0a92'),(109,106,1,NULL,NULL,1,'2022-11-16 11:35:02','2022-11-16 11:35:02','450f75f6-c881-452b-955c-f188443a9936'),(113,110,1,NULL,NULL,1,'2022-11-16 11:37:29','2022-11-16 11:37:29','d4410010-5e0f-48fa-8fb0-0c5a41662612'),(114,111,1,NULL,NULL,1,'2022-11-16 11:37:29','2022-11-16 11:37:29','d474e746-5107-4fe8-9727-efd6251e456a'),(115,112,1,NULL,NULL,1,'2022-11-16 11:37:29','2022-11-16 11:37:29','bf83d7bc-e280-4621-9954-e4f989699a25'),(119,116,1,NULL,NULL,1,'2022-11-16 11:37:49','2022-11-16 11:37:49','716317ee-94cf-4d9c-a74f-c3a92c793a9f'),(120,117,1,NULL,NULL,1,'2022-11-16 11:37:49','2022-11-16 11:37:49','fe9df869-34b3-4b38-bd64-ee3eb007eda2'),(121,118,1,NULL,NULL,1,'2022-11-16 11:37:49','2022-11-16 11:37:49','93dc617c-9f7e-4721-837f-142c45d2a379'),(125,122,1,NULL,NULL,1,'2022-11-16 11:39:06','2022-11-16 11:39:06','249af72c-8a60-4d34-ad00-7f87b9ab5da5'),(126,123,1,NULL,NULL,1,'2022-11-16 11:39:06','2022-11-16 11:39:06','896f7a37-cda1-43b4-bb59-d6246a1e081b'),(127,124,1,NULL,NULL,1,'2022-11-16 11:39:06','2022-11-16 11:39:06','55e63e43-5e9e-4220-9778-61bb89804bea'),(130,127,1,NULL,NULL,1,'2022-11-16 19:08:17','2022-11-16 19:08:17','fa69a1b4-006e-4dba-a4e3-b0bd87ed0dee'),(131,128,1,NULL,NULL,1,'2022-11-16 19:08:17','2022-11-16 19:08:17','b72a69af-c5f5-40cf-a4b9-2d56202d56e8'),(132,129,1,NULL,NULL,1,'2022-11-16 19:08:17','2022-11-16 19:08:17','dcf9f1e5-aad3-42c9-aba7-4d7414c7c43e'),(133,130,1,'news-story','news/news-story',1,'2022-11-16 20:33:16','2022-11-16 20:33:22','f6dc5f70-c05f-427c-8f4c-24cb61c464ac'),(134,131,1,'news-story','news/news-story',1,'2022-11-16 20:33:49','2022-11-16 20:33:49','728c7eba-8823-410a-b7f3-797c569acaab'),(135,132,1,'news-story','news/news-story',1,'2022-11-16 20:33:55','2022-11-16 20:33:55','3c9b0081-9af0-4bca-a1ee-375cc8401dcb'),(136,133,1,'news-story-with-a-much-longer-title-than-you-might-normally-expect','news/news-story-with-a-much-longer-title-than-you-might-normally-expect',1,'2022-11-16 20:33:57','2022-11-16 20:34:12','409a08c9-d871-40d5-ac5a-684820bf67b8'),(137,134,1,'news-story-with-a-much-longer-title-than-you-might-normally-expect','news/news-story-with-a-much-longer-title-than-you-might-normally-expect',1,'2022-11-16 20:34:27','2022-11-16 20:34:27','6cb47bc6-2a7b-4b87-916f-a9576a22c382'),(141,138,1,NULL,NULL,1,'2022-11-16 20:37:49','2022-11-16 20:37:49','5ff07816-5a72-44d1-bc74-3f72811b89d9'),(142,139,1,NULL,NULL,1,'2022-11-16 20:37:49','2022-11-16 20:37:49','dd92169f-a455-4f90-a31e-0baa06265718'),(143,140,1,NULL,NULL,1,'2022-11-16 20:37:49','2022-11-16 20:37:49','d1b6c620-0c3d-4334-b25d-09aab3ab8bf8'),(145,142,1,NULL,NULL,1,'2022-11-16 20:38:11','2022-11-16 20:38:11','fdf3a5ee-a5ac-4a2a-a6e1-15096f99660a'),(146,143,1,NULL,NULL,1,'2022-11-16 20:38:11','2022-11-16 20:38:11','d8265d6c-e3b2-4038-aa41-f3ec3e042bbe'),(147,144,1,NULL,NULL,1,'2022-11-16 20:38:11','2022-11-16 20:38:11','67768a4e-4959-45f4-b76d-3879632aa49e'),(148,145,1,'news','news',1,'2022-11-16 20:38:14','2022-11-16 20:38:14','3a5c3154-fd47-4016-b7b0-9b5a3e3e0c1c'),(149,146,1,NULL,NULL,1,'2022-11-16 20:38:14','2022-11-16 20:38:14','8443007a-66ee-485b-b7ae-0dd449c0ab28'),(151,148,1,'privacy','privacy',1,'2022-11-16 20:46:17','2022-11-16 20:46:17','b6a5f49f-d0fc-4e04-a347-6e40a93133d0'),(153,150,1,NULL,NULL,1,'2022-11-16 20:46:29','2022-11-16 20:46:29','04c2be37-587e-41ee-934f-e6b0be4f1b3e'),(156,153,1,NULL,NULL,1,'2022-11-16 20:46:32','2022-11-16 20:46:32','14d6de5c-0e0c-423d-a90e-b87c791d7e15'),(157,154,1,'privacy','privacy',1,'2022-11-16 20:46:32','2022-11-16 20:46:32','bd33025a-e017-47e9-b196-a859b944c8fc'),(158,155,1,NULL,NULL,1,'2022-11-16 20:46:32','2022-11-16 20:46:32','87e9d539-187a-4d8e-9e01-2f1b249c002b'),(161,158,1,NULL,NULL,1,'2022-11-16 21:11:31','2022-11-16 21:11:31','bb1db626-3a6b-4240-aaf8-1673a4c59604'),(162,159,1,NULL,NULL,1,'2022-11-16 21:11:31','2022-11-16 21:11:31','f2d41303-9a6b-4702-be0f-33123de4bfcf'),(163,160,1,NULL,NULL,1,'2022-11-16 21:11:31','2022-11-16 21:11:31','69952782-c40c-4b63-986d-a05c0cf1b1dd'),(165,162,1,NULL,NULL,1,'2022-11-16 21:14:17','2022-11-16 21:14:17','ead930b1-8bb0-4820-94d7-6c087884ce82'),(166,163,1,NULL,NULL,1,'2022-11-16 21:14:20','2022-11-16 21:14:20','544a1864-ecea-43a4-a206-5f68003cfc45'),(168,165,1,NULL,NULL,1,'2022-11-16 21:14:23','2022-11-16 21:14:23','a3cbde59-242d-4453-a7be-a24c0c874bab'),(169,166,1,'news','news',1,'2022-11-16 21:14:23','2022-11-16 21:14:23','95e27576-6587-4b63-80ea-fd637b0c187b'),(170,167,1,NULL,NULL,1,'2022-11-16 21:14:23','2022-11-16 21:14:23','facbccda-08e3-4cc3-bc1e-9c339fa074bb'),(171,168,1,NULL,NULL,1,'2022-11-16 21:14:23','2022-11-16 21:14:23','beb361d9-d298-4e3b-aedd-b54a9fefd219'),(174,171,1,'news','news',1,'2022-11-16 21:20:12','2022-11-16 21:20:12','d06ac4fd-63c0-4b63-9d6c-0bb552b4223c'),(175,172,1,NULL,NULL,1,'2022-11-16 21:20:12','2022-11-16 21:20:12','84b4439b-3e38-4f97-8de3-ec8e45a9edf8'),(176,173,1,NULL,NULL,1,'2022-11-16 21:20:12','2022-11-16 21:20:12','5bdc5b93-52f6-46be-bec2-e6f90d43092d'),(178,175,1,'newsletter-subscribe','fragments/newsletter-subscribe',1,'2022-11-16 21:22:04','2022-11-16 21:22:04','5ce3c185-c552-4e0f-bdbc-9c8a21304c3e'),(180,177,1,'newsletter-subscribe','fragments/newsletter-subscribe',1,'2022-11-16 21:25:43','2022-11-16 21:25:43','18251168-cc71-4019-b593-3b88a2573cde'),(182,179,1,NULL,NULL,1,'2022-11-16 22:52:16','2022-11-16 22:52:16','adc8d696-b52c-4bf0-a8c3-8ac182b71f7e'),(183,180,1,NULL,NULL,1,'2022-11-16 22:52:20','2022-11-16 22:52:20','09b30d95-0e61-413c-8b83-fd41c8495f19'),(184,181,1,NULL,NULL,1,'2022-11-16 22:52:23','2022-11-16 22:52:23','a4814dc0-ee78-4950-a86d-eeddb425f88b'),(185,182,1,NULL,NULL,1,'2022-11-16 22:52:26','2022-11-16 22:52:26','2a3a2fb8-fe3d-4397-a532-b5cd22a99805'),(187,184,1,NULL,NULL,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','d4ed9e04-7979-4252-a092-29736d9dce88'),(188,185,1,'contact','contact',1,'2022-11-16 22:52:33','2022-11-16 22:52:33','f93357cd-ac9e-47da-ad73-7929c7188c20'),(189,186,1,NULL,NULL,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','a50d72bf-9461-48ec-a0ea-4b7691f6c049'),(190,187,1,NULL,NULL,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','923ba6be-22a5-4474-83e1-078a5627f3ca'),(191,188,1,NULL,NULL,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','86849a48-ca9f-4bb7-aadd-fdda6fbf65e7'),(192,189,1,NULL,NULL,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','e2334f8d-ef74-4184-8d2f-2fa78b59ddf2'),(195,192,1,'__home__','__home__',1,'2022-11-17 04:34:36','2022-11-17 04:34:36','9eb0ca66-a2f5-41d3-8a92-2ec3dfa62d71'),(196,193,1,NULL,NULL,1,'2022-11-17 04:34:36','2022-11-17 04:34:36','df663f1c-f6f3-463f-ba7b-8f02415eefac'),(198,195,1,NULL,NULL,1,'2022-11-17 05:12:49','2022-11-17 05:12:49','86a241c7-a638-462b-952f-c39ddd03fd8d'),(199,196,1,NULL,NULL,1,'2022-11-17 05:12:52','2022-11-17 05:12:52','6ea84116-9a54-4bb9-98e3-71d567349096'),(200,197,1,NULL,NULL,1,'2022-11-17 05:12:52','2022-11-17 05:12:52','2aac5094-5bf2-48c9-993a-c6d28b792451'),(201,198,1,NULL,NULL,1,'2022-11-17 05:15:16','2022-11-17 05:15:16','3cd47d49-9991-48e0-8af1-01ddca068dee'),(202,199,1,NULL,NULL,1,'2022-11-17 05:15:16','2022-11-17 05:15:16','393f49a3-2c08-49ce-9c73-7cc7ac2bbedd'),(203,200,1,NULL,NULL,1,'2022-11-17 05:15:22','2022-11-17 05:15:22','3c97f773-c361-4737-9142-c6c337ffe983'),(204,201,1,NULL,NULL,1,'2022-11-17 05:15:22','2022-11-17 05:15:22','09a0958b-5657-4762-9fef-0e7336c66219'),(207,204,1,NULL,NULL,1,'2022-11-17 05:17:35','2022-11-17 05:17:35','9ec97d90-9a99-480b-a0e1-23a0da1bf54c'),(210,207,1,NULL,NULL,1,'2022-11-17 05:23:28','2022-11-17 05:23:28','fae3db48-c7b3-42b3-92d3-a8fb32400461'),(211,208,1,NULL,NULL,1,'2022-11-17 05:23:30','2022-11-17 05:23:30','87cfeea6-7d44-4ade-890a-65e2dd6e35f3'),(212,209,1,NULL,NULL,1,'2022-11-17 05:23:30','2022-11-17 05:23:30','c8ac1b6e-00c3-47b3-85c8-fb66694bb6df'),(213,210,1,NULL,NULL,1,'2022-11-17 05:23:34','2022-11-17 05:23:34','96f481bb-e8ea-4293-824f-d79761703b12'),(214,211,1,NULL,NULL,1,'2022-11-17 05:23:34','2022-11-17 05:23:34','7969dc0e-9f82-45cf-bb1c-e910ab87deae'),(215,212,1,NULL,NULL,1,'2022-11-17 05:23:34','2022-11-17 05:23:34','56ef05f0-d4f1-44c0-b37c-636a593a4974'),(216,213,1,NULL,NULL,1,'2022-11-17 05:23:40','2022-11-17 05:23:40','26faf3c4-268b-41fd-beb5-8a3dd0f582d8'),(217,214,1,NULL,NULL,1,'2022-11-17 05:23:40','2022-11-17 05:23:40','f441289b-6908-49ec-a1c1-707d5e60d009'),(219,216,1,NULL,NULL,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','4fea6d4e-f063-47f4-8f3f-c2905c994fad'),(220,217,1,'contact','contact',1,'2022-11-17 05:23:42','2022-11-17 05:23:42','cdad5aef-aa13-4341-bf2d-822a062e7c73'),(221,218,1,NULL,NULL,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','50638d2f-5690-4fb1-89d5-a1842d2619c0'),(222,219,1,NULL,NULL,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','24e288b3-4c99-4fa5-b723-4efa68a3af37'),(223,220,1,NULL,NULL,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','f72bbb7d-273c-4add-963d-622fd19b0749'),(224,221,1,NULL,NULL,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','7f2650cf-0b14-42a1-9b87-741735e7f3ce'),(225,222,1,NULL,NULL,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','cb3a9cba-3bbf-4553-8df2-7fc824cafbc3'),(228,225,1,NULL,NULL,1,'2022-11-17 05:24:09','2022-11-17 05:24:09','25173ce7-fe46-41b0-bbe6-32f627d08b4d'),(231,228,1,NULL,NULL,1,'2022-11-17 05:58:43','2022-11-17 05:58:43','e1e670dd-c373-453b-a29b-b08d0e8cade4'),(232,229,1,NULL,NULL,1,'2022-11-17 05:58:48','2022-11-17 05:58:48','fcef84a3-e737-43b0-a39f-b0be9af3a651'),(233,230,1,NULL,NULL,1,'2022-11-17 05:58:52','2022-11-17 05:58:52','5226257f-dcfe-40e0-ac55-01df4c078298'),(234,231,1,NULL,NULL,1,'2022-11-17 05:59:00','2022-11-17 05:59:00','4e63e2a6-7f57-4303-bb46-faa789d5ead2'),(236,233,1,NULL,NULL,1,'2022-11-17 05:59:06','2022-11-17 05:59:06','8bcfcb85-2f23-4eee-8187-e555ac57fd61'),(237,234,1,'__home__','__home__',1,'2022-11-17 05:59:06','2022-11-17 05:59:06','10cb8ec7-8e58-4682-ab66-e06831dc1b89'),(238,235,1,NULL,NULL,1,'2022-11-17 05:59:06','2022-11-17 05:59:06','e9d6588e-ab6d-449f-b8b5-167309cc36aa'),(239,236,1,NULL,NULL,1,'2022-11-17 05:59:06','2022-11-17 05:59:06','534194d1-2aed-4eeb-809d-b5cfa577e75e'),(242,239,1,'news','news',1,'2022-11-17 06:06:58','2022-11-17 06:06:58','c8bc8ff3-ca40-400c-8eca-a888b006f3f4'),(243,240,1,NULL,NULL,1,'2022-11-17 06:06:58','2022-11-17 06:06:58','77ea164a-680e-48b6-8094-81dc4f4a6f0a'),(244,241,1,NULL,NULL,1,'2022-11-17 06:06:58','2022-11-17 06:06:58','a3e158a4-d541-4953-84da-d23121a8a568'),(245,242,1,NULL,NULL,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','b667e14e-2037-4585-8c92-db8945ac6a09'),(246,243,1,'contact','contact',1,'2022-11-17 06:09:47','2022-11-17 06:09:47','60db95ba-11d4-4ca2-9bd4-f82c6c8200f5'),(247,244,1,NULL,NULL,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','aaf8d65e-438d-4fc6-8f69-59e686b939ce'),(248,245,1,NULL,NULL,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','add79da7-73b6-42d5-baf5-0dce4d4faf40'),(249,246,1,NULL,NULL,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','e9eca6ae-c04e-4169-a077-46781c8eaaf2'),(250,247,1,NULL,NULL,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','29f79d82-2716-49d5-ac71-2a3888644060'),(251,248,1,NULL,NULL,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','845ca5a3-23e2-4a34-ae76-12d0c66d0c38'),(252,249,1,NULL,NULL,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','936e30de-cd67-4d7d-9446-ad8ca0a9ecc6'),(255,252,1,'contact','contact',1,'2022-11-17 06:10:16','2022-11-17 06:10:16','63576fb7-70a2-4310-a7f6-6004160b3acc'),(256,253,1,NULL,NULL,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','506a9f73-7a67-4a9d-8a22-5aefab9ec247'),(257,254,1,NULL,NULL,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','ae358c01-b4ee-4b57-8a77-b766917f95a4'),(258,255,1,NULL,NULL,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','6b1271c3-4648-4c8b-8d97-71be35f22b06'),(259,256,1,NULL,NULL,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','a643df3b-271a-477b-87d0-df2b368c1116'),(261,258,1,NULL,NULL,1,'2022-11-17 07:44:47','2022-11-17 07:44:47','dc90c4a3-8374-4ebf-996b-75eafb780d65'),(263,260,1,NULL,NULL,1,'2022-11-17 07:45:17','2022-11-17 07:45:17','f10a67b8-9270-4df3-9a6e-ee5c0eae74c7'),(264,261,1,'news-story-with-a-much-longer-title-than-you-might-normally-expect','news/news-story-with-a-much-longer-title-than-you-might-normally-expect',1,'2022-11-17 07:45:17','2022-11-17 07:45:17','3682921b-7001-4d41-8841-bc6f04d38e87'),(265,262,1,NULL,NULL,1,'2022-11-17 07:45:17','2022-11-17 07:45:17','86452796-e25c-47fd-bbc5-17d0f6b8050c'),(268,265,1,'news-story-with-a-much-longer-title-than-you-might-normally-expect','news/news-story-with-a-much-longer-title-than-you-might-normally-expect',1,'2022-11-17 07:54:40','2022-11-17 07:54:40','1a8be6e4-9ba6-4b82-bc21-9cff6a6657e3'),(269,266,1,NULL,NULL,1,'2022-11-17 07:54:40','2022-11-17 07:54:40','12cc9646-9011-4d7c-9bba-7af793474f4d'),(272,269,1,'contact','contact',1,'2022-11-17 10:02:11','2022-11-17 10:02:11','1b03781e-73ce-4d1e-92ac-2e69a33dc92b'),(273,270,1,NULL,NULL,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','69a18698-fc30-4be1-8da0-5931aab4d9a8'),(274,271,1,NULL,NULL,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','79307e20-cdab-45d2-8286-d178a9b9ed6f'),(275,272,1,NULL,NULL,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','7eddf3f5-f426-4788-8fe5-6f1882bab782'),(276,273,1,NULL,NULL,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','9f9036f4-82d8-44db-a2e6-08bf4ba30ec9'),(279,276,1,'contact','contact',1,'2022-11-17 10:21:55','2022-11-17 10:21:55','179a697b-a603-4eca-a7a5-98921a41b8f1'),(280,277,1,NULL,NULL,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','dc310f7f-c15f-419c-976e-578e922fef38'),(281,278,1,NULL,NULL,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','8120c263-6909-4ed2-8e7f-14e6f4869cf9'),(282,279,1,NULL,NULL,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','418dd05e-c3fb-4864-8c94-02dee30c9a1d'),(283,280,1,NULL,NULL,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','2ff801dc-46d9-4358-9e3b-78c019628eb3'),(286,283,1,'contact','contact',1,'2022-11-17 10:36:54','2022-11-17 10:36:54','50091d39-5728-4c5b-987c-dc31688400f5'),(287,284,1,NULL,NULL,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','847ec0bd-b408-4051-b99b-b098fc740356'),(288,285,1,NULL,NULL,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','71c0bd53-000f-4494-8241-e8953363e677'),(289,286,1,NULL,NULL,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','d0f73f54-1190-49b5-8de4-330f58c2bc73'),(290,287,1,NULL,NULL,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','803124a4-87f1-4912-a111-d99671e45b70'),(293,290,1,'contact','contact',1,'2022-11-17 10:37:11','2022-11-17 10:37:11','a7baf5f6-4f43-4aa2-a14a-a8e732ec82cb'),(294,291,1,NULL,NULL,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','42317eef-c4a2-4265-a910-1f13359df322'),(295,292,1,NULL,NULL,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','86ddbe58-971f-497d-a4e2-aea88fce435a'),(296,293,1,NULL,NULL,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','86df134f-938a-4ad3-af1c-9411b96159b5'),(297,294,1,NULL,NULL,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','cbf142c2-d437-4b66-944a-40feb36ebf9d'),(300,297,1,'contact','contact',1,'2022-11-17 10:44:59','2022-11-17 10:44:59','ff22f576-3cce-4bcc-a9a8-2e30f45e4d64'),(301,298,1,NULL,NULL,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','14b15636-1240-4a38-8afc-06066f7a5b6e'),(302,299,1,NULL,NULL,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','9cda14ce-bcbb-40f2-95b7-ad9f7a718a37'),(303,300,1,NULL,NULL,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','37ab6532-1cce-4ef0-b33c-86067b2f8132'),(304,301,1,NULL,NULL,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','1c2ce43f-853a-42db-af25-d515f4aaef37'),(307,304,1,'contact','contact',1,'2022-11-17 10:49:11','2022-11-17 10:49:11','c7a4e6b1-a44f-4270-8f51-4c63b7cb9897'),(308,305,1,NULL,NULL,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','b4c9b4be-e4b9-4689-9f34-126a15c40cfd'),(309,306,1,NULL,NULL,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','201f0315-1bee-4bc2-96af-01e896f297b5'),(310,307,1,NULL,NULL,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','69cfb481-4577-4551-a8c9-88840368da16'),(311,308,1,NULL,NULL,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','d9abc8d5-3f66-4e89-9bee-e0d51ef50de9');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (1,2,NULL,4,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36'),(2,2,NULL,4,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36'),(3,2,NULL,4,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36'),(4,4,NULL,7,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36'),(5,4,NULL,7,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36'),(6,4,NULL,7,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36'),(7,6,NULL,10,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36'),(8,6,NULL,10,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:37','2022-11-16 06:42:37'),(9,6,NULL,10,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:37','2022-11-16 06:42:37'),(10,2,NULL,4,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:51','2022-11-16 06:42:51'),(11,2,NULL,4,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:51','2022-11-16 06:42:51'),(12,4,NULL,7,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:51','2022-11-16 06:42:51'),(13,4,NULL,7,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:51','2022-11-16 06:42:51'),(14,6,NULL,10,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:52','2022-11-16 06:42:52'),(15,6,NULL,10,NULL,'2022-11-16 06:42:00',NULL,NULL,'2022-11-16 06:42:52','2022-11-16 06:42:52'),(17,9,NULL,9,16,'2022-11-16 06:48:00',NULL,NULL,'2022-11-16 06:48:22','2022-11-16 06:48:32'),(18,9,NULL,9,16,'2022-11-16 06:48:00',NULL,NULL,'2022-11-16 06:48:32','2022-11-16 06:48:32'),(19,9,NULL,9,16,'2022-11-16 06:49:00',NULL,NULL,'2022-11-16 06:48:39','2022-11-16 06:49:25'),(24,9,NULL,9,16,'2022-11-16 06:49:00',NULL,NULL,'2022-11-16 06:49:25','2022-11-16 06:49:25'),(26,8,NULL,1,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-16 06:49:52','2022-11-16 06:50:19'),(27,8,NULL,1,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-16 06:50:19','2022-11-16 06:50:19'),(28,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-16 06:50:23','2022-11-16 10:16:55'),(37,8,NULL,1,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-16 08:01:18','2022-11-16 08:01:18'),(38,9,NULL,2,16,'2022-11-16 09:56:00',NULL,NULL,'2022-11-16 09:56:14','2022-11-16 20:46:17'),(39,9,NULL,9,16,'2022-11-16 09:56:00',NULL,NULL,'2022-11-16 09:56:25','2022-11-16 09:56:25'),(41,9,NULL,9,16,'2022-11-16 09:56:00',NULL,NULL,'2022-11-16 09:56:46','2022-11-16 09:56:46'),(47,1,NULL,13,16,'2022-11-16 10:07:00',NULL,NULL,'2022-11-16 10:07:00','2022-11-16 10:07:00'),(48,1,NULL,13,16,'2022-11-16 10:07:00',NULL,NULL,'2022-11-16 10:07:53','2022-11-16 10:07:53'),(50,1,NULL,13,16,'2022-11-16 10:07:00',NULL,NULL,'2022-11-16 10:08:43','2022-11-16 10:08:43'),(52,1,NULL,13,16,'2022-11-16 10:07:00',NULL,NULL,'2022-11-16 10:09:34','2022-11-16 10:09:34'),(69,9,NULL,9,16,'2022-11-16 06:49:00',NULL,NULL,'2022-11-16 10:35:02','2022-11-16 10:35:02'),(80,9,NULL,9,16,'2022-11-16 06:48:00',NULL,NULL,'2022-11-16 11:27:17','2022-11-16 11:27:17'),(88,8,NULL,1,16,'2022-11-16 11:28:00',NULL,NULL,'2022-11-16 11:28:12','2022-11-16 11:28:34'),(89,8,NULL,1,16,'2022-11-16 11:28:00',NULL,NULL,'2022-11-16 11:28:34','2022-11-16 11:28:34'),(130,1,NULL,13,16,'2022-11-16 20:33:00',NULL,NULL,'2022-11-16 20:33:16','2022-11-16 20:33:49'),(131,1,NULL,13,16,'2022-11-16 20:33:00',NULL,NULL,'2022-11-16 20:33:49','2022-11-16 20:33:49'),(132,1,NULL,13,16,'2022-11-16 20:33:00',NULL,NULL,'2022-11-16 20:33:55','2022-11-16 20:33:55'),(133,1,NULL,13,16,'2022-11-16 20:34:00',NULL,NULL,'2022-11-16 20:33:57','2022-11-16 20:34:27'),(134,1,NULL,13,16,'2022-11-16 20:34:00',NULL,NULL,'2022-11-16 20:34:27','2022-11-16 20:34:27'),(145,9,NULL,9,16,'2022-11-16 06:49:00',NULL,NULL,'2022-11-16 20:38:14','2022-11-16 20:38:14'),(148,9,NULL,2,16,'2022-11-16 09:56:00',NULL,NULL,'2022-11-16 20:46:17','2022-11-16 20:46:17'),(154,9,NULL,2,16,'2022-11-16 09:56:00',NULL,NULL,'2022-11-16 20:46:32','2022-11-16 20:46:32'),(166,9,NULL,9,16,'2022-11-16 06:49:00',NULL,NULL,'2022-11-16 21:14:23','2022-11-16 21:14:23'),(171,9,NULL,9,16,'2022-11-16 06:49:00',NULL,NULL,'2022-11-16 21:20:12','2022-11-16 21:20:12'),(175,8,NULL,1,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-16 21:22:04','2022-11-16 21:22:04'),(177,8,NULL,1,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-16 21:25:43','2022-11-16 21:25:43'),(185,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-16 22:52:33','2022-11-16 22:52:33'),(192,9,NULL,9,16,'2022-11-16 06:48:00',NULL,NULL,'2022-11-17 04:34:36','2022-11-17 04:34:36'),(217,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-17 05:23:42','2022-11-17 05:23:42'),(234,9,NULL,9,16,'2022-11-16 06:48:00',NULL,NULL,'2022-11-17 05:59:06','2022-11-17 05:59:06'),(239,9,NULL,9,16,'2022-11-16 06:49:00',NULL,NULL,'2022-11-17 06:06:58','2022-11-17 06:06:58'),(243,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-17 06:09:47','2022-11-17 06:09:47'),(252,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-17 06:10:16','2022-11-17 06:10:16'),(261,1,NULL,13,16,'2022-11-16 20:34:00',NULL,NULL,'2022-11-17 07:45:17','2022-11-17 07:45:17'),(265,1,NULL,13,16,'2022-11-16 20:34:00',NULL,NULL,'2022-11-17 07:54:40','2022-11-17 07:54:40'),(269,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-17 10:02:11','2022-11-17 10:02:11'),(276,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-17 10:21:55','2022-11-17 10:21:55'),(283,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-17 10:36:54','2022-11-17 10:36:54'),(290,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-17 10:37:11','2022-11-17 10:37:11'),(297,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-17 10:44:59','2022-11-17 10:44:59'),(304,9,NULL,2,16,'2022-11-16 06:50:00',NULL,NULL,'2022-11-17 10:49:11','2022-11-17 10:49:11');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,8,5,'Basic Fragments','basic',1,'site',NULL,NULL,1,'2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'174cd975-f457-4998-8bcc-3d25963f9c3b'),(2,9,23,'Standard with Sidebar (Two Columns)','standardSidebar',1,'site',NULL,NULL,3,'2022-11-16 06:42:35','2022-11-16 06:42:35',NULL,'1da13089-e303-46d0-930f-aefd062df474'),(3,11,24,'Default','default',1,'site',NULL,NULL,1,'2022-11-16 06:42:35','2022-11-16 06:42:35',NULL,'780c9942-bfd5-4d94-82c7-5b323a47f5d4'),(4,2,25,'Alert Message','alertMessage',0,'site',NULL,'{section.name|raw}',1,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'fb1d50db-864b-4553-9fb0-d1d784dd98d9'),(5,5,26,'User Comment','userComment',1,'site',NULL,NULL,2,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'67e56d28-ce0e-42b3-a78b-cbafa75cb98a'),(6,5,27,'Testimonial','testimonial',1,'site',NULL,NULL,1,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'480317fb-766a-4fad-b7d1-ee171a3aefb6'),(7,4,28,'Error 404','error404',1,'site',NULL,NULL,1,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'ecafdb45-55b7-4568-b087-9c19bc75197a'),(8,10,29,'Private','private',1,'site',NULL,NULL,2,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'6b7d0e03-182d-44ba-a6ef-08930a4253e1'),(9,9,30,'Standard (Single Column)','standard',1,'site',NULL,NULL,1,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'e0521335-ccc2-4893-a505-4baacf112dee'),(10,6,31,'Search','search',0,'site',NULL,'{section.name|raw}',1,'2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'7c143451-c641-4b9e-9b70-317f53656197'),(11,3,32,'Standard (Single Column)','standard',1,'site',NULL,NULL,1,'2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'0f144f04-bdb4-4ad8-9279-376e39af170e'),(12,7,33,'Default','default',1,'site',NULL,NULL,1,'2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'64029a67-3d0c-4cad-8fc6-dc0eec8c112c'),(13,1,34,'Default','default',1,'site',NULL,NULL,1,'2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'d3282cfb-d044-4890-b553-9a0b87393027'),(14,9,35,'Redirect','redirect',1,'site',NULL,NULL,5,'2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'986a0a6d-c09c-4a78-b259-2190a004b305'),(15,10,36,'Public','public',1,'site',NULL,NULL,1,'2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'912adfc2-2bca-47f1-9da2-f1ed5514623c');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2022-11-16 06:42:18','2022-11-16 06:42:18',NULL,'e0dac603-c510-4bb5-8701-e25672d93744'),(2,'Text Input','2022-11-16 06:42:18','2022-11-16 06:42:18',NULL,'a4b149ed-cc92-46ad-bfb9-6fa96bb29e5c'),(3,'Buttons & Links','2022-11-16 06:42:18','2022-11-16 06:42:18',NULL,'b7f29b8a-788f-4f46-a93e-cdfdfa91d44b'),(4,'Textarea','2022-11-16 06:42:18','2022-11-16 06:42:18',NULL,'481eb25d-9439-4ee3-85c2-e1a0e6d62d11'),(5,'Dropdowns','2022-11-16 06:42:18','2022-11-16 06:42:18',NULL,'3be366bf-8e5e-4f28-8502-7ebf1d83e26e'),(6,'Content Builders','2022-11-16 06:42:18','2022-11-16 06:42:18',NULL,'ea1a69ed-b5c5-46cf-a629-4435f7f7cad0');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (334,37,104,3,0,0,'2022-11-16 06:42:37','2022-11-16 06:42:37','598ebc08-ffca-4c01-a15a-d33aa0383fa2'),(350,1,118,17,0,2,'2022-11-16 06:42:39','2022-11-16 06:42:39','e3369a7d-a9e4-4dc5-9fed-43103ba3bd72'),(351,1,118,5,0,3,'2022-11-16 06:42:39','2022-11-16 06:42:39','2c45793a-2fa5-448e-929c-8132ec79b1d5'),(352,1,118,16,0,4,'2022-11-16 06:42:39','2022-11-16 06:42:39','8f010be7-7d27-4f08-bd69-301b59e537ea'),(359,13,122,75,0,0,'2022-11-16 06:42:40','2022-11-16 06:42:40','a4646333-de3e-4afd-8f0d-a89f3ea35ed3'),(360,13,122,74,0,1,'2022-11-16 06:42:40','2022-11-16 06:42:40','bca10e42-035f-4a24-ba23-4199256449c6'),(361,13,122,77,0,2,'2022-11-16 06:42:40','2022-11-16 06:42:40','c7c9a636-9b3d-4182-b05b-69e7cbc3b33e'),(362,13,122,76,0,3,'2022-11-16 06:42:40','2022-11-16 06:42:40','81a4561c-eafb-48c0-88c2-3761192ad788'),(363,13,122,79,0,4,'2022-11-16 06:42:40','2022-11-16 06:42:40','ae39574c-fd76-4a29-a924-dd853c2d3c27'),(364,13,122,78,0,5,'2022-11-16 06:42:40','2022-11-16 06:42:40','5dca6f50-e731-4687-8ef0-37324c099a9f'),(389,16,130,86,0,0,'2022-11-16 06:42:41','2022-11-16 06:42:41','5a29bdee-4d3e-4f95-b783-2162194f5e74'),(390,16,130,85,0,1,'2022-11-16 06:42:41','2022-11-16 06:42:41','d6c529a7-3f6f-4d03-b9bc-d6b7a0e1d801'),(391,16,130,84,0,2,'2022-11-16 06:42:41','2022-11-16 06:42:41','82baa765-d728-4b67-b95c-61633e805154'),(392,16,130,87,0,3,'2022-11-16 06:42:41','2022-11-16 06:42:41','3c5184ed-6e0d-4afd-b293-1049755c8d0d'),(406,17,134,89,0,0,'2022-11-16 06:42:42','2022-11-16 06:42:42','9481dd74-c449-45ca-91db-e6222ee420e0'),(407,17,134,91,1,1,'2022-11-16 06:42:42','2022-11-16 06:42:42','330e02ae-80b7-4e8b-8941-23e4ce83b9a0'),(408,17,134,88,0,2,'2022-11-16 06:42:42','2022-11-16 06:42:42','32df170a-32bd-446a-bc7a-e8db86071fc3'),(409,17,134,92,0,3,'2022-11-16 06:42:43','2022-11-16 06:42:43','7b031977-c129-495a-900a-c1a5d72fc1cf'),(410,17,134,90,0,4,'2022-11-16 06:42:43','2022-11-16 06:42:43','9047a207-44ef-49dd-a233-6a546cf7912a'),(429,9,138,63,0,0,'2022-11-16 06:42:44','2022-11-16 06:42:44','164fa613-f8b9-4f9c-b5b3-b6bdc033e511'),(430,9,138,56,0,1,'2022-11-16 06:42:44','2022-11-16 06:42:44','39312fda-dba1-4a9f-9423-56e4c04ccecd'),(431,9,138,59,0,2,'2022-11-16 06:42:44','2022-11-16 06:42:44','d1722dfe-650f-4f8e-abb8-485969c60121'),(432,9,138,58,0,3,'2022-11-16 06:42:44','2022-11-16 06:42:44','d749bf03-4517-4485-aba1-b4df2823fe7b'),(433,9,138,57,0,4,'2022-11-16 06:42:44','2022-11-16 06:42:44','22f53507-c400-4370-8e9d-b6af2768e103'),(434,9,138,62,0,5,'2022-11-16 06:42:44','2022-11-16 06:42:44','ffdee883-39f1-4f97-8eac-eb809c600ee9'),(435,9,138,64,0,6,'2022-11-16 06:42:44','2022-11-16 06:42:44','e3296cb4-3479-4072-bc5b-f79fb5674e74'),(436,9,138,54,0,7,'2022-11-16 06:42:44','2022-11-16 06:42:44','9249586c-6ae6-49a4-8f67-2418d1c64d3d'),(437,9,138,55,0,8,'2022-11-16 06:42:44','2022-11-16 06:42:44','1ce015fd-8750-4a0a-910c-2f02b6870ed1'),(438,9,138,61,0,9,'2022-11-16 06:42:44','2022-11-16 06:42:44','c77127ee-f111-4581-9f03-1f61716fc116'),(439,9,138,60,0,10,'2022-11-16 06:42:44','2022-11-16 06:42:44','f68eb61b-bac2-41f3-8196-18975f2cd08b'),(440,9,138,65,0,11,'2022-11-16 06:42:44','2022-11-16 06:42:44','b56410d4-66d6-4df9-b0fb-d49f98ee5ff1'),(448,18,140,99,0,0,'2022-11-16 06:42:45','2022-11-16 06:42:45','49d1dc2f-ab11-441c-9b10-a0a75db7eedd'),(449,18,140,98,1,1,'2022-11-16 06:42:45','2022-11-16 06:42:45','f4e9dde6-5b65-490b-8325-f083300e9a20'),(450,18,140,97,0,2,'2022-11-16 06:42:45','2022-11-16 06:42:45','059b7a6d-e9e3-450e-a22b-e800014b062a'),(451,18,140,94,0,3,'2022-11-16 06:42:45','2022-11-16 06:42:45','198388bd-89c7-4e94-bc8b-3e965af4261d'),(452,18,140,95,0,4,'2022-11-16 06:42:45','2022-11-16 06:42:45','148cb8eb-983d-45a2-9f03-50966364a958'),(453,18,140,93,0,5,'2022-11-16 06:42:45','2022-11-16 06:42:45','5d52c0a4-226a-46ae-ab89-b20602ec05cf'),(454,18,140,96,0,6,'2022-11-16 06:42:45','2022-11-16 06:42:45','b15a9399-9620-44a1-8f89-e67db67ca9e5'),(460,19,142,103,1,0,'2022-11-16 06:42:46','2022-11-16 06:42:46','ebea39ac-bc46-48c3-a283-af4dca654b64'),(461,19,142,102,0,1,'2022-11-16 06:42:46','2022-11-16 06:42:46','e90e29ec-10b4-48bb-b2cd-827b0d2fe0b7'),(462,19,142,104,0,2,'2022-11-16 06:42:46','2022-11-16 06:42:46','045ac718-af5a-448c-a646-d40e3a150322'),(463,19,142,101,0,3,'2022-11-16 06:42:46','2022-11-16 06:42:46','52700863-7399-4afc-93c9-7c34d2057581'),(464,19,142,100,0,4,'2022-11-16 06:42:46','2022-11-16 06:42:46','b29e549f-c1d3-47d9-bb62-2fac84a89c95'),(522,21,150,110,0,0,'2022-11-16 06:42:49','2022-11-16 06:42:49','263019a7-f588-4c98-aff3-79eee41aa29f'),(523,21,150,113,1,1,'2022-11-16 06:42:49','2022-11-16 06:42:49','142caeba-532b-4ae4-9b32-32a9f0f607f9'),(524,21,150,114,0,2,'2022-11-16 06:42:49','2022-11-16 06:42:49','47c992ae-f028-44d5-a42f-7d8b7a445e44'),(525,21,150,111,0,3,'2022-11-16 06:42:49','2022-11-16 06:42:49','353207a8-6f59-471b-a665-e1b730878f72'),(526,21,150,115,0,4,'2022-11-16 06:42:49','2022-11-16 06:42:49','99c4cbc4-7a5c-4b70-9ef5-49f5eb7b3cff'),(527,21,150,112,0,5,'2022-11-16 06:42:49','2022-11-16 06:42:49','aca496e7-4bc6-4494-9b1b-3d9db5b30b08'),(528,21,150,109,0,6,'2022-11-16 06:42:49','2022-11-16 06:42:49','7bae5572-6378-49d7-af4d-1427a654f319'),(535,4,152,45,0,0,'2022-11-16 06:42:50','2022-11-16 06:42:50','cd9c102b-4f7b-405e-9da8-f5d0cee0c48c'),(536,4,152,48,0,1,'2022-11-16 06:42:50','2022-11-16 06:42:50','59e530bb-057c-44bb-bb25-91b97319149d'),(537,4,152,46,0,2,'2022-11-16 06:42:50','2022-11-16 06:42:50','675e6594-bcbd-4e9c-af37-bd82fd328d9e'),(538,4,152,44,0,3,'2022-11-16 06:42:50','2022-11-16 06:42:50','e1e34de0-db74-41fe-949e-5d99ef569f86'),(539,4,152,49,0,4,'2022-11-16 06:42:50','2022-11-16 06:42:50','30e028fd-8ad8-4aef-8ee8-ed5d1eeb3246'),(540,4,152,47,0,5,'2022-11-16 06:42:50','2022-11-16 06:42:50','8cb42af0-cb38-4888-8906-d71e89e8d2f7'),(546,22,154,120,0,0,'2022-11-16 06:42:50','2022-11-16 06:42:50','a5ed6742-06e0-4bdd-8c50-ce329e69f7ef'),(547,22,154,118,0,1,'2022-11-16 06:42:50','2022-11-16 06:42:50','ecdec442-6fee-4d9b-9075-290229e10211'),(548,22,154,117,0,2,'2022-11-16 06:42:50','2022-11-16 06:42:50','20e131a5-1a07-4988-94bb-bcf45aae94e0'),(549,22,154,116,0,3,'2022-11-16 06:42:50','2022-11-16 06:42:50','935cdcc5-d878-4618-ac29-7e21c8014953'),(550,22,154,119,0,4,'2022-11-16 06:42:50','2022-11-16 06:42:50','16985cd0-2749-44af-ad6e-2c280b92263a'),(574,24,166,18,0,2,'2022-11-16 06:42:51','2022-11-16 06:42:51','a510b0e8-a20d-480b-8943-c4103533811d'),(575,24,166,2,0,4,'2022-11-16 06:42:51','2022-11-16 06:42:51','6d767ee7-819d-41a3-ac0e-38eeb5027e4a'),(576,24,167,9,0,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','72896033-925d-492f-bf76-668c6e00efe9'),(577,24,168,5,0,0,'2022-11-16 06:42:51','2022-11-16 06:42:51','555bf677-69ae-4c63-a73f-d9cfc4fc86dd'),(578,24,168,7,0,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','bf256184-0ea9-4968-aed7-04f1892bd4e0'),(579,24,168,13,0,2,'2022-11-16 06:42:51','2022-11-16 06:42:51','df707f0e-df81-441c-8547-c6a883437e40'),(580,24,168,8,0,3,'2022-11-16 06:42:51','2022-11-16 06:42:51','2c08dd36-3c5b-4d4a-bb56-2f256c152e89'),(584,25,170,10,0,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','b2a3ae9d-29a3-4380-bc4b-373d5a01918b'),(585,25,170,7,0,3,'2022-11-16 06:42:51','2022-11-16 06:42:51','2560ee99-5359-4efb-a351-e468cfed055f'),(586,25,170,1,0,4,'2022-11-16 06:42:51','2022-11-16 06:42:51','1de78361-5113-47b8-9565-ad79e2b85f9f'),(588,26,172,17,0,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','d8206d29-ddcd-4bf0-8dd4-e9f7985039b2'),(592,27,174,17,0,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','02b311bc-066c-4194-928c-dba8c6031f5c'),(593,27,174,5,0,2,'2022-11-16 06:42:51','2022-11-16 06:42:51','bd4c492f-cf1b-43c0-9f6e-a3db321e6756'),(594,27,174,13,0,3,'2022-11-16 06:42:51','2022-11-16 06:42:51','41e1a6ec-ac52-46ca-848a-dfff70795643'),(597,28,176,18,0,1,'2022-11-16 06:42:51','2022-11-16 06:42:51','1609f098-24db-4b11-923c-52c30a513ee7'),(598,28,176,16,0,2,'2022-11-16 06:42:51','2022-11-16 06:42:51','4666cf42-3ed1-4d57-827c-c227ce91a554'),(602,29,178,17,0,1,'2022-11-16 06:42:52','2022-11-16 06:42:52','6a097112-9f31-46c1-adec-000822ca2053'),(603,29,178,5,0,2,'2022-11-16 06:42:52','2022-11-16 06:42:52','65fbeff7-d924-4462-abda-c8590334f839'),(604,29,178,11,0,3,'2022-11-16 06:42:52','2022-11-16 06:42:52','324cc3c1-28db-430b-8920-cf23ecadfdec'),(618,30,184,18,0,2,'2022-11-16 06:42:52','2022-11-16 06:42:52','2d72c435-979a-4156-aa43-b9156b861633'),(619,30,184,2,0,4,'2022-11-16 06:42:52','2022-11-16 06:42:52','2528ad47-393c-4f18-9d93-864d4992ed4f'),(620,30,185,9,0,1,'2022-11-16 06:42:52','2022-11-16 06:42:52','2a53ddd2-8261-4350-8bf6-ba2caff85111'),(621,30,186,5,0,0,'2022-11-16 06:42:52','2022-11-16 06:42:52','228b4eca-51eb-4e65-8c96-09b913dc1b45'),(622,30,186,7,0,1,'2022-11-16 06:42:52','2022-11-16 06:42:52','6c7b84e0-445f-46f9-ac63-ac07255dd9cb'),(623,30,186,13,0,2,'2022-11-16 06:42:52','2022-11-16 06:42:52','b36d1d9c-191e-44f1-8f90-b146b8d85aab'),(624,30,186,8,0,3,'2022-11-16 06:42:52','2022-11-16 06:42:52','55896cfa-7dfe-4664-a90c-b70b6eaa4a5b'),(627,31,188,18,0,1,'2022-11-16 06:42:52','2022-11-16 06:42:52','ebb8daef-7615-4105-aee0-6d716f73799b'),(628,31,188,16,0,2,'2022-11-16 06:42:52','2022-11-16 06:42:52','f7f39bea-e288-4da1-b5bd-d0633fac37cb'),(636,32,192,18,0,2,'2022-11-16 06:42:52','2022-11-16 06:42:52','892ddd7f-9f62-493f-a3b4-faff4712e2c0'),(637,32,192,2,0,4,'2022-11-16 06:42:52','2022-11-16 06:42:52','246173d0-5e49-4d85-99ea-d3da2583703c'),(638,32,193,9,0,1,'2022-11-16 06:42:52','2022-11-16 06:42:52','319b9268-3fa4-47be-89ba-5a7a06ffa2e8'),(639,32,194,5,0,0,'2022-11-16 06:42:52','2022-11-16 06:42:52','5f4c8953-3a85-4774-924e-65b16110643f'),(640,32,194,7,0,1,'2022-11-16 06:42:52','2022-11-16 06:42:52','b98f547a-2819-422c-9113-e60b8eaf4d21'),(641,32,194,13,0,2,'2022-11-16 06:42:52','2022-11-16 06:42:52','bef6b320-5aae-4fa3-b2a5-93b91f457d70'),(642,32,194,8,0,3,'2022-11-16 06:42:52','2022-11-16 06:42:52','c78cffb3-f7dd-4044-83a8-d48e2a120a8a'),(647,33,197,5,0,1,'2022-11-16 06:42:53','2022-11-16 06:42:53','0d8088d4-1365-4c8d-ab95-e163d17fcb33'),(648,33,197,16,0,2,'2022-11-16 06:42:53','2022-11-16 06:42:53','9c3d77d9-6004-436a-9cd1-f3d63f752e18'),(649,33,198,13,0,0,'2022-11-16 06:42:53','2022-11-16 06:42:53','d09fbe57-ade5-45b4-b5cd-9beae0f29442'),(658,34,202,13,0,1,'2022-11-16 06:42:53','2022-11-16 06:42:53','ba53cb08-0d11-42ab-994e-7b43f211ac6c'),(659,34,202,5,0,2,'2022-11-16 06:42:53','2022-11-16 06:42:53','256866b1-4a31-4ca2-b658-2385e2149b2b'),(660,34,202,7,1,3,'2022-11-16 06:42:53','2022-11-16 06:42:53','769f1de1-e609-44af-a049-79d2ccfa3f6d'),(661,34,202,18,0,5,'2022-11-16 06:42:53','2022-11-16 06:42:53','189a076d-3e32-4f03-bbb3-d62a0f8c6ed6'),(662,34,202,2,0,7,'2022-11-16 06:42:53','2022-11-16 06:42:53','6e200a2a-56d1-4710-b804-7bb79218b531'),(663,34,203,9,0,1,'2022-11-16 06:42:53','2022-11-16 06:42:53','f23ae253-a598-4bac-a2cd-bc198aef26ac'),(664,34,204,8,0,0,'2022-11-16 06:42:53','2022-11-16 06:42:53','c1f2115f-d24b-4c34-88c7-af0dc181242a'),(666,35,206,12,1,1,'2022-11-16 06:42:53','2022-11-16 06:42:53','fc599dfa-de1c-45b7-83f6-89141781487c'),(670,36,208,17,0,1,'2022-11-16 06:42:53','2022-11-16 06:42:53','ffa718df-658b-4a8a-8e66-530ba7cf337f'),(671,36,208,5,0,2,'2022-11-16 06:42:53','2022-11-16 06:42:53','5f332242-75bc-41a1-b48a-7dfa5c532eaf'),(672,36,208,11,0,3,'2022-11-16 06:42:53','2022-11-16 06:42:53','e9f1a15a-ea12-4ea7-b8fa-c13e0097b508'),(676,38,210,123,1,0,'2022-11-16 06:42:55','2022-11-16 06:42:55','80525608-6386-4475-9fdd-3db7dd8fe258'),(677,38,210,122,0,1,'2022-11-16 06:42:55','2022-11-16 06:42:55','ca68109b-6481-4940-a7ac-27994cb8a90f'),(678,38,210,121,0,2,'2022-11-16 06:42:55','2022-11-16 06:42:55','55c8d6f2-584b-4470-9ce1-4b56b0ac7a6a'),(679,39,211,124,1,0,'2022-11-16 06:51:38','2022-11-16 06:51:38','60a0a894-d7cf-41b5-b827-4be241c43a76'),(703,23,221,18,0,2,'2022-11-16 11:35:59','2022-11-16 11:35:59','46aaa202-7002-47c5-8298-13a9f83393ad'),(704,23,221,2,0,4,'2022-11-16 11:35:59','2022-11-16 11:35:59','cfac8ce2-344d-49e9-9716-6337de6a402c'),(705,23,222,21,0,1,'2022-11-16 11:35:59','2022-11-16 11:35:59','f70f9b07-03ca-405e-aa0e-e1d3a785b22e'),(706,23,223,9,0,1,'2022-11-16 11:35:59','2022-11-16 11:35:59','fec37ae4-1123-4189-9534-05544f61e652'),(707,23,224,5,0,0,'2022-11-16 11:35:59','2022-11-16 11:35:59','fc83f483-3726-428a-98d7-e718e3ddfbb9'),(708,23,224,7,0,1,'2022-11-16 11:35:59','2022-11-16 11:35:59','78e1cc8e-7cce-4293-84a6-642f3510015d'),(709,23,224,13,0,2,'2022-11-16 11:35:59','2022-11-16 11:35:59','c94da5a1-a8e1-47ce-b58d-c85c6712bcd0'),(710,23,224,8,0,3,'2022-11-16 11:35:59','2022-11-16 11:35:59','3c1fbd8f-668d-4df5-9a54-5e3ac9d6eccf'),(711,14,225,80,1,0,'2022-11-16 11:36:25','2022-11-16 11:36:25','72570dc0-1f69-4de2-97ff-7d1ffd5a183e'),(712,14,225,82,0,1,'2022-11-16 11:36:25','2022-11-16 11:36:25','6785a321-f340-4b83-8450-e7f150417a62'),(713,14,225,81,0,2,'2022-11-16 11:36:25','2022-11-16 11:36:25','ea0d9f5e-aba8-4826-b2d2-bf8f216d0bb4'),(714,20,226,106,1,0,'2022-11-16 11:36:25','2022-11-16 11:36:25','eb86426a-4264-4b7b-8b7a-4707e51ac622'),(715,20,226,105,0,1,'2022-11-16 11:36:25','2022-11-16 11:36:25','f7afc47f-d59a-49b4-8a12-b345e1ace107'),(716,20,226,107,0,2,'2022-11-16 11:36:25','2022-11-16 11:36:25','71bd703f-5397-4b77-9c2e-e7fa44396605'),(717,20,226,108,0,3,'2022-11-16 11:36:25','2022-11-16 11:36:25','68e51efa-83c9-4405-ba59-f364ea9eafd0'),(724,5,228,4,0,1,'2022-11-16 21:25:07','2022-11-16 21:25:07','570c298c-c061-402c-ace6-9301f13023f6'),(725,5,228,2,0,3,'2022-11-16 21:25:07','2022-11-16 21:25:07','10b9faa5-3870-4852-ac10-759d8234ef64'),(726,5,228,16,0,5,'2022-11-16 21:25:07','2022-11-16 21:25:07','9f869bb2-ae74-4906-8506-15f101bfe16f'),(727,5,228,14,0,6,'2022-11-16 21:25:07','2022-11-16 21:25:07','2dfc4bef-44d2-4a72-b4d8-d8334b0a82a8'),(728,15,229,129,0,0,'2022-11-16 22:52:00','2022-11-16 22:52:00','656da9ae-4ec2-46ab-9a29-a640d74cf1bd'),(729,15,229,83,0,1,'2022-11-16 22:52:00','2022-11-16 22:52:00','cab6c4ee-ecf7-4fc4-9fb4-4525663f6fa6'),(730,15,229,130,0,2,'2022-11-16 22:52:00','2022-11-16 22:52:00','0f3073a6-28a9-4c5d-947d-44ba7f942e59'),(731,15,229,128,0,3,'2022-11-16 22:52:00','2022-11-16 22:52:00','d2a75017-458c-4bc6-bd3c-8d2e0a6ed571'),(732,15,229,131,0,4,'2022-11-16 22:52:00','2022-11-16 22:52:00','45c9f821-33b9-470a-8c32-d882b7ee5eee'),(733,15,229,132,0,5,'2022-11-16 22:52:00','2022-11-16 22:52:00','3ad77cae-c7b3-40e8-a28f-1c5669aaba75'),(734,43,230,136,0,0,'2022-11-16 22:52:00','2022-11-16 22:52:00','25461e3a-3627-4e59-860e-891ff39e253e'),(735,43,230,137,0,1,'2022-11-16 22:52:00','2022-11-16 22:52:00','bd73aeb2-f507-4e87-bd57-144094cbffcb'),(736,43,230,135,0,2,'2022-11-16 22:52:00','2022-11-16 22:52:00','c46f978a-6234-49c1-9602-ba71385c0554'),(737,43,230,133,0,3,'2022-11-16 22:52:00','2022-11-16 22:52:00','304685f5-4fb6-42ff-8591-57bf1a10a83d'),(738,43,230,134,0,4,'2022-11-16 22:52:00','2022-11-16 22:52:00','e5aa5049-2db1-4289-ac95-9b61ad131221'),(759,11,235,71,0,0,'2022-11-17 05:36:16','2022-11-17 05:36:16','0b0466d1-ea87-49d3-821e-0e07ff5444fe'),(760,11,235,72,0,1,'2022-11-17 05:36:16','2022-11-17 05:36:16','10425220-b39b-4653-9c22-49335d296c82'),(761,11,235,73,0,2,'2022-11-17 05:36:16','2022-11-17 05:36:16','c6e6fb76-b0a2-4420-bf41-4456271ebabc'),(762,2,236,26,0,0,'2022-11-17 05:36:16','2022-11-17 05:36:16','3deae252-ed8e-497f-a148-afb113f6f360'),(763,2,236,27,0,1,'2022-11-17 05:36:16','2022-11-17 05:36:16','6552d69b-956b-408d-978b-ee7ca835b7cb'),(764,2,236,25,0,2,'2022-11-17 05:36:16','2022-11-17 05:36:16','a0a34bfd-f96e-4dd3-858c-15b178247bfc'),(765,2,236,23,0,3,'2022-11-17 05:36:16','2022-11-17 05:36:16','72cb6f3a-c105-4e1f-a725-9aadd642c5e7'),(766,2,236,22,0,4,'2022-11-17 05:36:16','2022-11-17 05:36:16','e4315734-56a7-490d-98c3-891167b310d4'),(767,2,236,24,0,5,'2022-11-17 05:36:16','2022-11-17 05:36:16','fa9ef11c-3948-49e6-8c20-08fe5812d273'),(786,40,212,125,0,0,'2022-11-17 06:22:43','2022-11-17 06:22:43','3bcc33cc-4439-438e-8cb8-539747f877f8'),(787,40,212,126,1,1,'2022-11-17 06:22:43','2022-11-17 06:22:43','02ec3893-bed9-4918-b20a-31a8e591a077'),(788,40,212,127,1,2,'2022-11-17 06:22:43','2022-11-17 06:22:43','1b80bff5-a8d0-46b5-9e0f-d97da607dcc7');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Asset','2022-11-16 06:42:21','2022-11-16 06:42:21',NULL,'155d9590-a8a9-44a0-b379-c089f17b9c37'),(2,'craft\\elements\\MatrixBlock','2022-11-16 06:42:22','2022-11-16 06:42:22',NULL,'a1f0f4d1-9056-4f56-b262-8722794749a3'),(3,'craft\\elements\\MatrixBlock','2022-11-16 06:42:23','2022-11-16 06:42:23','2022-11-16 10:17:46','339c0122-cc30-4d9b-bddf-5e32ed3cb83f'),(4,'craft\\elements\\MatrixBlock','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'4b0e5059-247d-4ef8-a8a6-3d1c7461be34'),(5,'craft\\elements\\Entry','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'240ed303-f7fd-4dc9-bffa-07b489cb529e'),(6,'verbb\\navigation\\elements\\Node','2022-11-16 06:42:25','2022-11-16 06:42:25','2022-11-16 09:54:37','1b65b6d9-e336-4a82-9d66-028627711de3'),(7,'verbb\\navigation\\elements\\Node','2022-11-16 06:42:25','2022-11-16 06:42:25','2022-11-16 09:54:35','5a222860-a794-4ec1-8f37-9f94f6dff7de'),(8,'craft\\elements\\MatrixBlock','2022-11-16 06:42:26','2022-11-16 06:42:26','2022-11-16 10:17:44','28250438-d9bd-4b01-9316-6ca8648d5b32'),(9,'craft\\elements\\MatrixBlock','2022-11-16 06:42:27','2022-11-16 06:42:27',NULL,'740cffdc-873e-42da-ab3b-9f6a01003077'),(10,'craft\\elements\\MatrixBlock','2022-11-16 06:42:28','2022-11-16 06:42:28','2022-11-16 10:17:45','6b6c5acd-7109-4ddb-820d-7ee84be86350'),(11,'verbb\\supertable\\elements\\SuperTableBlockElement','2022-11-16 06:42:28','2022-11-16 06:42:28',NULL,'79dd7d9f-7ef5-438e-9e9f-d231cc488aca'),(12,'craft\\elements\\Asset','2022-11-16 06:42:29','2022-11-16 06:42:29',NULL,'453ddd73-5986-4ead-a737-8a2775163520'),(13,'craft\\elements\\MatrixBlock','2022-11-16 06:42:29','2022-11-16 06:42:29',NULL,'a067cac1-ec42-43cc-b56a-f98e3b5b7803'),(14,'craft\\elements\\MatrixBlock','2022-11-16 06:42:30','2022-11-16 06:42:30',NULL,'8bdf956f-22c4-496a-9941-c6b7426ef9be'),(15,'craft\\elements\\MatrixBlock','2022-11-16 06:42:30','2022-11-16 06:42:30',NULL,'6a521951-ee4a-490a-93da-631e4286c554'),(16,'craft\\elements\\MatrixBlock','2022-11-16 06:42:30','2022-11-16 06:42:30',NULL,'030b6d0b-c5dc-459c-b3e0-6e508313ca31'),(17,'craft\\elements\\MatrixBlock','2022-11-16 06:42:31','2022-11-16 06:42:31',NULL,'71a6d7a6-25ac-452b-be15-ac1e85ee1f0c'),(18,'craft\\elements\\MatrixBlock','2022-11-16 06:42:32','2022-11-16 06:42:32',NULL,'4a46a896-31c8-4705-b7f5-c484fd7002bd'),(19,'craft\\elements\\MatrixBlock','2022-11-16 06:42:33','2022-11-16 06:42:33',NULL,'564ddb22-070a-4f59-9191-678a9a6aa04c'),(20,'craft\\elements\\MatrixBlock','2022-11-16 06:42:33','2022-11-16 06:42:33',NULL,'1316dcbc-3dc3-4533-9ef7-3d2d46216e72'),(21,'craft\\elements\\MatrixBlock','2022-11-16 06:42:34','2022-11-16 06:42:34',NULL,'95d89b00-d16f-4739-a893-bc7118fdb3e9'),(22,'craft\\elements\\MatrixBlock','2022-11-16 06:42:35','2022-11-16 06:42:35',NULL,'ddb9be0d-9c71-4e4a-82c1-e7bae599e577'),(23,'craft\\elements\\Entry','2022-11-16 06:42:35','2022-11-16 06:42:35',NULL,'1a82b273-bb1c-458c-b9a5-2722aa9e1020'),(24,'craft\\elements\\Entry','2022-11-16 06:42:35','2022-11-16 06:42:35',NULL,'40684536-4ae6-410b-9ab9-ce1f423c9427'),(25,'craft\\elements\\Entry','2022-11-16 06:42:35','2022-11-16 06:42:35',NULL,'44a33a2f-7625-459e-aed6-bd555138cbec'),(26,'craft\\elements\\Entry','2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'533207f0-30a6-4dc9-a13c-4b33b38129de'),(27,'craft\\elements\\Entry','2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'aa1d4284-387c-47e6-8cfa-1e77f71cfaef'),(28,'craft\\elements\\Entry','2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'3047450d-a8c1-4a0f-abac-55c4c060904f'),(29,'craft\\elements\\Entry','2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'3dfd712d-559c-4099-9f96-58d7e591e5ff'),(30,'craft\\elements\\Entry','2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'0e6296a2-ebef-4158-ba3d-e196af38899e'),(31,'craft\\elements\\Entry','2022-11-16 06:42:36','2022-11-16 06:42:36',NULL,'c07a4b2a-7329-47f6-99b5-a3b36287892e'),(32,'craft\\elements\\Entry','2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'b31791aa-909d-43be-a352-7970cd695247'),(33,'craft\\elements\\Entry','2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'40286c86-e98b-4ded-a26d-b9e7c32862f0'),(34,'craft\\elements\\Entry','2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'428ba83c-5ca7-4751-9529-c3d5c77739fc'),(35,'craft\\elements\\Entry','2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'3f206f90-5a6c-4c30-a73d-4ed5e65796db'),(36,'craft\\elements\\Entry','2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'6d89d782-8ec8-449f-9485-0863df883597'),(37,'craft\\elements\\User','2022-11-16 06:42:37','2022-11-16 06:42:37',NULL,'ca66fe73-6c5b-416c-9ddf-3b94de104a52'),(38,'craft\\elements\\MatrixBlock','2022-11-16 06:42:43','2022-11-16 06:42:43',NULL,'01865706-b1bf-4be6-bced-0738a08097c7'),(39,'verbb\\formie\\elements\\Form','2022-11-16 06:51:38','2022-11-16 06:51:38',NULL,'5a6cc733-5a7e-4d42-8501-95795c76de64'),(40,'verbb\\formie\\elements\\Form','2022-11-16 06:52:08','2022-11-17 06:22:43',NULL,'c06ea1fc-f602-430f-8b7d-a3dc5af4977a'),(41,'verbb\\navigation\\elements\\Node','2022-11-16 09:55:23','2022-11-16 09:55:23',NULL,'9ea0ed09-a2ca-4369-bd27-80cbae5f3458'),(42,'verbb\\navigation\\elements\\Node','2022-11-16 09:56:02','2022-11-16 09:56:02',NULL,'c8d846b3-7162-4e76-b1bf-8e0b47fae7b3'),(43,'craft\\elements\\MatrixBlock','2022-11-16 22:52:00','2022-11-16 22:52:00',NULL,'11ac70c8-3f82-4242-a7e6-04387ce9d1c7');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (104,37,'Content Admin','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"453bde0e-a795-4633-8040-222e1c3b8f8e\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b181050f-eab8-45f0-906a-c8241c2d3cf2\"}]',1,'2022-11-16 06:42:37','2022-11-16 06:42:37','89de91e6-9ff7-4611-aad2-6091680ede55'),(108,6,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"uid\":\"66bdaf44-647f-4a16-9a48-8728e53668f5\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\NodeTypeElements\",\"uid\":\"cf10bde2-037a-4050-9296-d13a1f59331f\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 06:42:38','2022-11-16 06:42:38','d36aafbb-41e1-4cc0-82e1-0bdd5fe8e389'),(112,7,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"uid\":\"7b1ad96e-a48e-4f0a-8dc9-1e13bcb4f3d8\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\NodeTypeElements\",\"uid\":\"27befde0-c1d2-4676-932c-18679a91cf44\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 06:42:38','2022-11-16 06:42:38','c1dae2bc-759c-4d6e-9e6b-86a4f54421a4'),(118,1,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\assets\\\\AssetTitleField\",\"uid\":\"c38c79bd-37a2-436d-b5b2-425ffbcff512\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\assets\\\\AltField\",\"uid\":\"fc671211-d55d-4f5d-b286-051141138624\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"requirable\":true,\"attribute\":\"alt\",\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"class\":null,\"rows\":null,\"cols\":null,\"name\":null,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"userCondition\":null,\"elementCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\",\"conditionRules\":[{\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\FileTypeConditionRule\",\"uid\":\"6746067f-ecaa-4bcd-b92d-421a65dfe38a\",\"operator\":\"in\",\"values\":[\"image\"]}]}},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"8574f116-bb2f-4ed9-9225-f90e2a6756e2\",\"width\":100,\"label\":\"Summary / Caption\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e47b95bf-7a74-49e3-afa3-a938bd733ef7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"aea191f8-91fb-4212-9984-9a9e70a24146\",\"width\":100,\"label\":\"Cover Image\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\",\"conditionRules\":[{\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\FileTypeConditionRule\",\"uid\":\"f6fcceaf-5241-4e7a-81fe-ace2e5f75ac6\",\"operator\":\"in\",\"values\":[\"audio\",\"compressed\",\"excel\",\"pdf\",\"powerpoint\",\"video\",\"word\"]}]},\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"ebbe2b10-5bc3-49b2-bc1c-9f7f3d3afb96\",\"width\":100,\"label\":\"Transcription\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\",\"conditionRules\":[{\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\FileTypeConditionRule\",\"uid\":\"7ba479ee-f825-4f2c-a44b-0ab0a4df9aab\",\"operator\":\"in\",\"values\":[\"audio\",\"video\"]}]},\"fieldUid\":\"6a1ab78a-ce1d-4e06-944f-7fa172aaa06a\"}]',1,'2022-11-16 06:42:39','2022-11-16 06:42:39','259afe9f-bdf2-48fc-bb4b-23537e764dfa'),(120,12,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\assets\\\\AssetTitleField\",\"uid\":\"52e15e4f-4d53-4b8d-8106-654d6e621e0c\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 06:42:39','2022-11-16 06:42:39','eeefc0c2-8e1c-4607-94af-2574c13d09fe'),(122,13,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"9ebdf9f9-f485-4eaa-8d3f-3dfbcb3e859a\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"30b5253e-1f74-41f3-b484-e6c82e3210d5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"25e6f7b0-ef21-41a3-bde5-2f2646a2779e\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1d242d6f-f863-4979-b2af-bb1da5c2aee2\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"482f9cf0-2950-4e81-a1ee-4dcd8c1a4597\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"dda1fa64-dd45-42b6-8df9-476cbac15152\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"db705720-4f45-4505-8b23-dd8e4c9fd2b0\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b8f98eab-bd44-4073-b73b-c5c394a00643\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"adf55cbb-40d8-4b6c-9618-e0f89cde467c\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e826463c-c088-426d-be5d-9630e1b872c9\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"510ff4bf-39e4-4dd7-ad78-851b7df7b254\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e44c7d4a-f794-4917-8a3f-e77e8162cc93\"}]',1,'2022-11-16 06:42:40','2022-11-16 06:42:40','cac765d1-21c1-46d6-addb-0dfd3c50eb9e'),(130,16,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"1ab4375b-4552-4f3d-be6c-051e5f50b17d\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"9d4f8876-987f-46fc-9042-aaf824a7131d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d1935261-af10-4a93-9d6e-ac4e9cd50639\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"07a0012a-4bdf-4aaa-8415-bbe06adaf62c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"58085824-b0ac-4ccb-be35-e8f3181916d5\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"0dabdba1-b0ed-4220-8bfd-115e5127ee42\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"8819b91b-089d-4d95-b23f-752efb7df8bb\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a7b99dca-7b58-438c-b57e-9d7965c3093b\"}]',1,'2022-11-16 06:42:41','2022-11-16 06:42:41','17da5594-72ac-4f5d-9596-133476199500'),(132,8,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"5a7b7ab8-2057-4a87-abf6-7710f61631a5\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"29f157fc-9918-4177-bcd3-55c2c5c9a38f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"185f0b37-ba39-4f30-bc42-6e34e0d95919\",\"width\":25,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"8217fe05-a738-46ef-940d-19f1348f18d6\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"9c255194-215d-44d5-83d0-f805e0d55a9c\",\"width\":25,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6cf35dcf-8c52-416d-8ce6-736d91b93f74\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"b8a7716f-d3ab-461a-b71d-479465f745c5\",\"width\":25,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a57a80dd-895b-4db9-9fb1-02ecff2a9086\"}]',1,'2022-11-16 06:42:42','2022-11-16 06:42:42','ecc76848-26ca-4eb1-bcdf-621e0e250ad2'),(134,17,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"bcd0b055-368d-4601-a190-ccedeb506394\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"34c8b184-a3df-4101-9525-d2c4a65aa9cb\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"e9097578-15ac-44ef-87fd-cc84292d97e2\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d08c5ca6-5020-4ac5-9460-c831d0921585\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"0312ee83-431f-46df-8213-cda6f2af4ed2\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6bd61b45-415d-4702-8b93-c734e25ed41e\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"78543238-2420-49c8-b9c8-9c94fb98ce92\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ea2610d5-eecb-4d99-916e-90ce7e2c2bbc\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"77738567-525c-4225-89b5-47b760aa84df\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"bfcd0468-97ee-40dd-9344-996e63ff7beb\"}]',1,'2022-11-16 06:42:42','2022-11-16 06:42:42','7d750c4a-98f2-471f-b70b-27b31afd4974'),(138,9,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"6608cdda-0c26-4552-8081-38603a7865de\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"dea0077f-b1c4-4d4d-be6c-72ae2f47e105\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"918a62a4-ab2c-457c-a8af-17d26af6cf87\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"20c62722-b003-461f-a9e8-763b2a9cbc21\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"8681f02a-2210-4f45-9404-ca6b2379ba31\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b911f8a5-3dbc-4aa9-8be2-9eb2c9c8a2ed\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"33fad8c0-e55c-48fa-a820-4a3b1170da8e\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a1609989-70ec-42e9-a2d0-ce1a902593c7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d19462e3-126a-44aa-8a47-c3866e36dbee\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"654452af-16fc-46e0-8dc7-0865935a5d62\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"a639dce8-c509-42c9-bceb-d6b914f14eb3\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c71f0a73-bd49-42fd-8d60-075e1800d924\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"c4c8d78c-c856-467b-9881-eb19c01d5072\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e29f44d4-5676-46d2-9a24-b7dce4058c40\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"9710241a-2726-4fe2-b278-2a92d6a64e90\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1a73a849-2233-4157-a6bf-b59605d0f83c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"83da7c64-7fbb-4ba4-aac6-30568b3bdd69\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1fcfe5f1-d6bb-41d8-a50a-14c2998b0b66\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"389e7c7c-63fb-456e-a55a-a1a9d5f63940\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c0c7cafe-5642-4171-81fa-ef73b6d7a36d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"289f32b0-d40f-4ea6-a183-d04811a7fd19\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b114569d-4057-4cc7-acc0-04ff0d55ef41\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"1a4d90e1-ea57-4c18-9a12-137dd2f165d9\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ffda0f34-d718-475b-b8ed-99c25f516b8b\"}]',1,'2022-11-16 06:42:44','2022-11-16 06:42:44','d1aaa0a6-b73f-406c-bc76-8576bc43d59b'),(140,18,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"4c2a4e63-e0b9-42d2-9959-51a05c681169\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"f121e5ad-eddc-485f-8d18-8f74c406c771\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"f59aff54-2470-449c-9cce-71c16a4b64f4\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"de70b474-8e41-4034-8450-229b89760037\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"2a390413-414b-4734-96be-abec31d6d760\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b750d657-987a-41b2-953b-807b6c688a88\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"2c242e2d-dc7e-4b85-be7b-3638b1ceffd3\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"17687c83-d165-4736-b0ae-59020efcb749\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"86947ec2-5295-40f3-a934-a32dee77abc9\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"87482970-1ffe-4760-a28d-cf986bbb8c72\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"97033d36-32f9-4d74-9f9b-da7524ba74dd\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"887c7e34-0b1f-40b8-b330-27d660a47d50\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"7ca869e4-46de-49ea-9f3e-9d3cccc2ad20\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"aebe2498-55fa-4926-8908-8a0bc8d303ba\"}]',1,'2022-11-16 06:42:45','2022-11-16 06:42:45','0c30a478-2b78-42e3-a501-8bf256ff5cb9'),(142,19,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"cf64b0c8-2197-4b35-882d-1efa6ff77c73\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e2cdac24-87bd-4a5b-be66-d991b0323794\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"9e12432b-9546-4b4c-8c78-08b969786487\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c27f9fb5-d0cc-4e10-841c-c739bfbdb971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"5f5876ee-6ad6-41e4-beba-f992b65a9810\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e8af3e49-fbce-4621-a06d-a3d56f425497\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"32fc547d-c5c4-4205-a400-fed243e51d88\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"bf152e62-fb69-4e45-836d-7546488987e6\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"41cfa4e2-45bf-495a-8ef7-5181c17669d7\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"abf72c9c-cdfc-4765-b71d-a03735da679d\"}]',1,'2022-11-16 06:42:46','2022-11-16 06:42:46','d9dcfac7-2f95-4e7f-8dff-5e8f93eb6332'),(146,10,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"2ee62636-b58e-4fe7-b077-abb820e66622\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a62dcf2c-64d8-4cb9-82b6-73cf878eff3d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"fefafdce-00fb-4ccf-b371-c885e1c4fe9b\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"fb9aac65-9df8-4d6f-b3e8-dec682391eb1\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"b08d4b70-1749-4bd8-8d60-f91a5d6895a0\",\"width\":25,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"76d6a612-0d42-461e-9c00-05cac551f775\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"5dac42b8-5cdf-4401-9c55-d95909acb68e\",\"width\":25,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"088d28b2-b2cf-4b3d-8741-de59b3784d07\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"bc08436f-8051-47b9-8b2b-8ccb3292d0a1\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"13d8c1ff-fb5e-44df-935d-fc33f1b35f6e\"}]',1,'2022-11-16 06:42:47','2022-11-16 06:42:47','b55a42a9-e6e5-46b0-9bb1-ef6fa0352253'),(148,3,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"df745945-b7e8-41ad-8368-981cfbcf8ff4\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"80ab6db6-b74b-4300-9d18-5f3a1f3eed59\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"2ccce7aa-0107-4cd6-893e-6519ed5cc513\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"83bbca72-25f6-496c-b095-52dcdf21323d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"8300fc50-1826-4d5e-8228-9cb5db33eb82\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"f318c0b9-c05e-4e37-b455-1c9372cd602e\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"9577d8d5-613c-46eb-830d-85925d84e23c\",\"width\":25,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c418b531-e6e7-4a06-bd70-e20e6e6e6950\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"5d3ca963-fb38-45fd-8dde-1e7676392084\",\"width\":25,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"500d3539-5d02-4c1a-97ba-890be8854857\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"2927452d-492c-41e1-96ce-43dddbe61140\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e21b715b-d604-4b2b-936e-a9b9ab272d39\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"87595b4e-1fa9-46c6-a577-510c36d9376f\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"4bedd98c-1f69-4364-b00a-c104f29b836c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"a28f9051-4bd0-4a08-8305-0f30ee8dda93\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"074ac1b8-ff0c-4993-a607-0b94b74cc84a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"1b66c32b-b609-424e-9329-84da64ba2bfb\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"8196fcb8-fa8a-48b2-a62d-8163c8bdc14a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"1294d2e3-8922-4c4e-9279-6e55283ff064\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"10491714-9ba1-4777-bb3c-d4e1083979aa\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"ec4df552-8666-48e7-a4c4-dbb0da43972a\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"dfcbd5d1-a56d-485a-bbe1-bb5fc49bec58\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"3f188024-2dec-43f4-bea8-a22157c4ef33\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e8c41477-003c-46c3-b6fb-449126b08709\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"bd646124-f14b-4f7a-a1b4-e7ea02442efb\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"7927f7ad-975c-4d46-948a-6bba692a6714\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"11a40eaa-6469-4dd4-b452-d80f18c4ddcd\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"183c2169-29b6-48fe-8dcd-c8b4945c8abd\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"b33a4a52-3065-4887-b867-5f06afd9797c\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6c74006c-0a40-4ee2-8129-d384c43b0f37\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"114ddc49-8bf9-4b08-8602-e54f95583216\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"047acefc-818d-4df0-83c5-d8b5a1ebf27c\"}]',1,'2022-11-16 06:42:48','2022-11-16 06:42:48','e58f85af-58d8-45fc-90b2-9f5a67050e8a'),(150,21,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"77234ae4-bd4c-458b-8160-c7ce2ce03346\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"468a14eb-fb24-4d42-85ea-51a108f68949\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"834dbe1f-7223-4c42-8f85-a2d0c90841c6\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c1193bb1-b500-4050-8b68-a0a7bee4594f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"47b29ed0-d72a-4b71-8929-6df841e61907\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ec26ccd6-8b77-446f-83e4-5a157ab84ee5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"62df11bc-39f6-447f-9ece-b024dd93def8\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"25414516-f079-42de-9891-f9dd403af271\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"da21838e-b116-4936-b3a5-42bdd92af0f3\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"fb8236c7-dc6f-45c6-b62d-6d6ffaaf1657\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"e7fbfa69-35ec-47dd-a3d7-3e328ea96ae6\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a53977b7-95c0-4ac6-bd66-2547ac6caa22\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"887aee5f-0935-49c2-a6b9-a2287f9cf273\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"2a64e6bd-a23b-4826-bc19-829c037e6e39\"}]',1,'2022-11-16 06:42:49','2022-11-16 06:42:49','70caaf25-ddf7-4109-b3f1-81e24c4423f5'),(152,4,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"2806c478-4604-42a9-8371-84017a7f9e9a\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"56c5070f-cf62-458c-9dc1-f775ee6f2380\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"bc6cb3c0-b5fd-4220-8970-0f845442acd2\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"cf8fe7e3-d6b1-4626-bd5f-9816c7b1cd1a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"f037bcf9-aaf4-45cd-90c7-d310d4f4679c\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"aa5de47f-bd21-4e66-9e6b-93f174062abc\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"8d6508d2-6cce-4cb1-b2ad-af30426626ff\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"9e4fa41f-fd14-4cd9-bc39-6ace1e57fe5c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"e5484552-2e33-4296-af9d-2fea3f641d8f\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e55d7836-b3e5-49a2-a9bf-afb1e7fd91d9\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"65929d1c-1f38-46eb-992b-977b1ce68b98\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"bdb06b40-a3b0-4a5c-a000-82f87c2f70d0\"}]',1,'2022-11-16 06:42:50','2022-11-16 06:42:50','06fcfa84-a4b0-40d3-9fa4-5e8e032778cd'),(154,22,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"dbb08e69-d9f5-44ac-955a-9aaa57de18c1\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"f3fc91f4-ef9e-4532-beaf-1c80b55b7233\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"e1606cf7-2992-4c96-99b3-6d962ecf7b8e\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b431aa28-7fd8-4a95-8ace-467582d8e01f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"e6db4a45-0247-4c09-918e-9dd563db1fa0\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"79001047-67b4-4b93-825f-333664a55c70\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d3b4e657-3c15-4be6-9e25-5540d2d09513\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1a28951d-82d5-47da-8ec8-ab405c40e0b8\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"f78019cd-ba94-4f38-bdf8-bef956b4bd6e\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ef8f5bd0-5250-42da-b861-c220362619e2\"}]',1,'2022-11-16 06:42:50','2022-11-16 06:42:50','fdd84f30-2bdd-479e-be58-143b9b45dbfd'),(166,24,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"47231d35-0018-4377-b46c-ae84f4e46fcc\",\"width\":100,\"label\":\"Page Title\",\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"ea61fb96-468b-4427-a0b4-a1b5dbb29752\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsHeaderBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"77db6e21-1b04-4dc7-b055-8b4e14e30ef3\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"0a342393-374b-4c57-8dcc-e08a394b84fd\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"90dfabd8-446b-40c7-958c-984a9647211d\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"e8450ae2-36ee-4f3b-837c-dd11c1cf4538\",\"width\":100,\"template\":\"_builders/controlpanel/matrixConditionalFields.twig\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 06:42:51','2022-11-16 06:42:51','201e19ec-430f-436f-bc75-9985641f2352'),(167,24,'Content Chunks','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"abe45b6a-3af5-405c-84e0-b9c8c640e611\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentChunks.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"4e2b9296-5d6e-40a4-af59-8da58b4bf78d\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b09bda91-6d4a-42c4-a824-f3d402ce20e7\"}]',2,'2022-11-16 06:42:51','2022-11-16 06:42:51','5dd83726-a9d9-4dd3-837a-50c8a37bab20'),(168,24,'Page Settings','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d2afd6a8-b5fe-4b5f-8d55-af5c501dcb75\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"373a4f64-b4a5-40fc-a09d-030d18293177\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"e4125718-7942-4545-8e0a-edb64323c89a\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"772247d2-d67e-40f2-a243-6e6eca55c5f5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"7ba2254d-ab6e-4818-a0bd-39f8002ea1e1\",\"width\":100,\"label\":\"Footer Fragment(s)\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c62ec2a4-1966-4b3c-a5d1-b0842235c23e\"}]',3,'2022-11-16 06:42:51','2022-11-16 06:42:51','2b82df5f-5521-4d7c-b079-1432a96c9a75'),(170,25,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"77d04eff-cd3c-4a0c-ae93-84839425651c\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"77905452-fd8c-4240-bf16-405547d53ffd\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"69ac403d-1688-46dc-ab62-a46257cb4e1b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\HorizontalRule\",\"uid\":\"76b95bbb-28ab-4496-922b-3f28af9c2e67\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"059fc1cc-7bc5-49db-b9ea-de548210dc96\",\"width\":50,\"label\":\"Message\",\"instructions\":\"A short one sentence message (80 characters)\",\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"58735c29-ebe5-47e8-9b0f-e9a5733458a5\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d339dd86-5cec-4889-b2d2-81f993979c61\"}]',1,'2022-11-16 06:42:51','2022-11-16 06:42:51','bb87b4cb-d2c3-4675-907e-f0d5a9bd8f90'),(172,26,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"23f2001a-68d1-4e13-8fad-0f5adf268f68\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"7629e19e-a60e-4c70-b2ac-8323dbf07065\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e47b95bf-7a74-49e3-afa3-a938bd733ef7\"}]',1,'2022-11-16 06:42:51','2022-11-16 06:42:51','8aae87ed-a55c-4e81-9745-e112fdc10a29'),(174,27,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"40c8f327-88fe-4e2a-8a36-de2ca24d8429\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"5e2d2d14-6437-4750-abcf-99c64af43f1b\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e47b95bf-7a74-49e3-afa3-a938bd733ef7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"b950ef0e-0c06-4d96-bba8-c1b7086cf852\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"9fa1da7e-12be-4b22-b43a-ef6d38a75f45\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"772247d2-d67e-40f2-a243-6e6eca55c5f5\"}]',1,'2022-11-16 06:42:51','2022-11-16 06:42:51','735982e5-b923-4f3c-bdb5-2b8bd24fe507'),(176,28,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"a94d8351-801a-48e7-b4d4-63bd171c0305\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"093a37c4-c5a0-4faa-a2cf-0053ab10a554\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"efb821b0-0d1d-4e26-8104-69187c662545\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6a1ab78a-ce1d-4e06-944f-7fa172aaa06a\"}]',1,'2022-11-16 06:42:51','2022-11-16 06:42:51','c4455f3e-a54b-45c1-b400-de704e346a49'),(178,29,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"66b19dcc-3c7c-4183-8914-5ef4a921400e\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"e9d7920c-442b-4c16-b2ce-278e11fcf660\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e47b95bf-7a74-49e3-afa3-a938bd733ef7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"145d2c09-1779-4d8e-947b-a356e58145d3\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"0760926f-dbcc-4b22-bec6-1ef130871e47\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"16ea4eb8-377b-4740-955d-89f60729fce4\"}]',1,'2022-11-16 06:42:52','2022-11-16 06:42:52','7d435989-cada-4c87-929c-cb36c4aa1be6'),(184,30,'Layout Designer','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"7f78bbcb-7f32-477a-ba16-b79baf60d778\",\"width\":100,\"label\":\"Page Title\",\"instructions\":\"This is the main page title. It will appear on the page unless you used the header builder.\",\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"d766d6d4-3d04-465a-b1ae-88f0c0d02827\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsHeaderBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"618ae43d-0a54-4835-a637-3662dbf41d4d\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"31763d74-d9d5-429f-8fe7-1d8ba7d5f229\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"7ac47f09-ee20-4f31-93a1-d14442cfdd2f\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"0aa7ff39-373d-49b2-bfcb-9b428ba0bf6b\",\"width\":100,\"template\":\"_builders/controlpanel/matrixConditionalFields.twig\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 06:42:52','2022-11-16 06:42:52','818faf38-587a-432a-ae15-0223cdae2343'),(185,30,'Content Chunks','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"4f12c4f4-4ab4-461c-9599-72085b9f2332\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentChunks.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"ee5c96a8-687c-4b14-bfdd-267277d4066e\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b09bda91-6d4a-42c4-a824-f3d402ce20e7\"}]',2,'2022-11-16 06:42:52','2022-11-16 06:42:52','226ff169-2ef9-4c9a-adc7-4ad41fe0047e'),(186,30,'Page Settings','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"fc50be8e-c504-4f3f-aa26-ba68f45b4f80\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d7777e9e-253d-42bc-92ba-52af6fb6bf4d\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"c7e8b1b6-6e23-4309-8750-e27c23cd78af\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"772247d2-d67e-40f2-a243-6e6eca55c5f5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"454fd9d7-d9b8-459c-a082-b3b3b6886bf0\",\"width\":100,\"label\":\"Footer Fragment(s)\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c62ec2a4-1966-4b3c-a5d1-b0842235c23e\"}]',3,'2022-11-16 06:42:52','2022-11-16 06:42:52','a533ce47-f77f-4d3b-add6-fa261e2823b1'),(188,31,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"cb05178f-1b70-401c-b614-ebf53f33a2a1\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"1ef221ce-d267-4c49-8a9a-1cb45f8500d7\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d64199e8-1588-4e7b-93a5-8bde2af6e3ba\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6a1ab78a-ce1d-4e06-944f-7fa172aaa06a\"}]',1,'2022-11-16 06:42:52','2022-11-16 06:42:52','c9dfb4a7-fbc1-41cb-8e49-6ebde7c55e97'),(192,32,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"3f9ed9b7-3cde-4499-a7a2-396bf7a3d33b\",\"width\":100,\"label\":\"Page Title\",\"instructions\":\"This is the main page title. It will appear on the page unless you used the header builder.\",\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"706c3a05-0cce-4331-8d53-2c66f752969d\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsHeaderBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"afef7495-b715-4717-900c-146a33e75450\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"1e1b2698-ace8-444b-af5d-e333a70dad96\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"3013d139-6ccf-4920-8105-9d74fb779d9c\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"1d2d5820-d225-4571-aba5-cb8f0f45d81d\",\"width\":100,\"template\":\"_builders/controlpanel/matrixConditionalFields.twig\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 06:42:52','2022-11-16 06:42:52','20e7b132-6229-47bf-8c01-9a2142ccfc2b'),(193,32,'Content Chunks','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"14196bc8-b742-42da-b42e-d9017bf2f230\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentChunks.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"b1440ecd-041f-4ef3-9850-009970b29d4a\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b09bda91-6d4a-42c4-a824-f3d402ce20e7\"}]',2,'2022-11-16 06:42:52','2022-11-16 06:42:52','7b8a24fa-23a4-4502-a297-045769f082c9'),(194,32,'Page Settings','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"da6fc831-aaa6-4d44-a48a-6c7ddd44dbf4\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"179a2beb-2983-434b-b1b1-4f7203ee0206\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d94261f6-2a33-4d40-9720-6f7d626ce8c0\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"772247d2-d67e-40f2-a243-6e6eca55c5f5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"64433471-dc20-433c-8c04-22dda5811bc1\",\"width\":100,\"label\":\"Footer Fragment(s)\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c62ec2a4-1966-4b3c-a5d1-b0842235c23e\"}]',3,'2022-11-16 06:42:52','2022-11-16 06:42:52','9f8c970f-637c-425e-b58c-19deaf4b7a95'),(197,33,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"53cb8baa-f384-4ef0-b722-6e76955c4341\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"314a12d3-18cf-445e-b040-c503f62a36ed\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"abeaf090-977e-4282-b84c-2feef8674c73\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6a1ab78a-ce1d-4e06-944f-7fa172aaa06a\"}]',1,'2022-11-16 06:42:53','2022-11-16 06:42:53','3d99a854-f397-48f2-bb53-3be188f296d1'),(198,33,'SEO','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"7625b54c-ea41-4033-8f06-ce4e1c2225bd\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"772247d2-d67e-40f2-a243-6e6eca55c5f5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"103a727c-7397-4a17-91fe-fa2c4e2d7ff4\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',2,'2022-11-16 06:42:53','2022-11-16 06:42:53','8c962eba-4012-42b8-8b82-8a42123a74bb'),(202,34,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"dd4c06b0-4735-4900-b07d-48ba38231994\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"76184b30-8fd7-4592-9f15-c8ed69afc161\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"772247d2-d67e-40f2-a243-6e6eca55c5f5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"5bf51005-3bb9-412e-adf4-7f150865f2ef\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"a8eeeea5-3bf1-46eb-8f82-8abc84922946\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"fb18a7d9-1148-4a3d-a5f5-6cb6b8ea2235\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsHeaderBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"bb156ffb-d69e-44cc-ad8c-5217d827f31d\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"c9b202cd-acd4-4b2c-ad50-11492b1cc603\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"7d767a26-af52-4bce-8587-abff92061600\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"4ac17ff9-5e7e-4a33-8a4d-59ba78173584\",\"width\":100,\"template\":\"_builders/controlpanel/matrixConditionalFields.twig\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 06:42:53','2022-11-16 06:42:53','100480a7-38f5-4090-8ea7-6b1e1f466a64'),(203,34,'Content Chunks','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"5c68d99d-276d-4d3a-af07-9780d95560ee\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentChunks.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"48ae06c6-bc85-41f7-80b0-92734b0ebc7a\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b09bda91-6d4a-42c4-a824-f3d402ce20e7\"}]',2,'2022-11-16 06:42:53','2022-11-16 06:42:53','c339eecb-e3d9-4f42-8063-61eadcc39dea'),(204,34,'Page Settings','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"3d765f0a-7ae3-4627-9277-6fe235f3bcf9\",\"width\":100,\"label\":\"Footer Fragment(s)\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c62ec2a4-1966-4b3c-a5d1-b0842235c23e\"}]',3,'2022-11-16 06:42:53','2022-11-16 06:42:53','8163b101-7568-4d0b-aed3-9882d54c5ad3'),(206,35,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"9ec137fd-9aca-4b45-bf1f-b627c9679d47\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"9cef4421-3b31-422a-ae46-d6e5363185f1\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"14d7d858-e4eb-4c44-90bc-a606a5a2372a\"}]',1,'2022-11-16 06:42:53','2022-11-16 06:42:53','c7a33653-3ea2-44ad-ab45-1b76935b4ac4'),(208,36,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"6909f8d4-4f55-4f0b-ba70-f931db078535\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"e834c304-da57-403e-ba6b-09430d71fde6\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e47b95bf-7a74-49e3-afa3-a938bd733ef7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"4e6bae1b-29c8-49d7-9bc8-c805096c0b20\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"78ca5d7f-a6d5-41ae-8160-8cac7b2bbe92\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"16ea4eb8-377b-4740-955d-89f60729fce4\"}]',1,'2022-11-16 06:42:53','2022-11-16 06:42:53','2174b7ee-9151-4332-ad0a-3715fafa203f'),(210,38,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"46966d97-b451-4b52-bd32-1f8c52565bc8\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"fa8573f7-ea9b-4f06-8ecd-1b91a778dbd9\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"a01208a5-4ff6-4fee-adf1-0482deb856fa\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ebab35b1-2b82-4883-aa61-9c554557708f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"fd6c223b-1548-4210-841b-eed3a6f0b114\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d40f6841-ce5c-4010-b41a-f7d8a1b30c93\"}]',1,'2022-11-16 06:42:55','2022-11-16 06:42:55','239e475d-18aa-4c25-9330-9f5c18b67919'),(211,39,'Page 1','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"c0997967-ecdd-4c7f-9503-231859a7e6be\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"62e3d09e-ff7a-4843-bf90-f6ceda67b960\"}]',0,'2022-11-16 06:51:38','2022-11-16 06:51:38','70713147-d753-452c-b154-80342cc5b4e2'),(212,40,'Page 1','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d06e1806-c3f9-4679-a534-b66a2506d1d4\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"0b9e9d8a-1cd4-4a63-aae6-4d1ed51bec5a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"729a3298-3134-4ed6-a3d2-ff725ff024b2\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c6caabbb-7be2-4464-bd5c-92b9509dc555\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"20a9690e-88c1-49f0-945b-5347f3389201\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"98928f6c-db75-4f56-b84b-a94f6d81cf85\"}]',0,'2022-11-16 06:52:08','2022-11-17 06:22:43','632f47b3-9110-4e1c-8eef-a1a2a67631d7'),(213,41,'Node','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"uid\":\"09042c3b-b303-4b3d-9fcc-e80205067075\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\NodeTypeElements\",\"uid\":\"32c569d1-d602-4f35-a3e4-d70b29907fcc\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\NewWindowField\",\"uid\":\"11e57b40-ebde-465c-9e41-70bdc7dc0105\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"mandatory\":false,\"requirable\":true,\"attribute\":\"newWindow\",\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"translatable\":false,\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 09:55:23','2022-11-16 09:55:23','78284955-9c25-48e0-a101-af21dd12471a'),(214,41,'Advanced','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\UrlSuffixField\",\"uid\":\"037f4399-ba6e-4423-b83c-8413a3fc743d\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"mandatory\":false,\"requirable\":true,\"attribute\":\"urlSuffix\",\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"translatable\":false,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"maxlength\":null,\"autofocus\":false,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\ClassesField\",\"uid\":\"0d2bcf5a-d7f7-44fa-895b-35412982fc85\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"mandatory\":false,\"requirable\":true,\"attribute\":\"classes\",\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"translatable\":false,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"maxlength\":null,\"autofocus\":false,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\CustomAttributesField\",\"uid\":\"a5a9c479-0b25-4a5c-bfef-6a73c7564c7b\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"mandatory\":false,\"requirable\":true,\"attribute\":\"customAttributes\",\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"translatable\":false,\"userCondition\":null,\"elementCondition\":null}]',2,'2022-11-16 09:55:23','2022-11-16 09:55:23','8c4fe6be-094c-4072-9ecb-2a91ff322b77'),(215,42,'Node','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"uid\":\"2eb6da45-f3c5-411b-aaa5-1b97bf202f3a\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\NodeTypeElements\",\"uid\":\"888b6738-b9b4-4e2d-b8a7-5ea5b985b8fb\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\NewWindowField\",\"uid\":\"aa217a6b-c29a-4bb2-902e-18b914acf079\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"mandatory\":false,\"requirable\":true,\"attribute\":\"newWindow\",\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"translatable\":false,\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 09:56:02','2022-11-16 09:56:02','289d3632-8871-4105-a783-0093a5015415'),(216,42,'Advanced','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\UrlSuffixField\",\"uid\":\"8d1ba919-94cc-4452-b6c5-a767a6fbf19b\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"mandatory\":false,\"requirable\":true,\"attribute\":\"urlSuffix\",\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"translatable\":false,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"maxlength\":null,\"autofocus\":false,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\ClassesField\",\"uid\":\"aa095808-7e42-4d28-862a-49cd6bd36f69\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"mandatory\":false,\"requirable\":true,\"attribute\":\"classes\",\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"translatable\":false,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"maxlength\":null,\"autofocus\":false,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\CustomAttributesField\",\"uid\":\"8f117706-31ba-4031-ad41-67c753f25436\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"mandatory\":false,\"requirable\":true,\"attribute\":\"customAttributes\",\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"translatable\":false,\"userCondition\":null,\"elementCondition\":null}]',2,'2022-11-16 09:56:02','2022-11-16 09:56:02','8607ca9b-3afd-4371-bab4-aaf2f7140474'),(221,23,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"aff7c356-6d38-41f0-8ad6-1611b9d0470f\",\"width\":100,\"label\":\"Page Title\",\"instructions\":\"This is the main page title. It will appear on the page unless you used the header builder.\",\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"a9440325-5030-48ac-8db3-064cc4750400\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsHeaderBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"45d1c2b8-3ae2-4ac7-b698-663d5e301564\",\"width\":100,\"label\":\"__blank__\",\"instructions\":\"Use the block below to customize the hero section for this page\",\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"868120ed-342e-4a60-b979-5bc194680518\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"5f1c3647-1a55-497b-a7c2-33cbf90ecae4\",\"width\":100,\"label\":\"__blank__\",\"instructions\":\"Use the blocks below to construct the body of your entry. Each block contains specific settings and content requirements.\",\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"64393159-3e89-4faa-9aaa-11de8dcd8b2a\",\"width\":100,\"template\":\"_builders/controlpanel/matrixConditionalFields.twig\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-11-16 11:35:59','2022-11-16 11:35:59','7309709a-e27a-4226-a2c1-5685670c4c51'),(222,23,'Sidebar','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"ad4c755b-f0ca-48dc-b0d9-211e845bc0fb\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsSidebarBuilder.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"f6cccab6-cc19-437f-84cc-fcbd912b8ae6\",\"width\":100,\"label\":\"__blank__\",\"instructions\":\"Use the blocks below to construct the sidebar of your entry. Each block contains specific settings and content requirements.\",\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a35a0beb-0cf7-4a2b-9ec3-91e953a18116\"}]',2,'2022-11-16 11:35:59','2022-11-16 11:35:59','e6f941ab-670b-4aa1-83f6-1ebb29e90282'),(223,23,'Content Chunks','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"b72bf7f1-6cf2-4014-9722-4d0da57563d8\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentChunks.twig\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"1f67b2a4-7a46-456a-bcd3-2a82af00f1ac\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b09bda91-6d4a-42c4-a824-f3d402ce20e7\"}]',3,'2022-11-16 11:35:59','2022-11-16 11:35:59','1cbeeae6-6012-4c05-ac30-e7fe9623d3be'),(224,23,'Page Settings','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"645515ab-242d-4610-a4e6-2238a3f66628\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d29e982c-a5a6-4cf0-979c-70c6ce0cf0fb\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d61974ce-b568-4fe3-8df6-8c5325cd4f91\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"772247d2-d67e-40f2-a243-6e6eca55c5f5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"36536b1f-7aba-4adb-bda7-2cc207ba7589\",\"width\":100,\"label\":\"Footer Fragment(s)\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c62ec2a4-1966-4b3c-a5d1-b0842235c23e\"}]',4,'2022-11-16 11:35:59','2022-11-16 11:35:59','25183390-3692-4379-9b10-d39ff01ebbbb'),(225,14,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d7d5a905-296f-41be-8522-8a08ada18196\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"68b93e4b-8d64-4598-b7c7-7e34609198b2\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"43a89a21-6e23-49ac-8412-0a26a4d3c3d1\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"f92a01b3-02b6-427e-9141-3dd789bbef6f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"e31380db-5e73-4fdd-92ae-8d0aa327ad62\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c832b847-2fbc-4a68-ac50-698b165e4fc3\"}]',1,'2022-11-16 11:36:25','2022-11-16 11:36:25','dae834e1-6140-423f-bd63-1f6c477bb162'),(226,20,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"f86bcee9-d9db-4dd1-87de-ed8972b3a69a\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"af48dd81-f2f9-4b6e-83b6-81012dc228db\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"f8880e59-49d0-42a6-bdb9-8b6deecb2a02\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"0634113d-5014-46e7-a319-61f78258ce62\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"ff052687-edde-4835-98ed-cc18bde86677\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"f8f98780-0d0a-46aa-b8bf-3986a32262ac\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"be21fc74-d3cd-4d09-ba29-340d5ea1357a\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ffb53008-0128-493f-9c96-5f66a6a83565\"}]',1,'2022-11-16 11:36:25','2022-11-16 11:36:25','52cdd53c-459a-4d7d-b958-d80384896622'),(228,5,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"uid\":\"8534454a-8dda-4499-8321-155586e2654c\",\"width\":100,\"label\":null,\"instructions\":\"Describe this fragment to make it easier for content editors to find in the future.\",\"tip\":null,\"warning\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"c84b3440-e6c2-4cba-bb81-14384a2b665e\",\"width\":100,\"label\":\"What kind of fragment do you want to create?\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"36dbc7a6-4add-4410-8718-a9f8d7e2da97\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"a18c1716-fe54-40b0-82bf-63ecb26a55b6\",\"width\":100,\"template\":\"_builders/controlpanel/instructionsContentBuilder.twig\",\"userCondition\":null,\"elementCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\",\"conditionRules\":[{\"class\":\"craft\\\\fields\\\\conditions\\\\TextFieldConditionRule\",\"uid\":\"91730e32-5222-421b-870a-900f971d595b\",\"operator\":\"=\",\"value\":\"contentBuilder\",\"fieldUid\":\"36dbc7a6-4add-4410-8718-a9f8d7e2da97\"}]}},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"4886831b-bb98-4016-8f27-ae84c1314744\",\"width\":100,\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\",\"conditionRules\":[{\"class\":\"craft\\\\fields\\\\conditions\\\\TextFieldConditionRule\",\"uid\":\"6eb3ad1d-c65d-4fed-b60b-9c16bda02f13\",\"operator\":\"=\",\"value\":\"contentBuilder\",\"fieldUid\":\"36dbc7a6-4add-4410-8718-a9f8d7e2da97\"}]},\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Template\",\"uid\":\"b0f2bfcc-aaac-45ff-b420-08fe0a5614b2\",\"width\":100,\"template\":\"_builders/controlpanel/matrixConditionalFields.twig\",\"userCondition\":null,\"elementCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\",\"conditionRules\":[{\"class\":\"craft\\\\fields\\\\conditions\\\\TextFieldConditionRule\",\"uid\":\"d82b4ab5-0c90-4ca9-8615-e0cfe205ad9b\",\"operator\":\"=\",\"value\":\"contentBuilder\",\"fieldUid\":\"36dbc7a6-4add-4410-8718-a9f8d7e2da97\"}]}},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"54c3c8b3-ed2c-4fcc-b2fc-f98fd7ab4b33\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\",\"conditionRules\":[{\"class\":\"craft\\\\fields\\\\conditions\\\\TextFieldConditionRule\",\"uid\":\"c9a3b42a-71b3-4472-84cd-4d4ec6223691\",\"operator\":\"=\",\"value\":\"subscribe\",\"fieldUid\":\"36dbc7a6-4add-4410-8718-a9f8d7e2da97\"}]},\"fieldUid\":\"6a1ab78a-ce1d-4e06-944f-7fa172aaa06a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"505f133f-0ebe-4d06-ba5a-0ca53114588f\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\",\"conditionRules\":[{\"class\":\"craft\\\\fields\\\\conditions\\\\TextFieldConditionRule\",\"uid\":\"3058fcda-d3d1-407e-9a46-fd7c40562b0c\",\"operator\":\"=\",\"value\":\"customHTML\",\"fieldUid\":\"36dbc7a6-4add-4410-8718-a9f8d7e2da97\"}]},\"fieldUid\":\"3def122c-77bc-465f-b54f-4bba4ecfab39\"}]',1,'2022-11-16 21:25:07','2022-11-16 21:25:07','c51ca2c5-e211-4b0f-aedb-ec23acc395a9'),(229,15,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"8b020226-579d-4e9a-9d09-f019db9c797a\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"0554821f-40fc-4bf7-bd90-a3a2581c88ab\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"b6b12061-1c20-4a22-beb8-139fa8024cfb\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"4e1fbf94-015b-4a5b-880a-8e7051457536\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"339349c3-d933-493a-ac39-7ead1e90ab9f\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a99de532-088e-484b-94fc-945b766ee947\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"91e9064c-7a4f-4ae5-b780-379354f7dd9f\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1aa226f6-fbd8-4cb9-94b9-26bca8299a04\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"ebf53c92-59b5-485f-90e0-24feb2144145\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e2490fe0-802e-4be2-8173-d77847a05e26\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"5e714675-b281-46bc-8b74-766940d696df\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b04167bb-2563-4547-99d7-2f6a3331a57b\"}]',1,'2022-11-16 22:52:00','2022-11-16 22:52:00','04b77bf4-524c-4e70-8fad-86c4b383525c'),(230,43,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"8d2bfba5-3be5-4c1c-a617-dbf656a06bbf\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"98433f5b-b542-41ff-a0ca-915026fb4455\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"bc8eaf9b-92bf-44e6-8eab-15700aea91ab\",\"width\":75,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b6689e78-2cda-4120-a5a3-7337cec63b2c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"cd20ca56-f365-43b4-bfab-55fa2f5db314\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"0553ed4a-8d9c-42be-855a-82fb23a24aac\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"7fb2e6cb-6236-417c-831b-720e8aa698a6\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"2d9e094a-7b59-4560-841c-138c5391fe7c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"8e41ae63-b864-4c85-9e8d-3713412392c5\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"5f8fc242-fe03-4416-9cd3-f32841e4b6ca\"}]',1,'2022-11-16 22:52:00','2022-11-16 22:52:00','964906e7-2633-4e1b-b324-1deefe2b0bb3'),(235,11,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"61cadeca-8dfa-4a6e-86ec-b11ac8f1e6a4\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1ddd814c-a3f1-4689-bb67-33d04ad8307a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"69ae4ad8-d5b8-4026-a6cd-9eccd9a8f0be\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"69c2d7dc-3df8-4df1-a444-d2ae376da00c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d93f1dbf-17fa-41ab-b73e-bdf543d358d6\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"fd647249-c4ea-4ade-99ab-13f9e53bba3f\"}]',1,'2022-11-17 05:36:16','2022-11-17 05:36:16','0e802755-824f-48de-979f-ee9d5fd2bf97'),(236,2,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"33aeadab-024e-46c6-9f23-3bdae21f68da\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ae3f34db-5fe5-4438-86f0-377cfaebf02a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"6017252d-7c65-4716-8587-0267805477aa\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c6677eab-6c78-4ca1-93cd-0faa266d1c45\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"2f595a52-9846-4c22-a6d4-d5436eca92a9\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a6c56b68-6955-44a2-a86d-198b65955f13\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"4043fe8b-846c-4408-af28-90d689ede417\",\"width\":100,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"5347a201-6da8-47ff-bc5b-20a0dc63d44e\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"a9125f69-85d0-464d-a645-9adf0935f0d9\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"7b72b671-dcdc-49b2-95cd-44a8e8be7cad\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"uid\":\"d6cead47-c085-40f3-975f-ce5f00b44f23\",\"width\":50,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a1a62d7a-5173-4caf-8d92-423b6dc0dede\"}]',1,'2022-11-17 05:36:16','2022-11-17 05:36:16','6272049f-8eaf-4847-a1fc-52a1f881a7a9');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (1,3,'Button','button','global','lvxnzhkr',NULL,0,'none',NULL,'lenz\\linkfield\\fields\\LinkField','{\"allowCustomText\":true,\"allowTarget\":true,\"autoNoReferrer\":true,\"customTextMaxLength\":0,\"customTextRequired\":false,\"defaultLinkName\":\"url\",\"defaultText\":\"Click here\",\"enableAllLinkTypes\":false,\"enableAriaLabel\":false,\"enableElementCache\":false,\"enableTitle\":false,\"typeSettings\":{\"asset\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":false,\"sources\":\"*\"},\"category\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":true,\"sources\":\"*\"},\"custom\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"email\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"entry\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":true,\"sources\":\"*\"},\"site\":{\"enabled\":true,\"sites\":\"*\"},\"tel\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"url\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"user\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":false,\"sources\":\"*\"}}}','2022-11-16 06:42:18','2022-11-16 06:42:18','d339dd86-5cec-4889-b2d2-81f993979c61'),(2,6,'Content Builder','contentBuilder','global',NULL,NULL,1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":null,\"maxBlocks\":null,\"contentTable\":\"{{%matrixcontent_contentbuilder}}\",\"propagationMethod\":\"all\",\"propagationKeyFormat\":null}','2022-11-16 06:42:18','2022-11-16 11:34:36','a4fe99b5-7832-4eb2-9833-f551177bb821'),(3,6,'Show Block Meta','showBlockMeta','global','cvrpdgoz','When enabled, you will see the setting information for each content block through-out the site.',0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-11-16 06:42:19','2022-11-16 06:42:19','b181050f-eab8-45f0-906a-c8241c2d3cf2'),(4,5,'Fragment Subtype','fragmentType','global','rdkrtdam',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_sections/fragments/basicFragments.json\"}','2022-11-16 06:42:19','2022-11-16 06:42:19','36dbc7a6-4add-4410-8718-a9f8d7e2da97'),(5,1,'Lead Image(s)','images','global',NULL,NULL,1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{%- set folder = object.folder ??? false -%} {%- if folder %}{{ ( folder == \'Uploads\' ) ? \'asset-meta\' : folder ~ \'/asset-meta\' }}{% endif -%} {%- if not folder -%}     {{- ( object.variants   ?? null  ) ? \\\"products/#{object.type.handle|lower}/\\\" : \'\' -}}     {{- ( object.product    ?? null  ) ? \\\"products/#{object.product.type.handle|lower}/\\\" : \'\' -}}     {{- ( object.section    ?? null  ) ? \\\"#{object.section.handle|lower}/\\\" : \'\' -}}     {{- ( object.parentUri  ?? null  ) ? \\\"#{object.parentUri|replace(\'__\',\'\')}/\\\" : \'\' -}}     {{object.slug}} {%- endif -%}\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":[\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-11-16 06:42:19','2022-11-16 06:42:19','adcea45e-bf40-4faf-b0c8-4ce089696971'),(7,4,'Dek','dek','global',NULL,'A short one or two sentence description or summary of the content. ',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Dek.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:19','2022-11-16 06:42:19','b1c52a06-4990-43f5-90d3-898a48789556'),(8,1,'Fragment(s)','fragments','global',NULL,NULL,0,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\"},\"selectionLabel\":\"Choose fragment\",\"showSiteMenu\":false,\"source\":null,\"sources\":[\"section:89093e20-515d-4e3c-b4c4-c6733d8ab56f\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-11-16 06:42:19','2022-11-16 06:42:19','c62ec2a4-1966-4b3c-a5d1-b0842235c23e'),(9,6,'Chunks','chunks','global',NULL,NULL,1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":null,\"maxBlocks\":null,\"contentTable\":\"{{%matrixcontent_chunks}}\",\"propagationMethod\":\"all\",\"propagationKeyFormat\":null}','2022-11-16 06:42:19','2022-11-16 11:36:25','b09bda91-6d4a-42c4-a824-f3d402ce20e7'),(10,1,'Emergency Message Layout','eMsgLayout','global','zfkvvptv',NULL,0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"All Pages\",\"value\":\"allPages\",\"default\":\"\"},{\"label\":\"Home Page Only\",\"value\":\"homePageOnly\",\"default\":\"\"}]}','2022-11-16 06:42:20','2022-11-16 06:42:20','69ac403d-1688-46dc-ab62-a46257cb4e1b'),(11,1,'Color','color','global','kgjpyuvd',NULL,0,'none',NULL,'craft\\fields\\Color','{\"defaultColor\":null}','2022-11-16 06:42:20','2022-11-16 06:42:20','16ea4eb8-377b-4740-955d-89f60729fce4'),(12,3,'Redirect','redirect','global','hjoahmzs',NULL,0,'none',NULL,'lenz\\linkfield\\fields\\LinkField','{\"allowCustomText\":false,\"allowTarget\":false,\"autoNoReferrer\":false,\"customTextMaxLength\":0,\"customTextRequired\":false,\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAllLinkTypes\":false,\"enableAriaLabel\":false,\"enableElementCache\":false,\"enableTitle\":false,\"typeSettings\":{\"asset\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":false,\"sources\":\"*\"},\"category\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":true,\"sources\":\"*\"},\"custom\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"email\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":false},\"entry\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":true,\"sources\":\"*\"},\"site\":{\"enabled\":true,\"sites\":\"*\"},\"tel\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":false},\"url\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"user\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":false,\"sources\":\"*\"}}}','2022-11-16 06:42:20','2022-11-16 06:42:20','14d7d858-e4eb-4c44-90bc-a606a5a2372a'),(13,1,'Topics','topics','global',NULL,NULL,0,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\"},\"selectionLabel\":\"Add Topic\",\"showSiteMenu\":false,\"source\":null,\"sources\":[\"section:942cbdfb-d50d-4dcd-9032-4f483562d1dd\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-11-16 06:42:20','2022-11-16 06:42:20','772247d2-d67e-40f2-a243-6e6eca55c5f5'),(14,4,'Code','code','global','jcmiyhiw',NULL,0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":true,\"columnType\":null,\"initialRows\":10,\"multiline\":true,\"placeholder\":null,\"uiMode\":\"normal\"}','2022-11-16 06:42:20','2022-11-16 06:42:20','3def122c-77bc-465f-b54f-4bba4ecfab39'),(16,4,'Text','text','global','qieovwoa',NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:20','2022-11-16 06:42:20','6a1ab78a-ce1d-4e06-944f-7fa172aaa06a'),(17,4,'Summary','summary','global','wtwwruam',NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"SimpleAir.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:20','2022-11-16 06:42:20','e47b95bf-7a74-49e3-afa3-a938bd733ef7'),(18,6,'Header Builder','headerBuilder','global',NULL,NULL,1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_headerbuilder}}\",\"maxBlocks\":1,\"minBlocks\":0,\"propagationKeyFormat\":null,\"propagationMethod\":\"all\"}','2022-11-16 06:42:20','2022-11-16 06:42:20','d05f4009-0b38-4065-a1b1-65221aa65e63'),(20,1,'Form','form','global',NULL,NULL,0,'site',NULL,'verbb\\formie\\fields\\Forms','{\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionLabel\":null,\"showSiteMenu\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-11-16 06:42:21','2022-11-16 06:42:21','51de348b-07ba-461d-930e-6c85778ed95d'),(21,6,'Sidebar Builder','sidebarBuilder','global',NULL,NULL,1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":null,\"maxBlocks\":null,\"contentTable\":\"{{%matrixcontent_sidebarbuilder}}\",\"propagationMethod\":\"all\",\"propagationKeyFormat\":null}','2022-11-16 06:42:21','2022-11-16 10:18:10','a35a0beb-0cf7-4a2b-9ec3-91e953a18116'),(22,NULL,'Background','bg','matrixBlockType:213c9175-81d2-4141-8993-904e59925583','ngczrvyg','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgrounds.json\"}','2022-11-16 06:42:21','2022-11-16 06:42:21','7b72b671-dcdc-49b2-95cd-44a8e8be7cad'),(23,NULL,'Repeating Content Items','items','matrixBlockType:213c9175-81d2-4141-8993-904e59925583',NULL,'Individual content snippets to be arranged based on the layout',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"blockTypeFields\":0,\"changedFieldIndicator\":13520478,\"columns\":{\"1ddd814c-a3f1-4689-bb67-33d04ad8307a\":{\"width\":\"\"},\"69c2d7dc-3df8-4df1-a444-d2ae376da00c\":{\"width\":\"\"},\"fd647249-c4ea-4ade-99ab-13f9e53bba3f\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_1_items}}\",\"fieldLayout\":\"matrix\",\"maxRows\":null,\"minRows\":null,\"propagationKeyFormat\":null,\"propagationMethod\":\"all\",\"selectionLabel\":\"Add Content Item\",\"staticField\":null}','2022-11-16 06:42:21','2022-11-17 05:36:16','5347a201-6da8-47ff-bc5b-20a0dc63d44e'),(24,NULL,'Spacing','spacing','matrixBlockType:213c9175-81d2-4141-8993-904e59925583','vdailebf','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacing.json\"}','2022-11-16 06:42:22','2022-11-16 06:42:22','a1a62d7a-5173-4caf-8d92-423b6dc0dede'),(25,NULL,'Image(s)','images','matrixBlockType:213c9175-81d2-4141-8993-904e59925583',NULL,NULL,0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\",\"json\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{{- ( object.owner.variants   ?? null  ) ? \\\"products/#{object.owner.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.product    ?? null  ) ? \\\"products/#{object.owner.product.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.section    ?? null  ) ? \\\"#{object.owner.section.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.parentUri  ?? null  ) ? \\\"#{object.owner.parentUri|replace(\'__\',\'\')}/\\\" : \'\' -}} {{object.owner.slug}}\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":null,\"showSiteMenu\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2022-11-16 06:42:22','2022-11-16 06:42:22','a6c56b68-6955-44a2-a86d-198b65955f13'),(26,NULL,'Layout Variant','variant','matrixBlockType:213c9175-81d2-4141-8993-904e59925583','ulxtrpcp','Change the block layout without changing its underlying content',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockContentRepeater.json\"}','2022-11-16 06:42:22','2022-11-16 06:42:22','ae3f34db-5fe5-4438-86f0-377cfaebf02a'),(27,NULL,'Text (Intro)','text','matrixBlockType:213c9175-81d2-4141-8993-904e59925583',NULL,'Headline / headnote regarding the repeating content items (optional)',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:22','2022-11-16 06:42:22','c6677eab-6c78-4ca1-93cd-0faa266d1c45'),(44,NULL,'External Media','externalMedia','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe','uhslrpql','Paste direct links to 3rd party hosted media (Youtube, Vimeo, etc)',0,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add External Media \",\"columnType\":\"text\",\"columns\":{\"col1\":{\"heading\":\"URL\",\"handle\":\"url\",\"width\":\"\",\"type\":\"url\"}},\"defaults\":null,\"maxRows\":null,\"minRows\":null}','2022-11-16 06:42:24','2022-11-16 06:42:24','9e4fa41f-fd14-4cd9-bc39-6ace1e57fe5c'),(45,NULL,'Layout Variant','variant','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe','grrnasml','Change the block layout without changing its underlying content',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockMediaContent.json\"}','2022-11-16 06:42:24','2022-11-16 06:42:24','56c5070f-cf62-458c-9dc1-f775ee6f2380'),(46,NULL,'Local Media','media','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe',NULL,'Files uploaded direcrtly to the CMS.',1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"audio\",\"excel\",\"pdf\",\"powerpoint\",\"video\",\"word\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{{- ( object.owner.variants   ?? null  ) ? \\\"products/#{object.owner.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.product    ?? null  ) ? \\\"products/#{object.owner.product.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.section    ?? null  ) ? \\\"#{object.owner.section.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.parentUri  ?? null  ) ? \\\"#{object.owner.parentUri|replace(\'__\',\'\')}/\\\" : \'\' -}} {{object.owner.slug}}\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose Media\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-11-16 06:42:24','2022-11-16 06:42:24','aa5de47f-bd21-4e66-9e6b-93f174062abc'),(47,NULL,'Spacing','spacing','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe','lcpsbupz','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacing.json\"}','2022-11-16 06:42:24','2022-11-16 06:42:24','bdb06b40-a3b0-4a5c-a000-82f87c2f70d0'),(48,NULL,'Text','text','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe','lriaudff',NULL,0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":false,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:24','2022-11-16 06:42:24','cf8fe7e3-d6b1-4626-bd5f-9816c7b1cd1a'),(49,NULL,'Background','bg','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe','qbjriieh','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgrounds.json\"}','2022-11-16 06:42:25','2022-11-16 06:42:25','e55d7836-b3e5-49a2-a9bf-afb1e7fd91d9'),(54,NULL,'Sort order','order','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f','ympxzups',NULL,0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Most Recent\",\"value\":\"mostRecent\",\"default\":\"\"},{\"label\":\"Random\",\"value\":\"random\",\"default\":\"\"},{\"label\":\"Alphabetical by Title\",\"value\":\"alphabeticalByTitle\",\"default\":\"\"}]}','2022-11-16 06:42:26','2022-11-16 06:42:26','1a73a849-2233-4157-a6bf-b59605d0f83c'),(55,NULL,'Total results to return','limit','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f','xctinfgl','Limit your search to a specific number of results.',0,'none',NULL,'craft\\fields\\Number','{\"decimals\":0,\"defaultValue\":3,\"max\":null,\"min\":1,\"prefix\":null,\"previewCurrency\":null,\"previewFormat\":\"decimal\",\"size\":4,\"suffix\":null}','2022-11-16 06:42:26','2022-11-16 06:42:26','1fcfe5f1-d6bb-41d8-a50a-14c2998b0b66'),(56,NULL,'How do you want to pick  which entries to embed?','method','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f','eqfrdkfb',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/selectionMethod.json\"}','2022-11-16 06:42:26','2022-11-16 06:42:26','20c62722-b003-461f-a9e8-763b2a9cbc21'),(57,NULL,'Alternate card','card','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f','odhcrdvx','Override the suggested card design for this variant and use this one',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/overrideCards.json\"}','2022-11-16 06:42:26','2022-11-16 06:42:26','654452af-16fc-46e0-8dc7-0865935a5d62'),(58,NULL,'Content Entries','items','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,'Choose the existing content items to embed here.',1,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\"},\"selectionLabel\":\"Add Content\",\"showSiteMenu\":true,\"source\":null,\"sources\":[\"section:a52e2b08-2e30-4b00-8784-4104c409d3ed\",\"section:c2b6d2e5-34ab-410c-8b3b-f752217b7552\",\"section:3721b4d6-42d5-41fc-b6e7-76204b42c91a\",\"section:650e7d1d-63e5-42f9-b3ab-4febfb502723\",\"section:942cbdfb-d50d-4dcd-9032-4f483562d1dd\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-11-16 06:42:26','2022-11-16 06:42:26','a1609989-70ec-42e9-a2d0-ce1a902593c7'),(59,NULL,'Text (Intro)','text','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,'Headline / headnote regarding the content being embedded (optional)',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:26','2022-11-16 06:42:26','b911f8a5-3dbc-4aa9-8be2-9eb2c9c8a2ed'),(60,NULL,'Background','bg','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f','ccgrpbfv','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgrounds.json\"}','2022-11-16 06:42:26','2022-11-16 06:42:26','b114569d-4057-4cc7-acc0-04ff0d55ef41'),(61,NULL,'Results per page','perPage','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f','pmubvmbx','Pagination (next/previous links) will appear after this many results (if supported by the layout)',0,'none',NULL,'craft\\fields\\Number','{\"decimals\":0,\"defaultValue\":12,\"max\":null,\"min\":-1,\"prefix\":null,\"previewCurrency\":null,\"previewFormat\":\"decimal\",\"size\":4,\"suffix\":null}','2022-11-16 06:42:26','2022-11-16 06:42:26','c0c7cafe-5642-4171-81fa-ef73b6d7a36d'),(62,NULL,'Filter by content type','contentType','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f','wzxkluqz','Results will only include this type of content',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"FAQs\",\"value\":\"faqs\",\"default\":\"\"},{\"label\":\"Feedback\",\"value\":\"feedback\",\"default\":\"\"},{\"label\":\"News\",\"value\":\"news\",\"default\":\"\"},{\"label\":\"Pages\",\"value\":\"pages\",\"default\":\"\"},{\"label\":\"Topics\",\"value\":\"topics\",\"default\":\"\"}]}','2022-11-16 06:42:27','2022-11-16 06:42:27','c71f0a73-bd49-42fd-8d60-075e1800d924'),(63,NULL,'Layout Variant','variant','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f','mljzpfmg','Change the block layout without changing its underlying content',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockEmbeddedEntries.json\"}','2022-11-16 06:42:27','2022-11-16 06:42:27','dea0077f-b1c4-4d4d-be6c-72ae2f47e105'),(64,NULL,'Filter by topic(s)','topics','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,'Only return records associated with these topics',0,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\"},\"selectionLabel\":null,\"showSiteMenu\":false,\"source\":null,\"sources\":[\"section:942cbdfb-d50d-4dcd-9032-4f483562d1dd\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-11-16 06:42:27','2022-11-16 06:42:27','e29f44d4-5676-46d2-9a24-b7dce4058c40'),(65,NULL,'Spacing','spacing','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f','sotrfnux','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacing.json\"}','2022-11-16 06:42:27','2022-11-16 06:42:27','ffda0f34-d718-475b-b8ed-99c25f516b8b'),(71,NULL,'Headline','headline','superTableBlockType:d5468b8f-24c2-45c5-a377-ac0da764cbb1',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"HeadlineWithLink.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:28','2022-11-16 06:42:28','1ddd814c-a3f1-4689-bb67-33d04ad8307a'),(72,NULL,'Text','text','superTableBlockType:d5468b8f-24c2-45c5-a377-ac0da764cbb1',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":[\"a4f97962-52de-4b53-8422-5b833d1cd5fd\"],\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"SimpleAir.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:28','2022-11-16 06:42:28','69c2d7dc-3df8-4df1-a444-d2ae376da00c'),(73,NULL,'Image / Icon','images','superTableBlockType:d5468b8f-24c2-45c5-a377-ac0da764cbb1',NULL,NULL,1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{# for fields inside a supertable inside a matrix block #} {{- ( object.owner.owner.variants   ?? null  ) ? \\\"products/#{object.owner.owner.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.owner.product    ?? null  ) ? \\\"products/#{object.owner.owner.product.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.owner.section    ?? null  ) ? \\\"#{object.owner.owner.section.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.owner.parentUri  ?? null  ) ? \\\"#{object.owner.owner.parentUri|replace(\'__\',\'\')}/\\\" : \'\' -}} {{object.owner.owner.slug}}\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose Image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-11-16 06:42:28','2022-11-16 06:42:28','fd647249-c4ea-4ade-99ab-13f9e53bba3f'),(74,NULL,'Text','text','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:29','2022-11-16 06:42:29','1d242d6f-f863-4979-b2af-bb1da5c2aee2'),(75,NULL,'Layout Variant','variant','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','payanbyx','Change the block layout without changing its underlying content',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockTextImage.json\"}','2022-11-16 06:42:29','2022-11-16 06:42:29','30b5253e-1f74-41f3-b484-e6c82e3210d5'),(76,NULL,'Background','bg','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','cpekkbhk','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgrounds.json\"}','2022-11-16 06:42:29','2022-11-16 06:42:29','b8f98eab-bd44-4073-b73b-c5c394a00643'),(77,NULL,'Image(s)','images','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e',NULL,NULL,1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\",\"json\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{{- ( object.owner.variants   ?? null  ) ? \\\"products/#{object.owner.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.product    ?? null  ) ? \\\"products/#{object.owner.product.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.section    ?? null  ) ? \\\"#{object.owner.section.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.parentUri  ?? null  ) ? \\\"#{object.owner.parentUri|replace(\'__\',\'\')}/\\\" : \'\' -}} {{object.owner.slug}}\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose Image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-11-16 06:42:29','2022-11-16 06:42:29','dda1fa64-dd45-42b6-8df9-476cbac15152'),(78,NULL,'Widget','widget','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','mdoonwrh','Add a custom feature to this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/widgets.json\"}','2022-11-16 06:42:29','2022-11-16 06:42:29','e44c7d4a-f794-4917-8a3f-e77e8162cc93'),(79,NULL,'Spacing','spacing','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','eqfigngd','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacing.json\"}','2022-11-16 06:42:29','2022-11-16 06:42:29','e826463c-c088-426d-be5d-9630e1b872c9'),(80,NULL,'Identifier','identifier','matrixBlockType:93580b97-9c95-4704-b7f5-a580fb56486c','ajvokjou',NULL,0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":false,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":null,\"uiMode\":\"normal\"}','2022-11-16 06:42:30','2022-11-16 06:42:30','68b93e4b-8d64-4598-b7c7-7e34609198b2'),(81,NULL,'Caption','caption','matrixBlockType:93580b97-9c95-4704-b7f5-a580fb56486c','sqjwhpfm',NULL,0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"SimpleAir.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:30','2022-11-16 06:42:30','c832b847-2fbc-4a68-ac50-698b165e4fc3'),(82,NULL,'Code','code','matrixBlockType:93580b97-9c95-4704-b7f5-a580fb56486c','sbypotws',NULL,0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":true,\"columnType\":null,\"initialRows\":10,\"multiline\":true,\"placeholder\":null,\"uiMode\":\"normal\"}','2022-11-16 06:42:30','2022-11-16 06:42:30','f92a01b3-02b6-427e-9141-3dd789bbef6f'),(83,NULL,'Text','text','matrixBlockType:a25a7c39-08d8-449e-818a-0974ed415987','tjslxfvc',NULL,0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":false,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:30','2022-11-16 22:51:59','4e1fbf94-015b-4a5b-880a-8e7051457536'),(84,NULL,'Background','bg','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','dqtdfrpw','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgrounds.json\"}','2022-11-16 06:42:30','2022-11-16 06:42:30','0dabdba1-b0ed-4220-8bfd-115e5127ee42'),(85,NULL,'Text','text','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":\"allow.iframes.json\",\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:30','2022-11-16 06:42:30','07a0012a-4bdf-4aaa-8415-bbe06adaf62c'),(86,NULL,'Layout Variant','variant','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','qfgjxwao','Change the block layout without changing its underlying content',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockText.json\"}','2022-11-16 06:42:30','2022-11-16 06:42:30','9d4f8876-987f-46fc-9042-aaf824a7131d'),(87,NULL,'Spacing','spacing','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','lhqmhzea','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacing.json\"}','2022-11-16 06:42:30','2022-11-16 06:42:30','a7b99dca-7b58-438c-b57e-9d7965c3093b'),(88,NULL,'Headnote','text','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31',NULL,'Anything important to be said above the body copy (optional)',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"SimpleAir.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:31','2022-11-16 06:42:31','6bd61b45-415d-4702-8b93-c734e25ed41e'),(89,NULL,'Variant layout','variant','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31','ntqzccqg','Changes the block layout without changing its underlying content',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockText.json\"}','2022-11-16 06:42:31','2022-11-16 06:42:31','34c8b184-a3df-4101-9525-d2c4a65aa9cb'),(90,NULL,'Spacing','spacing','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31','gloywvje','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacingHero.json\"}','2022-11-16 06:42:31','2022-11-16 06:42:31','bfcd0468-97ee-40dd-9344-996e63ff7beb'),(91,NULL,'Hero title','headline','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31',NULL,'Replaces the page <title> and acts as the default SEO <h1> tag',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:31','2022-11-16 06:42:31','d08c5ca6-5020-4ac5-9460-c831d0921585'),(92,NULL,'Background','bg','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31','unpwravq','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgroundsHero.json\"}','2022-11-16 06:42:31','2022-11-16 06:42:31','ea2610d5-eecb-4d99-916e-90ce7e2c2bbc'),(93,NULL,'Spacing','spacing','matrixBlockType:563430f9-eadc-4a5b-8adf-3f784f79d901','kqtbfzex','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacingHero.json\"}','2022-11-16 06:42:32','2022-11-16 06:42:32','887c7e34-0b1f-40b8-b330-27d660a47d50'),(94,NULL,'Media','media','matrixBlockType:563430f9-eadc-4a5b-8adf-3f784f79d901',NULL,NULL,1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"audio\",\"excel\",\"pdf\",\"powerpoint\",\"video\",\"word\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{{- ( object.owner.variants   ?? null  ) ? \\\"products/#{object.owner.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.product    ?? null  ) ? \\\"products/#{object.owner.product.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.section    ?? null  ) ? \\\"#{object.owner.section.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.parentUri  ?? null  ) ? \\\"#{object.owner.parentUri|replace(\'__\',\'\')}/\\\" : \'\' -}} {{object.owner.slug}}\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose Media\",\"showSiteMenu\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-11-16 06:42:32','2022-11-16 06:42:32','17687c83-d165-4736-b0ae-59020efcb749'),(95,NULL,'Background','bg','matrixBlockType:563430f9-eadc-4a5b-8adf-3f784f79d901','cyumhlrq','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgroundsHero.json\"}','2022-11-16 06:42:32','2022-11-16 06:42:32','87482970-1ffe-4760-a28d-cf986bbb8c72'),(96,NULL,'Widget','widget','matrixBlockType:563430f9-eadc-4a5b-8adf-3f784f79d901','kjrfytpr','Add a custom feature to this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/widgets.json\"}','2022-11-16 06:42:32','2022-11-16 06:42:32','aebe2498-55fa-4926-8908-8a0bc8d303ba'),(97,NULL,'Headnote','text','matrixBlockType:563430f9-eadc-4a5b-8adf-3f784f79d901','ijcdahuf','Anything important to be said above the body copy (optional)',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"SimpleAir.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:32','2022-11-16 06:42:32','b750d657-987a-41b2-953b-807b6c688a88'),(98,NULL,'Hero title','headline','matrixBlockType:563430f9-eadc-4a5b-8adf-3f784f79d901','gmdbuezd',NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":false,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:32','2022-11-16 06:42:32','de70b474-8e41-4034-8450-229b89760037'),(99,NULL,'Variant layout','variant','matrixBlockType:563430f9-eadc-4a5b-8adf-3f784f79d901','lkocjylo',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockMediaContent.json\"}','2022-11-16 06:42:32','2022-11-16 06:42:32','f121e5ad-eddc-485f-8d18-8f74c406c771'),(100,NULL,'Spacing','spacing','matrixBlockType:d7da6677-ed4d-4768-8519-8c3123f108ab','gslywyag','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacingFragment.json\"}','2022-11-16 06:42:32','2022-11-16 06:42:32','abf72c9c-cdfc-4765-b71d-a03735da679d'),(101,NULL,'Background','bg','matrixBlockType:d7da6677-ed4d-4768-8519-8c3123f108ab','nfwtlclo','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgroundsFragment.json\"}','2022-11-16 06:42:32','2022-11-16 06:42:32','bf152e62-fb69-4e45-836d-7546488987e6'),(102,NULL,'Text','text','matrixBlockType:d7da6677-ed4d-4768-8519-8c3123f108ab','ahimykba','Injects additional text content into the selected fragment (if supported).',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":false,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:33','2022-11-16 06:42:33','c27f9fb5-d0cc-4e10-841c-c739bfbdb971'),(103,NULL,'Fragment(s)','fragments','matrixBlockType:d7da6677-ed4d-4768-8519-8c3123f108ab',NULL,NULL,0,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\"},\"selectionLabel\":\"Choose Fragment\",\"showSiteMenu\":false,\"source\":null,\"sources\":[\"section:89093e20-515d-4e3c-b4c4-c6733d8ab56f\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-11-16 06:42:33','2022-11-16 06:42:33','e2cdac24-87bd-4a5b-be66-d991b0323794'),(104,NULL,'Content Chunk','chunk','matrixBlockType:d7da6677-ed4d-4768-8519-8c3123f108ab','lrlikkza','Use the selected fragment to feature a Content Chunk.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/entryChunk.twig\"}','2022-11-16 06:42:33','2022-11-16 06:42:33','e8af3e49-fbce-4621-a06d-a3d56f425497'),(105,NULL,'Form','form','matrixBlockType:387e39f3-66b5-4aa5-a6a8-500db12ccadc',NULL,NULL,0,'site',NULL,'verbb\\formie\\fields\\Forms','{\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":1,\"minRelations\":0,\"selectionLabel\":\"Choose form\",\"showSiteMenu\":true,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-11-16 06:42:33','2022-11-16 06:42:33','0634113d-5014-46e7-a319-61f78258ce62'),(106,NULL,'Identifier','identifier','matrixBlockType:387e39f3-66b5-4aa5-a6a8-500db12ccadc','nqcgwseh',NULL,0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":false,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":null,\"uiMode\":\"normal\"}','2022-11-16 06:42:33','2022-11-16 06:42:33','af48dd81-f2f9-4b6e-83b6-81012dc228db'),(107,NULL,'Recipient','recipient','matrixBlockType:387e39f3-66b5-4aa5-a6a8-500db12ccadc','qicypfxo',NULL,0,'none',NULL,'craft\\fields\\Email','{\"placeholder\":null}','2022-11-16 06:42:33','2022-11-16 06:42:33','f8f98780-0d0a-46aa-b8bf-3986a32262ac'),(108,NULL,'Attachment','attachment','matrixBlockType:387e39f3-66b5-4aa5-a6a8-500db12ccadc',NULL,NULL,0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{{- ( object.owner.variants   ?? null  ) ? \\\"products/#{object.owner.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.product    ?? null  ) ? \\\"products/#{object.owner.product.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.section    ?? null  ) ? \\\"#{object.owner.section.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.parentUri  ?? null  ) ? \\\"#{object.owner.parentUri|replace(\'__\',\'\')}/\\\" : \'\' -}} {{object.owner.slug}}\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":false,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose File\",\"showSiteMenu\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2022-11-16 06:42:33','2022-11-16 06:42:33','ffb53008-0128-493f-9c96-5f66a6a83565'),(109,NULL,'Widget','widget','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213','gquevifw','Add a custom feature to this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/widgets.json\"}','2022-11-16 06:42:34','2022-11-16 06:42:34','2a64e6bd-a23b-4826-bc19-829c037e6e39'),(110,NULL,'Variant layout','variant','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213','udmwrcap','Changes the block layout without changing its underlying content',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockTextImage.json\"}','2022-11-16 06:42:34','2022-11-16 06:42:34','468a14eb-fb24-4d42-85ea-51a108f68949'),(111,NULL,'Image(s)','images','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213',NULL,NULL,0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{{- ( object.owner.variants   ?? null  ) ? \\\"products/#{object.owner.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.product    ?? null  ) ? \\\"products/#{object.owner.product.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.section    ?? null  ) ? \\\"#{object.owner.section.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.parentUri  ?? null  ) ? \\\"#{object.owner.parentUri|replace(\'__\',\'\')}/\\\" : \'\' -}} {{object.owner.slug}}\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose Image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":[\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"volume:3c05e593-d621-444e-8fb9-ddbb1b356a43\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-11-16 06:42:34','2022-11-16 06:42:34','25414516-f079-42de-9891-f9dd403af271'),(112,NULL,'Spacing','spacing','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213','xfkxramj','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacingHero.json\"}','2022-11-16 06:42:34','2022-11-16 06:42:34','a53977b7-95c0-4ac6-bd66-2547ac6caa22'),(113,NULL,'Hero title','headline','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213',NULL,'Replaces the page <title> and acts as the default SEO <h1> tag',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:34','2022-11-16 06:42:34','c1193bb1-b500-4050-8b68-a0a7bee4594f'),(114,NULL,'Headnote','text','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213',NULL,'Anything important to be said above the body copy (optional)',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"SimpleAir.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:34','2022-11-16 06:42:34','ec26ccd6-8b77-446f-83e4-5a157ab84ee5'),(115,NULL,'Background','bg','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213','rqyqbtbd','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgroundsHero.json\"}','2022-11-16 06:42:34','2022-11-16 06:42:34','fb8236c7-dc6f-45c6-b62d-6d6ffaaf1657'),(116,NULL,'Background','bg','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8','mgtiyjak','Set the background style behind this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgrounds.json\"}','2022-11-16 06:42:34','2022-11-16 06:42:34','1a28951d-82d5-47da-8ec8-ab405c40e0b8'),(117,NULL,'Text (Right)','text2','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:35','2022-11-16 06:42:35','79001047-67b4-4b93-825f-333664a55c70'),(118,NULL,'Text (Left)','text','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:35','2022-11-16 06:42:35','b431aa28-7fd8-4a95-8ace-467582d8e01f'),(119,NULL,'Spacing','spacing','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8','kvbxevci','Change spacing & dividers above/below this block.',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacing.json\"}','2022-11-16 06:42:35','2022-11-16 06:42:35','ef8f5bd0-5250-42da-b861-c220362619e2'),(120,NULL,'Layout Variant','variant','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8','rkmoflxj','Change the block layout without changing its underlying content',0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockTextText.json\"}','2022-11-16 06:42:35','2022-11-16 06:42:35','f3fc91f4-ef9e-4532-beaf-1c80b55b7233'),(121,NULL,'Caption','caption','matrixBlockType:df5451d1-310f-43b1-9f9d-9b352d647c18','ckfsdsda',NULL,0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"SimpleAir.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 06:42:43','2022-11-16 06:42:43','d40f6841-ce5c-4010-b41a-f7d8a1b30c93'),(122,NULL,'Table','table','matrixBlockType:df5451d1-310f-43b1-9f9d-9b352d647c18','dhajqazy',NULL,0,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a row\",\"columnType\":\"text\",\"columns\":{\"col1\":{\"heading\":\"ID #\",\"handle\":\"id\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"Name\",\"handle\":\"name\",\"width\":\"\",\"type\":\"singleline\"},\"col3\":{\"heading\":\"Status\",\"handle\":\"status\",\"width\":\"\",\"type\":\"select\",\"options\":[{\"label\":\"Available\",\"value\":\"available\",\"default\":false},{\"label\":\"Unavailable\",\"value\":\"unavailable\",\"default\":false},{\"label\":\"Unknown\",\"value\":\"unknown\",\"default\":false}]},\"col4\":{\"heading\":\"Date\",\"handle\":\"date\",\"width\":\"\",\"type\":\"date\"}},\"defaults\":null,\"maxRows\":null,\"minRows\":null}','2022-11-16 06:42:43','2022-11-16 06:42:43','ebab35b1-2b82-4883-aa61-9c554557708f'),(123,NULL,'Identifier','identifier','matrixBlockType:df5451d1-310f-43b1-9f9d-9b352d647c18','luuslhqe',NULL,0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":false,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":null,\"uiMode\":\"normal\"}','2022-11-16 06:42:43','2022-11-16 06:42:43','fa8573f7-ea9b-4f06-8ecd-1b91a778dbd9'),(124,NULL,'Email','email','formie:234256a5-e09f-4241-b669-7224fd3ca605','atpppbqx',NULL,1,'none',NULL,'verbb\\formie\\fields\\formfields\\Email','{\"validateDomain\":false,\"blockedDomains\":[],\"uniqueValue\":false,\"matchField\":null,\"placeholder\":null,\"defaultValue\":null,\"prePopulate\":null,\"errorMessage\":null,\"labelPosition\":null,\"instructionsPosition\":null,\"cssClasses\":null,\"containerAttributes\":null,\"inputAttributes\":null,\"includeInEmail\":true,\"enableConditions\":false,\"conditions\":null,\"enableContentEncryption\":false,\"visibility\":null,\"formId\":null,\"isNested\":false}','2022-11-16 06:51:38','2022-11-16 06:51:38','62e3d09e-ff7a-4843-bf90-f6ceda67b960'),(125,NULL,'Your Name','yourName','formie:61c5bb74-9601-4136-a973-babd4059bead','jpvcvecw',NULL,1,'none',NULL,'verbb\\formie\\fields\\formfields\\Name','{\"useMultipleFields\":true,\"prefixEnabled\":false,\"prefixCollapsed\":true,\"prefixLabel\":\"Prefix\",\"prefixPlaceholder\":null,\"prefixDefaultValue\":null,\"prefixPrePopulate\":null,\"prefixRequired\":false,\"prefixErrorMessage\":null,\"firstNameEnabled\":true,\"firstNameCollapsed\":false,\"firstNameLabel\":\"First Name\",\"firstNamePlaceholder\":\"e.g. Peter\",\"firstNameDefaultValue\":null,\"firstNamePrePopulate\":null,\"firstNameRequired\":true,\"firstNameErrorMessage\":null,\"middleNameEnabled\":false,\"middleNameCollapsed\":true,\"middleNameLabel\":\"Middle Name\",\"middleNamePlaceholder\":null,\"middleNameDefaultValue\":null,\"middleNamePrePopulate\":null,\"middleNameRequired\":false,\"middleNameErrorMessage\":null,\"lastNameEnabled\":true,\"lastNameCollapsed\":false,\"lastNameLabel\":\"Last Name\",\"lastNamePlaceholder\":\"e.g. Sherman\",\"lastNameDefaultValue\":null,\"lastNamePrePopulate\":null,\"lastNameRequired\":true,\"lastNameErrorMessage\":null,\"subfieldLabelPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"matchField\":null,\"placeholder\":\"Your name\",\"defaultValue\":null,\"prePopulate\":null,\"errorMessage\":null,\"labelPosition\":\"verbb\\\\formie\\\\positions\\\\Hidden\",\"instructionsPosition\":\"verbb\\\\formie\\\\positions\\\\BelowInput\",\"cssClasses\":null,\"containerAttributes\":null,\"inputAttributes\":null,\"includeInEmail\":true,\"enableConditions\":false,\"conditions\":{\"showRule\":\"show\",\"conditionRule\":\"all\",\"conditions\":[]},\"enableContentEncryption\":false,\"visibility\":null,\"formId\":35,\"isNested\":false}','2022-11-16 06:52:08','2022-11-17 06:22:33','0b9e9d8a-1cd4-4a63-aae6-4d1ed51bec5a'),(126,NULL,'Email Address','emailAddress','formie:61c5bb74-9601-4136-a973-babd4059bead','ajyaynxy',NULL,1,'none',NULL,'verbb\\formie\\fields\\formfields\\Email','{\"validateDomain\":false,\"blockedDomains\":[],\"uniqueValue\":false,\"matchField\":null,\"placeholder\":\"e.g. psherman@wallaby.com\",\"defaultValue\":null,\"prePopulate\":null,\"errorMessage\":null,\"labelPosition\":null,\"instructionsPosition\":null,\"cssClasses\":null,\"containerAttributes\":null,\"inputAttributes\":null,\"includeInEmail\":true,\"enableConditions\":false,\"conditions\":null,\"enableContentEncryption\":false,\"visibility\":null,\"formId\":35,\"isNested\":false}','2022-11-16 06:52:08','2022-11-17 06:22:37','c6caabbb-7be2-4464-bd5c-92b9509dc555'),(127,NULL,'Message','message','formie:61c5bb74-9601-4136-a973-babd4059bead','dwsxhbyj',NULL,1,'none',NULL,'verbb\\formie\\fields\\formfields\\MultiLineText','{\"limit\":false,\"min\":null,\"minType\":null,\"max\":null,\"maxType\":\"characters\",\"useRichText\":false,\"richTextButtons\":null,\"matchField\":null,\"placeholder\":\"e.g. The reason for my enquiry is...\",\"defaultValue\":null,\"prePopulate\":null,\"errorMessage\":null,\"labelPosition\":null,\"instructionsPosition\":null,\"cssClasses\":null,\"containerAttributes\":null,\"inputAttributes\":null,\"includeInEmail\":true,\"enableConditions\":false,\"conditions\":{\"showRule\":\"show\",\"conditionRule\":\"all\",\"conditions\":[]},\"enableContentEncryption\":false,\"visibility\":null,\"formId\":35,\"isNested\":false}','2022-11-16 06:52:08','2022-11-17 06:22:41','98928f6c-db75-4f56-b84b-a94f6d81cf85'),(128,NULL,'Background','bg','matrixBlockType:a25a7c39-08d8-449e-818a-0974ed415987','qwymistc',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgrounds.json\"}','2022-11-16 11:32:09','2022-11-16 11:32:09','1aa226f6-fbd8-4cb9-94b9-26bca8299a04'),(129,NULL,'Layout Variant','variant','matrixBlockType:a25a7c39-08d8-449e-818a-0974ed415987','xzyekbfe',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockSidebarText.json\"}','2022-11-16 11:32:09','2022-11-16 22:51:59','0554821f-40fc-4bf7-bd90-a3a2581c88ab'),(130,NULL,'Images','images','matrixBlockType:a25a7c39-08d8-449e-818a-0974ed415987',NULL,NULL,0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\",\"json\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{{- ( object.owner.variants   ?? null  ) ? \\\"products/#{object.owner.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.product    ?? null  ) ? \\\"products/#{object.owner.product.type.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.section    ?? null  ) ? \\\"#{object.owner.section.handle|lower}/\\\" : \'\' -}} {{- ( object.owner.parentUri  ?? null  ) ? \\\"#{object.owner.parentUri|replace(\'__\',\'\')}/\\\" : \'\' -}} {{object.owner.slug}}\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":null,\"showSiteMenu\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2022-11-16 11:32:09','2022-11-16 11:32:09','a99de532-088e-484b-94fc-945b766ee947'),(131,NULL,'Spacing','spacing','matrixBlockType:a25a7c39-08d8-449e-818a-0974ed415987','tbjdznwk',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacing.json\"}','2022-11-16 11:32:09','2022-11-16 11:32:09','e2490fe0-802e-4be2-8173-d77847a05e26'),(132,NULL,'Widget','widget','matrixBlockType:a25a7c39-08d8-449e-818a-0974ed415987','uhlqqmzz',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/widgets.json\"}','2022-11-16 11:32:39','2022-11-16 11:32:39','b04167bb-2563-4547-99d7-2f6a3331a57b'),(133,NULL,'Spacing','spacing','matrixBlockType:21209162-922b-4edb-b952-1cd88d3ac05e','imzhlgvq',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/spacing.json\"}','2022-11-16 22:52:00','2022-11-16 22:52:00','2d9e094a-7b59-4560-841c-138c5391fe7c'),(134,NULL,'Widget','widget','matrixBlockType:21209162-922b-4edb-b952-1cd88d3ac05e','vpnhxvtr',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/widgets.json\"}','2022-11-16 22:52:00','2022-11-16 22:52:00','5f8fc242-fe03-4416-9cd3-f32841e4b6ca'),(135,NULL,'Background','bg','matrixBlockType:21209162-922b-4edb-b952-1cd88d3ac05e','yxvtjfiq',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/backgrounds.json\"}','2022-11-16 22:52:00','2022-11-16 22:52:00','0553ed4a-8d9c-42be-855a-82fb23a24aac'),(136,NULL,'Layout Variant','variant','matrixBlockType:21209162-922b-4edb-b952-1cd88d3ac05e','kvgukfcy',NULL,0,'none',NULL,'simplicateca\\referencefield\\fields\\Dropdown','{\"referenceFile\":\"_builders/references/blockSidebarText.json\"}','2022-11-16 22:52:00','2022-11-16 22:52:00','98433f5b-b542-41ff-a0ca-915026fb4455'),(137,NULL,'Text','text','matrixBlockType:21209162-922b-4edb-b952-1cd88d3ac05e','jnelsrsi',NULL,0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":false,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-11-16 22:52:00','2022-11-16 22:52:00','b6689e78-2cda-4120-a5a3-7337cec63b2c');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fmc_contactform`
--

LOCK TABLES `fmc_contactform` WRITE;
/*!40000 ALTER TABLE `fmc_contactform` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fmc_contactform` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fmc_newslettersubscription`
--

LOCK TABLES `fmc_newslettersubscription` WRITE;
/*!40000 ALTER TABLE `fmc_newslettersubscription` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fmc_newslettersubscription` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_emailtemplates`
--

LOCK TABLES `formie_emailtemplates` WRITE;
/*!40000 ALTER TABLE `formie_emailtemplates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_emailtemplates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_forms`
--

LOCK TABLES `formie_forms` WRITE;
/*!40000 ALTER TABLE `formie_forms` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `formie_forms` VALUES (34,'newsletterSubscription','{{%fmc_newslettersubscription}}','{\"displayFormTitle\":false,\"displayCurrentPageTitle\":false,\"displayPageTabs\":false,\"displayPageProgress\":false,\"scrollToTop\":true,\"progressPosition\":\"end\",\"defaultLabelPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"defaultInstructionsPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"submitMethod\":\"ajax\",\"submitAction\":\"message\",\"submitActionTab\":null,\"submitActionUrl\":null,\"submitActionFormHide\":true,\"submitActionMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"},\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Submission saved.\\\"}]}]\",\"submitActionMessageTimeout\":null,\"submitActionMessagePosition\":\"top-form\",\"loadingIndicator\":null,\"loadingIndicatorText\":null,\"validationOnSubmit\":true,\"validationOnFocus\":false,\"errorMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"},\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Couldn’t save submission due to errors.\\\"}]}]\",\"errorMessagePosition\":\"top-form\",\"requireUser\":false,\"requireUserMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"}}]\",\"scheduleForm\":false,\"scheduleFormStart\":null,\"scheduleFormEnd\":null,\"scheduleFormPendingMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"}}]\",\"scheduleFormExpiredMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"}}]\",\"limitSubmissions\":false,\"limitSubmissionsNumber\":null,\"limitSubmissionsType\":\"total\",\"limitSubmissionsMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"}}]\",\"integrations\":{\"recaptcha\":{\"enabled\":true,\"showAllPages\":\"\"},\"hcaptcha\":{\"enabled\":true,\"showAllPages\":\"\"},\"duplicate\":{\"enabled\":true,\"showAllPages\":\"\"},\"honeypot\":{\"enabled\":true,\"showAllPages\":\"\"},\"javascript\":{\"enabled\":true,\"showAllPages\":\"\"}},\"submissionTitleFormat\":\"{timestamp}\",\"collectIp\":true,\"collectUser\":true,\"dataRetention\":null,\"dataRetentionValue\":null,\"fileUploadsAction\":null,\"redirectUrl\":null,\"defaultEmailTemplateId\":null,\"disableCaptchas\":false}',NULL,NULL,NULL,1,'forever',NULL,'retain','retain',39,'2022-11-16 06:51:38','2022-11-16 06:51:38','234256a5-e09f-4241-b669-7224fd3ca605'),(35,'contactForm','{{%fmc_contactform}}','{\"displayFormTitle\":false,\"displayCurrentPageTitle\":false,\"displayPageTabs\":false,\"displayPageProgress\":false,\"scrollToTop\":true,\"progressPosition\":\"end\",\"defaultLabelPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"defaultInstructionsPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"submitMethod\":\"ajax\",\"submitAction\":\"message\",\"submitActionTab\":null,\"submitActionUrl\":null,\"submitActionFormHide\":false,\"submitActionMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"},\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Thank you for contacting us! Our team will get in touch shortly to follow up on your message.\\\"}]}]\",\"submitActionMessageTimeout\":null,\"submitActionMessagePosition\":\"top-form\",\"loadingIndicator\":\"spinner\",\"loadingIndicatorText\":null,\"validationOnSubmit\":true,\"validationOnFocus\":true,\"errorMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"},\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Couldn’t save submission due to errors.\\\"}]}]\",\"errorMessagePosition\":\"top-form\",\"requireUser\":false,\"requireUserMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"}}]\",\"scheduleForm\":false,\"scheduleFormStart\":null,\"scheduleFormEnd\":null,\"scheduleFormPendingMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"}}]\",\"scheduleFormExpiredMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"}}]\",\"limitSubmissions\":false,\"limitSubmissionsNumber\":null,\"limitSubmissionsType\":\"total\",\"limitSubmissionsMessage\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"attrs\\\":{\\\"textAlign\\\":\\\"start\\\"}}]\",\"integrations\":{\"\":{\"enabled\":true},\"recaptcha\":{\"enabled\":true,\"showAllPages\":\"\"},\"hcaptcha\":{\"enabled\":true,\"showAllPages\":\"\"},\"duplicate\":{\"enabled\":true,\"showAllPages\":\"\"},\"honeypot\":{\"enabled\":true,\"showAllPages\":\"\"},\"javascript\":{\"enabled\":\"1\",\"showAllPages\":\"\"}},\"submissionTitleFormat\":\"{timestamp}\",\"collectIp\":true,\"collectUser\":true,\"dataRetention\":null,\"dataRetentionValue\":null,\"fileUploadsAction\":null,\"redirectUrl\":null,\"defaultEmailTemplateId\":null,\"disableCaptchas\":false}',NULL,NULL,NULL,1,'forever',NULL,'retain','retain',40,'2022-11-16 06:52:08','2022-11-17 06:22:43','61c5bb74-9601-4136-a973-babd4059bead');
/*!40000 ALTER TABLE `formie_forms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_formtemplates`
--

LOCK TABLES `formie_formtemplates` WRITE;
/*!40000 ALTER TABLE `formie_formtemplates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_formtemplates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_integrations`
--

LOCK TABLES `formie_integrations` WRITE;
/*!40000 ALTER TABLE `formie_integrations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_integrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_nested`
--

LOCK TABLES `formie_nested` WRITE;
/*!40000 ALTER TABLE `formie_nested` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_nested` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_nestedfieldrows`
--

LOCK TABLES `formie_nestedfieldrows` WRITE;
/*!40000 ALTER TABLE `formie_nestedfieldrows` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_nestedfieldrows` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_notifications`
--

LOCK TABLES `formie_notifications` WRITE;
/*!40000 ALTER TABLE `formie_notifications` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `formie_notifications` VALUES (1,35,NULL,NULL,'Admin Notification',1,'A new submission was made on \"{formName}\"','email','{systemEmail}','{\"toRecipients\":[]}',NULL,NULL,'{field.emailAddress}',NULL,'{field.emailAddress}',NULL,NULL,'[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"A user submission has been made on the \\\"\"},{\"type\":\"variableTag\",\"attrs\":{\"label\":\"Form Name\",\"value\":\"{formName}\"}},{\"type\":\"text\",\"text\":\"\\\" form on \"},{\"type\":\"variableTag\",\"attrs\":{\"label\":\"Site Name\",\"value\":\"{siteName}\"}},{\"type\":\"text\",\"text\":\" at \"},{\"type\":\"variableTag\",\"attrs\":{\"label\":\"Timestamp (yyyy-mm-dd hh:mm:ss)\",\"value\":\"{timestamp}\"}}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Their submission details are:\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"variableTag\",\"attrs\":{\"label\":\"All Form Fields\",\"value\":\"{allFields}\"}}]}]',1,NULL,NULL,0,'{\"sendRule\":\"send\",\"conditionRule\":\"all\",\"conditions\":[]}','2022-11-16 06:52:08','2022-11-17 06:22:43','f83813b0-3c72-4468-83d8-f87e7a282a90'),(2,35,NULL,NULL,'User Notification',1,'Thanks for contacting us!','email','{field.emailAddress}','{\"toRecipients\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Thanks again for contacting us. Our team will get back to you as soon as we can.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"As a reminder, you submitted the following details at \"},{\"type\":\"variableTag\",\"attrs\":{\"label\":\"Timestamp (yyyy-mm-dd hh:mm:ss)\",\"value\":\"{timestamp}\"}}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"variableTag\",\"attrs\":{\"label\":\"All Form Fields\",\"value\":\"{allFields}\"}}]}]',1,NULL,NULL,0,'{\"sendRule\":\"send\",\"conditionRule\":\"all\",\"conditions\":[]}','2022-11-16 06:52:08','2022-11-17 06:22:43','9bad3119-acb4-4551-9b6e-68ac2a75dd6b');
/*!40000 ALTER TABLE `formie_notifications` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_pagesettings`
--

LOCK TABLES `formie_pagesettings` WRITE;
/*!40000 ALTER TABLE `formie_pagesettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `formie_pagesettings` VALUES (1,39,211,'{\"submitButtonLabel\":\"Submit\",\"backButtonLabel\":\"Back\",\"showBackButton\":false,\"saveButtonLabel\":\"Save\",\"showSaveButton\":false,\"saveButtonStyle\":\"link\",\"buttonsPosition\":\"left\",\"cssClasses\":null,\"containerAttributes\":null,\"inputAttributes\":null,\"enableNextButtonConditions\":false,\"nextButtonConditions\":[],\"enablePageConditions\":false,\"pageConditions\":[],\"enableJsEvents\":false,\"jsGtmEventOptions\":[]}','2022-11-16 06:51:38','2022-11-16 06:51:38','f3311d92-2dd3-4cfe-90a3-539c563389ec'),(2,40,212,'{\"submitButtonLabel\":\"Contact us\",\"backButtonLabel\":\"Back\",\"showBackButton\":false,\"saveButtonLabel\":\"Save\",\"showSaveButton\":false,\"saveButtonStyle\":\"link\",\"buttonsPosition\":\"left\",\"cssClasses\":null,\"containerAttributes\":null,\"inputAttributes\":null,\"enableNextButtonConditions\":false,\"nextButtonConditions\":[],\"enablePageConditions\":false,\"pageConditions\":[],\"enableJsEvents\":false,\"jsGtmEventOptions\":[]}','2022-11-16 06:52:08','2022-11-16 06:52:08','e2bc4609-38d1-4d60-a643-78cb5fd27dab');
/*!40000 ALTER TABLE `formie_pagesettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_payments`
--

LOCK TABLES `formie_payments` WRITE;
/*!40000 ALTER TABLE `formie_payments` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_payments` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_payments_plans`
--

LOCK TABLES `formie_payments_plans` WRITE;
/*!40000 ALTER TABLE `formie_payments_plans` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_payments_plans` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_payments_subscriptions`
--

LOCK TABLES `formie_payments_subscriptions` WRITE;
/*!40000 ALTER TABLE `formie_payments_subscriptions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_payments_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_pdftemplates`
--

LOCK TABLES `formie_pdftemplates` WRITE;
/*!40000 ALTER TABLE `formie_pdftemplates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_pdftemplates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_relations`
--

LOCK TABLES `formie_relations` WRITE;
/*!40000 ALTER TABLE `formie_relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_rows`
--

LOCK TABLES `formie_rows` WRITE;
/*!40000 ALTER TABLE `formie_rows` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `formie_rows` VALUES (1,39,679,0,'2022-11-16 06:51:38','2022-11-16 06:51:38','fdb40ec2-8c15-4902-b903-64db4e695d18'),(23,40,786,0,'2022-11-17 06:22:43','2022-11-17 06:22:43','1d0a13f0-87da-4c0c-95c6-5235f011952b'),(24,40,787,1,'2022-11-17 06:22:43','2022-11-17 06:22:43','37157011-829e-45e9-8615-479a1c4ccc0c'),(25,40,788,2,'2022-11-17 06:22:43','2022-11-17 06:22:43','5ee7e3cd-e544-406b-acaa-fcf9e1a3972e');
/*!40000 ALTER TABLE `formie_rows` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_sentnotifications`
--

LOCK TABLES `formie_sentnotifications` WRITE;
/*!40000 ALTER TABLE `formie_sentnotifications` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_sentnotifications` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_statuses`
--

LOCK TABLES `formie_statuses` WRITE;
/*!40000 ALTER TABLE `formie_statuses` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `formie_statuses` VALUES (1,'New','new','green',NULL,1,1,NULL,'2022-11-16 06:42:21','2022-11-16 06:42:21','537988be-e9c5-43e8-8611-2256a41a72fe');
/*!40000 ALTER TABLE `formie_statuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_stencils`
--

LOCK TABLES `formie_stencils` WRITE;
/*!40000 ALTER TABLE `formie_stencils` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `formie_stencils` VALUES (1,'Contact Form','contactForm','{\"dataRetention\":\"forever\",\"dataRetentionValue\":null,\"fileUploadsAction\":\"retain\",\"notifications\":[{\"attachFiles\":true,\"attachPdf\":false,\"bcc\":null,\"cc\":null,\"conditions\":\"{\\\"sendRule\\\":\\\"send\\\",\\\"conditionRule\\\":\\\"all\\\",\\\"conditions\\\":[]}\",\"content\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"A user submission has been made on the \\\\\\\"\\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Form Name\\\",\\\"value\\\":\\\"{formName}\\\"}},{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"\\\\\\\" form on \\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Site Name\\\",\\\"value\\\":\\\"{siteName}\\\"}},{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\" at \\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Timestamp (yyyy-mm-dd hh:mm:ss)\\\",\\\"value\\\":\\\"{timestamp}\\\"}}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Their submission details are:\\\"}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"All Form Fields\\\",\\\"value\\\":\\\"{allFields}\\\"}}]}]\",\"enableConditions\":false,\"enabled\":true,\"formId\":null,\"from\":\"{field.emailAddress}\",\"fromName\":null,\"id\":\"new981-8077\",\"name\":\"Admin Notification\",\"pdfTemplateId\":null,\"recipients\":\"email\",\"replyTo\":\"{field.emailAddress}\",\"replyToName\":null,\"subject\":\"A new submission was made on \\\"{formName}\\\"\",\"templateId\":null,\"to\":\"{systemEmail}\",\"toConditions\":\"{\\\"toRecipients\\\":[]}\",\"uid\":null},{\"attachFiles\":true,\"attachPdf\":false,\"bcc\":null,\"cc\":null,\"conditions\":\"{\\\"sendRule\\\":\\\"send\\\",\\\"conditionRule\\\":\\\"all\\\",\\\"conditions\\\":[]}\",\"content\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Thanks again for contacting us. Our team will get back to you as soon as we can.\\\"}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"As a reminder, you submitted the following details at \\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Timestamp (yyyy-mm-dd hh:mm:ss)\\\",\\\"value\\\":\\\"{timestamp}\\\"}}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"All Form Fields\\\",\\\"value\\\":\\\"{allFields}\\\"}}]}]\",\"enableConditions\":false,\"enabled\":true,\"formId\":null,\"from\":null,\"fromName\":null,\"id\":\"new7052-5168\",\"name\":\"User Notification\",\"pdfTemplateId\":\"\",\"recipients\":\"email\",\"replyTo\":null,\"replyToName\":null,\"subject\":\"Thanks for contacting us!\",\"templateId\":\"\",\"to\":\"{field.emailAddress}\",\"toConditions\":\"{\\\"toRecipients\\\":[]}\",\"uid\":null}],\"pages\":[{\"id\":\"new1272610411\",\"label\":\"Page 1\",\"notificationFlag\":true,\"rows\":[{\"fields\":[{\"brandNewField\":false,\"handle\":\"yourName\",\"hasLabel\":true,\"id\":\"new7715-7348\",\"label\":\"Your Name\",\"settings\":{\"conditions\":\"{\\\"showRule\\\":\\\"show\\\",\\\"conditionRule\\\":\\\"all\\\",\\\"conditions\\\":[]}\",\"firstNameCollapsed\":false,\"firstNameDefaultValue\":\"\",\"firstNameEnabled\":true,\"firstNameLabel\":\"First Name\",\"firstNamePlaceholder\":\"e.g. Peter\",\"firstNameRequired\":true,\"handle\":\"yourName\",\"instructions\":\"Please enter your full name.\",\"instructionsPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"label\":\"Your Name\",\"labelPosition\":\"verbb\\\\formie\\\\positions\\\\Hidden\",\"lastNameCollapsed\":false,\"lastNameDefaultValue\":\"\",\"lastNameEnabled\":true,\"lastNameLabel\":\"Last Name\",\"lastNamePlaceholder\":\"e.g. Sherman\",\"lastNameRequired\":true,\"maxType\":\"characters\",\"middleNameCollapsed\":true,\"middleNameDefaultValue\":\"\",\"middleNameEnabled\":false,\"middleNameLabel\":\"Middle Name\",\"placeholder\":\"Your name\",\"prefixCollapsed\":true,\"prefixDefaultValue\":\"\",\"prefixEnabled\":false,\"prefixLabel\":\"Prefix\",\"subfieldLabelPosition\":\"\",\"useMultipleFields\":true,\"visibility\":\"\"},\"type\":\"verbb\\\\formie\\\\fields\\\\formfields\\\\Name\"}],\"id\":\"new8990-9934\"},{\"fields\":[{\"brandNewField\":false,\"handle\":\"emailAddress\",\"hasLabel\":true,\"id\":\"new6482-9528\",\"label\":\"Email Address\",\"settings\":{\"handle\":\"emailAddress\",\"instructions\":\"Please enter your email so we can get in touch.\",\"instructionsPosition\":\"\",\"label\":\"Email Address\",\"labelPosition\":\"\",\"maxType\":\"characters\",\"placeholder\":\"e.g. psherman@wallaby.com\",\"required\":true},\"type\":\"verbb\\\\formie\\\\fields\\\\formfields\\\\Email\"}],\"id\":\"new9524-8509\"},{\"fields\":[{\"brandNewField\":false,\"handle\":\"message\",\"hasLabel\":true,\"id\":\"new982-7322\",\"label\":\"Message\",\"settings\":{\"conditions\":\"{\\\"showRule\\\":\\\"show\\\",\\\"conditionRule\\\":\\\"all\\\",\\\"conditions\\\":[]}\",\"handle\":\"message\",\"instructions\":\"Please enter your comments.\",\"instructionsPosition\":\"\",\"label\":\"Message\",\"labelPosition\":\"\",\"maxType\":\"characters\",\"placeholder\":\"e.g. The reason for my enquiry is...\",\"required\":true,\"visibility\":\"\"},\"type\":\"verbb\\\\formie\\\\fields\\\\formfields\\\\MultiLineText\"}],\"id\":\"new2177-9685\"}],\"settings\":{\"backButtonLabel\":\"Back\",\"buttonsPosition\":\"left\",\"label\":\"Page 1\",\"showBackButton\":false,\"submitButtonLabel\":\"Contact us\"},\"sortOrder\":0}],\"settings\":{\"collectIp\":false,\"collectUser\":false,\"dataRetention\":null,\"dataRetentionValue\":null,\"defaultEmailTemplateId\":null,\"defaultInstructionsPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"defaultLabelPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"disableCaptchas\":false,\"displayCurrentPageTitle\":false,\"displayFormTitle\":false,\"displayPageProgress\":false,\"displayPageTabs\":false,\"errorMessage\":[{\"content\":[{\"text\":\"Couldn’t save submission due to errors.\",\"type\":\"text\"}],\"type\":\"paragraph\"}],\"errorMessagePosition\":\"top-form\",\"fileUploadsAction\":null,\"integrations\":{\"\":{\"enabled\":true}},\"limitSubmissions\":false,\"limitSubmissionsMessage\":null,\"limitSubmissionsNumber\":null,\"limitSubmissionsType\":null,\"loadingIndicator\":\"spinner\",\"loadingIndicatorText\":null,\"progressPosition\":\"end\",\"redirectUrl\":null,\"requireUser\":false,\"requireUserMessage\":null,\"scheduleForm\":false,\"scheduleFormEnd\":null,\"scheduleFormExpiredMessage\":null,\"scheduleFormPendingMessage\":null,\"scheduleFormStart\":null,\"scrollToTop\":true,\"submissionTitleFormat\":\"{timestamp}\",\"submitAction\":\"message\",\"submitActionFormHide\":false,\"submitActionMessage\":[{\"content\":[{\"text\":\"Thank you for contacting us! Our team will get in touch shortly to follow up on your message.\",\"type\":\"text\"}],\"type\":\"paragraph\"}],\"submitActionMessagePosition\":\"top-form\",\"submitActionMessageTimeout\":null,\"submitActionTab\":null,\"submitActionUrl\":null,\"submitMethod\":\"ajax\",\"validationOnFocus\":true,\"validationOnSubmit\":true},\"userDeletedAction\":\"retain\"}',NULL,NULL,NULL,1,NULL,'2022-11-16 06:42:21','2022-11-16 06:42:21','b97d889b-174a-4908-b53e-13fbe7ad2d73');
/*!40000 ALTER TABLE `formie_stencils` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_submissions`
--

LOCK TABLES `formie_submissions` WRITE;
/*!40000 ALTER TABLE `formie_submissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_submissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_syncfields`
--

LOCK TABLES `formie_syncfields` WRITE;
/*!40000 ALTER TABLE `formie_syncfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_syncfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_syncs`
--

LOCK TABLES `formie_syncs` WRITE;
/*!40000 ALTER TABLE `formie_syncs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_syncs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_tokens`
--

LOCK TABLES `formie_tokens` WRITE;
/*!40000 ALTER TABLE `formie_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `gqlschemas` VALUES (1,'Public Schema','[]',1,'2022-11-16 06:42:39','2022-11-16 06:42:39','6996714c-bbb3-4367-9b3f-90be15abbbee');
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `imagetransforms`
--

LOCK TABLES `imagetransforms` WRITE;
/*!40000 ALTER TABLE `imagetransforms` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `imagetransforms` VALUES (1,'Square','square','crop','center-center',350,350,NULL,NULL,'none','2022-11-16 06:42:39','2022-11-16 06:42:39','2022-11-16 06:42:39','e2d14d09-0715-4ab2-b3ea-5bea36055901');
/*!40000 ALTER TABLE `imagetransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'4.3.1','4.0.0.9',0,'nlwddrfqbmxf','3@jnwngfmhtv','2022-11-16 06:42:06','2022-11-17 06:22:43','70d0b87c-53f2-44b9-a870-85d789751dd9');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `knockknock_logins`
--

LOCK TABLES `knockknock_logins` WRITE;
/*!40000 ALTER TABLE `knockknock_logins` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `knockknock_logins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `lenz_linkfield`
--

LOCK TABLES `lenz_linkfield` WRITE;
/*!40000 ALTER TABLE `lenz_linkfield` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `lenz_linkfield` VALUES (1,1,1,1,'url',NULL,NULL,NULL,NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36','7f19f4a9-dcd0-41fa-ae91-6356ece01232'),(2,2,1,1,'url',NULL,NULL,NULL,NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36','620659a4-834e-4915-b4f9-434f1b68d791'),(3,3,1,1,'url',NULL,NULL,NULL,NULL,NULL,'2022-11-16 06:42:36','2022-11-16 06:42:36','12a14b42-281d-4c22-b8b4-22273969cb87'),(4,10,1,1,'url',NULL,NULL,NULL,NULL,NULL,'2022-11-16 06:42:51','2022-11-16 06:42:51','f04d7544-9294-4976-9a44-8da7e360c8c8'),(5,11,1,1,'url',NULL,NULL,NULL,NULL,NULL,'2022-11-16 06:42:51','2022-11-16 06:42:51','e0367f23-cdb5-47f5-ac1a-e1f92d447784');
/*!40000 ALTER TABLE `lenz_linkfield` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocks` VALUES (20,19,2,5,0,'2022-11-16 06:48:47','2022-11-16 06:48:47'),(21,19,2,5,0,'2022-11-16 06:48:49','2022-11-16 06:48:49'),(22,19,2,5,0,'2022-11-16 06:48:57','2022-11-16 06:48:57'),(23,19,2,5,NULL,'2022-11-16 06:48:59','2022-11-16 06:48:59'),(25,24,2,5,NULL,'2022-11-16 06:49:25','2022-11-16 06:49:25'),(29,28,9,14,NULL,'2022-11-16 06:50:33','2022-11-16 06:50:33'),(60,28,18,15,0,'2022-11-16 10:16:55','2022-11-16 10:16:55'),(70,69,2,5,NULL,'2022-11-16 10:35:02','2022-11-16 10:35:02'),(79,17,18,15,NULL,'2022-11-16 11:27:17','2022-11-16 11:27:17'),(81,80,18,15,NULL,'2022-11-16 11:27:17','2022-11-16 11:27:17'),(90,28,2,13,NULL,'2022-11-16 11:28:51','2022-11-16 11:28:51'),(102,28,21,9,NULL,'2022-11-16 11:35:02','2022-11-16 11:35:02'),(146,145,2,5,NULL,'2022-11-16 20:38:14','2022-11-16 20:38:14'),(153,38,2,10,NULL,'2022-11-16 20:46:32','2022-11-16 20:46:32'),(155,154,2,10,NULL,'2022-11-16 20:46:32','2022-11-16 20:46:32'),(165,19,18,11,NULL,'2022-11-16 21:14:23','2022-11-16 21:14:23'),(167,166,18,11,NULL,'2022-11-16 21:14:23','2022-11-16 21:14:23'),(168,166,2,5,NULL,'2022-11-16 21:14:23','2022-11-16 21:14:23'),(172,171,18,11,NULL,'2022-11-16 21:20:12','2022-11-16 21:20:12'),(173,171,2,5,NULL,'2022-11-16 21:20:12','2022-11-16 21:20:12'),(184,28,21,18,NULL,'2022-11-16 22:52:33','2022-11-16 22:52:33'),(186,185,2,13,NULL,'2022-11-16 22:52:33','2022-11-16 22:52:33'),(187,185,21,9,NULL,'2022-11-16 22:52:33','2022-11-16 22:52:33'),(188,185,21,18,NULL,'2022-11-16 22:52:33','2022-11-16 22:52:33'),(189,185,9,14,NULL,'2022-11-16 22:52:33','2022-11-16 22:52:33'),(193,192,18,15,NULL,'2022-11-17 04:34:36','2022-11-17 04:34:36'),(216,28,2,1,0,'2022-11-17 05:23:42','2022-11-17 05:23:42'),(218,217,2,13,NULL,'2022-11-17 05:23:42','2022-11-17 05:23:42'),(219,217,2,1,NULL,'2022-11-17 05:23:42','2022-11-17 05:23:42'),(220,217,21,9,NULL,'2022-11-17 05:23:42','2022-11-17 05:23:42'),(221,217,21,18,NULL,'2022-11-17 05:23:42','2022-11-17 05:23:42'),(222,217,9,14,NULL,'2022-11-17 05:23:42','2022-11-17 05:23:42'),(233,17,2,5,NULL,'2022-11-17 05:59:06','2022-11-17 05:59:06'),(235,234,18,15,NULL,'2022-11-17 05:59:06','2022-11-17 05:59:06'),(236,234,2,5,NULL,'2022-11-17 05:59:06','2022-11-17 05:59:06'),(240,239,18,11,NULL,'2022-11-17 06:06:58','2022-11-17 06:06:58'),(241,239,2,5,NULL,'2022-11-17 06:06:58','2022-11-17 06:06:58'),(244,243,2,13,NULL,'2022-11-17 06:09:47','2022-11-17 06:09:47'),(245,243,2,1,NULL,'2022-11-17 06:09:47','2022-11-17 06:09:47'),(247,243,21,9,NULL,'2022-11-17 06:09:47','2022-11-17 06:09:47'),(248,243,21,18,NULL,'2022-11-17 06:09:47','2022-11-17 06:09:47'),(249,243,9,14,NULL,'2022-11-17 06:09:47','2022-11-17 06:09:47'),(253,252,2,13,NULL,'2022-11-17 06:10:16','2022-11-17 06:10:16'),(254,252,21,9,NULL,'2022-11-17 06:10:16','2022-11-17 06:10:16'),(255,252,21,18,NULL,'2022-11-17 06:10:16','2022-11-17 06:10:16'),(256,252,9,14,NULL,'2022-11-17 06:10:16','2022-11-17 06:10:16'),(260,133,2,10,NULL,'2022-11-17 07:45:17','2022-11-17 07:45:17'),(262,261,2,10,NULL,'2022-11-17 07:45:17','2022-11-17 07:45:17'),(266,265,2,10,NULL,'2022-11-17 07:54:40','2022-11-17 07:54:40'),(270,269,2,13,NULL,'2022-11-17 10:02:11','2022-11-17 10:02:11'),(271,269,21,9,NULL,'2022-11-17 10:02:11','2022-11-17 10:02:11'),(272,269,21,18,NULL,'2022-11-17 10:02:11','2022-11-17 10:02:11'),(273,269,9,14,NULL,'2022-11-17 10:02:11','2022-11-17 10:02:11'),(277,276,2,13,NULL,'2022-11-17 10:21:55','2022-11-17 10:21:55'),(278,276,21,9,NULL,'2022-11-17 10:21:55','2022-11-17 10:21:55'),(279,276,21,18,NULL,'2022-11-17 10:21:55','2022-11-17 10:21:55'),(280,276,9,14,NULL,'2022-11-17 10:21:55','2022-11-17 10:21:55'),(284,283,2,13,NULL,'2022-11-17 10:36:54','2022-11-17 10:36:54'),(285,283,21,9,NULL,'2022-11-17 10:36:54','2022-11-17 10:36:54'),(286,283,21,18,NULL,'2022-11-17 10:36:54','2022-11-17 10:36:54'),(287,283,9,14,NULL,'2022-11-17 10:36:54','2022-11-17 10:36:54'),(291,290,2,13,NULL,'2022-11-17 10:37:11','2022-11-17 10:37:11'),(292,290,21,9,NULL,'2022-11-17 10:37:11','2022-11-17 10:37:11'),(293,290,21,18,NULL,'2022-11-17 10:37:11','2022-11-17 10:37:11'),(294,290,9,14,NULL,'2022-11-17 10:37:11','2022-11-17 10:37:11'),(298,297,2,13,NULL,'2022-11-17 10:44:59','2022-11-17 10:44:59'),(299,297,21,9,NULL,'2022-11-17 10:44:59','2022-11-17 10:44:59'),(300,297,21,18,NULL,'2022-11-17 10:44:59','2022-11-17 10:44:59'),(301,297,9,14,NULL,'2022-11-17 10:44:59','2022-11-17 10:44:59'),(305,304,2,13,NULL,'2022-11-17 10:49:11','2022-11-17 10:49:11'),(306,304,21,9,NULL,'2022-11-17 10:49:11','2022-11-17 10:49:11'),(307,304,21,18,NULL,'2022-11-17 10:49:11','2022-11-17 10:49:11'),(308,304,9,14,NULL,'2022-11-17 10:49:11','2022-11-17 10:49:11');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks_owners`
--

LOCK TABLES `matrixblocks_owners` WRITE;
/*!40000 ALTER TABLE `matrixblocks_owners` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocks_owners` VALUES (20,19,1),(21,19,1),(22,19,1),(23,19,1),(25,24,1),(29,28,1),(60,28,1),(70,69,1),(79,17,1),(81,80,1),(90,28,1),(102,28,1),(146,145,1),(153,38,1),(155,154,1),(165,19,1),(167,166,1),(168,166,1),(172,171,1),(173,171,1),(184,28,2),(186,185,1),(187,185,1),(188,185,2),(189,185,1),(193,192,1),(216,28,2),(218,217,1),(219,217,2),(220,217,1),(221,217,2),(222,217,1),(233,17,1),(235,234,1),(236,234,1),(240,239,1),(241,239,1),(244,243,1),(245,243,2),(247,243,1),(248,243,2),(249,243,1),(253,252,1),(254,252,1),(255,252,2),(256,252,1),(260,133,1),(262,261,1),(266,265,1),(270,269,1),(271,269,1),(272,269,2),(273,269,1),(277,276,1),(278,276,1),(279,276,2),(280,276,1),(284,283,1),(285,283,1),(286,283,2),(287,283,1),(291,290,1),(292,290,1),(293,290,2),(294,290,1),(298,297,1),(299,297,1),(300,297,2),(301,297,1),(305,304,1),(306,304,1),(307,304,2),(308,304,1);
/*!40000 ALTER TABLE `matrixblocks_owners` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocktypes` VALUES (1,2,2,'Content Repeater','contentRepeater',4,'2022-11-16 06:42:22','2022-11-16 06:42:22','213c9175-81d2-4141-8993-904e59925583'),(3,2,4,'Media Content','media',5,'2022-11-16 06:42:25','2022-11-16 06:42:25','7593ee0e-5c97-47ca-a580-35990cabaffe'),(5,2,9,'Embedded Entries','entries',6,'2022-11-16 06:42:27','2022-11-16 06:42:27','4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f'),(7,2,13,'Text + Image(s)','textImage',3,'2022-11-16 06:42:29','2022-11-16 06:42:29','a39c9c32-2acb-47fd-ad36-7980c445a44e'),(8,9,14,'Code','code',2,'2022-11-16 06:42:30','2022-11-16 06:42:30','93580b97-9c95-4704-b7f5-a580fb56486c'),(9,21,15,'Text + Image(s)','textImage',1,'2022-11-16 06:42:30','2022-11-16 11:32:09','a25a7c39-08d8-449e-818a-0974ed415987'),(10,2,16,'Text','text',1,'2022-11-16 06:42:30','2022-11-16 06:42:30','a345255e-6a6e-450c-8f3f-bd44bd0d7a91'),(11,18,17,'Text','text',2,'2022-11-16 06:42:31','2022-11-16 06:42:31','0ad703e2-37a9-478e-9ad4-b6b00485da31'),(12,18,18,'Text + Media','media',3,'2022-11-16 06:42:32','2022-11-16 06:42:32','563430f9-eadc-4a5b-8adf-3f784f79d901'),(13,2,19,'Fragment','fragment',7,'2022-11-16 06:42:33','2022-11-16 06:42:33','d7da6677-ed4d-4768-8519-8c3123f108ab'),(14,9,20,'Form','form',3,'2022-11-16 06:42:33','2022-11-16 06:42:33','387e39f3-66b5-4aa5-a6a8-500db12ccadc'),(15,18,21,'Text + Image','textImage',1,'2022-11-16 06:42:34','2022-11-16 06:42:34','c00d6261-7e8e-413b-816c-41326575c213'),(16,2,22,'Text + Text','textText',2,'2022-11-16 06:42:35','2022-11-16 06:42:35','4fa97a99-7fb7-479d-aa34-e020e16ab4b8'),(17,9,38,'Table','table',1,'2022-11-16 06:42:43','2022-11-16 06:42:43','df5451d1-310f-43b1-9f9d-9b352d647c18'),(18,21,43,'Text','text',2,'2022-11-16 22:52:00','2022-11-16 22:52:00','21209162-922b-4edb-b952-1cd88d3ac05e');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_chunks`
--

LOCK TABLES `matrixcontent_chunks` WRITE;
/*!40000 ALTER TABLE `matrixcontent_chunks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_chunks` VALUES (1,29,1,'2022-11-16 06:50:33','2022-11-16 11:28:51','905565ce-9373-4eeb-bd9e-b1fcff216ea6',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(2,31,1,'2022-11-16 06:50:37','2022-11-16 06:50:37','9a488316-771a-4996-ae42-cca573f18361',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,33,1,'2022-11-16 06:50:46','2022-11-16 06:50:46','f5ff9986-1321-4cde-b836-5293d344336d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,63,1,'2022-11-16 10:16:55','2022-11-16 10:16:55','1f9dca06-f809-48ce-8836-90b08ad562ec',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,66,1,'2022-11-16 10:17:10','2022-11-16 10:17:10','977f3e46-7dde-4002-b242-33a44b536afa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,84,1,'2022-11-16 11:27:42','2022-11-16 11:27:42','0db75311-4493-422e-992c-1a49cb2669b8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,93,1,'2022-11-16 11:28:51','2022-11-16 11:28:51','90e00fc1-4f20-4637-9192-13d7a50d9920',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(9,98,1,'2022-11-16 11:29:07','2022-11-16 11:29:07','93280a01-14f8-4e25-9dd1-146c3ec811b3',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(10,106,1,'2022-11-16 11:35:02','2022-11-16 11:35:02','de730afa-5361-4ecb-a1ab-aeb0e018e231',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(11,112,1,'2022-11-16 11:37:29','2022-11-16 11:37:29','bd588545-3e31-4ca0-92f7-7c7aa0572c7a',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(12,118,1,'2022-11-16 11:37:49','2022-11-16 11:37:49','bc8bbdab-f8cc-47e1-9a46-30a1a0183695',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(13,124,1,'2022-11-16 11:39:06','2022-11-16 11:39:06','c31c192b-fde0-443a-9e9d-01435b0d2699',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(14,129,1,'2022-11-16 19:08:17','2022-11-16 19:08:17','0a33af90-ee76-4ce5-86d1-daf6c0f1b0c9',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(15,140,1,'2022-11-16 20:37:49','2022-11-16 20:37:49','942e9a0e-05ec-4d8a-9caf-1a14a35ff420',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(16,144,1,'2022-11-16 20:38:11','2022-11-16 20:38:11','006e03e5-c64d-4c57-b8c3-a8e3813d7192',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(17,160,1,'2022-11-16 21:11:31','2022-11-16 21:11:31','168d244d-f58b-4fd5-8ffd-96a0ce89fdae',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(18,189,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','fa785bb9-6517-45d4-a648-d0d63dd302ca',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(19,222,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','4174bba2-3f3e-484c-9ed8-78e2c4b2925b',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(20,249,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','72087fe5-3f63-42c8-b732-97d91bfe103e',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(21,256,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','21e28f8a-3f09-45f2-ba25-1d1e6d302a21',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(22,273,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','0a97c094-3f3b-40ab-8d1c-c478a626e250',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(23,280,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','1c396e1c-9dfc-41f2-a8e2-50e0fe65e351',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(24,287,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','c538a938-dfb3-490f-8597-ed1e237c9f15',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(25,294,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','9445e25e-62c7-40d6-a039-237ddef611d4',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(26,301,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','2771b87e-c34c-4858-8db8-d038906fc6fb',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL),(27,308,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','b9f3f8b8-ab0e-4fca-bdb7-4bb36bc4d944',NULL,NULL,NULL,'Contact Form',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `matrixcontent_chunks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_contentbuilder`
--

LOCK TABLES `matrixcontent_contentbuilder` WRITE;
/*!40000 ALTER TABLE `matrixcontent_contentbuilder` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_contentbuilder` VALUES (1,20,1,'2022-11-16 06:48:47','2022-11-16 06:48:47','e52508be-e832-4604-9ff6-605acd9af6b4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"choose\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"default\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',12,'faqs','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,21,1,'2022-11-16 06:48:49','2022-11-16 06:48:49','4ac2482e-1773-4196-bd0b-ed16cb21775f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"allSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"default\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',12,'faqs','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,22,1,'2022-11-16 06:48:57','2022-11-16 06:48:57','6dad34b4-cd9d-426f-b23f-d874e867d8a9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"allSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"default\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',12,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,23,1,'2022-11-16 06:48:59','2022-11-17 06:06:58','14b42fe9-dd55-4939-b1ab-0a020cf5e68e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"allSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"237\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"text\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"237\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"237\"}',2,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"gridCards\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"237\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"237\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,25,1,'2022-11-16 06:49:25','2022-11-16 06:49:25','5eed37bb-c44f-400c-888d-346bc288a6e7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"allSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"text\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',12,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,70,1,'2022-11-16 10:35:02','2022-11-16 10:35:02','94e2b073-8d64-4ae7-b781-4ea9b0046217',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"allSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"text\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',12,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"gridCards\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,90,1,'2022-11-16 11:28:51','2022-11-17 10:44:59','51519524-7e73-4e35-ad25-97b4e5c0a1d8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"295\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"295\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"295\"}',NULL,NULL,NULL,NULL,NULL),(10,92,1,'2022-11-16 11:28:51','2022-11-16 11:28:51','358abb51-ffa3-400e-be9d-15bbadbc2a92',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,'{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(12,97,1,'2022-11-16 11:29:07','2022-11-16 11:29:07','69d874ea-a888-415a-acc9-5c48d55c4205',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,'{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(13,104,1,'2022-11-16 11:35:02','2022-11-16 11:35:02','f883a2a1-b633-4546-81de-1fbfc520660c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,'{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(15,110,1,'2022-11-16 11:37:29','2022-11-16 11:37:29','42342d7f-0f2f-43ea-89c4-91e77a16c05c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(16,116,1,'2022-11-16 11:37:49','2022-11-16 11:37:49','c85d2a2c-9958-44c9-8de7-e2ce84391095',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(17,122,1,'2022-11-16 11:39:06','2022-11-16 11:39:06','4815e5e7-509d-4098-bb47-b6056de28ad8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(18,127,1,'2022-11-16 19:08:17','2022-11-16 19:08:17','0eabcab6-00e6-4ac2-a29c-c90c6834e522',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(20,138,1,'2022-11-16 20:37:49','2022-11-16 20:37:49','da146a8a-6ec9-4d9b-bb8f-d8e360819ffa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(21,142,1,'2022-11-16 20:38:11','2022-11-16 20:38:11','8d194388-9ede-42b4-b5c0-00de11f4e61d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(22,146,1,'2022-11-16 20:38:14','2022-11-16 20:38:14','e21db4e9-1fc4-4fe0-a60c-9ca48d7da778',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"allSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"text\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',12,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"gridCards\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,150,1,'2022-11-16 20:46:29','2022-11-16 20:46:29','8b937874-670b-40bb-99ea-c44592378663',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"149\"}',NULL,'{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"149\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"149\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,153,1,'2022-11-16 20:46:32','2022-11-16 20:46:32','27753bd4-cd4d-4b41-87f2-48870c23e432',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"149\"}','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ad bona praeterita redeamus. Nonne igitur tibi videntur, inquit, mala? Duo Reges: constructio interrete. Videamus animi partes, quarum est conspectus illustrior;</p>\n<p>Duo enim genera quae erant, fecit tria. At ego quem huic anteponam non audeo dicere; Hoc mihi cum tuo fratre convenit. Quoniam, si dis placet, ab Epicuro loqui discimus. Quis istud possit, inquit, negare? Igitur ne dolorem quidem. Immo alio genere;</p>\n<p>Quod ea non occurrentia fingunt, vincunt Aristonem; Compensabatur, inquit, cum summis doloribus laetitia. Hanc ergo intuens debet institutum illud quasi signum absolvere. Prioris generis est docilitas, memoria; Praeclare hoc quidem.</p>','{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"149\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"149\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,155,1,'2022-11-16 20:46:32','2022-11-16 20:46:32','406c981e-7251-4780-9fd7-04a6e28cf9b7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"38\"}','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ad bona praeterita redeamus. Nonne igitur tibi videntur, inquit, mala? Duo Reges: constructio interrete. Videamus animi partes, quarum est conspectus illustrior;</p>\n<p>Duo enim genera quae erant, fecit tria. At ego quem huic anteponam non audeo dicere; Hoc mihi cum tuo fratre convenit. Quoniam, si dis placet, ab Epicuro loqui discimus. Quis istud possit, inquit, negare? Igitur ne dolorem quidem. Immo alio genere;</p>\n<p>Quod ea non occurrentia fingunt, vincunt Aristonem; Compensabatur, inquit, cum summis doloribus laetitia. Hanc ergo intuens debet institutum illud quasi signum absolvere. Prioris generis est docilitas, memoria; Praeclare hoc quidem.</p>','{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"38\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"38\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,158,1,'2022-11-16 21:11:31','2022-11-16 21:11:31','6b90d9b3-5d7a-437b-9d88-ae48a39f260d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(29,168,1,'2022-11-16 21:14:23','2022-11-16 21:14:23','be11399f-3d1a-44e4-951e-1ca9b01b23c2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"allSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"text\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',12,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"gridCards\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,173,1,'2022-11-16 21:20:12','2022-11-16 21:20:12','d9c49a31-72da-4d6a-a427-bc3dfc74b28d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"allSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"text\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',12,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"gridCards\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,186,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','ebaeb482-b6ba-40f2-8561-e407b0ac2c65',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(32,195,1,'2022-11-17 05:12:49','2022-11-17 05:12:49','fed43b99-7628-4ef6-ac3e-87b90f42cfec','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,196,1,'2022-11-17 05:12:52','2022-11-17 05:12:52','d536fecf-cacd-4eb9-8eaa-ea70d4c412c4','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,198,1,'2022-11-17 05:15:16','2022-11-17 05:15:16','7d543246-4d75-45b3-8de2-63cb1c39c9e4','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}','<p>123</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,200,1,'2022-11-17 05:15:22','2022-11-17 05:15:22','80e78715-811c-4bc4-a27e-4be66c5d7270','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"194\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,207,1,'2022-11-17 05:23:28','2022-11-17 05:23:28','5d3ef997-eac9-4a48-884a-40947d1698a8','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,208,1,'2022-11-17 05:23:30','2022-11-17 05:23:30','e3d1b67a-0814-4ed8-acc7-a4202c324ec8','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,210,1,'2022-11-17 05:23:34','2022-11-17 05:23:34','07a45bf6-deff-426a-9e04-3ddbb3a0b423','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,213,1,'2022-11-17 05:23:40','2022-11-17 05:23:40','9e11e1ea-89b1-416d-bf0f-68058c41dcb0','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"206\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,216,1,'2022-11-17 05:23:42','2022-11-17 06:09:47','9715b0b0-fe41-4586-a046-1f572726e7cd','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"223\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"223\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"223\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,218,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','fd00a78c-079d-4b67-9cac-5b036164e2ba',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(44,219,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','59de63bb-ae50-4751-92bb-2940dcadea44','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,228,1,'2022-11-17 05:58:43','2022-11-17 05:58:43','23726316-0575-4b15-9b30-3e0f07692b1c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"choose\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"default\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',12,'faqs','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,229,1,'2022-11-17 05:58:48','2022-11-17 05:58:48','c3a0178e-5517-4762-8d58-4a5bc79008fd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"limitedSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"default\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',12,'faqs','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(48,230,1,'2022-11-17 05:58:52','2022-11-17 05:58:52','a6dcfcac-f5bc-4234-9e56-0bb48d60677c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',2,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"limitedSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"default\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',12,'faqs','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(49,231,1,'2022-11-17 05:59:00','2022-11-17 05:59:00','8f169f30-0df7-4ace-81b0-582d72a58430',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',1,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"limitedSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"default\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',12,'faqs','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,233,1,'2022-11-17 05:59:06','2022-11-17 05:59:06','02fae6f5-4845-40e0-aa2f-0d50f4a5738c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',1,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"limitedSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"default\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',12,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"227\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,236,1,'2022-11-17 05:59:06','2022-11-17 05:59:06','cac0054a-24f7-4ea4-b0a6-11ecfebd26c3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',1,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"limitedSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"default\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}',12,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"featuredEntry\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,241,1,'2022-11-17 06:06:58','2022-11-17 06:06:58','3610b4c9-29a4-40b7-b436-d722c26b148c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mostRecent',3,'{\"refpath\":\"_builders/references/selectionMethod.json\",\"value\":\"allSearch\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/overrideCards.json\",\"value\":\"text\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',2,'news','{\"refpath\":\"_builders/references/blockEmbeddedEntries.json\",\"value\":\"gridCards\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,244,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','a0a648a8-b2cc-4885-99fe-d51ac1025c37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(56,245,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','d1daa04c-d125-4499-8d82-bcb124557857','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockContentRepeater.json\",\"value\":\"accordion\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(57,253,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','566727f2-c39b-4cb7-a38b-97c0229a666f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(58,258,1,'2022-11-17 07:44:47','2022-11-17 07:44:47','06d701c7-3cad-4c1f-bae7-c4bd03ae4eeb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"257\"}',NULL,'{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"257\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"257\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(60,260,1,'2022-11-17 07:45:17','2022-11-17 07:54:39','4fc806c4-9395-4703-9c8d-7251bb9b5db1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgWhite\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"263\"}','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quid, si etiam iucunda memoria est praeteritorum malorum? Vide, quantum, inquam, fallare, Torquate. <strong>Moriatur, inquit.</strong> Quae autem natura suae primae institutionis oblita est? Sed tempus est, si videtur, et recta quidem ad me. Sic enim censent, oportunitatis esse beate vivere. <a href=\"http://loripsum.net/\" target=\"_blank\" rel=\"noreferrer noopener\">Quantum Aristoxeni ingenium consumptum videmus in musicis?</a> Duo Reges: constructio interrete. <strong>Laboro autem non sine causa;</strong> <a href=\"http://loripsum.net/\" target=\"_blank\" rel=\"noreferrer noopener\">Quae cum essent dicta, discessimus.</a> </p>\n<p>Mihi, inquam, qui te id ipsum rogavi? Immo videri fortasse. De ingenio eius in his disputationibus, non de moribus quaeritur. Quid enim possumus hoc agere divinius? </p>\n<p><strong>Iam contemni non poteris.</strong> Atqui reperies, inquit, in hoc quidem pertinacem; <strong>Ratio enim nostra consentit, pugnat oratio.</strong> Scaevola tribunus plebis ferret ad plebem vellentne de ea re quaeri. Cuius similitudine perspecta in formarum specie ac dignitate transitum est ad honestatem dictorum atque factorum. <strong>Bonum integritas corporis: misera debilitas.</strong> <em>Honesta oratio, Socratica, Platonis etiam.</em> Sic, et quidem diligentius saepiusque ista loquemur inter nos agemusque communiter. Qui ita affectus, beatum esse numquam probabis; Etsi ea quidem, quae adhuc dixisti, quamvis ad aetatem recte isto modo dicerentur. Atque haec ita iustitiae propria sunt, ut sint virtutum reliquarum communia. Efficiens dici potest. </p>','{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"263\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"263\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(61,262,1,'2022-11-17 07:45:17','2022-11-17 07:45:17','4f3a0822-cb3d-4258-bbb9-d80ca92c055e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"133\"}','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quid, si etiam iucunda memoria est praeteritorum malorum? Vide, quantum, inquam, fallare, Torquate. <strong>Moriatur, inquit.</strong> Quae autem natura suae primae institutionis oblita est? Sed tempus est, si videtur, et recta quidem ad me. Sic enim censent, oportunitatis esse beate vivere. <a href=\"http://loripsum.net/\" target=\"_blank\" rel=\"noreferrer noopener\">Quantum Aristoxeni ingenium consumptum videmus in musicis?</a> Duo Reges: constructio interrete. <strong>Laboro autem non sine causa;</strong> <a href=\"http://loripsum.net/\" target=\"_blank\" rel=\"noreferrer noopener\">Quae cum essent dicta, discessimus.</a> </p>\n<p>Mihi, inquam, qui te id ipsum rogavi? Immo videri fortasse. De ingenio eius in his disputationibus, non de moribus quaeritur. Quid enim possumus hoc agere divinius? </p>\n<p><strong>Iam contemni non poteris.</strong> Atqui reperies, inquit, in hoc quidem pertinacem; <strong>Ratio enim nostra consentit, pugnat oratio.</strong> Scaevola tribunus plebis ferret ad plebem vellentne de ea re quaeri. Cuius similitudine perspecta in formarum specie ac dignitate transitum est ad honestatem dictorum atque factorum. <strong>Bonum integritas corporis: misera debilitas.</strong> <em>Honesta oratio, Socratica, Platonis etiam.</em> Sic, et quidem diligentius saepiusque ista loquemur inter nos agemusque communiter. Qui ita affectus, beatum esse numquam probabis; Etsi ea quidem, quae adhuc dixisti, quamvis ad aetatem recte isto modo dicerentur. Atque haec ita iustitiae propria sunt, ut sint virtutum reliquarum communia. Efficiens dici potest. </p>','{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"133\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"133\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,266,1,'2022-11-17 07:54:40','2022-11-17 07:54:40','cdd68fc6-e4d4-455b-a15a-0050d858f61e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgWhite\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"133\"}','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quid, si etiam iucunda memoria est praeteritorum malorum? Vide, quantum, inquam, fallare, Torquate. <strong>Moriatur, inquit.</strong> Quae autem natura suae primae institutionis oblita est? Sed tempus est, si videtur, et recta quidem ad me. Sic enim censent, oportunitatis esse beate vivere. <a href=\"http://loripsum.net/\" target=\"_blank\" rel=\"noreferrer noopener\">Quantum Aristoxeni ingenium consumptum videmus in musicis?</a> Duo Reges: constructio interrete. <strong>Laboro autem non sine causa;</strong> <a href=\"http://loripsum.net/\" target=\"_blank\" rel=\"noreferrer noopener\">Quae cum essent dicta, discessimus.</a> </p>\n<p>Mihi, inquam, qui te id ipsum rogavi? Immo videri fortasse. De ingenio eius in his disputationibus, non de moribus quaeritur. Quid enim possumus hoc agere divinius? </p>\n<p><strong>Iam contemni non poteris.</strong> Atqui reperies, inquit, in hoc quidem pertinacem; <strong>Ratio enim nostra consentit, pugnat oratio.</strong> Scaevola tribunus plebis ferret ad plebem vellentne de ea re quaeri. Cuius similitudine perspecta in formarum specie ac dignitate transitum est ad honestatem dictorum atque factorum. <strong>Bonum integritas corporis: misera debilitas.</strong> <em>Honesta oratio, Socratica, Platonis etiam.</em> Sic, et quidem diligentius saepiusque ista loquemur inter nos agemusque communiter. Qui ita affectus, beatum esse numquam probabis; Etsi ea quidem, quae adhuc dixisti, quamvis ad aetatem recte isto modo dicerentur. Atque haec ita iustitiae propria sunt, ut sint virtutum reliquarum communia. Efficiens dici potest. </p>','{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"133\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"133\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(64,270,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','62358ab1-672c-4669-a9dc-c223e754942f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(66,277,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','221539d7-187f-4476-824c-a67f67f9414c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgWhite\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(68,284,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','fae38ae7-288a-486a-ac68-a233ca70aee7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgDark\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(69,291,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','2a82bb1f-4808-407f-bb56-4ba789b98216',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"bgDark\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(71,298,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','c5bc0fde-1645-4e26-8828-2c955d468377',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(72,305,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','d1d2c1e1-b4d6-424f-a82f-b5ad03af877a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacingFragment.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgroundsFragment.json\",\"value\":\"FROMFRAGMENT\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h2 class=\"rd-h2\">We\'d love to hear from you!</h2>','{\"refpath\":\"_builders/references/entryChunk.twig\",\"value\":\"29\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `matrixcontent_contentbuilder` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_headerbuilder`
--

LOCK TABLES `matrixcontent_headerbuilder` WRITE;
/*!40000 ALTER TABLE `matrixcontent_headerbuilder` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_headerbuilder` VALUES (1,55,1,'2022-11-16 10:16:29','2022-11-16 10:16:29','9d7cfb0a-2ea0-46ce-a8ad-3309235dc606',NULL,'{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}',NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,56,1,'2022-11-16 10:16:37','2022-11-16 10:16:37','0262d4bf-ab0e-4880-bfe4-60bd4a9ee4dc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}',NULL,NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}'),(3,57,1,'2022-11-16 10:16:42','2022-11-16 10:16:42','ad9b57ee-8929-4f53-b4fd-1b0e4f62df54',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','<p>Welcome </p>',NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}'),(4,58,1,'2022-11-16 10:16:43','2022-11-16 10:16:43','34f1ee84-3e7a-4e29-a122-619e6fa7b666',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','<p>Welcome to </p>',NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}'),(6,60,1,'2022-11-16 10:16:55','2022-11-16 10:16:55','da7cb1f3-7b86-4bc2-b390-fce7c45791e5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}','<p>Welcome</p>',NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"53\"}'),(7,62,1,'2022-11-16 10:16:55','2022-11-16 10:16:55','458bfa0d-b8a7-499f-9325-a753f066d994',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<p>Welcome</p>',NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}'),(8,65,1,'2022-11-16 10:17:10','2022-11-16 10:17:10','ddfe5168-0c7f-4c02-a264-f37294f29ede',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<p>Welcome</p>',NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}'),(9,72,1,'2022-11-16 11:26:59','2022-11-16 11:26:59','6ff6bace-a278-42f0-a9d6-144eaf139ccf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}',NULL,NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}'),(10,73,1,'2022-11-16 11:27:03','2022-11-16 11:27:03','4adf5f59-1d00-4d97-8a59-cbfec59f4678',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','<p>Welcome</p>',NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}'),(11,74,1,'2022-11-16 11:27:04','2022-11-16 11:27:04','043ad539-a1e8-43b0-b4c5-44f65b259b2a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','<p>Welcome</p>','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tum Triarius: Posthac quidem, inquit, audacius. Refert tamen, quo modo.</p>\n<p>Duo Reges: constructio interrete. Quid autem habent admirationis, cum prope accesseris?</p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}'),(12,75,1,'2022-11-16 11:27:06','2022-11-16 11:27:06','0d23c48d-5d03-40f7-a666-49ee8646a18e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','<p>Welcome</p>','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tum Triarius: Posthac quidem, inquit, audacius. Refert tamen, quo modo. Duo Reges: constructio interrete. Quid autem habent admirationis, cum prope accesseris?</p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}'),(13,76,1,'2022-11-16 11:27:08','2022-11-16 11:27:08','6227e237-4c19-4caa-853e-b28518d1e5d0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','<p>Welcome</p>','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.Tum Triarius: Posthac quidem, inquit, audacius. Refert tamen, quo modo. Duo Reges: constructio interrete. Quid autem habent admirationis, cum prope accesseris?</p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}'),(14,77,1,'2022-11-16 11:27:10','2022-11-16 11:27:10','6ab39684-2fd5-467e-96aa-468b6c4a9702',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}','<p>Welcome</p>','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>\n<p>Tum Triarius: Posthac quidem, inquit, audacius. Refert tamen, quo modo. Duo Reges: constructio interrete. Quid autem habent admirationis, cum prope accesseris?</p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"71\"}'),(16,79,1,'2022-11-16 11:27:17','2022-11-17 04:34:36','4d44c70f-18d2-4e3a-83de-62e8318b2bb4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"190\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"190\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"190\"}','<p>Wireframe!</p>','<p class=\"larger\">Lorem ipsum dolor sit amet elit</p>\n<p>Posthac quidem, inquit, audacius. Refert tamen, quo modo. Duo Reges: constructio interrete. Quid autem habent admirationis, cum prope accesseris?</p>\n<p><a href=\"{entry:19@1:url||http://localhost:8000/news}\" class=\"button\">Primary</a> <a href=\"{entry:28@1:url||http://localhost:8000/contact}\" class=\"button\">Alternate</a></p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"190\"}'),(17,81,1,'2022-11-16 11:27:17','2022-11-16 11:27:17','c0ef3c4c-5044-48f1-b54c-8e683777492a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','<p>Welcome</p>','<p class=\"larger\">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>\n<p>Tum Triarius: Posthac quidem, inquit, audacius. Refert tamen, quo modo. Duo Reges: constructio interrete. Quid autem habent admirationis, cum prope accesseris?</p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}'),(18,162,1,'2022-11-16 21:14:17','2022-11-16 21:14:17','da733495-d77f-4657-85e7-677ea2ee6dd6',NULL,'{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"161\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"161\"}',NULL,'{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"161\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,163,1,'2022-11-16 21:14:20','2022-11-16 21:14:20','93203231-3346-45b3-917d-a4de8e8f4c1e',NULL,'{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"161\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"161\"}','<p>Rwe</p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"161\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,165,1,'2022-11-16 21:14:23','2022-11-16 21:20:12','2e54749d-74fe-477a-ae59-46ad11887ae7',NULL,'{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"161\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"161\"}','<p>Recent <strong>News</strong></p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"161\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,167,1,'2022-11-16 21:14:23','2022-11-16 21:14:23','5112c5f1-ab5b-4b6a-aa6e-e3c91c185e72',NULL,'{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','<p>Recent News</p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,172,1,'2022-11-16 21:20:12','2022-11-16 21:20:12','e87f7c43-b3a1-4cae-9b5e-6545a1646ae3',NULL,'{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','<p>Recent <strong>News</strong></p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,193,1,'2022-11-17 04:34:36','2022-11-17 04:34:36','f1e33e92-64f9-4e29-bd0d-05c9d6116c7b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','<p>Wireframe!</p>','<p class=\"larger\">Lorem ipsum dolor sit amet elit</p>\n<p>Posthac quidem, inquit, audacius. Refert tamen, quo modo. Duo Reges: constructio interrete. Quid autem habent admirationis, cum prope accesseris?</p>\n<p><a href=\"{entry:19@1:url||http://localhost:8000/news}\" class=\"button\">Primary</a> <a href=\"{entry:28@1:url||http://localhost:8000/contact}\" class=\"button\">Alternate</a></p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}'),(27,235,1,'2022-11-17 05:59:06','2022-11-17 05:59:06','693c80ef-6501-4784-83c8-be812d149ca6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','{\"refpath\":\"_builders/references/blockTextImage.json\",\"value\":\"textLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}','<p>Wireframe!</p>','<p class=\"larger\">Lorem ipsum dolor sit amet elit</p>\n<p>Posthac quidem, inquit, audacius. Refert tamen, quo modo. Duo Reges: constructio interrete. Quid autem habent admirationis, cum prope accesseris?</p>\n<p><a href=\"{entry:19@1:url||http://localhost:8000/news}\" class=\"button\">Primary</a> <a href=\"{entry:28@1:url||http://localhost:8000/contact}\" class=\"button\">Alternate</a></p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"17\"}'),(28,240,1,'2022-11-17 06:06:58','2022-11-17 06:06:58','ab5eee09-c6bb-41fd-9352-51cc1fac350e',NULL,'{\"refpath\":\"_builders/references/blockText.json\",\"value\":\"optimalLeft\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','{\"refpath\":\"_builders/references/spacingHero.json\",\"value\":\"spaceNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}','<p>Recent <strong>News</strong></p>','{\"refpath\":\"_builders/references/backgroundsHero.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"19\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `matrixcontent_headerbuilder` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_sidebarbuilder`
--

LOCK TABLES `matrixcontent_sidebarbuilder` WRITE;
/*!40000 ALTER TABLE `matrixcontent_sidebarbuilder` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_sidebarbuilder` VALUES (1,54,1,'2022-11-16 10:10:20','2022-11-16 10:10:20','80269d0a-b449-490f-8131-91ad8cdd4556',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,100,1,'2022-11-16 11:34:54','2022-11-16 11:34:54','abceeeb4-e810-4485-b514-ee85220a3f5a',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"99\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"99\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"99\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"99\"}',NULL,NULL,NULL,NULL,NULL),(4,102,1,'2022-11-16 11:35:02','2022-11-17 10:49:11','4b1ff4dc-17ce-4ba4-a83d-b1a01e520414','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgWhite\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"302\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"302\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"302\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"302\"}',NULL,NULL,NULL,NULL,NULL),(5,105,1,'2022-11-16 11:35:02','2022-11-16 11:35:02','c36701cb-329e-4035-b55c-c157def83ec0',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(6,111,1,'2022-11-16 11:37:29','2022-11-16 11:37:29','10ae4ff8-3214-48ea-85bf-67d508cace40',NULL,'{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(8,117,1,'2022-11-16 11:37:49','2022-11-16 11:37:49','87f0602b-a3e8-4491-857e-08876123d499','Our Location','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(10,123,1,'2022-11-16 11:39:06','2022-11-16 11:39:06','c5f0d5fd-dd71-4b8f-b291-a10b23711809','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(11,128,1,'2022-11-16 19:08:17','2022-11-16 19:08:17','eb0ee5ed-7288-47bd-a339-45383a28e313','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(12,139,1,'2022-11-16 20:37:49','2022-11-16 20:37:49','789c4da6-787d-46c7-80fe-44bd9a3f5039','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(13,143,1,'2022-11-16 20:38:11','2022-11-16 20:38:11','595ec417-e41f-4ec4-b4e2-5b0762acf864','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(14,159,1,'2022-11-16 21:11:31','2022-11-16 21:11:31','0ef91e95-46e1-4257-9ac3-17a7c30a0681','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(15,179,1,'2022-11-16 22:52:16','2022-11-16 22:52:16','680b7d97-6980-4fac-9bed-6315e1f506f1',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}',NULL),(16,180,1,'2022-11-16 22:52:20','2022-11-16 22:52:20','9ef2dcb8-054e-4795-9628-a88cab88c7a8',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','<p>Follow us </p>'),(17,181,1,'2022-11-16 22:52:23','2022-11-16 22:52:23','e2cf2139-ed8d-4d44-a081-c949cf286e5a',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','<p>Follow us On Social media</p>'),(18,182,1,'2022-11-16 22:52:26','2022-11-16 22:52:26','1e8a7e30-2611-4d55-a4d3-29b44fc6d4da',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"178\"}','<h4 class=\"rd-h4\">Follow us On Social media</h4>'),(20,184,1,'2022-11-16 22:52:33','2022-11-17 06:10:16','29f70bf3-bb69-44b6-828a-0589b30717e9',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"250\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"250\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"250\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"250\"}','<h4 class=\"rd-h4\">Follow us!</h4>'),(21,187,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','80974f8b-e826-4a52-8515-932bf92daec4','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(22,188,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','1c23a11a-b21c-4a15-9cca-35ec41389b68',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us On Social media</h4>'),(23,220,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','627d9b65-b58a-455a-940f-d423455dc240','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(24,221,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','4b98762f-ac5c-45d1-8928-3f37c3045ac6',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us On Social media</h4>'),(25,247,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','cd095253-c1e2-4209-8816-e35ddbfc1442','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(26,248,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','437625a9-8d67-4a2f-8112-87bb60cb4ece',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us On Social media</h4>'),(28,254,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','0ab2a6a2-4cbc-45c7-9041-af5732877b02','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(29,255,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','e1e4bb52-a3da-44f3-8974-07d052b047ae',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us!</h4>'),(31,271,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','49c392b8-83bc-4489-887a-24af85d1f5a1','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgWhite\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(32,272,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','20d35f2a-7440-40cc-a999-b5e20ed0ed61',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us!</h4>'),(33,278,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','0067df1d-2013-47be-93f0-cc261e98c626','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgWhite\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(34,279,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','9f8739b3-4cfc-48ce-9ac8-a1a6f9cc7cb2',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us!</h4>'),(35,285,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','bdf49185-2d9e-4c31-b516-abc11421fc0d','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgWhite\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(36,286,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','ad1f3c8a-5ac7-4f32-ad3d-06fdd1279154',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us!</h4>'),(38,292,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','5fd66f8f-445a-44da-89f0-b6507ca2862b','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(39,293,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','db5ec321-2dbc-4bf1-aaba-8ff0541d0132',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us!</h4>'),(40,299,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','6df05f3a-3f00-4c59-897f-84f4c91cebd7','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(41,300,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','eaa87999-ac4d-45e2-94e0-63b290d67d34',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us!</h4>'),(43,306,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','fa98a362-b0bc-4c88-9fed-471d7ad37e0e','<h4>Our Location</h4>','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgWhite\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"contactDetails\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}',NULL,NULL,NULL,NULL,NULL),(44,307,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','08037c96-aa59-4e3f-a25f-84acaf141016',NULL,NULL,NULL,NULL,NULL,'{\"refpath\":\"_builders/references/spacing.json\",\"value\":\"spaceGap\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/widgets.json\",\"value\":\"socialIcons\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/backgrounds.json\",\"value\":\"bgNone\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','{\"refpath\":\"_builders/references/blockSidebarText.json\",\"value\":\"fullWidth\",\"elementClass\":\"craft\\\\elements\\\\Entry\",\"elementId\":\"28\"}','<h4 class=\"rd-h4\">Follow us!</h4>');
/*!40000 ALTER TABLE `matrixcontent_sidebarbuilder` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixfieldpreview_blocktypes_config`
--

LOCK TABLES `matrixfieldpreview_blocktypes_config` WRITE;
/*!40000 ALTER TABLE `matrixfieldpreview_blocktypes_config` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixfieldpreview_blocktypes_config` VALUES (1,'2022-11-16 06:48:24','2022-11-16 06:48:24','45f4c2ff-2b2e-4c58-a0b1-e7d320c089a4',15,18,NULL,'',NULL,0),(2,'2022-11-16 06:48:24','2022-11-16 06:48:24','55f299ae-3887-4105-b7ea-9e76978a9ab2',11,18,NULL,'',NULL,0),(3,'2022-11-16 06:48:24','2022-11-16 06:48:24','d62de0b4-9154-4d1c-a25d-8427d69f9ca7',12,18,NULL,'',NULL,0),(4,'2022-11-16 06:48:24','2022-11-16 06:48:24','f9242ac6-8651-452c-8e79-fa181712f063',10,2,NULL,'',NULL,0),(5,'2022-11-16 06:48:24','2022-11-16 06:48:24','68276e38-6910-4f79-a86b-bb81ea8bc228',16,2,NULL,'',NULL,0),(6,'2022-11-16 06:48:24','2022-11-16 06:48:24','8d7300d7-390f-4591-b0b0-0e0dcbf4573d',17,9,NULL,'',NULL,0),(7,'2022-11-16 06:48:24','2022-11-16 06:48:24','446771c9-8389-462b-9649-911a42dad819',7,2,NULL,'',NULL,0),(8,'2022-11-16 06:48:24','2022-11-16 06:48:24','b5891a32-92ef-4583-8f5e-fd1721353836',8,9,NULL,'',NULL,0),(9,'2022-11-16 06:48:24','2022-11-16 06:48:24','9e51f5e4-03e0-4c1f-80ab-56b804568a0b',1,2,NULL,'',NULL,0),(10,'2022-11-16 06:48:24','2022-11-16 06:48:24','f526943c-fb71-4336-a933-aa7725f1f2c4',14,9,NULL,'',NULL,0),(11,'2022-11-16 06:48:24','2022-11-16 06:48:24','e3a4e3ad-6faa-43dc-83eb-ae68e97289f4',3,2,NULL,'',NULL,0),(12,'2022-11-16 06:48:24','2022-11-16 06:48:24','834d4177-835f-4e9e-9cea-d02d82d89308',5,2,NULL,'',NULL,0),(13,'2022-11-16 06:48:24','2022-11-16 06:48:24','aff50e70-1c06-4a22-82e3-80e1b378ef77',13,2,NULL,'',NULL,0),(14,'2022-11-16 10:10:15','2022-11-16 10:10:15','c5b0eaa4-b5ce-4a2a-9cc3-47735b90686b',9,21,NULL,'',NULL,0),(15,'2022-11-16 22:52:10','2022-11-16 22:52:10','caacbc35-c844-44aa-8096-de79725f13f8',18,21,NULL,'',NULL,0);
/*!40000 ALTER TABLE `matrixfieldpreview_blocktypes_config` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixfieldpreview_category`
--

LOCK TABLES `matrixfieldpreview_category` WRITE;
/*!40000 ALTER TABLE `matrixfieldpreview_category` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixfieldpreview_category` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixfieldpreview_fields_config`
--

LOCK TABLES `matrixfieldpreview_fields_config` WRITE;
/*!40000 ALTER TABLE `matrixfieldpreview_fields_config` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixfieldpreview_fields_config` VALUES (1,'2022-11-16 06:48:24','2022-11-16 06:48:24','dabd2b8a-bffc-4bd1-a2a8-c77f1dbb14ef',18,1,1),(2,'2022-11-16 06:48:24','2022-11-16 06:48:24','89a7f1fa-ffa1-4953-a5a4-bbbce6187419',2,1,1),(3,'2022-11-16 06:48:24','2022-11-16 06:48:24','a5fcf1fe-1548-417c-81a5-9baa6d4e6e0a',9,1,1),(4,'2022-11-16 10:10:15','2022-11-16 10:10:15','24dff84d-6d26-4e87-a7c6-10e617790f92',21,1,1);
/*!40000 ALTER TABLE `matrixfieldpreview_fields_config` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,'plugin:dospaces','m220426_100557_update_volume_to_fs','2022-11-16 06:42:06','2022-11-16 06:42:06','2022-11-16 06:42:06','c0bc0a6a-db82-4930-854d-344a9bc5d5f2'),(2,'plugin:formie','Install','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','e9e76e17-82ba-4262-8f76-ab716b0c4bf0'),(3,'plugin:formie','m220420_000000_stencil_add_entryid','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','dcd10550-0a67-4fed-b940-61e98cbb475c'),(4,'plugin:formie','m220422_000000_migrate_asset_fields','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','6c8509e5-1485-453b-925d-77d27d18ab03'),(5,'plugin:formie','m220530_000000_payments','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','e8bdbab8-8f17-426f-805a-09bfea47d587'),(6,'plugin:formie','m220727_000000_hubspot','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','c2b8687b-5159-487f-be21-a9aedb7e0ab7'),(7,'plugin:formie','m220903_000000_remove_old_form_settings','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','3acd6795-c20f-4a3b-b4af-b51db2f247dc'),(8,'plugin:formie','m220904_000000_add_siteid_entry_redirect','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','e192310b-6aeb-47bb-853f-e0eb6c01d147'),(9,'plugin:formie','m220905_000000_integration_enabled','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','ac446cd5-10d5-4c6a-b2e2-717077297efe'),(10,'plugin:formie','m220917_000000_submission_spamclass','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','d56b1fa6-95bc-49cb-8730-4c59608de8e4'),(11,'plugin:formie','m220918_000000_email_sender','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','2bc81f5a-10b7-42be-93ed-513155204912'),(12,'plugin:knock-knock','Install','2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-16 06:42:13','1702acd9-cf30-4c08-a411-ea3761a7b125'),(13,'plugin:matrix-field-preview','Install','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','8efe54ff-d208-47ab-bbcb-09eb8dabea71'),(14,'plugin:matrix-field-preview','m200717_143303_create_field_foreign_key','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','670a77b4-9150-4e07-bcc5-86d381d9d7a1'),(15,'plugin:matrix-field-preview','m201025_204725_new_matrix_field_table','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','ea7af211-475f-4987-859f-834eadb5a716'),(16,'plugin:matrix-field-preview','m201026_153002_rename_preview_table','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','b3b62cb0-0385-4260-b74d-5dbe8ff51bcd'),(17,'plugin:matrix-field-preview','m201026_153926_migrate_block_type_handle_data','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','9988f161-aa65-4cda-acb7-142412fc68bc'),(18,'plugin:matrix-field-preview','m201031_120401_add_neo_support','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','a5f8f7bc-b199-4be4-a7e3-871536b9894d'),(19,'plugin:matrix-field-preview','m220531_194116_create_category_table','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','3d38f820-fbda-40e8-ae9f-0d44e392777d'),(20,'plugin:matrix-field-preview','m220602_095344_add_category_foreignkey','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','8ad55f1d-0cb4-4e9b-b80d-77397eedc67f'),(21,'plugin:matrix-field-preview','m220606_112005_add_category_fk_to_neo','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','025ee1a3-c88b-4b6c-8d00-524e2443211d'),(22,'plugin:matrix-field-preview','m220606_200119_add_matrix_block_type_sort_order','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','2a407f61-44d8-4f77-ba4d-425666e67a27'),(23,'plugin:matrix-field-preview','m220606_200131_add_neo_block_type_sort_order','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','23580882-dfed-4964-afbf-07073c504b1a'),(24,'plugin:matrix-field-preview','m220607_111203_remove_site_ids','2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-16 06:42:14','c16e54ca-362a-450b-87bb-7c2e55aedf75'),(25,'plugin:navigation','Install','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','d5539838-de4c-49a4-b174-276d1556e5e0'),(26,'plugin:navigation','m220427_000000_navs_site_settings','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','190acc04-d072-431e-8191-7b289ed75cd6'),(27,'plugin:navigation','m220427_100000_navs_placement','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','45866006-14e4-428e-9c72-901490ff9e72'),(28,'plugin:navigation','m220428_000000_custom_node_type','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','06ff5af9-b4bf-4fc3-af38-de6b06100889'),(29,'plugin:navigation','m220831_000000_fix_nav_sites','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','caca0508-860e-486d-bb40-a79a9abf37c9'),(30,'plugin:navigation','m220902_000000_fix_empty_nav_sites','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','b9c3907d-5d7c-4c34-9eef-3591ebe4b125'),(31,'plugin:navigation','m221025_000000_propagation','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','1b81eb00-7531-467d-bc87-cbe17c2e12e8'),(32,'plugin:navigation','m221025_100000_max_nodes_settings','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','d4c7eeca-e6e8-4de7-9a15-4290de80dd4b'),(33,'plugin:redactor','m180430_204710_remove_old_plugins','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','9843059a-9c02-46c4-9834-552e7f8c69ee'),(34,'plugin:redactor','Install','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','eb1ae709-637d-4f32-8da0-2ccbaf776e19'),(35,'plugin:redactor','m190225_003922_split_cleanup_html_settings','2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-16 06:42:15','fd64f76e-bbf3-4ba0-ad53-c2b57f6f6150'),(36,'plugin:redirect','Install','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','81aaafe2-9b87-4103-8d34-8c4f2af70f94'),(37,'plugin:redirect','m170602_080218_redirect_1_0_1','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','5a0a1c0f-def2-4738-a45c-912f9c3ff9dc'),(38,'plugin:redirect','m170707_211256_count_fix','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','71ce29ef-36a8-4d92-8b1d-030300b33744'),(39,'plugin:redirect','m171003_120604_createmultisiteurls','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','f22cde70-541b-449b-a51d-fcd1f4a22c8e'),(40,'plugin:redirect','m180104_143118_c_redirects_catch_all_urls','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','9ac47109-22b4-4062-9d37-c92cc2869434'),(41,'plugin:redirect','m190426_121317_change_url_size_to_1000','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','ac3e8bcb-7652-4587-9f4b-95c729f82c8b'),(42,'plugin:seomatic','Install','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','e46ac42b-d5a1-407f-8fcc-75472e0802dd'),(43,'plugin:seomatic','m180314_002755_field_type','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','43c20b30-abd6-4f1d-aa59-7ebcd75cc61c'),(44,'plugin:seomatic','m180314_002756_base_install','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','c0637551-3f8b-4d44-8601-4c5b79d94b52'),(45,'plugin:seomatic','m180502_202319_remove_field_metabundles','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','d3f72e3b-bb0d-4fbf-9366-6b62c8283a6f'),(46,'plugin:seomatic','m180711_024947_commerce_products','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','54a05c24-c8c2-4778-9437-29cad29df2a9'),(47,'plugin:seomatic','m190401_220828_longer_handles','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','4dece88d-4cd6-4ab6-a209-c67942a77b93'),(48,'plugin:seomatic','m190518_030221_calendar_events','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','9168a77f-3b30-4f62-8983-f9042820a0ec'),(49,'plugin:seomatic','m200419_203444_add_type_id','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','253b43f0-05c6-45eb-82db-95cda7c6b141'),(50,'plugin:seomatic','m210603_213100_add_gql_schema_components','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','35947ac4-efc7-4562-94da-2058f4eaf4ae'),(51,'plugin:seomatic','m210817_230853_announcement_v3_4','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','35b6c18a-702b-4659-8208-e14f2a8b718e'),(52,'plugin:sherlock','Install','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','6d8d17ff-fca6-4754-aa18-81052fa10135'),(53,'plugin:sherlock','m220330_120000_update_setting','2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-16 06:42:16','7f070d10-3543-4d0e-8f94-99d193d335d4'),(54,'plugin:sprig','Install','2022-11-16 06:42:16','2022-11-16 06:42:17','2022-11-16 06:42:17','cad061c9-ef36-4d83-a58d-b9952a84ebc3'),(55,'plugin:super-table','Install','2022-11-16 06:42:17','2022-11-16 06:42:17','2022-11-16 06:42:17','3171403b-421d-4251-83a1-9f1cfa8c8000'),(56,'plugin:super-table','m220308_000000_remove_superfluous_uids','2022-11-16 06:42:18','2022-11-16 06:42:18','2022-11-16 06:42:18','5ab66c8f-5cb9-4919-944e-2759332cf359'),(57,'plugin:super-table','m220308_100000_owners_table','2022-11-16 06:42:18','2022-11-16 06:42:18','2022-11-16 06:42:18','b5514889-a410-47ba-8c77-502e2d11885a'),(58,'plugin:typedlinkfield','Install','2022-11-16 06:42:18','2022-11-16 06:42:18','2022-11-16 06:42:18','2adfe13d-71d8-4317-b4d6-24afae65abe4'),(59,'plugin:typedlinkfield','m190417_202153_migrateDataToTable','2022-11-16 06:42:18','2022-11-16 06:42:18','2022-11-16 06:42:18','70f07e7a-a56c-462f-8df5-22a368972e0f'),(60,'craft','Install','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','e6f426d0-4386-48df-9e9a-06a91b1a12ab'),(61,'craft','m210121_145800_asset_indexing_changes','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','fc6077a9-b999-4780-a112-79907ac3d4d4'),(62,'craft','m210624_222934_drop_deprecated_tables','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','9cffbe49-1c69-4df0-9604-8a2056bf471a'),(63,'craft','m210724_180756_rename_source_cols','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','df2225aa-d7ce-4ca3-a8ea-5f0927228c62'),(64,'craft','m210809_124211_remove_superfluous_uids','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','cc5b635d-1d18-4c78-aad6-574332c97c30'),(65,'craft','m210817_014201_universal_users','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','d90f16d2-0d38-434d-b769-f3b8a8ea0685'),(66,'craft','m210904_132612_store_element_source_settings_in_project_config','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','34963720-a124-4f18-b8d6-30f7d9fa0e0d'),(67,'craft','m211115_135500_image_transformers','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','35054141-37b9-4731-998e-5c7c8bb468a5'),(68,'craft','m211201_131000_filesystems','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','54bc3e3a-b0b4-4b3b-8f8b-df899a716681'),(69,'craft','m220103_043103_tab_conditions','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','e77c8c99-2e92-458f-b4e4-6c4b70609246'),(70,'craft','m220104_003433_asset_alt_text','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','cd57ed3a-9f9e-4fcf-b4c4-4beb97458ced'),(71,'craft','m220123_213619_update_permissions','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','77b8a135-f614-4173-be0c-dbba43e92514'),(72,'craft','m220126_003432_addresses','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','4fb857a7-7913-449b-a1c3-9fdc6f03e18e'),(73,'craft','m220209_095604_add_indexes','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','d5717aa3-2075-449e-9ec0-66c1b09c216f'),(74,'craft','m220213_015220_matrixblocks_owners_table','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','68c31b43-580b-4877-9759-d6605e263736'),(75,'craft','m220214_000000_truncate_sessions','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','187cd140-1fbf-4ef6-af76-625c8fa4dad2'),(76,'craft','m220222_122159_full_names','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','1a198072-2094-4f45-a1ef-e5db5a0f43d5'),(77,'craft','m220223_180559_nullable_address_owner','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','0e1c263d-abb3-44a1-bcca-6f69ec17b800'),(78,'craft','m220225_165000_transform_filesystems','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','f489b02d-8e33-414b-9d05-bcbfc7dd415d'),(79,'craft','m220309_152006_rename_field_layout_elements','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','21fdc139-db29-4b42-8beb-5bd33967c504'),(80,'craft','m220314_211928_field_layout_element_uids','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','d42ba971-8670-4c3b-aa51-25b92a5d343f'),(81,'craft','m220316_123800_transform_fs_subpath','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','d2ad52b5-6235-421d-b9d3-3f4be8d1dc76'),(82,'craft','m220317_174250_release_all_jobs','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','ba9eb6c6-0ff2-42ab-a573-49d5446f3411'),(83,'craft','m220330_150000_add_site_gql_schema_components','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','96b1e786-36c7-4c90-a655-4f62c5a7f306'),(84,'craft','m220413_024536_site_enabled_string','2022-11-16 06:42:56','2022-11-16 06:42:56','2022-11-16 06:42:56','9138e58a-e9ee-4688-b344-47e436daf5cd');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `navigation_navs`
--

LOCK TABLES `navigation_navs` WRITE;
/*!40000 ALTER TABLE `navigation_navs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `navigation_navs` VALUES (1,3,'Legal','legal',NULL,2,'none',NULL,'[]','{\"craft\\\\elements\\\\Asset\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Category\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Entry\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Tag\":{\"enabled\":\"\",\"permissions\":\"*\"},\"verbb\\\\navigation\\\\nodetypes\\\\CustomType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\PassiveType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\SiteType\":{\"enabled\":\"1\"}}',6,'end','2022-11-16 06:42:25','2022-11-16 06:42:38','2022-11-16 09:54:37','d1f62e57-fa7c-44d0-8deb-ce19e5ff24f4'),(2,4,'Primary','primary',NULL,1,'none',NULL,'[]','{\"craft\\\\elements\\\\Asset\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Category\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Entry\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Tag\":{\"enabled\":\"\",\"permissions\":\"*\"},\"verbb\\\\navigation\\\\nodetypes\\\\CustomType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\PassiveType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\SiteType\":{\"enabled\":\"1\"}}',7,'end','2022-11-16 06:42:25','2022-11-16 06:42:38','2022-11-16 09:54:35','c631ebbf-3bef-4266-8a8b-5d9087223423'),(3,5,'Primary','primary','',3,'all',NULL,'[]','{\"craft\\\\elements\\\\Asset\":{\"enabled\":\"1\",\"permissions\":\"\"},\"craft\\\\elements\\\\Category\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Entry\":{\"enabled\":\"1\",\"permissions\":[\"section:942cbdfb-d50d-4dcd-9032-4f483562d1dd\",\"section:3721b4d6-42d5-41fc-b6e7-76204b42c91a\",\"section:8c9174b7-2c31-491e-a3f9-0374374c967c\",\"section:650e7d1d-63e5-42f9-b3ab-4febfb502723\"]},\"craft\\\\elements\\\\Tag\":{\"enabled\":\"\",\"permissions\":\"*\"},\"verbb\\\\navigation\\\\nodetypes\\\\CustomType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\PassiveType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\SiteType\":{\"enabled\":\"\"}}',41,'end','2022-11-16 09:55:23','2022-11-16 09:55:23',NULL,'32cc7e71-1196-4abe-a2b2-b9479600a266'),(4,6,'Legal','legal','',4,'none',NULL,'[]','{\"craft\\\\elements\\\\Asset\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Category\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Entry\":{\"enabled\":\"1\",\"permissions\":[\"section:942cbdfb-d50d-4dcd-9032-4f483562d1dd\",\"section:3721b4d6-42d5-41fc-b6e7-76204b42c91a\",\"section:8c9174b7-2c31-491e-a3f9-0374374c967c\",\"section:650e7d1d-63e5-42f9-b3ab-4febfb502723\"]},\"craft\\\\elements\\\\Tag\":{\"enabled\":\"\",\"permissions\":\"*\"},\"verbb\\\\navigation\\\\nodetypes\\\\CustomType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\PassiveType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\SiteType\":{\"enabled\":\"1\"}}',42,'end','2022-11-16 09:56:02','2022-11-16 09:56:02',NULL,'60a99a1b-8081-4b05-959f-fe916ff2b96e');
/*!40000 ALTER TABLE `navigation_navs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `navigation_navs_sites`
--

LOCK TABLES `navigation_navs_sites` WRITE;
/*!40000 ALTER TABLE `navigation_navs_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `navigation_navs_sites` VALUES (1,1,2,1,'2022-11-16 06:42:25','2022-11-16 06:42:25','85fdf4e1-d6ff-48fa-a91a-8dbd61bffd65'),(2,2,2,1,'2022-11-16 06:42:25','2022-11-16 06:42:25','ff9a5818-a87e-4f61-9f8b-f281d0b0536f'),(3,3,1,1,'2022-11-16 09:55:23','2022-11-16 09:55:23','f8c12dea-b558-4e57-93fe-624e3db20735'),(4,3,2,1,'2022-11-16 09:55:23','2022-11-16 09:55:23','91fbce93-4c3a-4bdb-8972-db59367bd272'),(5,4,1,1,'2022-11-16 09:56:02','2022-11-16 09:56:02','51dbc9ab-c1bf-438b-bb36-92c7cf05accd'),(6,4,2,1,'2022-11-16 09:56:02','2022-11-16 09:56:02','83e4ee5d-32cf-46b9-b41e-1a5a5b9c69ce');
/*!40000 ALTER TABLE `navigation_navs_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `navigation_nodes`
--

LOCK TABLES `navigation_nodes` WRITE;
/*!40000 ALTER TABLE `navigation_nodes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `navigation_nodes` VALUES (42,38,4,NULL,NULL,'craft\\elements\\Entry',NULL,NULL,'[]','[]',0,NULL,'2022-11-16 09:57:13','2022-11-16 09:57:13','ab53c030-8ce3-4964-a354-caae457febed'),(43,28,4,NULL,NULL,'craft\\elements\\Entry',NULL,NULL,'[]','[]',0,NULL,'2022-11-16 09:57:18','2022-11-16 09:57:18','a9b1837c-bf5d-4005-8c25-03ee0b874b18'),(44,17,3,NULL,NULL,'craft\\elements\\Entry',NULL,NULL,'[]','[]',0,NULL,'2022-11-16 09:57:31','2022-11-16 09:57:31','8752786c-e13a-4118-81fd-c3e5dd4338b2'),(45,19,3,NULL,NULL,'craft\\elements\\Entry',NULL,NULL,'[]','[]',0,NULL,'2022-11-16 09:57:34','2022-11-16 09:57:34','c12678af-a65c-4535-ae8f-dbcdf6f3ad6a'),(46,28,3,NULL,NULL,'craft\\elements\\Entry',NULL,NULL,'[]','[]',0,NULL,'2022-11-16 09:57:36','2022-11-16 09:57:36','fbffe7e3-89b9-4438-9919-ffff4a2cbbc7');
/*!40000 ALTER TABLE `navigation_nodes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'dospaces','2.0.0','2.0.0','unknown',NULL,'2022-11-16 06:42:06','2022-11-16 06:42:06','2022-11-17 07:29:40','465a31dd-14e0-4308-87c6-3eca2f276473'),(2,'empty-coalesce','4.0.0','1.0.0','unknown',NULL,'2022-11-16 06:42:06','2022-11-16 06:42:06','2022-11-17 07:29:40','3cc72321-9588-4860-9237-87b0fa77bad3'),(3,'entriessubset','2.1.0','1.1.1','trial',NULL,'2022-11-16 06:42:06','2022-11-16 06:42:06','2022-11-17 07:29:40','67d4bdda-0ca4-4517-a9be-4921c6de446c'),(4,'environment-label','4.0.2','1.0.0','unknown',NULL,'2022-11-16 06:42:06','2022-11-16 06:42:06','2022-11-17 07:29:40','22dfc502-a6c8-48f3-8dd4-cf7d5c3dd733'),(5,'fastcgi-cache-bust','4.0.0-beta.1','1.0.0','unknown',NULL,'2022-11-16 06:42:07','2022-11-16 06:42:07','2022-11-17 07:29:40','bc61d1b2-e3b4-4a54-97c4-0d7ec9060cef'),(6,'formie','2.0.17','2.0.8','trial',NULL,'2022-11-16 06:42:07','2022-11-16 06:42:07','2022-11-17 07:29:40','0c7db4df-1d27-464e-84f5-627f8bb76d1a'),(7,'knock-knock','2.0.5','1.1.1','unknown',NULL,'2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-17 07:29:40','293f6e03-4ae6-4c09-a307-536c37edc773'),(8,'matrix-field-preview','4.0.5','3.0.2','trial',NULL,'2022-11-16 06:42:13','2022-11-16 06:42:13','2022-11-17 07:29:40','ba20e7e1-c9b2-4f96-adf3-ac733e03b639'),(9,'matrixmate','2.1.2','1.0.0','unknown',NULL,'2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-17 07:29:40','85be23a4-dca3-41ff-9b0c-3083a1cf1e46'),(10,'minify','4.0.0-beta.2','1.0.0','unknown',NULL,'2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-17 07:29:40','c5e828d5-2bb9-40dc-a9b0-9fdbd53fb01b'),(11,'navigation','2.0.11','2.0.6','trial',NULL,'2022-11-16 06:42:14','2022-11-16 06:42:14','2022-11-17 07:29:40','82b5dc26-afe8-47d8-a7f9-ec41211f52b7'),(12,'redactor','3.0.2','2.3.0','unknown',NULL,'2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-17 07:29:40','871d4bca-49a9-49b8-a0f6-c6f3f8dbfa4b'),(13,'redirect','2.0.0','1.0.5','unknown',NULL,'2022-11-16 06:42:15','2022-11-16 06:42:15','2022-11-17 07:29:40','613fa890-4e20-4d2a-879d-10ab985fe29c'),(14,'referencefield','v0.2','1.0.0','unknown',NULL,'2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-17 07:29:40','b36550b1-2e4c-47fb-8461-7e61b1a38fe9'),(15,'retcon','2.6.0','1.0.0','unknown',NULL,'2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-17 07:29:40','8a041c08-6317-473c-8e31-66851626f50a'),(16,'seomatic','4.0.13','3.0.11','trial',NULL,'2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-17 07:29:40','0cdb79ec-4883-48b1-9c23-b3b875f1b7f6'),(17,'sherlock','4.2.0','4.1.0','unknown',NULL,'2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-17 07:29:40','1f3e1cde-61a6-4139-b049-0d5f0e4bd8dd'),(18,'sprig','2.3.0','1.0.1','unknown',NULL,'2022-11-16 06:42:16','2022-11-16 06:42:16','2022-11-17 07:29:40','4f4cf8f0-a625-4c15-aa09-9cf0b67ebee7'),(19,'super-table','3.0.5','3.0.0','unknown',NULL,'2022-11-16 06:42:17','2022-11-16 06:42:17','2022-11-17 07:29:40','973c83a2-8f49-4665-9934-1f2833c465c7'),(20,'twigpack','4.0.0-beta.4','1.0.0','unknown',NULL,'2022-11-16 06:42:18','2022-11-16 06:42:18','2022-11-17 07:29:40','f7c960fd-e52a-4e2d-b0d4-0176963157b7'),(21,'typedlinkfield','2.1.4','2.0.0','unknown',NULL,'2022-11-16 06:42:18','2022-11-16 06:42:18','2022-11-17 07:29:40','4710393e-b444-45b7-a188-02c80e2c30d9'),(22,'typogrify','4.0.0','1.0.0','unknown',NULL,'2022-11-16 06:42:18','2022-11-16 06:42:18','2022-11-17 07:29:40','4db0155d-ba0a-452b-bb64-d88f497ce65e');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `relations` VALUES (3,103,90,NULL,88,1,'2022-11-16 11:28:51','2022-11-16 11:28:51','3781e271-cc15-4baf-86a7-2d8d57bd25ff'),(4,105,29,NULL,35,1,'2022-11-16 11:28:51','2022-11-16 11:28:51','fff5545f-af61-4848-8a96-8a6fd64d5f27'),(5,103,92,NULL,88,1,'2022-11-16 11:28:51','2022-11-16 11:28:51','16e91e0e-e2f7-4881-82ec-638e02512228'),(6,105,93,NULL,35,1,'2022-11-16 11:28:51','2022-11-16 11:28:51','7e453de8-847e-4af4-abf1-d4404350b95b'),(8,103,97,NULL,88,1,'2022-11-16 11:29:07','2022-11-16 11:29:07','ee49b8fa-f4ce-49c7-98bc-295c2e58dbdd'),(9,105,98,NULL,35,1,'2022-11-16 11:29:07','2022-11-16 11:29:07','ba41032e-06df-468e-b6b9-e82f8248acb1'),(10,103,104,NULL,88,1,'2022-11-16 11:35:02','2022-11-16 11:35:02','7e1e8c17-75ab-43a8-b14b-e7262ade4c3b'),(11,105,106,NULL,35,1,'2022-11-16 11:35:02','2022-11-16 11:35:02','5b677fbc-98e5-40d8-a228-0cc53cd0db59'),(13,103,110,NULL,88,1,'2022-11-16 11:37:29','2022-11-16 11:37:29','ad933938-07a0-41f8-8d08-913f7403d6d5'),(14,105,112,NULL,35,1,'2022-11-16 11:37:29','2022-11-16 11:37:29','51dc0b2e-d425-4298-8831-4bc7e96c4343'),(15,103,116,NULL,88,1,'2022-11-16 11:37:49','2022-11-16 11:37:49','7c7e57d0-e8d7-4e34-91bd-bd9b4a2889b0'),(16,105,118,NULL,35,1,'2022-11-16 11:37:49','2022-11-16 11:37:49','f58e1fd2-ba54-4ff3-a899-0dc7e3f01edd'),(17,103,122,NULL,88,1,'2022-11-16 11:39:06','2022-11-16 11:39:06','00c07ffb-76fe-4742-9652-593f9840bf98'),(18,105,124,NULL,35,1,'2022-11-16 11:39:06','2022-11-16 11:39:06','98d4ef01-bcf1-47fd-9532-aa1075fafbaf'),(19,103,127,NULL,88,1,'2022-11-16 19:08:17','2022-11-16 19:08:17','54f45a68-c101-4a2b-a078-64f4a347a474'),(20,105,129,NULL,35,1,'2022-11-16 19:08:17','2022-11-16 19:08:17','c427bd2a-4dfa-479b-99c8-350434c12087'),(22,103,138,NULL,88,1,'2022-11-16 20:37:49','2022-11-16 20:37:49','d065b61a-08bc-464d-b57a-38bc1822a41b'),(23,105,140,NULL,35,1,'2022-11-16 20:37:49','2022-11-16 20:37:49','32b5cefc-7df4-4abf-9b56-2f33fe9d2721'),(24,103,142,NULL,88,1,'2022-11-16 20:38:11','2022-11-16 20:38:11','10772d76-ce02-4646-9de5-5f193c986476'),(25,105,144,NULL,35,1,'2022-11-16 20:38:11','2022-11-16 20:38:11','dfe8e70c-ab9c-4911-810b-a245c56c560d'),(26,103,158,NULL,88,1,'2022-11-16 21:11:31','2022-11-16 21:11:31','53f3fd99-9b0c-42ec-879d-04ae1caecfc3'),(27,105,160,NULL,35,1,'2022-11-16 21:11:31','2022-11-16 21:11:31','32718754-2ece-48f1-8a22-a38a872ef19d'),(28,103,186,NULL,88,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','2e0713a5-28db-4b5a-9a97-74fb3452ab8b'),(29,105,189,NULL,35,1,'2022-11-16 22:52:33','2022-11-16 22:52:33','f02fad18-d558-4594-84cb-21e1b2730e04'),(30,103,218,NULL,88,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','59152cd9-64e9-493d-8393-7be518b268ac'),(31,105,222,NULL,35,1,'2022-11-17 05:23:42','2022-11-17 05:23:42','1319a1d0-690e-471a-a730-a98c3c040052'),(32,103,244,NULL,88,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','d695b7a5-03eb-4b46-9fe0-d47d5bdeff78'),(33,105,249,NULL,35,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','ab51d7c0-aeb9-4744-ada4-48cde37e7c60'),(34,103,253,NULL,88,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','b75e7ced-814a-4b77-b76c-10c41dd5aa66'),(35,105,256,NULL,35,1,'2022-11-17 06:10:16','2022-11-17 06:10:16','624e1a09-53e4-4edb-b7c0-50df79e50378'),(36,103,270,NULL,88,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','e8e8abc5-4ce8-48db-9b88-b273eb39ec4e'),(37,105,273,NULL,35,1,'2022-11-17 10:02:11','2022-11-17 10:02:11','538cf34c-a6ca-4fab-843f-546bb37a011f'),(39,103,277,NULL,88,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','997d5607-d448-4093-9e68-7479725c889d'),(40,105,280,NULL,35,1,'2022-11-17 10:21:55','2022-11-17 10:21:55','de45ba17-bb20-4e6f-93c3-db15b4e8d3b3'),(42,103,284,NULL,88,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','6b5d0601-e8b0-4c62-8849-0ab54b335b85'),(43,105,287,NULL,35,1,'2022-11-17 10:36:54','2022-11-17 10:36:54','59eac249-d9a5-4aaf-a68a-d59c981faedd'),(44,103,291,NULL,88,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','563f8212-8b7c-458e-a3a0-d29eb173ec73'),(45,105,294,NULL,35,1,'2022-11-17 10:37:11','2022-11-17 10:37:11','f385dfd4-77ec-4185-8890-c46666db34a1'),(47,103,298,NULL,88,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','c6d50c1d-682f-4548-b4de-71d8f973077a'),(48,105,301,NULL,35,1,'2022-11-17 10:44:59','2022-11-17 10:44:59','f861c91c-17f5-43e3-994f-349cf2f4c0be'),(49,103,305,NULL,88,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','0795b641-0ade-4696-8359-470007d6113a'),(50,105,308,NULL,35,1,'2022-11-17 10:49:11','2022-11-17 10:49:11','b1d2ea98-12b1-4247-9546-07504f29f5d5');
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `revisions` VALUES (1,1,NULL,1,NULL),(2,1,NULL,2,NULL),(3,4,NULL,1,NULL),(4,4,NULL,2,NULL),(5,7,NULL,1,NULL),(6,7,NULL,2,NULL),(7,1,NULL,3,NULL),(8,1,NULL,4,NULL),(9,4,NULL,3,NULL),(10,4,NULL,4,NULL),(11,7,NULL,3,NULL),(12,7,NULL,4,NULL),(13,17,16,1,''),(14,19,16,1,''),(15,23,16,1,NULL),(16,26,16,1,''),(18,29,16,1,NULL),(20,29,16,2,NULL),(21,26,16,2,'Applied “Draft 1”'),(22,38,16,1,''),(23,38,16,2,'Applied “Draft 1”'),(24,47,16,1,''),(25,47,16,2,'Applied “Draft 1”'),(26,47,16,3,'Applied “Draft 1”'),(28,60,16,1,NULL),(29,29,16,3,NULL),(31,60,16,2,NULL),(32,29,16,4,NULL),(33,19,16,2,'Applied “Draft 1”'),(34,23,16,2,NULL),(35,17,16,2,'Applied “Draft 1”'),(36,79,16,1,NULL),(38,29,16,5,NULL),(39,88,16,1,''),(41,90,16,1,NULL),(42,29,16,6,NULL),(44,90,16,2,NULL),(45,29,16,7,NULL),(47,90,16,3,NULL),(48,102,16,1,NULL),(49,29,16,8,NULL),(51,90,16,4,NULL),(52,102,16,2,NULL),(53,29,16,9,NULL),(55,90,16,5,NULL),(56,102,16,3,NULL),(57,29,16,10,NULL),(59,90,16,6,NULL),(60,102,16,4,NULL),(61,29,16,11,NULL),(63,90,16,7,NULL),(64,102,16,5,NULL),(65,29,16,12,NULL),(66,130,16,1,''),(67,130,16,2,''),(68,133,16,1,''),(70,90,16,8,NULL),(71,102,16,6,NULL),(72,29,16,13,NULL),(74,90,16,9,NULL),(75,102,16,7,NULL),(76,29,16,14,NULL),(77,19,16,3,''),(78,23,16,3,NULL),(79,38,16,3,'Applied “Draft 1”'),(80,38,16,4,'Applied “Draft 1”'),(81,153,16,1,NULL),(83,90,16,10,NULL),(84,102,16,8,NULL),(85,29,16,15,NULL),(86,19,16,4,'Applied “Draft 1”'),(87,165,16,1,NULL),(88,23,16,4,NULL),(89,19,16,5,''),(90,165,16,2,NULL),(91,23,16,5,NULL),(92,26,16,3,'Applied “Draft 1”'),(93,26,16,4,'Applied “Draft 1”'),(94,28,16,16,'Applied “Draft 1”'),(95,90,16,11,NULL),(96,102,16,9,NULL),(97,184,16,1,NULL),(98,29,16,16,NULL),(99,17,16,3,'Applied “Draft 1”'),(100,79,16,2,NULL),(101,28,16,17,'Applied “Draft 1”'),(102,90,16,12,NULL),(103,216,16,1,NULL),(104,102,16,10,NULL),(105,184,16,2,NULL),(106,29,16,17,NULL),(107,17,16,4,'Applied “Draft 1”'),(108,79,16,3,NULL),(109,233,16,1,NULL),(110,19,16,6,'Applied “Draft 1”'),(111,165,16,3,NULL),(112,23,16,6,NULL),(113,28,16,18,'Applied “Draft 1”'),(114,90,16,13,NULL),(115,216,16,2,NULL),(116,242,16,1,NULL),(117,102,16,11,NULL),(118,184,16,3,NULL),(119,29,16,18,NULL),(120,28,16,19,'Applied “Draft 1”'),(121,90,16,14,NULL),(122,102,16,12,NULL),(123,184,16,4,NULL),(124,29,16,19,NULL),(125,133,16,2,'Applied “Draft 1”'),(126,260,16,1,NULL),(127,133,16,3,'Applied “Draft 1”'),(128,260,16,2,NULL),(129,28,16,20,'Applied “Draft 1”'),(130,90,16,15,NULL),(131,102,16,13,NULL),(132,184,16,5,NULL),(133,29,16,20,NULL),(134,28,16,21,'Applied “Draft 1”'),(135,90,16,16,NULL),(136,102,16,14,NULL),(137,184,16,6,NULL),(138,29,16,21,NULL),(139,28,16,22,'Applied “Draft 1”'),(140,90,16,17,NULL),(141,102,16,15,NULL),(142,184,16,7,NULL),(143,29,16,22,NULL),(144,28,16,23,''),(145,90,16,18,NULL),(146,102,16,16,NULL),(147,184,16,8,NULL),(148,29,16,23,NULL),(149,28,16,24,'Applied “Draft 1”'),(150,90,16,19,NULL),(151,102,16,17,NULL),(152,184,16,9,NULL),(153,29,16,24,NULL),(154,28,16,25,'Applied “Draft 1”'),(155,90,16,20,NULL),(156,102,16,18,NULL),(157,184,16,10,NULL),(158,29,16,25,NULL);
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'field',7,1,''),(1,'slug',0,1,' alert message '),(1,'title',0,1,' alert message '),(4,'field',16,1,''),(4,'field',18,1,''),(4,'slug',0,1,' error 404 '),(4,'title',0,1,' error 404 '),(7,'field',16,1,''),(7,'field',18,1,''),(7,'slug',0,1,' search '),(7,'title',0,1,' search '),(16,'email',0,1,' steve simplicate ca '),(16,'firstname',0,1,''),(16,'fullname',0,1,''),(16,'lastname',0,1,''),(16,'slug',0,1,''),(16,'username',0,1,' steve simplicate ca '),(17,'field',2,1,''),(17,'field',5,1,''),(17,'field',7,1,''),(17,'field',9,1,''),(17,'field',18,1,' lorem ipsum dolor sit amet elit posthac quidem inquit audacius refert tamen quo modo duo reges constructio interrete quid autem habent admirationis cum prope accesseris primary alternate wireframe '),(17,'slug',0,1,' home '),(17,'title',0,1,' home '),(19,'field',2,1,''),(19,'field',5,1,''),(19,'field',7,1,''),(19,'field',9,1,''),(19,'field',18,1,' recent news '),(19,'slug',0,1,' news '),(19,'title',0,1,' news '),(23,'field',58,1,''),(23,'field',59,1,''),(23,'slug',0,1,''),(26,'field',2,1,''),(26,'field',16,1,' signup for our newsletter '),(26,'slug',0,1,' newsletter subscribe '),(26,'title',0,1,' signup for our newsletter '),(28,'field',2,1,' wed love to hear from you '),(28,'field',5,1,''),(28,'field',7,1,''),(28,'field',9,1,''),(28,'field',18,1,''),(28,'field',21,1,''),(28,'slug',0,1,' contact '),(28,'title',0,1,' contact '),(29,'slug',0,1,''),(34,'handle',0,1,' newslettersubscription '),(34,'slug',0,1,''),(34,'title',0,1,' newsletter subscription '),(35,'handle',0,1,' contactform '),(35,'slug',0,1,''),(35,'title',0,1,' contact form '),(38,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed ad bona praeterita redeamus nonne igitur tibi videntur inquit mala duo reges constructio interrete videamus animi partes quarum est conspectus illustrior duo enim genera quae erant fecit tria at ego quem huic anteponam non audeo dicere hoc mihi cum tuo fratre convenit quoniam si dis placet ab epicuro loqui discimus quis istud possit inquit negare igitur ne dolorem quidem immo alio genere quod ea non occurrentia fingunt vincunt aristonem compensabatur inquit cum summis doloribus laetitia hanc ergo intuens debet institutum illud quasi signum absolvere prioris generis est docilitas memoria praeclare hoc quidem '),(38,'field',5,1,''),(38,'field',7,1,''),(38,'field',9,1,''),(38,'field',18,1,''),(38,'field',21,1,''),(38,'slug',0,1,' privacy '),(38,'title',0,1,' privacy policy '),(42,'slug',0,1,' 1 '),(42,'title',0,1,' privacy policy '),(43,'slug',0,1,' 1 '),(43,'title',0,1,' contact '),(44,'slug',0,1,' 1 '),(44,'slug',0,2,' 1 '),(44,'title',0,1,' home '),(44,'title',0,2,' home '),(45,'slug',0,1,' 1 '),(45,'slug',0,2,' 1 '),(45,'title',0,1,' news '),(45,'title',0,2,' news '),(46,'slug',0,1,' 1 '),(46,'slug',0,2,' 1 '),(46,'title',0,1,' contact '),(46,'title',0,2,' contact us '),(47,'field',2,1,''),(47,'field',5,1,''),(47,'field',7,1,' lorem ipsum dolor sit amet consectetur adipiscing elit cum sciret confestim esse moriendum eamque mortem ardentiore studio peteret quam epicurus voluptatem petendam putat '),(47,'field',9,1,''),(47,'field',18,1,''),(47,'slug',0,1,' a news story '),(47,'title',0,1,' news story with a medium title '),(60,'field',113,1,' welcome '),(60,'field',114,1,''),(60,'slug',0,1,''),(79,'field',113,1,' wireframe '),(79,'field',114,1,' lorem ipsum dolor sit amet elit posthac quidem inquit audacius refert tamen quo modo duo reges constructio interrete quid autem habent admirationis cum prope accesseris primary alternate '),(79,'slug',0,1,''),(88,'slug',0,1,' common chunk '),(88,'title',0,1,' common chunk '),(90,'field',102,1,' wed love to hear from you '),(90,'slug',0,1,''),(102,'slug',0,1,''),(130,'field',7,1,' this is an example of too much content in a dek lorem ipsum dolor sit amet consectetur adipiscing elit hinc ceteri particulas arripere conati suam quisque videro voluit afferre sententiam itaque haec cum illis est dissensio cum peripateticis nulla sane apud ceteros autem philosophos qui quaesivit aliquid tacet me ipsum esse dicerem inquam nisi mihi viderer habere bene cognitam voluptatem et satis firme conceptam animo atque comprehensam satisne vobis videor pro meo iure in vestris auribus commentatus hoc loco discipulos quaerere videtur ut qui asoti esse velint philosophi ante fiant atqui haec patefactio quasi rerum opertarum cum quid quidque sit aperitur definitio est duo reges constructio interrete '),(130,'slug',0,1,' news story '),(130,'title',0,1,' news story '),(133,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit quid si etiam iucunda memoria est praeteritorum malorum vide quantum inquam fallare torquate moriatur inquit quae autem natura suae primae institutionis oblita est sed tempus est si videtur et recta quidem ad me sic enim censent oportunitatis esse beate vivere quantum aristoxeni ingenium consumptum videmus in musicis duo reges constructio interrete laboro autem non sine causa quae cum essent dicta discessimus mihi inquam qui te id ipsum rogavi immo videri fortasse de ingenio eius in his disputationibus non de moribus quaeritur quid enim possumus hoc agere divinius iam contemni non poteris atqui reperies inquit in hoc quidem pertinacem ratio enim nostra consentit pugnat oratio scaevola tribunus plebis ferret ad plebem vellentne de ea re quaeri cuius similitudine perspecta in formarum specie ac dignitate transitum est ad honestatem dictorum atque factorum bonum integritas corporis misera debilitas honesta oratio socratica platonis etiam sic et quidem diligentius saepiusque ista loquemur inter nos agemusque communiter qui ita affectus beatum esse numquam probabis etsi ea quidem quae adhuc dixisti quamvis ad aetatem recte isto modo dicerentur atque haec ita iustitiae propria sunt ut sint virtutum reliquarum communia efficiens dici potest '),(133,'field',5,1,''),(133,'field',7,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed ad bona praeterita redeamus nonne igitur tibi videntur inquit mala duo reges constructio interrete videamus animi partes quarum est conspectus illustrior '),(133,'field',9,1,''),(133,'field',18,1,''),(133,'slug',0,1,' news story with a much longer title than you might normally expect '),(133,'title',0,1,' news story with a much longer title than you might normally expect '),(153,'field',85,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed ad bona praeterita redeamus nonne igitur tibi videntur inquit mala duo reges constructio interrete videamus animi partes quarum est conspectus illustrior duo enim genera quae erant fecit tria at ego quem huic anteponam non audeo dicere hoc mihi cum tuo fratre convenit quoniam si dis placet ab epicuro loqui discimus quis istud possit inquit negare igitur ne dolorem quidem immo alio genere quod ea non occurrentia fingunt vincunt aristonem compensabatur inquit cum summis doloribus laetitia hanc ergo intuens debet institutum illud quasi signum absolvere prioris generis est docilitas memoria praeclare hoc quidem '),(153,'slug',0,1,''),(165,'field',88,1,''),(165,'field',91,1,' recent news '),(165,'slug',0,1,''),(184,'slug',0,1,''),(216,'field',23,1,''),(216,'field',27,1,''),(216,'slug',0,1,''),(233,'field',58,1,''),(233,'field',59,1,''),(233,'slug',0,1,''),(242,'field',71,1,''),(242,'field',72,1,''),(242,'field',73,1,''),(242,'slug',0,1,''),(258,'field',85,1,''),(258,'slug',0,1,''),(260,'field',85,1,' lorem ipsum dolor sit amet consectetur adipiscing elit quid si etiam iucunda memoria est praeteritorum malorum vide quantum inquam fallare torquate moriatur inquit quae autem natura suae primae institutionis oblita est sed tempus est si videtur et recta quidem ad me sic enim censent oportunitatis esse beate vivere quantum aristoxeni ingenium consumptum videmus in musicis duo reges constructio interrete laboro autem non sine causa quae cum essent dicta discessimus mihi inquam qui te id ipsum rogavi immo videri fortasse de ingenio eius in his disputationibus non de moribus quaeritur quid enim possumus hoc agere divinius iam contemni non poteris atqui reperies inquit in hoc quidem pertinacem ratio enim nostra consentit pugnat oratio scaevola tribunus plebis ferret ad plebem vellentne de ea re quaeri cuius similitudine perspecta in formarum specie ac dignitate transitum est ad honestatem dictorum atque factorum bonum integritas corporis misera debilitas honesta oratio socratica platonis etiam sic et quidem diligentius saepiusque ista loquemur inter nos agemusque communiter qui ita affectus beatum esse numquam probabis etsi ea quidem quae adhuc dixisti quamvis ad aetatem recte isto modo dicerentur atque haec ita iustitiae propria sunt ut sint virtutum reliquarum communia efficiens dici potest '),(260,'slug',0,1,'');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'News','news','channel',1,'custom','end','[{\"label\":\"Primary Content\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'3721b4d6-42d5-41fc-b6e7-76204b42c91a'),(2,NULL,'Alert Message','alertMessage','single',1,'all','end',NULL,'2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c'),(3,NULL,'Landing Pages','landingPages','channel',1,'custom','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'8c9174b7-2c31-491e-a3f9-0374374c967c'),(4,NULL,'Error 404','error404','single',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'16422b2c-c780-4355-b3a5-44a1cc28ba36'),(5,NULL,'Feedback','feedback','channel',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'c2b6d2e5-34ab-410c-8b3b-f752217b7552'),(6,NULL,'Search','search','single',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'4faab281-22d5-4b78-a310-d3f84c34aa67'),(7,NULL,'FAQs','faqs','channel',1,'custom','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'a52e2b08-2e30-4b00-8784-4104c409d3ed'),(8,NULL,'Fragments','fragments','channel',1,'custom','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'89093e20-515d-4e3c-b4c4-c6733d8ab56f'),(9,1,'Primary Pages','pages','structure',1,'custom','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'650e7d1d-63e5-42f9-b3ab-4febfb502723'),(10,NULL,'Topics','topics','channel',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'942cbdfb-d50d-4dcd-9032-4f483562d1dd'),(11,2,'Sitebook','sitebook','structure',1,'custom','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'fdb77561-cbd1-4a4e-a2a5-eb559a5361cb');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'news/{slug}','_sections/news/_entry.twig',1,'2022-11-16 06:42:25','2022-11-16 06:42:25','fd3197d3-3531-47af-9566-128fcb23aaef'),(2,2,1,0,NULL,NULL,1,'2022-11-16 06:42:25','2022-11-16 06:42:25','975be11d-de8e-48c5-8278-a3457680580c'),(3,3,1,1,'lp/{slug}','_sections/landing-pages/_entry',1,'2022-11-16 06:42:25','2022-11-16 06:42:25','12c2328c-793c-420c-847c-d526b65c8451'),(4,4,1,0,NULL,NULL,1,'2022-11-16 06:42:25','2022-11-16 06:42:25','4bc34fae-adfd-4c2a-9e85-dd0219263db3'),(5,5,1,0,NULL,NULL,1,'2022-11-16 06:42:25','2022-11-16 06:42:25','3c603626-0afc-44ff-acae-8fa67cf00d49'),(6,6,1,1,'search','_sections/search.twig',1,'2022-11-16 06:42:25','2022-11-16 06:42:25','8f8e2760-07c8-4ff1-8fd4-c210cf56b3b7'),(7,7,1,1,'faqs/{slug}','_sections/faqs/_entry.twig',1,'2022-11-16 06:42:25','2022-11-16 06:42:25','9d8509a3-6362-4a7c-b343-6b1e553e185e'),(8,8,1,1,'fragments/{slug}','_sections/fragments/_entry.twig',1,'2022-11-16 06:42:25','2022-11-16 06:42:25','b2d1457c-5564-4959-8720-a3dcd27ffb62'),(9,9,1,1,'{parent.uri}/{slug}','_page',1,'2022-11-16 06:42:25','2022-11-16 06:42:25','1a4ff4b1-8563-4f02-ae5b-5ef6703e772f'),(10,10,1,1,'topics/{slug}','_sections/topics/_entry',1,'2022-11-16 06:42:25','2022-11-16 06:42:25','9b36b8b2-7b23-4d35-9e7d-a771d1ee2616'),(11,11,1,1,'{{parent.uri ?? \'sitebook\'}}/{{slug}}','_page',1,'2022-11-16 06:42:25','2022-11-16 06:42:25','9b9db3bd-8508-4c9f-8103-6617efb72611');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `seomatic_metabundles`
--

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `seomatic_metabundles` VALUES (1,'2022-11-16 06:42:16','2022-11-16 06:42:16','713ac929-cb14-4f42-9af2-09874c6a0aa7','1.0.61','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',2,'[]','2022-11-16 06:42:16','{\"inherited\":[],\"overrides\":[],\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ seomatic.helper.safeCanonicalUrl() }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{{ seomatic.meta.seoTitle }}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{{ seomatic.meta.seoDescription }}\",\"ogImage\":\"{{ seomatic.meta.seoImage }}\",\"ogImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"ogImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"ogImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{{ seomatic.site.twitterHandle }}\",\"twitterTitle\":\"{{ seomatic.meta.seoTitle }}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{{ seomatic.meta.seoDescription }}\",\"twitterImage\":\"{{ seomatic.meta.seoImage }}\",\"twitterImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"twitterImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"twitterImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\"}','{\"siteName\":\"Main Site\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"inherited\":[],\"overrides\":[],\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"generator\":{\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null},\"keywords\":{\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.seoKeywords }}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null},\"description\":{\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.seoDescription }}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null},\"referrer\":{\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.referrer }}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null},\"robots\":{\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{{ seomatic.meta.robots }}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.robots }}\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null}}},\"MetaTagContaineropengraph\":{\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"fb:profile_id\":{\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookProfileId }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\"},\"fb:app_id\":{\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookAppId }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\"},\"og:locale\":{\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\"},\"og:locale:alternate\":{\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\"},\"og:site_name\":{\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.siteName }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\"},\"og:type\":{\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogType }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\"},\"og:url\":{\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.canonicalUrl }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\"},\"og:title\":{\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogTitle }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.ogSiteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"},\"og:description\":{\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogDescription }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\"},\"og:image\":{\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImage }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\"},\"og:image:width\":{\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageWidth }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\"},\"og:image:height\":{\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageHeight }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\"},\"og:image:alt\":{\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageDescription }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\"},\"og:see_also\":{\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\"},\"facebook-site-verification\":{\"include\":true,\"key\":\"facebook-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"facebookSiteVerification\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"facebook-domain-verification\",\"property\":null}}},\"MetaTagContainertwitter\":{\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false,\"data\":{\"twitter:card\":{\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterCard }}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null},\"twitter:site\":{\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"@{{ seomatic.site.twitterHandle }}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null},\"twitter:creator\":{\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"@{{ seomatic.meta.twitterCreator }}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null},\"twitter:title\":{\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterTitle }}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.twitterSiteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"},\"twitter:description\":{\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterDescription }}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null},\"twitter:image\":{\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImage }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null},\"twitter:image:width\":{\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageWidth }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null},\"twitter:image:height\":{\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageHeight }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null},\"twitter:image:alt\":{\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageDescription }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null}}},\"MetaTagContainermiscellaneous\":{\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"google-site-verification\":{\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.googleSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null},\"bing-site-verification\":{\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.bingSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null},\"pinterest-site-verification\":{\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.pinterestSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null}}},\"MetaLinkContainergeneral\":{\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"canonical\":{\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"crossorigin\":\"\",\"href\":\"{{ seomatic.meta.canonicalUrl }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\"},\"home\":{\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\"},\"author\":{\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]},\"tagAttrs\":[],\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\"},\"publisher\":{\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]},\"tagAttrs\":[],\"crossorigin\":\"\",\"href\":\"{{ seomatic.site.googlePublisherLink }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\"}}},\"MetaScriptContainergeneral\":{\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"gtag\":{\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Measurement/Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `G-XXXXXXXXXX` or `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[]},\"googleTagManager\":{\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[]},\"facebookPixel\":{\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[]},\"linkedInInsight\":{\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[]},\"hubSpot\":{\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[]},\"pinterestTag\":{\"include\":false,\"key\":\"pinterestTag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Pinterest Tag\",\"description\":\"The Pinterest tag allows you to track actions people take on your website after viewing your Promoted Pin. You can use this information to measure return on ad spend (RoAS) and create audiences to target on your Promoted Pins. [Learn More](https://help.pinterest.com/en/business/article/track-conversions-with-pinterest-tag)\",\"templatePath\":\"_frontend/scripts/pinterestTagHead.twig\",\"templateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n!function(e){if(!window.pintrk){window.pintrk=function(){window.pintrk.queue.push(\\nArray.prototype.slice.call(arguments))};var\\nn=window.pintrk;n.queue=[],n.version=\\\"3.0\\\";var\\nt=document.createElement(\\\"script\\\");t.async=!0,t.src=e;var\\nr=document.getElementsByTagName(\\\"script\\\")[0];r.parentNode.insertBefore(t,r)}}(\\\"{{ pinterestTagUrl.value }}\\\");\\npintrk(\'load\', \'{{ pinterestTagId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\npintrk(\'page\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/pinterestTagBody.twig\",\"bodyTemplateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ pinterestTagNoScriptUrl.value }}?tid={{ pinterestTagId.value }}&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"pinterestTagId\":{\"title\":\"Pinterest Tag ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.pinterest.com/docs/ad-tools/conversion-tag/)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Pinterest Tag PageView\",\"instructions\":\"Controls whether the Pinterest Tag script automatically sends a PageView to when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"pinterestTagUrl\":{\"title\":\"Pinterest Tag Script URL\",\"instructions\":\"The URL to the Pinterest Tag script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://s.pinimg.com/ct/core.js\"},\"pinterestTagNoScriptUrl\":{\"title\":\"Pinterest Tag Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Pinterest Tag `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://ct.pinterest.com/v3/\"}},\"dataLayer\":[]},\"fathom\":{\"include\":false,\"key\":\"fathom\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Fathom\",\"description\":\"Fathom is a simple, light-weight, privacy-first alternative to Google Analytics. So, stop scrolling through pages of reports and collecting gobs of personal data about your visitors, both of which you probably don’t need. [Learn More](https://usefathom.com/)\",\"templatePath\":\"_frontend/scripts/fathomAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-site\\\", \\\"{{ siteId.value | raw }}\\\");\\n{% if honorDnt.value %}\\ntag.setAttribute(\\\"data-honor-dnt\\\", \\\"true\\\");\\n{% endif %}\\n{% if disableAutoTracking.value %}\\ntag.setAttribute(\\\"data-auto\\\", \\\"false\\\");\\n{% endif %}\\n{% if ignoreCanonicals.value %}\\ntag.setAttribute(\\\"data-canonical\\\", \\\"false\\\");\\n{% endif %}\\n{% if excludedDomains.value | length %}\\ntag.setAttribute(\\\"data-excluded-domains\\\", \\\"{{ excludedDomains.value | raw }}\\\");\\n{% endif %}\\n{% if includedDomains.value | length %}\\ntag.setAttribute(\\\"data-included-domains\\\", \\\"{{ includedDomains.value | raw }}\\\");\\n{% endif %}\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://usefathom.com/support/tracking)\",\"type\":\"string\",\"value\":\"\"},\"honorDnt\":{\"title\":\"Honoring Do Not Track (DNT)\",\"instructions\":\"By default we track every visitor to your website, regardless of them having DNT turned on or not. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"disableAutoTracking\":{\"title\":\"Disable automatic tracking\",\"instructions\":\"By default, we track a page view every time a visitor to your website loads a page with our script on it. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"ignoreCanonicals\":{\"title\":\"Ignore canonicals\",\"instructions\":\"If there’s a canonical URL in place, then by default we use it instead of the current URL. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"excludedDomains\":{\"title\":\"Excluded Domains\",\"instructions\":\"You exclude one or several domains, so our tracker will track things on every domain, except the ones excluded. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"includedDomains\":{\"title\":\"Included Domains\",\"instructions\":\"If you want to go in the opposite direction and only track stats on a specific domain. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Fathom Script URL\",\"instructions\":\"The URL to the Fathom tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://cdn.usefathom.com/script.js\"}},\"dataLayer\":[]},\"matomo\":{\"include\":false,\"key\":\"matomo\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Matomo\",\"description\":\"Matomo is a Google Analytics alternative that protects your data and your customers\' privacy [Learn More](https://matomo.org/)\",\"templatePath\":\"_frontend/scripts/matomoAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value and scriptUrl.value is defined and scriptUrl.value | length %}\\nvar _paq = window._paq = window._paq || [];\\n{% if sendPageView.value %}\\n_paq.push([\'trackPageView\']);\\n{% endif %}\\n{% if sendPageView.value %}\\n_paq.push([\'enableLinkTracking\']);\\n{% endif %}\\n(function() {\\nvar u=\\\"{{ scriptUrl.value }}\\\";\\n_paq.push([\'setTrackerUrl\', u+\'matomo.php\']);\\n_paq.push([\'setSiteId\', {{ siteId.value }}]);\\nvar d=document, g=d.createElement(\'script\'), s=d.getElementsByTagName(\'script\')[0];\\ng.type=\'text/javascript\'; g.async=true; g.src=u+\'matomo.js\'; s.parentNode.insertBefore(g,s);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Matomo PageView\",\"instructions\":\"Controls whether the Matomo script automatically sends a PageView when your pages are loaded. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"enableLinkTracking\":{\"title\":\"Enable Link Tracking\",\"instructions\":\"Install link tracking on all applicable link elements. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"scriptUrl\":{\"title\":\"Matomo Script URL\",\"instructions\":\"The URL to the Matomo tracking script. This will vary depending on whether you are using Matomo Cloud or Matomo On-Premise. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"}},\"dataLayer\":[]},\"plausible\":{\"include\":false,\"key\":\"plausible\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Plausible\",\"description\":\"Plausible is a lightweight and open-source website analytics tool. No cookies and fully compliant with GDPR, CCPA and PECR. [Learn More](https://plausible.io/)\",\"templatePath\":\"_frontend/scripts/plausibleAnalytics.twig\",\"templateString\":\"{% if siteDomain.value is defined and siteDomain.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-domain\\\", \\\"{{ siteDomain.value | raw }}\\\");\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteDomain\":{\"title\":\"Site Domain\",\"instructions\":\"Only enter the site domain, not the entire script code. [Learn More](https://plausible.io/docs/plausible-script)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Plausible Script URL\",\"instructions\":\"The URL to the Plausible tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://plausible.io/js/plausible.js\"}},\"dataLayer\":[]},\"googleAnalytics\":{\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Google Analytics (old)\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[]}},\"position\":1},\"MetaJsonLdContainergeneral\":{\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"mainEntityOfPage\":{\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.meta.mainEntityOfPage }}\",\"id\":null,\"graph\":null,\"issn\":null,\"teaches\":null,\"educationalLevel\":null,\"abstract\":null,\"creativeWorkStatus\":null,\"expires\":null,\"contentReferenceTime\":null,\"material\":null,\"review\":null,\"fileFormat\":null,\"text\":null,\"translator\":null,\"award\":null,\"assesses\":null,\"copyrightNotice\":null,\"schemaVersion\":null,\"countryOfOrigin\":null,\"pattern\":null,\"accountablePerson\":null,\"funding\":null,\"educationalUse\":null,\"genre\":null,\"keywords\":null,\"position\":null,\"accessibilityHazard\":null,\"alternativeHeadline\":null,\"audience\":null,\"offers\":null,\"locationCreated\":null,\"associatedMedia\":null,\"materialExtent\":null,\"mainEntity\":null,\"copyrightHolder\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"awards\":null,\"contentLocation\":null,\"sdDatePublished\":null,\"producer\":null,\"spatial\":null,\"publisher\":null,\"sourceOrganization\":null,\"character\":null,\"funder\":null,\"exampleOfWork\":null,\"usageInfo\":null,\"provider\":null,\"sdPublisher\":null,\"comment\":null,\"accessibilityFeature\":null,\"publication\":null,\"translationOfWork\":null,\"interactivityType\":null,\"commentCount\":null,\"accessMode\":null,\"aggregateRating\":null,\"timeRequired\":null,\"typicalAgeRange\":null,\"interactionStatistic\":null,\"copyrightYear\":null,\"isBasedOn\":null,\"workExample\":null,\"publishingPrinciples\":null,\"discussionUrl\":null,\"releasedEvent\":null,\"dateCreated\":null,\"workTranslation\":null,\"editor\":null,\"creditText\":null,\"recordedAt\":null,\"editEIDR\":null,\"author\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"dateModified\":null,\"sponsor\":null,\"accessibilitySummary\":null,\"encodingFormat\":null,\"maintainer\":null,\"educationalAlignment\":null,\"acquireLicensePage\":null,\"isAccessibleForFree\":null,\"datePublished\":null,\"spatialCoverage\":null,\"sdLicense\":null,\"conditionsOfAccess\":null,\"correction\":null,\"contentRating\":null,\"size\":null,\"isPartOf\":null,\"temporal\":null,\"thumbnailUrl\":null,\"inLanguage\":\"{{ seomatic.meta.language }}\",\"license\":null,\"creator\":{\"id\":\"{{ parseEnv(seomatic.site.creator.genericUrl) }}#creator\"},\"reviews\":null,\"about\":null,\"isFamilyFriendly\":null,\"headline\":null,\"accessibilityAPI\":null,\"publisherImprint\":null,\"isBasedOnUrl\":null,\"encodings\":null,\"interpretedAsClaim\":null,\"accessibilityControl\":null,\"citation\":null,\"version\":null,\"archivedAt\":null,\"learningResourceType\":null,\"encoding\":null,\"audio\":null,\"mentions\":null,\"accessModeSufficient\":null,\"hasPart\":null,\"temporalCoverage\":null,\"contributor\":null,\"video\":null,\"mainEntityOfPage\":\"{{ seomatic.meta.canonicalUrl }}\",\"alternateName\":null,\"name\":\"{{ seomatic.meta.seoTitle }}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":{\"type\":\"EntryPoint\",\"urlTemplate\":\"{{ seomatic.site.siteLinksSearchTarget }}\"},\"query-input\":\"{{ seomatic.helper.siteLinksQueryInput() }}\"},\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.meta.seoImage }}\"},\"url\":\"{{ seomatic.meta.canonicalUrl }}\",\"description\":\"{{ seomatic.meta.seoDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null},\"identity\":{\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.site.identity.computedType }}\",\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\",\"graph\":null,\"ownershipFundingInfo\":null,\"hasCredential\":null,\"founders\":null,\"telephone\":\"{{ seomatic.site.identity.genericTelephone }}\",\"review\":null,\"knowsAbout\":null,\"award\":null,\"member\":null,\"employee\":null,\"dissolutionDate\":null,\"funding\":null,\"vatID\":null,\"globalLocationNumber\":null,\"keywords\":null,\"contactPoints\":[],\"subOrganization\":null,\"awards\":null,\"numberOfEmployees\":null,\"funder\":null,\"makesOffer\":null,\"legalName\":null,\"correctionsPolicy\":null,\"aggregateRating\":null,\"interactionStatistic\":null,\"location\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{{ seomatic.site.identity.genericStreetAddress }}\",\"addressLocality\":\"{{ seomatic.site.identity.genericAddressLocality }}\",\"addressRegion\":\"{{ seomatic.site.identity.genericAddressRegion }}\",\"postalCode\":\"{{ seomatic.site.identity.genericPostalCode }}\",\"addressCountry\":\"{{ seomatic.site.identity.genericAddressCountry }}\"},\"memberOf\":null,\"publishingPrinciples\":null,\"diversityStaffingReport\":null,\"diversityPolicy\":null,\"email\":\"{{ seomatic.site.identity.genericEmail }}\",\"employees\":null,\"nonprofitStatus\":null,\"slogan\":null,\"ethicsPolicy\":null,\"brand\":null,\"sponsor\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\",\"width\":\"{{ seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\",\"height\":\"{{ seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\"},\"actionableFeedbackPolicy\":null,\"naics\":null,\"contactPoint\":null,\"serviceArea\":null,\"isicV4\":null,\"hasMerchantReturnPolicy\":null,\"hasPOS\":null,\"founder\":\"{{ seomatic.site.identity.organizationFounder }}\",\"unnamedSourcesPolicy\":null,\"foundingLocation\":\"{{ seomatic.site.identity.organizationFoundingLocation }}\",\"duns\":\"{{ seomatic.site.identity.organizationDuns }}\",\"parentOrganization\":null,\"alumni\":null,\"leiCode\":null,\"areaServed\":null,\"foundingDate\":\"{{ seomatic.site.identity.organizationFoundingDate }}\",\"knowsLanguage\":null,\"reviews\":null,\"seeks\":null,\"taxID\":null,\"owns\":null,\"hasOfferCatalog\":null,\"members\":null,\"events\":null,\"iso6523Code\":null,\"department\":null,\"faxNumber\":null,\"event\":null,\"mainEntityOfPage\":null,\"alternateName\":\"{{ seomatic.site.identity.genericAlternateName }}\",\"name\":\"{{ seomatic.site.identity.genericName }}\",\"potentialAction\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.site.identity.genericImage }}\",\"width\":\"{{ seomatic.site.identity.genericImageWidth }}\",\"height\":\"{{ seomatic.site.identity.genericImageHeight }}\"},\"url\":\"{{ seomatic.site.identity.genericUrl }}\",\"description\":\"{{ seomatic.site.identity.genericDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null},\"creator\":{\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.site.creator.computedType }}\",\"id\":\"{{ parseEnv(seomatic.site.creator.genericUrl) }}#creator\",\"graph\":null,\"ownershipFundingInfo\":null,\"hasCredential\":null,\"founders\":null,\"telephone\":\"{{ seomatic.site.creator.genericTelephone }}\",\"review\":null,\"knowsAbout\":null,\"award\":null,\"member\":null,\"employee\":null,\"dissolutionDate\":null,\"funding\":null,\"vatID\":null,\"globalLocationNumber\":null,\"keywords\":null,\"contactPoints\":[],\"subOrganization\":null,\"awards\":null,\"numberOfEmployees\":null,\"funder\":null,\"makesOffer\":null,\"legalName\":null,\"correctionsPolicy\":null,\"aggregateRating\":null,\"interactionStatistic\":null,\"location\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{{ seomatic.site.creator.genericStreetAddress }}\",\"addressLocality\":\"{{ seomatic.site.creator.genericAddressLocality }}\",\"addressRegion\":\"{{ seomatic.site.creator.genericAddressRegion }}\",\"postalCode\":\"{{ seomatic.site.creator.genericPostalCode }}\",\"addressCountry\":\"{{ seomatic.site.creator.genericAddressCountry }}\"},\"memberOf\":null,\"publishingPrinciples\":null,\"diversityStaffingReport\":null,\"diversityPolicy\":null,\"email\":\"{{ seomatic.site.creator.genericEmail }}\",\"employees\":null,\"nonprofitStatus\":null,\"slogan\":null,\"ethicsPolicy\":null,\"brand\":null,\"sponsor\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\",\"width\":\"{{ seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\",\"height\":\"{{ seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\"},\"actionableFeedbackPolicy\":null,\"naics\":null,\"contactPoint\":null,\"serviceArea\":null,\"isicV4\":null,\"hasMerchantReturnPolicy\":null,\"hasPOS\":null,\"founder\":\"{{ seomatic.site.creator.organizationFounder }}\",\"unnamedSourcesPolicy\":null,\"foundingLocation\":\"{{ seomatic.site.creator.organizationFoundingLocation }}\",\"duns\":\"{{ seomatic.site.creator.organizationDuns }}\",\"parentOrganization\":null,\"alumni\":null,\"leiCode\":null,\"areaServed\":null,\"foundingDate\":\"{{ seomatic.site.creator.organizationFoundingDate }}\",\"knowsLanguage\":null,\"reviews\":null,\"seeks\":null,\"taxID\":null,\"owns\":null,\"hasOfferCatalog\":null,\"members\":null,\"events\":null,\"iso6523Code\":null,\"department\":null,\"faxNumber\":null,\"event\":null,\"mainEntityOfPage\":null,\"alternateName\":\"{{ seomatic.site.creator.genericAlternateName }}\",\"name\":\"{{ seomatic.site.creator.genericName }}\",\"potentialAction\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.site.creator.genericImage }}\",\"width\":\"{{ seomatic.site.creator.genericImageWidth }}\",\"height\":\"{{ seomatic.site.creator.genericImageHeight }}\"},\"url\":\"{{ seomatic.site.creator.genericUrl }}\",\"description\":\"{{ seomatic.site.creator.genericDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null}}},\"MetaTitleContainergeneral\":{\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"title\":{\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"title\":\"{{ seomatic.meta.seoTitle }}\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.siteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"}}}}','[]','{\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false,\"data\":{\"humans\":{\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\",\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ parseEnv(seomatic.site.creator.genericUrl ?? \\\"n/a\\\") }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 4, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null},\"robots\":{\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\",\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }}\\n\\n{{ seomatic.helper.sitemapIndex() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null},\"ads\":{\"include\":false,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\",\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ seomatic.helper.baseSiteUrl(\\\"/\\\") }},123,DIRECT\\n\",\"siteId\":null},\"security\":{\"include\":false,\"handle\":\"security\",\"path\":\"security.txt\",\"template\":\"_frontend/pages/security.twig\",\"controller\":\"frontend-template\",\"action\":\"security\",\"templateVersion\":\"1.0.0\",\"templateString\":\"# security.txt file for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }} - more info: https://securitytxt.org/\\n\\n# (required) Contact email address for security issues\\nContact: mailto:user@example.com\\n\\n# (required) Expiration date for the security information herein\\nExpires: {{ date(\'+1 year\')|atom }}\\n\\n# (optional) OpenPGP key:\\nEncryption: {{ url(\'pgp-key.txt\') }}\\n\\n# (optional) Security policy page:\\nPolicy: {{ url(\'security-policy\') }}\\n\\n# (optional) Security acknowledgements page:\\nAcknowledgements: {{ url(\'hall-of-fame\') }}\\n\",\"siteId\":null}}}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(2,'2022-11-16 06:42:16','2022-11-16 06:42:16','7153138e-e962-45d1-b8a3-b439374d0e76','1.0.61','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',1,'[]','2022-11-16 06:42:16','{\"inherited\":[],\"overrides\":[],\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ seomatic.helper.safeCanonicalUrl() }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{{ seomatic.meta.seoTitle }}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{{ seomatic.meta.seoDescription }}\",\"ogImage\":\"{{ seomatic.meta.seoImage }}\",\"ogImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"ogImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"ogImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{{ seomatic.site.twitterHandle }}\",\"twitterTitle\":\"{{ seomatic.meta.seoTitle }}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{{ seomatic.meta.seoDescription }}\",\"twitterImage\":\"{{ seomatic.meta.seoImage }}\",\"twitterImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"twitterImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"twitterImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\"}','{\"siteName\":\"Main Site\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"inherited\":[],\"overrides\":[],\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"generator\":{\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null},\"keywords\":{\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.seoKeywords }}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null},\"description\":{\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.seoDescription }}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null},\"referrer\":{\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.referrer }}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null},\"robots\":{\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{{ seomatic.meta.robots }}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.robots }}\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null}}},\"MetaTagContaineropengraph\":{\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"fb:profile_id\":{\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookProfileId }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\"},\"fb:app_id\":{\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookAppId }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\"},\"og:locale\":{\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\"},\"og:locale:alternate\":{\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\"},\"og:site_name\":{\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.siteName }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\"},\"og:type\":{\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogType }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\"},\"og:url\":{\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.canonicalUrl }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\"},\"og:title\":{\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogTitle }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.ogSiteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"},\"og:description\":{\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogDescription }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\"},\"og:image\":{\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImage }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\"},\"og:image:width\":{\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageWidth }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\"},\"og:image:height\":{\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageHeight }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\"},\"og:image:alt\":{\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageDescription }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\"},\"og:see_also\":{\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\"},\"facebook-site-verification\":{\"include\":true,\"key\":\"facebook-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"facebookSiteVerification\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"facebook-domain-verification\",\"property\":null}}},\"MetaTagContainertwitter\":{\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false,\"data\":{\"twitter:card\":{\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterCard }}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null},\"twitter:site\":{\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"@{{ seomatic.site.twitterHandle }}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null},\"twitter:creator\":{\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"@{{ seomatic.meta.twitterCreator }}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null},\"twitter:title\":{\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterTitle }}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.twitterSiteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"},\"twitter:description\":{\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterDescription }}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null},\"twitter:image\":{\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImage }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null},\"twitter:image:width\":{\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageWidth }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null},\"twitter:image:height\":{\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageHeight }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null},\"twitter:image:alt\":{\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageDescription }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null}}},\"MetaTagContainermiscellaneous\":{\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"google-site-verification\":{\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.googleSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null},\"bing-site-verification\":{\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.bingSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null},\"pinterest-site-verification\":{\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]},\"tagAttrs\":[],\"charset\":\"\",\"content\":\"{{ seomatic.site.pinterestSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null}}},\"MetaLinkContainergeneral\":{\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"canonical\":{\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"crossorigin\":\"\",\"href\":\"{{ seomatic.meta.canonicalUrl }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\"},\"home\":{\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\"},\"author\":{\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]},\"tagAttrs\":[],\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\"},\"publisher\":{\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]},\"tagAttrs\":[],\"crossorigin\":\"\",\"href\":\"{{ seomatic.site.googlePublisherLink }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\"}}},\"MetaScriptContainergeneral\":{\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"gtag\":{\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Measurement/Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `G-XXXXXXXXXX` or `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[]},\"googleTagManager\":{\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[]},\"facebookPixel\":{\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[]},\"linkedInInsight\":{\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[]},\"hubSpot\":{\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[]},\"pinterestTag\":{\"include\":false,\"key\":\"pinterestTag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Pinterest Tag\",\"description\":\"The Pinterest tag allows you to track actions people take on your website after viewing your Promoted Pin. You can use this information to measure return on ad spend (RoAS) and create audiences to target on your Promoted Pins. [Learn More](https://help.pinterest.com/en/business/article/track-conversions-with-pinterest-tag)\",\"templatePath\":\"_frontend/scripts/pinterestTagHead.twig\",\"templateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n!function(e){if(!window.pintrk){window.pintrk=function(){window.pintrk.queue.push(\\nArray.prototype.slice.call(arguments))};var\\nn=window.pintrk;n.queue=[],n.version=\\\"3.0\\\";var\\nt=document.createElement(\\\"script\\\");t.async=!0,t.src=e;var\\nr=document.getElementsByTagName(\\\"script\\\")[0];r.parentNode.insertBefore(t,r)}}(\\\"{{ pinterestTagUrl.value }}\\\");\\npintrk(\'load\', \'{{ pinterestTagId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\npintrk(\'page\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/pinterestTagBody.twig\",\"bodyTemplateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ pinterestTagNoScriptUrl.value }}?tid={{ pinterestTagId.value }}&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"pinterestTagId\":{\"title\":\"Pinterest Tag ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.pinterest.com/docs/ad-tools/conversion-tag/)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Pinterest Tag PageView\",\"instructions\":\"Controls whether the Pinterest Tag script automatically sends a PageView to when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"pinterestTagUrl\":{\"title\":\"Pinterest Tag Script URL\",\"instructions\":\"The URL to the Pinterest Tag script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://s.pinimg.com/ct/core.js\"},\"pinterestTagNoScriptUrl\":{\"title\":\"Pinterest Tag Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Pinterest Tag `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://ct.pinterest.com/v3/\"}},\"dataLayer\":[]},\"fathom\":{\"include\":false,\"key\":\"fathom\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Fathom\",\"description\":\"Fathom is a simple, light-weight, privacy-first alternative to Google Analytics. So, stop scrolling through pages of reports and collecting gobs of personal data about your visitors, both of which you probably don’t need. [Learn More](https://usefathom.com/)\",\"templatePath\":\"_frontend/scripts/fathomAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-site\\\", \\\"{{ siteId.value | raw }}\\\");\\n{% if honorDnt.value %}\\ntag.setAttribute(\\\"data-honor-dnt\\\", \\\"true\\\");\\n{% endif %}\\n{% if disableAutoTracking.value %}\\ntag.setAttribute(\\\"data-auto\\\", \\\"false\\\");\\n{% endif %}\\n{% if ignoreCanonicals.value %}\\ntag.setAttribute(\\\"data-canonical\\\", \\\"false\\\");\\n{% endif %}\\n{% if excludedDomains.value | length %}\\ntag.setAttribute(\\\"data-excluded-domains\\\", \\\"{{ excludedDomains.value | raw }}\\\");\\n{% endif %}\\n{% if includedDomains.value | length %}\\ntag.setAttribute(\\\"data-included-domains\\\", \\\"{{ includedDomains.value | raw }}\\\");\\n{% endif %}\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://usefathom.com/support/tracking)\",\"type\":\"string\",\"value\":\"\"},\"honorDnt\":{\"title\":\"Honoring Do Not Track (DNT)\",\"instructions\":\"By default we track every visitor to your website, regardless of them having DNT turned on or not. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"disableAutoTracking\":{\"title\":\"Disable automatic tracking\",\"instructions\":\"By default, we track a page view every time a visitor to your website loads a page with our script on it. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"ignoreCanonicals\":{\"title\":\"Ignore canonicals\",\"instructions\":\"If there’s a canonical URL in place, then by default we use it instead of the current URL. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"excludedDomains\":{\"title\":\"Excluded Domains\",\"instructions\":\"You exclude one or several domains, so our tracker will track things on every domain, except the ones excluded. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"includedDomains\":{\"title\":\"Included Domains\",\"instructions\":\"If you want to go in the opposite direction and only track stats on a specific domain. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Fathom Script URL\",\"instructions\":\"The URL to the Fathom tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://cdn.usefathom.com/script.js\"}},\"dataLayer\":[]},\"matomo\":{\"include\":false,\"key\":\"matomo\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Matomo\",\"description\":\"Matomo is a Google Analytics alternative that protects your data and your customers\' privacy [Learn More](https://matomo.org/)\",\"templatePath\":\"_frontend/scripts/matomoAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value and scriptUrl.value is defined and scriptUrl.value | length %}\\nvar _paq = window._paq = window._paq || [];\\n{% if sendPageView.value %}\\n_paq.push([\'trackPageView\']);\\n{% endif %}\\n{% if sendPageView.value %}\\n_paq.push([\'enableLinkTracking\']);\\n{% endif %}\\n(function() {\\nvar u=\\\"{{ scriptUrl.value }}\\\";\\n_paq.push([\'setTrackerUrl\', u+\'matomo.php\']);\\n_paq.push([\'setSiteId\', {{ siteId.value }}]);\\nvar d=document, g=d.createElement(\'script\'), s=d.getElementsByTagName(\'script\')[0];\\ng.type=\'text/javascript\'; g.async=true; g.src=u+\'matomo.js\'; s.parentNode.insertBefore(g,s);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Matomo PageView\",\"instructions\":\"Controls whether the Matomo script automatically sends a PageView when your pages are loaded. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"enableLinkTracking\":{\"title\":\"Enable Link Tracking\",\"instructions\":\"Install link tracking on all applicable link elements. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"scriptUrl\":{\"title\":\"Matomo Script URL\",\"instructions\":\"The URL to the Matomo tracking script. This will vary depending on whether you are using Matomo Cloud or Matomo On-Premise. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"}},\"dataLayer\":[]},\"plausible\":{\"include\":false,\"key\":\"plausible\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Plausible\",\"description\":\"Plausible is a lightweight and open-source website analytics tool. No cookies and fully compliant with GDPR, CCPA and PECR. [Learn More](https://plausible.io/)\",\"templatePath\":\"_frontend/scripts/plausibleAnalytics.twig\",\"templateString\":\"{% if siteDomain.value is defined and siteDomain.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-domain\\\", \\\"{{ siteDomain.value | raw }}\\\");\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteDomain\":{\"title\":\"Site Domain\",\"instructions\":\"Only enter the site domain, not the entire script code. [Learn More](https://plausible.io/docs/plausible-script)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Plausible Script URL\",\"instructions\":\"The URL to the Plausible tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://plausible.io/js/plausible.js\"}},\"dataLayer\":[]},\"googleAnalytics\":{\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"name\":\"Google Analytics (old)\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[]}},\"position\":1},\"MetaJsonLdContainergeneral\":{\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"mainEntityOfPage\":{\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.meta.mainEntityOfPage }}\",\"id\":null,\"graph\":null,\"issn\":null,\"teaches\":null,\"educationalLevel\":null,\"abstract\":null,\"creativeWorkStatus\":null,\"expires\":null,\"contentReferenceTime\":null,\"material\":null,\"review\":null,\"fileFormat\":null,\"text\":null,\"translator\":null,\"award\":null,\"assesses\":null,\"copyrightNotice\":null,\"schemaVersion\":null,\"countryOfOrigin\":null,\"pattern\":null,\"accountablePerson\":null,\"funding\":null,\"educationalUse\":null,\"genre\":null,\"keywords\":null,\"position\":null,\"accessibilityHazard\":null,\"alternativeHeadline\":null,\"audience\":null,\"offers\":null,\"locationCreated\":null,\"associatedMedia\":null,\"materialExtent\":null,\"mainEntity\":null,\"copyrightHolder\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"awards\":null,\"contentLocation\":null,\"sdDatePublished\":null,\"producer\":null,\"spatial\":null,\"publisher\":null,\"sourceOrganization\":null,\"character\":null,\"funder\":null,\"exampleOfWork\":null,\"usageInfo\":null,\"provider\":null,\"sdPublisher\":null,\"comment\":null,\"accessibilityFeature\":null,\"publication\":null,\"translationOfWork\":null,\"interactivityType\":null,\"commentCount\":null,\"accessMode\":null,\"aggregateRating\":null,\"timeRequired\":null,\"typicalAgeRange\":null,\"interactionStatistic\":null,\"copyrightYear\":null,\"isBasedOn\":null,\"workExample\":null,\"publishingPrinciples\":null,\"discussionUrl\":null,\"releasedEvent\":null,\"dateCreated\":null,\"workTranslation\":null,\"editor\":null,\"creditText\":null,\"recordedAt\":null,\"editEIDR\":null,\"author\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"dateModified\":null,\"sponsor\":null,\"accessibilitySummary\":null,\"encodingFormat\":null,\"maintainer\":null,\"educationalAlignment\":null,\"acquireLicensePage\":null,\"isAccessibleForFree\":null,\"datePublished\":null,\"spatialCoverage\":null,\"sdLicense\":null,\"conditionsOfAccess\":null,\"correction\":null,\"contentRating\":null,\"size\":null,\"isPartOf\":null,\"temporal\":null,\"thumbnailUrl\":null,\"inLanguage\":\"{{ seomatic.meta.language }}\",\"license\":null,\"creator\":{\"id\":\"{{ parseEnv(seomatic.site.creator.genericUrl) }}#creator\"},\"reviews\":null,\"about\":null,\"isFamilyFriendly\":null,\"headline\":null,\"accessibilityAPI\":null,\"publisherImprint\":null,\"isBasedOnUrl\":null,\"encodings\":null,\"interpretedAsClaim\":null,\"accessibilityControl\":null,\"citation\":null,\"version\":null,\"archivedAt\":null,\"learningResourceType\":null,\"encoding\":null,\"audio\":null,\"mentions\":null,\"accessModeSufficient\":null,\"hasPart\":null,\"temporalCoverage\":null,\"contributor\":null,\"video\":null,\"mainEntityOfPage\":\"{{ seomatic.meta.canonicalUrl }}\",\"alternateName\":null,\"name\":\"{{ seomatic.meta.seoTitle }}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":{\"type\":\"EntryPoint\",\"urlTemplate\":\"{{ seomatic.site.siteLinksSearchTarget }}\"},\"query-input\":\"{{ seomatic.helper.siteLinksQueryInput() }}\"},\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.meta.seoImage }}\"},\"url\":\"{{ seomatic.meta.canonicalUrl }}\",\"description\":\"{{ seomatic.meta.seoDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null},\"identity\":{\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.site.identity.computedType }}\",\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\",\"graph\":null,\"ownershipFundingInfo\":null,\"hasCredential\":null,\"founders\":null,\"telephone\":\"{{ seomatic.site.identity.genericTelephone }}\",\"review\":null,\"knowsAbout\":null,\"award\":null,\"member\":null,\"employee\":null,\"dissolutionDate\":null,\"funding\":null,\"vatID\":null,\"globalLocationNumber\":null,\"keywords\":null,\"contactPoints\":[],\"subOrganization\":null,\"awards\":null,\"numberOfEmployees\":null,\"funder\":null,\"makesOffer\":null,\"legalName\":null,\"correctionsPolicy\":null,\"aggregateRating\":null,\"interactionStatistic\":null,\"location\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{{ seomatic.site.identity.genericStreetAddress }}\",\"addressLocality\":\"{{ seomatic.site.identity.genericAddressLocality }}\",\"addressRegion\":\"{{ seomatic.site.identity.genericAddressRegion }}\",\"postalCode\":\"{{ seomatic.site.identity.genericPostalCode }}\",\"addressCountry\":\"{{ seomatic.site.identity.genericAddressCountry }}\"},\"memberOf\":null,\"publishingPrinciples\":null,\"diversityStaffingReport\":null,\"diversityPolicy\":null,\"email\":\"{{ seomatic.site.identity.genericEmail }}\",\"employees\":null,\"nonprofitStatus\":null,\"slogan\":null,\"ethicsPolicy\":null,\"brand\":null,\"sponsor\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\",\"width\":\"{{ seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\",\"height\":\"{{ seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\"},\"actionableFeedbackPolicy\":null,\"naics\":null,\"contactPoint\":null,\"serviceArea\":null,\"isicV4\":null,\"hasMerchantReturnPolicy\":null,\"hasPOS\":null,\"founder\":\"{{ seomatic.site.identity.organizationFounder }}\",\"unnamedSourcesPolicy\":null,\"foundingLocation\":\"{{ seomatic.site.identity.organizationFoundingLocation }}\",\"duns\":\"{{ seomatic.site.identity.organizationDuns }}\",\"parentOrganization\":null,\"alumni\":null,\"leiCode\":null,\"areaServed\":null,\"foundingDate\":\"{{ seomatic.site.identity.organizationFoundingDate }}\",\"knowsLanguage\":null,\"reviews\":null,\"seeks\":null,\"taxID\":null,\"owns\":null,\"hasOfferCatalog\":null,\"members\":null,\"events\":null,\"iso6523Code\":null,\"department\":null,\"faxNumber\":null,\"event\":null,\"mainEntityOfPage\":null,\"alternateName\":\"{{ seomatic.site.identity.genericAlternateName }}\",\"name\":\"{{ seomatic.site.identity.genericName }}\",\"potentialAction\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.site.identity.genericImage }}\",\"width\":\"{{ seomatic.site.identity.genericImageWidth }}\",\"height\":\"{{ seomatic.site.identity.genericImageHeight }}\"},\"url\":\"{{ seomatic.site.identity.genericUrl }}\",\"description\":\"{{ seomatic.site.identity.genericDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null},\"creator\":{\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.site.creator.computedType }}\",\"id\":\"{{ parseEnv(seomatic.site.creator.genericUrl) }}#creator\",\"graph\":null,\"ownershipFundingInfo\":null,\"hasCredential\":null,\"founders\":null,\"telephone\":\"{{ seomatic.site.creator.genericTelephone }}\",\"review\":null,\"knowsAbout\":null,\"award\":null,\"member\":null,\"employee\":null,\"dissolutionDate\":null,\"funding\":null,\"vatID\":null,\"globalLocationNumber\":null,\"keywords\":null,\"contactPoints\":[],\"subOrganization\":null,\"awards\":null,\"numberOfEmployees\":null,\"funder\":null,\"makesOffer\":null,\"legalName\":null,\"correctionsPolicy\":null,\"aggregateRating\":null,\"interactionStatistic\":null,\"location\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{{ seomatic.site.creator.genericStreetAddress }}\",\"addressLocality\":\"{{ seomatic.site.creator.genericAddressLocality }}\",\"addressRegion\":\"{{ seomatic.site.creator.genericAddressRegion }}\",\"postalCode\":\"{{ seomatic.site.creator.genericPostalCode }}\",\"addressCountry\":\"{{ seomatic.site.creator.genericAddressCountry }}\"},\"memberOf\":null,\"publishingPrinciples\":null,\"diversityStaffingReport\":null,\"diversityPolicy\":null,\"email\":\"{{ seomatic.site.creator.genericEmail }}\",\"employees\":null,\"nonprofitStatus\":null,\"slogan\":null,\"ethicsPolicy\":null,\"brand\":null,\"sponsor\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\",\"width\":\"{{ seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\",\"height\":\"{{ seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\"},\"actionableFeedbackPolicy\":null,\"naics\":null,\"contactPoint\":null,\"serviceArea\":null,\"isicV4\":null,\"hasMerchantReturnPolicy\":null,\"hasPOS\":null,\"founder\":\"{{ seomatic.site.creator.organizationFounder }}\",\"unnamedSourcesPolicy\":null,\"foundingLocation\":\"{{ seomatic.site.creator.organizationFoundingLocation }}\",\"duns\":\"{{ seomatic.site.creator.organizationDuns }}\",\"parentOrganization\":null,\"alumni\":null,\"leiCode\":null,\"areaServed\":null,\"foundingDate\":\"{{ seomatic.site.creator.organizationFoundingDate }}\",\"knowsLanguage\":null,\"reviews\":null,\"seeks\":null,\"taxID\":null,\"owns\":null,\"hasOfferCatalog\":null,\"members\":null,\"events\":null,\"iso6523Code\":null,\"department\":null,\"faxNumber\":null,\"event\":null,\"mainEntityOfPage\":null,\"alternateName\":\"{{ seomatic.site.creator.genericAlternateName }}\",\"name\":\"{{ seomatic.site.creator.genericName }}\",\"potentialAction\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.site.creator.genericImage }}\",\"width\":\"{{ seomatic.site.creator.genericImageWidth }}\",\"height\":\"{{ seomatic.site.creator.genericImageHeight }}\"},\"url\":\"{{ seomatic.site.creator.genericUrl }}\",\"description\":\"{{ seomatic.site.creator.genericDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null}}},\"MetaTitleContainergeneral\":{\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"title\":{\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"title\":\"{{ seomatic.meta.seoTitle }}\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.siteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"}}}}','[]','{\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false,\"data\":{\"humans\":{\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\",\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ parseEnv(seomatic.site.creator.genericUrl ?? \\\"n/a\\\") }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 4, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null},\"robots\":{\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\",\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }}\\n\\n{{ seomatic.helper.sitemapIndex() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null},\"ads\":{\"include\":false,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\",\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ seomatic.helper.baseSiteUrl(\\\"/\\\") }},123,DIRECT\\n\",\"siteId\":null},\"security\":{\"include\":false,\"handle\":\"security\",\"path\":\"security.txt\",\"template\":\"_frontend/pages/security.twig\",\"controller\":\"frontend-template\",\"action\":\"security\",\"templateVersion\":\"1.0.0\",\"templateString\":\"# security.txt file for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }} - more info: https://securitytxt.org/\\n\\n# (required) Contact email address for security issues\\nContact: mailto:user@example.com\\n\\n# (required) Expiration date for the security information herein\\nExpires: {{ date(\'+1 year\')|atom }}\\n\\n# (optional) OpenPGP key:\\nEncryption: {{ url(\'pgp-key.txt\') }}\\n\\n# (optional) Security policy page:\\nPolicy: {{ url(\'security-policy\') }}\\n\\n# (optional) Security acknowledgements page:\\nAcknowledgements: {{ url(\'hall-of-fame\') }}\\n\",\"siteId\":null}}}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(3,'2022-11-16 06:48:32','2022-11-17 10:49:11','299dbf77-cf0d-4da8-8f11-068f0a1806f4','1.0.30','section',9,'Primary Pages','pages','structure',NULL,'_page',1,'{\"1\":{\"id\":9,\"sectionId\":9,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"{parent.uri}/{slug}\",\"template\":\"_page\",\"language\":\"en-ca\"}}','2022-11-17 10:49:11','{\"inherited\":[],\"overrides\":[],\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{{ entry.title }}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ entry.url }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{{ seomatic.meta.seoTitle }}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{{ seomatic.meta.seoDescription }}\",\"ogImage\":\"{{ seomatic.meta.seoImage }}\",\"ogImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"ogImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"ogImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{{ seomatic.site.twitterHandle }}\",\"twitterTitle\":\"{{ seomatic.meta.seoTitle }}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{{ seomatic.meta.seoDescription }}\",\"twitterImage\":\"{{ seomatic.meta.seoImage }}\",\"twitterImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"twitterImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"twitterImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\"}','{\"siteName\":\"Main Site\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"inherited\":[],\"overrides\":[],\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContaineropengraph\":{\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContainertwitter\":{\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContainermiscellaneous\":{\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaLinkContainergeneral\":{\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaScriptContainergeneral\":{\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[],\"position\":1},\"MetaJsonLdContainergeneral\":{\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"mainEntityOfPage\":{\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.meta.mainEntityOfPage }}\",\"id\":null,\"graph\":null,\"lastReviewed\":null,\"specialty\":null,\"primaryImageOfPage\":null,\"significantLink\":null,\"reviewedBy\":null,\"mainContentOfPage\":null,\"relatedLink\":null,\"speakable\":null,\"breadcrumb\":null,\"significantLinks\":null,\"teaches\":null,\"educationalLevel\":null,\"abstract\":null,\"creativeWorkStatus\":null,\"expires\":null,\"contentReferenceTime\":null,\"material\":null,\"review\":null,\"fileFormat\":null,\"text\":null,\"translator\":null,\"award\":null,\"assesses\":null,\"copyrightNotice\":null,\"schemaVersion\":null,\"countryOfOrigin\":null,\"pattern\":null,\"accountablePerson\":null,\"funding\":null,\"educationalUse\":null,\"genre\":null,\"keywords\":null,\"position\":null,\"accessibilityHazard\":null,\"alternativeHeadline\":null,\"audience\":null,\"offers\":null,\"locationCreated\":null,\"associatedMedia\":null,\"materialExtent\":null,\"mainEntity\":null,\"copyrightHolder\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"awards\":null,\"contentLocation\":null,\"sdDatePublished\":null,\"producer\":null,\"spatial\":null,\"publisher\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"sourceOrganization\":null,\"character\":null,\"funder\":null,\"exampleOfWork\":null,\"usageInfo\":null,\"provider\":null,\"sdPublisher\":null,\"comment\":null,\"accessibilityFeature\":null,\"publication\":null,\"translationOfWork\":null,\"interactivityType\":null,\"commentCount\":null,\"accessMode\":null,\"aggregateRating\":null,\"timeRequired\":null,\"typicalAgeRange\":null,\"interactionStatistic\":null,\"copyrightYear\":\"{{ entry.postDate | date(\\\"Y\\\") }}\",\"isBasedOn\":null,\"workExample\":null,\"publishingPrinciples\":null,\"discussionUrl\":null,\"releasedEvent\":null,\"dateCreated\":false,\"workTranslation\":null,\"editor\":null,\"creditText\":null,\"recordedAt\":null,\"editEIDR\":null,\"author\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"dateModified\":\"{{ entry.dateUpdated |atom }}\",\"sponsor\":null,\"accessibilitySummary\":null,\"encodingFormat\":null,\"maintainer\":null,\"educationalAlignment\":null,\"acquireLicensePage\":null,\"isAccessibleForFree\":null,\"datePublished\":\"{{ entry.postDate |atom }}\",\"spatialCoverage\":null,\"sdLicense\":null,\"conditionsOfAccess\":null,\"correction\":null,\"contentRating\":null,\"size\":null,\"isPartOf\":null,\"temporal\":null,\"thumbnailUrl\":null,\"inLanguage\":\"{{ seomatic.meta.language }}\",\"license\":null,\"creator\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"reviews\":null,\"about\":null,\"isFamilyFriendly\":null,\"headline\":\"{{ seomatic.meta.seoTitle }}\",\"accessibilityAPI\":null,\"publisherImprint\":null,\"isBasedOnUrl\":null,\"encodings\":null,\"interpretedAsClaim\":null,\"accessibilityControl\":null,\"citation\":null,\"version\":null,\"archivedAt\":null,\"learningResourceType\":null,\"encoding\":null,\"audio\":null,\"mentions\":null,\"accessModeSufficient\":null,\"hasPart\":null,\"temporalCoverage\":null,\"contributor\":null,\"video\":null,\"mainEntityOfPage\":\"{{ seomatic.meta.canonicalUrl }}\",\"alternateName\":null,\"name\":\"{{ seomatic.meta.seoTitle }}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{{ seomatic.site.siteLinksSearchTarget }}\",\"query-input\":\"{{ seomatic.helper.siteLinksQueryInput() }}\"},\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.meta.seoImage }}\"},\"url\":\"{{ seomatic.meta.canonicalUrl }}\",\"description\":\"{{ seomatic.meta.seoDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null}}},\"MetaTitleContainergeneral\":{\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"title\":{\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"title\":\"{{ seomatic.meta.seoTitle }}\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.siteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"}}}}','[]','{\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false,\"data\":[]}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(4,'2022-11-16 06:50:19','2022-11-16 21:25:43','6c08ba35-e417-44bc-8076-a899bc2c48fb','1.0.30','section',8,'Fragments','fragments','channel',NULL,'_sections/fragments/_entry.twig',1,'{\"1\":{\"id\":8,\"sectionId\":8,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"fragments/{slug}\",\"template\":\"_sections/fragments/_entry.twig\",\"language\":\"en-ca\"}}','2022-11-16 21:25:43','{\"inherited\":[],\"overrides\":[],\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{{ entry.title }}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ entry.url }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{{ seomatic.meta.seoTitle }}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{{ seomatic.meta.seoDescription }}\",\"ogImage\":\"{{ seomatic.meta.seoImage }}\",\"ogImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"ogImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"ogImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{{ seomatic.site.twitterHandle }}\",\"twitterTitle\":\"{{ seomatic.meta.seoTitle }}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{{ seomatic.meta.seoDescription }}\",\"twitterImage\":\"{{ seomatic.meta.seoImage }}\",\"twitterImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"twitterImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"twitterImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\"}','{\"siteName\":\"Main Site\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"inherited\":[],\"overrides\":[],\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContaineropengraph\":{\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContainertwitter\":{\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContainermiscellaneous\":{\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaLinkContainergeneral\":{\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaScriptContainergeneral\":{\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[],\"position\":1},\"MetaJsonLdContainergeneral\":{\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"mainEntityOfPage\":{\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.meta.mainEntityOfPage }}\",\"id\":null,\"graph\":null,\"lastReviewed\":null,\"specialty\":null,\"primaryImageOfPage\":null,\"significantLink\":null,\"reviewedBy\":null,\"mainContentOfPage\":null,\"relatedLink\":null,\"speakable\":null,\"breadcrumb\":null,\"significantLinks\":null,\"teaches\":null,\"educationalLevel\":null,\"abstract\":null,\"creativeWorkStatus\":null,\"expires\":null,\"contentReferenceTime\":null,\"material\":null,\"review\":null,\"fileFormat\":null,\"text\":null,\"translator\":null,\"award\":null,\"assesses\":null,\"copyrightNotice\":null,\"schemaVersion\":null,\"countryOfOrigin\":null,\"pattern\":null,\"accountablePerson\":null,\"funding\":null,\"educationalUse\":null,\"genre\":null,\"keywords\":null,\"position\":null,\"accessibilityHazard\":null,\"alternativeHeadline\":null,\"audience\":null,\"offers\":null,\"locationCreated\":null,\"associatedMedia\":null,\"materialExtent\":null,\"mainEntity\":null,\"copyrightHolder\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"awards\":null,\"contentLocation\":null,\"sdDatePublished\":null,\"producer\":null,\"spatial\":null,\"publisher\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"sourceOrganization\":null,\"character\":null,\"funder\":null,\"exampleOfWork\":null,\"usageInfo\":null,\"provider\":null,\"sdPublisher\":null,\"comment\":null,\"accessibilityFeature\":null,\"publication\":null,\"translationOfWork\":null,\"interactivityType\":null,\"commentCount\":null,\"accessMode\":null,\"aggregateRating\":null,\"timeRequired\":null,\"typicalAgeRange\":null,\"interactionStatistic\":null,\"copyrightYear\":\"{{ entry.postDate | date(\\\"Y\\\") }}\",\"isBasedOn\":null,\"workExample\":null,\"publishingPrinciples\":null,\"discussionUrl\":null,\"releasedEvent\":null,\"dateCreated\":false,\"workTranslation\":null,\"editor\":null,\"creditText\":null,\"recordedAt\":null,\"editEIDR\":null,\"author\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"dateModified\":\"{{ entry.dateUpdated |atom }}\",\"sponsor\":null,\"accessibilitySummary\":null,\"encodingFormat\":null,\"maintainer\":null,\"educationalAlignment\":null,\"acquireLicensePage\":null,\"isAccessibleForFree\":null,\"datePublished\":\"{{ entry.postDate |atom }}\",\"spatialCoverage\":null,\"sdLicense\":null,\"conditionsOfAccess\":null,\"correction\":null,\"contentRating\":null,\"size\":null,\"isPartOf\":null,\"temporal\":null,\"thumbnailUrl\":null,\"inLanguage\":\"{{ seomatic.meta.language }}\",\"license\":null,\"creator\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"reviews\":null,\"about\":null,\"isFamilyFriendly\":null,\"headline\":\"{{ seomatic.meta.seoTitle }}\",\"accessibilityAPI\":null,\"publisherImprint\":null,\"isBasedOnUrl\":null,\"encodings\":null,\"interpretedAsClaim\":null,\"accessibilityControl\":null,\"citation\":null,\"version\":null,\"archivedAt\":null,\"learningResourceType\":null,\"encoding\":null,\"audio\":null,\"mentions\":null,\"accessModeSufficient\":null,\"hasPart\":null,\"temporalCoverage\":null,\"contributor\":null,\"video\":null,\"mainEntityOfPage\":\"{{ seomatic.meta.canonicalUrl }}\",\"alternateName\":null,\"name\":\"{{ seomatic.meta.seoTitle }}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{{ seomatic.site.siteLinksSearchTarget }}\",\"query-input\":\"{{ seomatic.helper.siteLinksQueryInput() }}\"},\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.meta.seoImage }}\"},\"url\":\"{{ seomatic.meta.canonicalUrl }}\",\"description\":\"{{ seomatic.meta.seoDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null}}},\"MetaTitleContainergeneral\":{\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"title\":{\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"title\":\"{{ seomatic.meta.seoTitle }}\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.siteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"}}}}','[]','{\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false,\"data\":[]}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(5,'2022-11-16 10:07:53','2022-11-17 07:54:39','57449e75-7338-4828-9fb2-6722d3810aa9','1.0.30','section',1,'News','news','channel',NULL,'_sections/news/_entry.twig',1,'{\"1\":{\"id\":1,\"sectionId\":1,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"news/{slug}\",\"template\":\"_sections/news/_entry.twig\",\"language\":\"en-ca\"}}','2022-11-17 07:54:39','{\"inherited\":[],\"overrides\":[],\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{{ entry.title }}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ entry.url }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{{ seomatic.meta.seoTitle }}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{{ seomatic.meta.seoDescription }}\",\"ogImage\":\"{{ seomatic.meta.seoImage }}\",\"ogImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"ogImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"ogImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{{ seomatic.site.twitterHandle }}\",\"twitterTitle\":\"{{ seomatic.meta.seoTitle }}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{{ seomatic.meta.seoDescription }}\",\"twitterImage\":\"{{ seomatic.meta.seoImage }}\",\"twitterImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"twitterImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"twitterImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\"}','{\"siteName\":\"Main Site\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"inherited\":[],\"overrides\":[],\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContaineropengraph\":{\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContainertwitter\":{\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContainermiscellaneous\":{\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaLinkContainergeneral\":{\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaScriptContainergeneral\":{\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[],\"position\":1},\"MetaJsonLdContainergeneral\":{\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"mainEntityOfPage\":{\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.meta.mainEntityOfPage }}\",\"id\":null,\"graph\":null,\"lastReviewed\":null,\"specialty\":null,\"primaryImageOfPage\":null,\"significantLink\":null,\"reviewedBy\":null,\"mainContentOfPage\":null,\"relatedLink\":null,\"speakable\":null,\"breadcrumb\":null,\"significantLinks\":null,\"teaches\":null,\"educationalLevel\":null,\"abstract\":null,\"creativeWorkStatus\":null,\"expires\":null,\"contentReferenceTime\":null,\"material\":null,\"review\":null,\"fileFormat\":null,\"text\":null,\"translator\":null,\"award\":null,\"assesses\":null,\"copyrightNotice\":null,\"schemaVersion\":null,\"countryOfOrigin\":null,\"pattern\":null,\"accountablePerson\":null,\"funding\":null,\"educationalUse\":null,\"genre\":null,\"keywords\":null,\"position\":null,\"accessibilityHazard\":null,\"alternativeHeadline\":null,\"audience\":null,\"offers\":null,\"locationCreated\":null,\"associatedMedia\":null,\"materialExtent\":null,\"mainEntity\":null,\"copyrightHolder\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"awards\":null,\"contentLocation\":null,\"sdDatePublished\":null,\"producer\":null,\"spatial\":null,\"publisher\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"sourceOrganization\":null,\"character\":null,\"funder\":null,\"exampleOfWork\":null,\"usageInfo\":null,\"provider\":null,\"sdPublisher\":null,\"comment\":null,\"accessibilityFeature\":null,\"publication\":null,\"translationOfWork\":null,\"interactivityType\":null,\"commentCount\":null,\"accessMode\":null,\"aggregateRating\":null,\"timeRequired\":null,\"typicalAgeRange\":null,\"interactionStatistic\":null,\"copyrightYear\":\"{{ entry.postDate | date(\\\"Y\\\") }}\",\"isBasedOn\":null,\"workExample\":null,\"publishingPrinciples\":null,\"discussionUrl\":null,\"releasedEvent\":null,\"dateCreated\":false,\"workTranslation\":null,\"editor\":null,\"creditText\":null,\"recordedAt\":null,\"editEIDR\":null,\"author\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"dateModified\":\"{{ entry.dateUpdated |atom }}\",\"sponsor\":null,\"accessibilitySummary\":null,\"encodingFormat\":null,\"maintainer\":null,\"educationalAlignment\":null,\"acquireLicensePage\":null,\"isAccessibleForFree\":null,\"datePublished\":\"{{ entry.postDate |atom }}\",\"spatialCoverage\":null,\"sdLicense\":null,\"conditionsOfAccess\":null,\"correction\":null,\"contentRating\":null,\"size\":null,\"isPartOf\":null,\"temporal\":null,\"thumbnailUrl\":null,\"inLanguage\":\"{{ seomatic.meta.language }}\",\"license\":null,\"creator\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"reviews\":null,\"about\":null,\"isFamilyFriendly\":null,\"headline\":\"{{ seomatic.meta.seoTitle }}\",\"accessibilityAPI\":null,\"publisherImprint\":null,\"isBasedOnUrl\":null,\"encodings\":null,\"interpretedAsClaim\":null,\"accessibilityControl\":null,\"citation\":null,\"version\":null,\"archivedAt\":null,\"learningResourceType\":null,\"encoding\":null,\"audio\":null,\"mentions\":null,\"accessModeSufficient\":null,\"hasPart\":null,\"temporalCoverage\":null,\"contributor\":null,\"video\":null,\"mainEntityOfPage\":\"{{ seomatic.meta.canonicalUrl }}\",\"alternateName\":null,\"name\":\"{{ seomatic.meta.seoTitle }}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{{ seomatic.site.siteLinksSearchTarget }}\",\"query-input\":\"{{ seomatic.helper.siteLinksQueryInput() }}\"},\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.meta.seoImage }}\"},\"url\":\"{{ seomatic.meta.canonicalUrl }}\",\"description\":\"{{ seomatic.meta.seoDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null}}},\"MetaTitleContainergeneral\":{\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"title\":{\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"title\":\"{{ seomatic.meta.seoTitle }}\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.siteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"}}}}','[]','{\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false,\"data\":[]}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(6,'2022-11-16 11:26:19','2022-11-16 11:26:19','908e3034-021e-42b8-a765-70f0a60959b5','1.0.30','section',6,'Search','search','single',NULL,'_sections/search.twig',1,'{\"1\":{\"id\":6,\"sectionId\":6,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"search\",\"template\":\"_sections/search.twig\",\"language\":\"en-ca\"}}','2022-11-16 06:42:52','{\"inherited\":[],\"overrides\":[],\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{{ entry.title }}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ entry.url }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{{ seomatic.meta.seoTitle }}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{{ seomatic.meta.seoDescription }}\",\"ogImage\":\"{{ seomatic.meta.seoImage }}\",\"ogImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"ogImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"ogImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{{ seomatic.site.twitterHandle }}\",\"twitterTitle\":\"{{ seomatic.meta.seoTitle }}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{{ seomatic.meta.seoDescription }}\",\"twitterImage\":\"{{ seomatic.meta.seoImage }}\",\"twitterImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"twitterImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"twitterImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\"}','{\"siteName\":\"Main Site\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"inherited\":[],\"overrides\":[],\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContaineropengraph\":{\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContainertwitter\":{\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaTagContainermiscellaneous\":{\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaLinkContainergeneral\":{\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[]},\"MetaScriptContainergeneral\":{\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":[],\"position\":1},\"MetaJsonLdContainergeneral\":{\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"mainEntityOfPage\":{\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.meta.mainEntityOfPage }}\",\"id\":null,\"graph\":null,\"lastReviewed\":null,\"specialty\":null,\"primaryImageOfPage\":null,\"significantLink\":null,\"reviewedBy\":null,\"mainContentOfPage\":null,\"relatedLink\":null,\"speakable\":null,\"breadcrumb\":null,\"significantLinks\":null,\"teaches\":null,\"educationalLevel\":null,\"abstract\":null,\"creativeWorkStatus\":null,\"expires\":null,\"contentReferenceTime\":null,\"material\":null,\"review\":null,\"fileFormat\":null,\"text\":null,\"translator\":null,\"award\":null,\"assesses\":null,\"copyrightNotice\":null,\"schemaVersion\":null,\"countryOfOrigin\":null,\"pattern\":null,\"accountablePerson\":null,\"funding\":null,\"educationalUse\":null,\"genre\":null,\"keywords\":null,\"position\":null,\"accessibilityHazard\":null,\"alternativeHeadline\":null,\"audience\":null,\"offers\":null,\"locationCreated\":null,\"associatedMedia\":null,\"materialExtent\":null,\"mainEntity\":null,\"copyrightHolder\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"awards\":null,\"contentLocation\":null,\"sdDatePublished\":null,\"producer\":null,\"spatial\":null,\"publisher\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"sourceOrganization\":null,\"character\":null,\"funder\":null,\"exampleOfWork\":null,\"usageInfo\":null,\"provider\":null,\"sdPublisher\":null,\"comment\":null,\"accessibilityFeature\":null,\"publication\":null,\"translationOfWork\":null,\"interactivityType\":null,\"commentCount\":null,\"accessMode\":null,\"aggregateRating\":null,\"timeRequired\":null,\"typicalAgeRange\":null,\"interactionStatistic\":null,\"copyrightYear\":\"{{ entry.postDate | date(\\\"Y\\\") }}\",\"isBasedOn\":null,\"workExample\":null,\"publishingPrinciples\":null,\"discussionUrl\":null,\"releasedEvent\":null,\"dateCreated\":false,\"workTranslation\":null,\"editor\":null,\"creditText\":null,\"recordedAt\":null,\"editEIDR\":null,\"author\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"dateModified\":\"{{ entry.dateUpdated |atom }}\",\"sponsor\":null,\"accessibilitySummary\":null,\"encodingFormat\":null,\"maintainer\":null,\"educationalAlignment\":null,\"acquireLicensePage\":null,\"isAccessibleForFree\":null,\"datePublished\":\"{{ entry.postDate |atom }}\",\"spatialCoverage\":null,\"sdLicense\":null,\"conditionsOfAccess\":null,\"correction\":null,\"contentRating\":null,\"size\":null,\"isPartOf\":null,\"temporal\":null,\"thumbnailUrl\":null,\"inLanguage\":\"{{ seomatic.meta.language }}\",\"license\":null,\"creator\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"reviews\":null,\"about\":null,\"isFamilyFriendly\":null,\"headline\":\"{{ seomatic.meta.seoTitle }}\",\"accessibilityAPI\":null,\"publisherImprint\":null,\"isBasedOnUrl\":null,\"encodings\":null,\"interpretedAsClaim\":null,\"accessibilityControl\":null,\"citation\":null,\"version\":null,\"archivedAt\":null,\"learningResourceType\":null,\"encoding\":null,\"audio\":null,\"mentions\":null,\"accessModeSufficient\":null,\"hasPart\":null,\"temporalCoverage\":null,\"contributor\":null,\"video\":null,\"mainEntityOfPage\":\"{{ seomatic.meta.canonicalUrl }}\",\"alternateName\":null,\"name\":\"{{ seomatic.meta.seoTitle }}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{{ seomatic.site.siteLinksSearchTarget }}\",\"query-input\":\"{{ seomatic.helper.siteLinksQueryInput() }}\"},\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.meta.seoImage }}\"},\"url\":\"{{ seomatic.meta.canonicalUrl }}\",\"description\":\"{{ seomatic.meta.seoDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null}}},\"MetaTitleContainergeneral\":{\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false,\"data\":{\"title\":{\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"title\":\"{{ seomatic.meta.seoTitle }}\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.siteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\"}}}}','[]','{\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false,\"data\":[]}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');
/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sherlock`
--

LOCK TABLES `sherlock` WRITE;
/*!40000 ALTER TABLE `sherlock` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sherlock` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Main Site (En+Fr)','2022-11-16 06:42:06','2022-11-16 06:42:06',NULL,'bcb40c76-f64f-408f-b1da-edb455b3588d');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'1','Main Site','english','en-CA',1,'@web/',2,'2022-11-16 06:42:06','2022-11-16 06:42:39',NULL,'41b193c3-f554-4c48-8c8a-7ac2645f083f'),(2,1,0,'0','Main Site (FRENCH)','french','fr-CA',1,'@web',1,'2022-11-16 06:42:06','2022-11-16 06:42:06',NULL,'34463b82-dd3f-441c-b9c6-59c351e847aa');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sprig_playgrounds`
--

LOCK TABLES `sprig_playgrounds` WRITE;
/*!40000 ALTER TABLE `sprig_playgrounds` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sprig_playgrounds` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `stc_1_items`
--

LOCK TABLES `stc_1_items` WRITE;
/*!40000 ALTER TABLE `stc_1_items` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `stc_1_items` VALUES (1,197,1,'2022-11-17 05:12:52','2022-11-17 05:12:52','9aa2b42a-a097-4ca8-8c78-828a88e376ce',NULL,NULL),(2,199,1,'2022-11-17 05:15:16','2022-11-17 05:15:16','157478d4-1bdc-4b60-9626-bb0a96f50a36',NULL,NULL),(3,201,1,'2022-11-17 05:15:22','2022-11-17 05:15:22','371e24dc-8bdf-4e6f-a033-8f387af309d4',NULL,NULL),(5,204,1,'2022-11-17 05:17:35','2022-11-17 05:17:35','052a0de0-cd22-43c0-8069-9b6af68165f7',NULL,NULL),(7,209,1,'2022-11-17 05:23:30','2022-11-17 05:23:30','7f399d7a-b1d6-47e2-b114-5c4b62755cfa',NULL,NULL),(8,211,1,'2022-11-17 05:23:34','2022-11-17 05:23:34','8e56a200-37b3-43e7-9d9c-359ac0f1d795',NULL,NULL),(9,212,1,'2022-11-17 05:23:34','2022-11-17 05:23:34','85889d41-ca6b-4f93-abf4-3904cef167d2',NULL,NULL),(10,214,1,'2022-11-17 05:23:40','2022-11-17 05:23:40','ce241bad-3716-4fb0-ac9b-4f7aaf304439',NULL,NULL),(11,225,1,'2022-11-17 05:24:09','2022-11-17 05:24:09','0c895d6d-e400-472e-8cb5-6548b6719596',NULL,NULL),(13,242,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','f97df703-ef77-4411-ae55-de1eaf24bec9',NULL,NULL),(14,246,1,'2022-11-17 06:09:47','2022-11-17 06:09:47','36247ca3-17a2-4fe9-ba5e-0f81d3625320',NULL,NULL);
/*!40000 ALTER TABLE `stc_1_items` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structureelements` VALUES (1,1,NULL,1,1,10,0,'2022-11-16 06:48:22','2022-11-16 09:56:14','be7d930b-d5e2-4f61-bd94-d94817a753c3'),(2,1,17,1,2,3,1,'2022-11-16 06:48:22','2022-11-16 06:48:22','f07054d2-971b-4e23-b3b9-4a3ad62f5157'),(3,1,19,1,4,5,1,'2022-11-16 06:48:39','2022-11-16 06:48:39','8959db31-40c6-4691-9536-51a11d97075f'),(4,1,28,1,6,7,1,'2022-11-16 06:50:23','2022-11-16 06:50:23','6883d68d-dce1-4818-b0dc-fe69032b2c05'),(5,1,38,1,8,9,1,'2022-11-16 09:56:14','2022-11-16 09:56:14','abf9fd6b-4d41-4d04-8b63-f8951f7baeb7'),(6,6,NULL,6,1,6,0,'2022-11-16 09:57:13','2022-11-16 09:57:18','596a7630-84b6-4f46-8cc9-60aae889c62e'),(7,6,42,6,2,3,1,'2022-11-16 09:57:13','2022-11-16 09:57:13','afa8f45b-96e9-453f-be7a-87404d01c6fa'),(8,6,43,6,4,5,1,'2022-11-16 09:57:18','2022-11-16 09:57:18','e9fc721d-227b-4b43-8744-2e8504676e9e'),(9,5,NULL,9,1,8,0,'2022-11-16 09:57:31','2022-11-16 09:57:36','97e10b64-cd8f-4e51-8415-f7eb412e85aa'),(10,5,44,9,2,3,1,'2022-11-16 09:57:31','2022-11-16 09:57:31','a52592a4-4419-41fd-b78b-96bb29c7f61e'),(11,5,45,9,4,5,1,'2022-11-16 09:57:34','2022-11-16 09:57:34','883c31bc-b936-446e-9cd7-66b47e03cea5'),(12,5,46,9,6,7,1,'2022-11-16 09:57:36','2022-11-16 09:57:36','edc33d03-c30b-4798-b169-43fceb08f1c6');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structures` VALUES (1,NULL,'2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'0f9bddc9-659f-4907-82a2-028748c7f504'),(2,NULL,'2022-11-16 06:42:25','2022-11-16 06:42:25',NULL,'d5688cfd-6a2b-4609-bc18-7e1f0c00426f'),(3,NULL,'2022-11-16 06:42:25','2022-11-16 06:42:25','2022-11-16 09:54:37','d38282dc-c747-4b18-9cc3-81089a42e2b7'),(4,NULL,'2022-11-16 06:42:25','2022-11-16 06:42:25','2022-11-16 09:54:35','4fe70de7-32cb-4d01-b895-5bb4b2f49d08'),(5,2,'2022-11-16 09:55:23','2022-11-16 09:55:23',NULL,'73e32a07-4773-48cf-94f7-6cfc39f43331'),(6,1,'2022-11-16 09:56:02','2022-11-16 09:56:02',NULL,'6af44de4-c664-467a-aa7e-ebae66b83613');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `supertableblocks`
--

LOCK TABLES `supertableblocks` WRITE;
/*!40000 ALTER TABLE `supertableblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `supertableblocks` VALUES (197,196,23,1,1,'2022-11-17 05:12:52','2022-11-17 05:12:52'),(199,198,23,1,1,'2022-11-17 05:15:16','2022-11-17 05:15:16'),(201,200,23,1,1,'2022-11-17 05:15:22','2022-11-17 05:15:22'),(209,208,23,1,1,'2022-11-17 05:23:30','2022-11-17 05:23:30'),(211,210,23,1,1,'2022-11-17 05:23:34','2022-11-17 05:23:34'),(212,210,23,1,1,'2022-11-17 05:23:34','2022-11-17 05:23:34'),(214,213,23,1,1,'2022-11-17 05:23:40','2022-11-17 05:23:40'),(242,216,23,1,1,'2022-11-17 06:09:47','2022-11-17 06:09:47'),(246,245,23,1,NULL,'2022-11-17 06:09:47','2022-11-17 06:09:47');
/*!40000 ALTER TABLE `supertableblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `supertableblocks_owners`
--

LOCK TABLES `supertableblocks_owners` WRITE;
/*!40000 ALTER TABLE `supertableblocks_owners` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `supertableblocks_owners` VALUES (197,196,1),(199,198,1),(201,200,1),(209,208,1),(211,210,1),(212,210,2),(214,213,1),(242,216,1),(246,245,1);
/*!40000 ALTER TABLE `supertableblocks_owners` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `supertableblocktypes`
--

LOCK TABLES `supertableblocktypes` WRITE;
/*!40000 ALTER TABLE `supertableblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `supertableblocktypes` VALUES (1,23,11,'2022-11-16 06:42:28','2022-11-16 06:42:28','d5468b8f-24c2-45c5-a377-ac0da764cbb1');
/*!40000 ALTER TABLE `supertableblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `usergroups` VALUES (1,'Content Editor','contentEditor',NULL,'2022-11-16 06:42:37','2022-11-16 06:42:37','a9eefedb-b175-4baa-a9ee-903aa94e9c9b'),(2,'Site Owner','siteOwner',NULL,'2022-11-16 06:42:37','2022-11-16 06:42:37','e511df66-41ea-4d8f-bfa5-538fec0fc45f'),(3,'SEO Editor','seoEditor',NULL,'2022-11-16 06:42:37','2022-11-16 06:42:37','43406218-0e65-4e33-bd0a-df130a7d2e6c');
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpermissions` VALUES (1,'accesscp','2022-11-16 06:42:37','2022-11-16 06:42:37','8bcd208c-8fd2-4650-8fc7-08454c034d3c'),(2,'accesscpwhensystemisoff','2022-11-16 06:42:37','2022-11-16 06:42:37','0654fe44-1cf5-40c7-a668-aa127333953e'),(3,'accessplugin-redirect','2022-11-16 06:42:37','2022-11-16 06:42:37','af36e8d7-11a7-4394-8f0f-e3f52d93c480'),(4,'accesssitewhensystemisoff','2022-11-16 06:42:37','2022-11-16 06:42:37','da6bab90-c799-43da-a323-f936d8a60ddb'),(5,'allowsitebook','2022-11-16 06:42:37','2022-11-16 06:42:37','74ebc966-ea9f-45f6-ad91-5e862e9e8c66'),(6,'createentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:37','2022-11-16 06:42:37','8e44647c-688e-4364-a9a7-15cac9c07d72'),(7,'createentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:37','2022-11-16 06:42:37','ac5888b6-e47a-4839-b7fe-b7763c241a01'),(8,'createentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-11-16 06:42:37','2022-11-16 06:42:37','229301ee-3a0a-4798-ad91-c2707007c638'),(9,'createentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:37','2022-11-16 06:42:37','4410a686-6669-4737-9e3a-39cce4b7cb48'),(10,'createfolders:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:37','2022-11-16 06:42:37','fb18e6cc-ce05-4991-9db3-fbb9afd5d82a'),(11,'createfolders:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:37','2022-11-16 06:42:37','8bd50b2d-4fbb-4364-8e36-3e86b45e2c9a'),(12,'deleteassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:37','2022-11-16 06:42:37','15810c03-a636-4b67-8010-6b886abf1a25'),(13,'deleteassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:37','2022-11-16 06:42:37','a8f40942-4258-4bac-aebc-70218792bc4f'),(14,'deleteentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:37','2022-11-16 06:42:37','0fc238cb-d439-441a-bbf0-76585ae4d9fa'),(15,'deleteentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:38','2022-11-16 06:42:38','61656440-bae2-4553-95ba-a3caa0ab0ebc'),(16,'deleteentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-11-16 06:42:38','2022-11-16 06:42:38','05c48583-4f32-4e61-9763-719b7a448488'),(17,'deleteentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:38','2022-11-16 06:42:38','52d86ee4-0f62-4320-9b3a-094369cdf6ee'),(18,'deletepeerassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:38','2022-11-16 06:42:38','e8ab4498-26ed-4ef3-b863-c852f5c9bb81'),(19,'deletepeerentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:38','2022-11-16 06:42:38','53f84b55-adc7-4de9-8eb3-8afe6bf26f71'),(20,'deletepeerentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:38','2022-11-16 06:42:38','8362ed79-dcf6-4490-bcdc-333fec4aa4bb'),(21,'deletepeerentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:38','2022-11-16 06:42:38','7226efa1-32d6-4d04-91f0-1d64d4138ad0'),(22,'deletepeerentrydrafts:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-11-16 06:42:38','2022-11-16 06:42:38','7ca74854-4786-48ad-a48e-1cb29a799cdc'),(23,'deletepeerentrydrafts:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:38','2022-11-16 06:42:38','b86df741-e111-4fb3-9100-4c5b0c035310'),(24,'deletepeerentrydrafts:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-11-16 06:42:38','2022-11-16 06:42:38','57a07fe3-f1be-4e66-bd05-7c581aea732f'),(25,'deletepeerentrydrafts:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:38','2022-11-16 06:42:38','4f41e6b1-4ca2-4785-b849-cf6f10ad833f'),(26,'deletepeerentrydrafts:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-11-16 06:42:38','2022-11-16 06:42:38','94239060-f1fe-4d41-8093-8329c11a1e32'),(27,'deletepeerentrydrafts:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-11-16 06:42:38','2022-11-16 06:42:38','7be75db4-1146-4c0e-81de-8c4605389199'),(28,'deletepeerentrydrafts:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:38','2022-11-16 06:42:38','7e8fad37-3195-46e7-aa14-813c4ccc2422'),(29,'editimages:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:38','2022-11-16 06:42:38','dbcd0648-a944-4423-9fea-5b780d706706'),(30,'editimages:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:38','2022-11-16 06:42:38','22e8a38f-1b4e-4e23-92e6-e740cf49e380'),(31,'editpeerimages:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:38','2022-11-16 06:42:38','873353cd-ee63-4b85-b352-6c06bc160a00'),(32,'editpeerimages:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:38','2022-11-16 06:42:38','ef81d9fc-76c1-418e-aac6-81220cd48f85'),(33,'editsite:34463b82-dd3f-441c-b9c6-59c351e847aa','2022-11-16 06:42:38','2022-11-16 06:42:38','139cbc0b-c97a-4c7d-a369-b893d292df2e'),(34,'replacefiles:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:38','2022-11-16 06:42:38','e9e604ac-91cd-4382-b8bc-9e5156e3f5ce'),(35,'replacefiles:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:38','2022-11-16 06:42:38','c428ea10-73e0-4da0-a289-6587c201deda'),(36,'replacepeerfiles:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:38','2022-11-16 06:42:38','c8f40ff7-6c3b-4ae1-a462-59ea08cae624'),(37,'replacepeerfiles:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:38','2022-11-16 06:42:38','9108ad81-023c-4b54-9ded-44a5d5010f88'),(38,'saveassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:38','2022-11-16 06:42:38','b72a519c-1b76-4e5b-b27d-d8e9a8ad3059'),(39,'saveassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:38','2022-11-16 06:42:38','8dbd5190-dbf2-4de5-9607-f4c9a2e5e600'),(40,'saveentries:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-11-16 06:42:38','2022-11-16 06:42:38','bbe651e1-00aa-4a5d-83ca-198128bb3614'),(41,'saveentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:38','2022-11-16 06:42:38','aeeef838-86ce-4f39-b24e-1160ce90836e'),(42,'saveentries:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-11-16 06:42:38','2022-11-16 06:42:38','e7a8af25-8bc0-400b-82e1-7411c0a28635'),(43,'saveentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:38','2022-11-16 06:42:38','179c049e-e27e-44a8-809c-aaca9a44333f'),(44,'saveentries:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-11-16 06:42:38','2022-11-16 06:42:38','c04ff69e-578d-4e11-a9fa-4288be288358'),(45,'saveentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-11-16 06:42:38','2022-11-16 06:42:38','8a57904c-e4d8-487c-aa0c-15d1675265fb'),(46,'saveentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:38','2022-11-16 06:42:38','29c81535-1034-4cf1-bf36-d4070c47e852'),(47,'savepeerassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:38','2022-11-16 06:42:38','a1b81cef-2ea9-45c2-862c-14683e91b113'),(48,'savepeerassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:38','2022-11-16 06:42:38','4e046335-07c8-44fe-a18e-4b25bef39f63'),(49,'savepeerentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:38','2022-11-16 06:42:38','36b8bc59-37d1-4e14-9580-e816222fad6f'),(50,'savepeerentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:38','2022-11-16 06:42:38','249e5d1a-1f50-4273-a239-0ee33c7e34c3'),(51,'savepeerentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-11-16 06:42:38','2022-11-16 06:42:38','18647071-c9d9-43ac-8cdf-e22c30e69609'),(52,'savepeerentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:38','2022-11-16 06:42:38','21c84ac9-e887-4541-901f-188abd317702'),(53,'savepeerentrydrafts:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-11-16 06:42:38','2022-11-16 06:42:38','3142e698-48e2-4567-9910-e1a830ad6594'),(54,'savepeerentrydrafts:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:38','2022-11-16 06:42:38','4a3d6510-4041-4844-803b-5b04a6bf5807'),(55,'savepeerentrydrafts:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-11-16 06:42:38','2022-11-16 06:42:38','566a9706-d642-466d-8acc-74106ee0cf00'),(56,'savepeerentrydrafts:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:38','2022-11-16 06:42:38','43c0c084-f20f-48a1-ad7d-4b4baec0f74f'),(57,'savepeerentrydrafts:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-11-16 06:42:38','2022-11-16 06:42:38','f201ce30-c898-4b24-a53c-bf842b35ed18'),(58,'savepeerentrydrafts:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-11-16 06:42:38','2022-11-16 06:42:38','d42ced92-b9ec-41a8-af7d-23cb9be45f8c'),(59,'savepeerentrydrafts:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:38','2022-11-16 06:42:38','efd31074-09b5-4819-ad62-0b5c4fd1c371'),(60,'utility:clear-caches','2022-11-16 06:42:38','2022-11-16 06:42:38','935a5b2f-6f28-44a7-a094-e76ed36cde18'),(61,'viewassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:38','2022-11-16 06:42:38','002c82d2-7332-4ee3-bad8-9c300630a01c'),(62,'viewassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:38','2022-11-16 06:42:38','8685b812-0494-402d-b87a-19cd56b4b4b1'),(63,'viewentries:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-11-16 06:42:38','2022-11-16 06:42:38','0192f2d8-3d1e-446f-851b-a5ffad46a562'),(64,'viewentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:38','2022-11-16 06:42:38','3812bda8-cd37-4e53-8485-feea8f176412'),(65,'viewentries:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-11-16 06:42:38','2022-11-16 06:42:38','38046422-e855-4234-93c8-4a290f8b180a'),(66,'viewentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:38','2022-11-16 06:42:38','f4f1ea7d-57b2-438e-9ce1-58f9f063c986'),(67,'viewentries:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-11-16 06:42:38','2022-11-16 06:42:38','e345fc7b-7fcc-4e42-a1e6-195b04673166'),(68,'viewentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-11-16 06:42:38','2022-11-16 06:42:38','43a74ad3-d855-4e85-9a41-a03a010c7101'),(69,'viewentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:38','2022-11-16 06:42:38','797f54ce-583b-4f6b-98b6-54708cce5bf1'),(70,'viewpeerassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-11-16 06:42:38','2022-11-16 06:42:38','2d1d4785-d445-461a-a9fd-5f21aacdb86a'),(71,'viewpeerassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-11-16 06:42:38','2022-11-16 06:42:38','0576da91-c976-422e-a512-65ca03b515e2'),(72,'viewpeerentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:38','2022-11-16 06:42:38','724f0b2c-7cda-42d4-8bac-3f60a5e272fb'),(73,'viewpeerentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:38','2022-11-16 06:42:38','1249b51b-99b3-4b28-88c7-a8ab9761ff31'),(74,'viewpeerentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-11-16 06:42:38','2022-11-16 06:42:38','4fd1f2e6-006b-4bc5-bdf1-7c110d203724'),(75,'viewpeerentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:38','2022-11-16 06:42:38','cfe2be18-f698-4d4f-ac5f-d4a2b1cdf0b8'),(76,'viewpeerentrydrafts:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-11-16 06:42:38','2022-11-16 06:42:38','e1921a94-9273-4686-b165-852936b19548'),(77,'viewpeerentrydrafts:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-11-16 06:42:38','2022-11-16 06:42:38','464bed16-a439-4822-8e08-d559cfb1f69b'),(78,'viewpeerentrydrafts:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-11-16 06:42:38','2022-11-16 06:42:38','9e8390cf-23dc-4a25-9a53-ed882c869424'),(79,'viewpeerentrydrafts:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-11-16 06:42:38','2022-11-16 06:42:38','1120cb9c-8564-4425-9ae8-91d16d54a352'),(80,'viewpeerentrydrafts:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-11-16 06:42:38','2022-11-16 06:42:38','be6da021-6416-4ac6-9e84-352f933c2f57'),(81,'viewpeerentrydrafts:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-11-16 06:42:38','2022-11-16 06:42:38','731f58ba-0c61-4ba9-a933-553a882aa0dd'),(82,'viewpeerentrydrafts:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-11-16 06:42:38','2022-11-16 06:42:38','6ac6002f-4860-42ae-b022-154ee98f6385'),(83,'administrateusers','2022-11-16 06:42:38','2022-11-16 06:42:38','39af31d3-9296-463c-ab56-06503356ae48'),(84,'assignusergroup:a9eefedb-b175-4baa-a9ee-903aa94e9c9b','2022-11-16 06:42:38','2022-11-16 06:42:38','84d6952a-d53f-4da9-9c8a-00937d15635d'),(85,'assignusergroup:e511df66-41ea-4d8f-bfa5-538fec0fc45f','2022-11-16 06:42:38','2022-11-16 06:42:38','f81ac1ba-55ec-4334-a6c8-7f7de6a3d057'),(86,'assignuserpermissions','2022-11-16 06:42:38','2022-11-16 06:42:38','e5f3fb3f-5b48-489c-81b3-aeb60cdf6377'),(87,'deleteusers','2022-11-16 06:42:38','2022-11-16 06:42:38','4e65e2d0-c493-4824-aacc-09c67da377b9'),(88,'editusers','2022-11-16 06:42:38','2022-11-16 06:42:38','2e31e64e-93f2-4ba5-847e-432bf2c46a94'),(89,'impersonateusers','2022-11-16 06:42:38','2022-11-16 06:42:38','03bd2247-d3cc-4524-90a9-cb6e5bdb941f'),(90,'moderateusers','2022-11-16 06:42:38','2022-11-16 06:42:38','c02212e8-1897-43c9-be4c-935dacd773dc'),(91,'registerusers','2022-11-16 06:42:38','2022-11-16 06:42:38','79dbdbd6-c1ad-43b5-a6e7-c2ec4811d858'),(92,'utility:asset-indexes','2022-11-16 06:42:38','2022-11-16 06:42:38','b3f01ad0-083a-4080-859f-43c04bda79e2'),(93,'utility:db-backup','2022-11-16 06:42:38','2022-11-16 06:42:38','1ea81ce6-36c9-4496-a4fb-3c995f9d536a'),(94,'utility:deprecation-errors','2022-11-16 06:42:38','2022-11-16 06:42:38','283f38cd-5b8d-447d-a048-f9e146cb04c5'),(95,'utility:php-info','2022-11-16 06:42:38','2022-11-16 06:42:38','48a1d6a3-0683-4a5b-9a2b-fb39b9e6c9e8'),(96,'utility:queue-manager','2022-11-16 06:42:38','2022-11-16 06:42:38','268f2513-a262-465c-bb80-106355d7d19e'),(97,'utility:system-messages','2022-11-16 06:42:38','2022-11-16 06:42:38','e9ded72d-cc1a-438b-b3e0-e86107eafd4d'),(98,'utility:system-report','2022-11-16 06:42:38','2022-11-16 06:42:38','a1dc5ea2-886d-4c68-8fd0-9a0096aaf431'),(99,'accessplugin-seomatic','2022-11-16 06:42:38','2022-11-16 06:42:38','de4c136d-90d8-4268-9ce2-d25232568ce2'),(100,'seomatic:content-meta','2022-11-16 06:42:38','2022-11-16 06:42:38','0c74e36b-98a8-42cd-98d1-c47168d1b2cf'),(101,'seomatic:content-meta:facebook','2022-11-16 06:42:38','2022-11-16 06:42:38','54099527-d58c-4f06-a2d7-2b4a66046a39'),(102,'seomatic:content-meta:general','2022-11-16 06:42:38','2022-11-16 06:42:38','754aeb55-66d4-47e5-8afb-3ba41f507288'),(103,'seomatic:content-meta:sitemap','2022-11-16 06:42:38','2022-11-16 06:42:38','5d2e2756-d108-4cdc-b30b-c643558be3c3'),(104,'seomatic:content-meta:twitter','2022-11-16 06:42:38','2022-11-16 06:42:38','5f009984-a227-4272-aa23-4f0c52288d11'),(105,'seomatic:dashboard','2022-11-16 06:42:38','2022-11-16 06:42:38','2ab4eab5-9a75-4966-96c9-17f1164077a0'),(106,'seomatic:global-meta','2022-11-16 06:42:38','2022-11-16 06:42:38','03d1f554-f54d-4776-a742-a3d060ed8eec'),(107,'seomatic:global-meta:ads','2022-11-16 06:42:38','2022-11-16 06:42:38','a62d57c1-9f39-4b4b-a90b-b14eb324869b'),(108,'seomatic:global-meta:facebook','2022-11-16 06:42:38','2022-11-16 06:42:38','fc9311d6-566e-4c0d-912f-01bf77ab894a'),(109,'seomatic:global-meta:general','2022-11-16 06:42:38','2022-11-16 06:42:38','ea0dcb32-82d3-4eaf-b4f4-d8b1f4dca3a8'),(110,'seomatic:global-meta:humans','2022-11-16 06:42:38','2022-11-16 06:42:38','9311c410-4245-498e-8ca4-60503cc8eb37'),(111,'seomatic:global-meta:robots','2022-11-16 06:42:38','2022-11-16 06:42:38','bbb2cc12-107a-4282-a241-ef64208e6cf6'),(112,'seomatic:global-meta:security','2022-11-16 06:42:38','2022-11-16 06:42:38','032d4158-a072-49ff-a0b7-6aa286f7a444'),(113,'seomatic:global-meta:twitter','2022-11-16 06:42:38','2022-11-16 06:42:38','35ecbf6c-a483-4fd0-94a3-b22953d4e992'),(114,'seomatic:plugin-settings','2022-11-16 06:42:38','2022-11-16 06:42:38','85c0da35-d5ad-40eb-9404-bb6ba75ca9e6'),(115,'seomatic:site-settings','2022-11-16 06:42:38','2022-11-16 06:42:38','0b06e7ea-8f26-4831-b832-52d4099f4b60'),(116,'seomatic:site-settings:creator','2022-11-16 06:42:38','2022-11-16 06:42:38','6f9caed8-fa65-4806-b36f-93562da7364e'),(117,'seomatic:site-settings:identity','2022-11-16 06:42:38','2022-11-16 06:42:38','e17531c9-c42b-4ded-a3c0-d832ae171f30'),(118,'seomatic:site-settings:miscellaneous','2022-11-16 06:42:38','2022-11-16 06:42:38','36050df4-4948-4ecc-b0da-5b7daaf51818'),(119,'seomatic:site-settings:sitemap','2022-11-16 06:42:38','2022-11-16 06:42:38','529d6f70-11da-4c9b-8d96-549a5e1df086'),(120,'seomatic:site-settings:social','2022-11-16 06:42:38','2022-11-16 06:42:38','6e7c6440-2e60-48d3-9cbc-1aec051ce739'),(121,'seomatic:tracking-scripts','2022-11-16 06:42:38','2022-11-16 06:42:38','b881caf1-e174-4723-9223-4081a8d1e016'),(122,'seomatic:tracking-scripts:facebookpixel','2022-11-16 06:42:38','2022-11-16 06:42:38','f1c49dd6-b7fd-45a2-b131-f95a0ce138a2'),(123,'seomatic:tracking-scripts:fathom','2022-11-16 06:42:38','2022-11-16 06:42:38','4a566966-ee7e-451e-a513-605956f6d639'),(124,'seomatic:tracking-scripts:googleanalytics','2022-11-16 06:42:38','2022-11-16 06:42:38','9758a534-2e1f-4542-8c4d-52a05702f299'),(125,'seomatic:tracking-scripts:googletagmanager','2022-11-16 06:42:38','2022-11-16 06:42:38','b4c088f2-7ac6-40a2-86ac-abd14fc6ad4f'),(126,'seomatic:tracking-scripts:gtag','2022-11-16 06:42:38','2022-11-16 06:42:38','19b42615-aadd-499b-8392-60975eaddd9e'),(127,'seomatic:tracking-scripts:hubspot','2022-11-16 06:42:38','2022-11-16 06:42:38','e5e27780-169f-4743-b8f7-da719c9d5614'),(128,'seomatic:tracking-scripts:linkedininsight','2022-11-16 06:42:38','2022-11-16 06:42:38','bfcee105-d2c6-4bb0-a054-f78d129ebf3c'),(129,'seomatic:tracking-scripts:matomo','2022-11-16 06:42:38','2022-11-16 06:42:38','b8312bed-2464-466c-96d3-75edd9e5cc90'),(130,'seomatic:tracking-scripts:pinteresttag','2022-11-16 06:42:38','2022-11-16 06:42:38','2599fa98-5a40-4b34-a8d2-ac2e404e07fa'),(131,'seomatic:tracking-scripts:plausible','2022-11-16 06:42:38','2022-11-16 06:42:38','5757ad24-7cba-43fb-8dc8-fd1ef54495c9');
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpermissions_usergroups` VALUES (83,1,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','1c3d9651-dfef-45a4-88c3-9757ad250b87'),(84,2,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','b736c67e-dfb5-4a00-840a-1231f1402e1f'),(85,3,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','65504cdb-3cfe-412b-a9a0-93d73a2b284b'),(86,4,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','dac029e3-bf8e-41f5-8974-bfcd36d2e1a2'),(87,5,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','99d85c3e-5c8c-401f-9d26-b4bcbcd98937'),(88,6,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','4fd17a0b-db2b-4e2a-ae49-956e5c6bd418'),(89,7,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','6ca88d66-3bfe-406b-a467-7f0f9712ec35'),(90,8,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','ad443b21-de06-495f-956e-315f03c30858'),(91,9,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','b96ff28b-fdb3-494c-9c29-2ab90db5317f'),(92,10,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','f121da8d-e9b9-46bc-84c3-3c7d9bf8e8ad'),(93,11,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','0d6954d6-c903-4031-8b41-bf8609cfdb79'),(94,12,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','a9a6079e-8b4b-4d92-ade8-f66a347ceb2b'),(95,13,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','94331cec-4f30-4106-9e39-49c138271983'),(96,14,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','6b491853-4f6f-47a0-9250-a9bb12eb0ea2'),(97,15,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','c4f15692-2015-402f-b965-833f13ba4613'),(98,16,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','2a4c5135-8eea-4c18-ab21-98d46780e9db'),(99,17,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','699b2618-a90a-459d-8a4f-1571116f215f'),(100,18,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','3d7ad921-3b79-415b-8ce9-121e7dcf9fa2'),(101,19,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','790e7734-5e23-43f5-9365-21658c7e8c22'),(102,20,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','bafeeac5-2be0-46bd-a96b-d45db9913b87'),(103,21,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','b0a7094b-083a-4334-9443-9f2bb638a67d'),(104,22,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','915de8ea-57b6-458c-8080-985b53980e1f'),(105,23,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','7390bede-4de2-4f6d-83f5-11215794f118'),(106,24,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','2a12d24a-30f5-4d08-a7a2-7a27f81d1161'),(107,25,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','b7c23efb-5204-4d60-a700-3eab10da0db3'),(108,26,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','5932289f-257f-44cf-87d5-6e3e78fd0a0f'),(109,27,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','c4331803-3b1d-4396-a033-4ccaa29d3254'),(110,28,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','94ca17f8-da9f-4804-9579-7beb3363bade'),(111,29,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','038a801e-7f7c-4318-8a70-446e64250458'),(112,30,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','12d40c02-2e4c-4459-afdf-b51c1d50a626'),(113,31,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','13013b82-1c20-4b8c-9419-cd787bbfd0c6'),(114,32,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','47b026ec-b6b7-463d-8128-dede190c6c59'),(115,33,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','790e9870-915e-4aff-aec3-3bec465faf3f'),(116,34,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','130b8d51-3c75-4bbc-b58b-311b69f8c7c4'),(117,35,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','dd01bb4e-9bed-4041-9818-a427bd8a143f'),(118,36,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','e24c73ac-0cfd-4709-bf88-02217e1e3c1f'),(119,37,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','66b12e88-d943-41d1-8d85-4cf09fad827b'),(120,38,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','edff429a-5881-4d96-9dcd-45907f587368'),(121,39,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','70054ced-6645-4c73-837f-fe8efba128a7'),(122,40,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','489282a3-9095-4997-8b98-6482f9e783d9'),(123,41,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','4790f054-c7a5-49c7-a162-cf65b99132d0'),(124,42,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','720ab352-6ea3-4c2e-a616-04e7f6cc3e0e'),(125,43,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','280597b4-587c-4534-a3c7-e6d75990b941'),(126,44,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','82cdef59-fb52-459b-b351-18a91f2d9091'),(127,45,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','0837c0e8-6c8e-4441-adf6-77f21f832c73'),(128,46,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','7b5c0a67-012a-416c-a19b-56cbba75de16'),(129,47,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','83a2bf6b-b137-4c37-b582-85db0e53331a'),(130,48,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','24493c09-b679-46f7-aab1-a7f72be2c967'),(131,49,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','89a1d3e6-6584-4f40-8e91-131ef60e9d1f'),(132,50,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','e4a9ae84-d883-4e62-92e3-bcac001d852f'),(133,51,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','495ed376-2590-4b9c-8591-4c5e81ced359'),(134,52,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','1a539548-8eb3-47f8-bfda-5f9c9754fd45'),(135,53,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','4721e716-9575-4213-ae54-ac1bd1153563'),(136,54,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','fe1d5416-fe8d-4e12-aa47-d813b96ace47'),(137,55,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','fb9ded60-d547-4fd0-b624-7a3cd2ec79db'),(138,56,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','370ad125-cd54-4d5a-a076-5f76d3c5939e'),(139,57,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','7f9c6589-bb26-41ee-989a-0fbae491b31c'),(140,58,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','10bde3af-0b9f-41d5-9d98-b3fc0e65b244'),(141,59,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','caab0e7a-2a0d-4aea-ae51-f8bba6f9ba41'),(142,60,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','be04f88e-8ebf-4d6d-a5bd-8b7b7fd990dc'),(143,61,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','373ba3a4-1682-4fd6-9082-1d193951cbcb'),(144,62,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','bd638f5e-ecd8-4e5f-b707-3ae8200c94c8'),(145,63,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','9697988b-1558-4f5d-ad35-ac3f1295ac64'),(146,64,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','3dd477e0-ce29-47c3-9497-d9a7ccea86aa'),(147,65,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','f259b48c-b76f-457d-bbe1-6751f5aa4502'),(148,66,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','a5627d14-ba72-402f-82dd-df395a3c420b'),(149,67,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','275cfb8f-ad3a-4057-bcf1-83b73f0704b9'),(150,68,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','b6a5b625-5b9e-40e4-88aa-7dfd21fa3d52'),(151,69,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','9a80fe8c-36f4-4110-b6e2-7b1efe301063'),(152,70,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','80cad84c-c6ef-4fb6-8a2d-ff536fe0c579'),(153,71,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','202fe846-33ea-490c-be17-4cfd70a76b6a'),(154,72,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','f46b1b7b-4d96-40c3-bd60-3ccfc85c5244'),(155,73,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','51ce3566-0abd-4b3d-9321-fd63cc562be9'),(156,74,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','d82d2871-7a50-4780-bd68-3042be705c7c'),(157,75,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','0721de34-e5b9-488a-9195-b52fb033ed21'),(158,76,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','37a67933-eec6-423a-a420-529b316f9e43'),(159,77,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','36adc977-dfc6-4334-afeb-e7544f3077fc'),(160,78,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','7e6e5672-483a-47ba-b8ad-cf5f26abde88'),(161,79,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','eff901c4-db93-4aa6-bc11-5072274cf8cb'),(162,80,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','ac8bc730-e971-46c5-b54a-f0c3a4b2ac4a'),(163,81,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','c5df9f01-6d2b-4550-9f28-a9562039ef53'),(164,82,1,'2022-11-16 06:42:38','2022-11-16 06:42:38','29855638-a364-4a6e-9faf-cf9c0eb52ef0'),(187,1,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','5bc14315-70b7-408e-a82f-923e44ef3ad6'),(188,2,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','9af8386c-8c09-4038-b30a-97fdeb31ff8d'),(189,4,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','7204e458-e1c0-4ae3-a06d-dd3f8c669a00'),(190,83,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','0515726b-8da1-4a9f-a47a-f1871fc3e7a4'),(191,5,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','9c42bbd2-dcb0-4b42-82c5-203503610c6d'),(192,84,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','16fa1dee-5826-4b8a-828c-31afce8c5f55'),(193,85,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','303fc47c-e9d8-468b-9378-2ebb39fcd3f4'),(194,86,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','85a862c0-f35b-44e8-9532-2621b6d09ecf'),(195,87,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','ee025d03-d5ce-4e7b-845b-de7dbfc3c66c'),(196,33,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','b97f0ea7-7fc0-41f0-b1f5-dcbc804a830c'),(197,88,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','7cacf433-83ce-4df2-8067-c2d592828654'),(198,89,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','b500c997-0fdb-46a9-874e-eaab9147500b'),(199,90,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','2f28df49-fa53-4fdc-9491-502b8eb254c0'),(200,91,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','0766b966-4f5d-4c05-95af-895274263f99'),(201,92,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','341b35cb-f4af-4060-aaba-30e5a5b93bc6'),(202,60,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','bac7f118-2f62-4b57-a11f-f959adf90323'),(203,93,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','bb0db9be-b578-4d96-8549-0140bdff95c9'),(204,94,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','5c146f7e-b2ab-4b65-952f-9a7fd79e863f'),(205,95,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','82b4f42b-6aa6-49e0-bcbf-40b2dffa9fe2'),(206,96,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','fbc0aaa9-e061-465a-8128-4ce3eec01388'),(207,97,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','f9e2a8ed-db73-421d-9793-d7da344098e4'),(208,98,2,'2022-11-16 06:42:38','2022-11-16 06:42:38','176c5737-3d29-4988-a512-bec90500ed07'),(245,1,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','ddee7756-fada-4898-a0c3-90b2c24b2746'),(246,99,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','9ce914e3-32e5-4f67-8526-0d416da1b274'),(247,4,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','2f2650c8-d47c-4f0b-b5a8-c1aa76cef743'),(248,5,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','bf4b83c3-5437-4402-88c2-e87c15eac3ab'),(249,100,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','01c5be16-2b77-41b9-9efc-a26bb07f18c5'),(250,101,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','d8bdcd08-8624-466e-9c0b-1c103096698a'),(251,102,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','4a19182f-1faf-49ed-82df-1ca6acbc9155'),(252,103,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','90c82593-ad4d-44e6-9ab5-35c4f2193467'),(253,104,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','6f08dbbf-b5ad-4ded-980d-49591fe4cf70'),(254,105,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','e3dbf39a-82d6-4de2-b04f-ad6eabd08b43'),(255,106,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','faa5c5bc-5f44-40b2-ad8c-de75c2e74c69'),(256,107,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','ff752eee-1a1d-4b35-a989-95e859c2a477'),(257,108,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','73ea70fd-93f4-402d-9c0c-e3523f7b8a4f'),(258,109,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','b04194a6-3e1f-47c2-8487-b5e0b2c6d4cd'),(259,110,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','b106ccd5-5194-4bbf-8726-888497539a1e'),(260,111,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','20324fb2-380c-4b71-b513-38126cbd8d27'),(261,112,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','57abbd20-68ed-41c0-9dc3-fa243d5c00c9'),(262,113,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','b28db82c-fd26-4033-bdd4-80d10a80f4e6'),(263,114,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','c920c7ce-9138-4ef0-a8dc-3a7119caf5ea'),(264,115,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','7357804a-57ab-4a35-9501-c69b5bf1ae60'),(265,116,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','e8fd53aa-6938-4b7c-89ce-f0228c5af3c5'),(266,117,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','1cc6d4a4-75b8-42ed-886d-e92a8303a3fe'),(267,118,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','6d8885fc-8fcf-4d9f-9b99-7bd6fe454575'),(268,119,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','74c29607-aa9a-4902-8d1c-62f8ade531e4'),(269,120,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','ac875907-67a8-4892-95e9-ab49a442618b'),(270,121,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','b25df937-11ea-4a8c-a6a9-8e82d9a343d6'),(271,122,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','b4f6ec37-afc8-4381-96d0-ac0ce485f74f'),(272,123,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','4250a9f1-4008-4b8e-8ed1-e27d6356094f'),(273,124,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','7210c4c0-52c2-4990-9635-cbc43e2eace3'),(274,125,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','12593b01-a051-4e82-a9d0-d9f041841be7'),(275,126,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','45d137d1-d87a-45bb-8d80-353684f477f8'),(276,127,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','6f5a60da-c9b8-4b62-bce4-644d5ce746ef'),(277,128,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','c1364f58-7371-40f3-ae1d-0411e2e3b6e3'),(278,129,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','f9d904e9-c75a-4c14-9308-2260c50c8458'),(279,130,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','c7c0612f-3bc0-4627-8bea-5756e720041c'),(280,131,3,'2022-11-16 06:42:38','2022-11-16 06:42:38','380d8218-ed7a-4c21-86f8-f05241b533d6');
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (16,'{\"language\":\"en-GB\",\"locale\":null,\"weekStartDay\":\"1\",\"alwaysShowFocusRings\":false,\"useShapes\":false,\"underlineLinks\":false,\"notificationDuration\":\"5000\",\"showFieldHandles\":true,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false,\"showExceptionView\":false,\"profileTemplates\":false}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (16,NULL,1,0,0,0,1,'steve@simplicate.ca','',NULL,NULL,'steve@simplicate.ca','$2y$13$Z.qsO/mLDJcpGnySYA0veeR7sAC9jfJAi/zE4UAQMfluTn2ur4uWy','2022-11-17 07:29:38',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2022-11-16 06:42:55','2022-11-16 06:42:55','2022-11-17 07:29:38');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Uploads',NULL,'2022-11-16 06:42:21','2022-11-16 06:42:21','12c647dc-9e9d-4b2c-9f21-fd3f9769a389'),(2,NULL,2,'Static Assets',NULL,'2022-11-16 06:42:29','2022-11-16 06:42:29','5d0b6175-03e2-4b44-a46d-278f8b8753f4'),(3,NULL,NULL,'Temporary filesystem',NULL,'2022-11-16 06:48:23','2022-11-16 06:48:23','f9c7e561-8cfc-4519-a582-be3b48f2836c'),(4,3,NULL,'user_16','user_16/','2022-11-16 06:48:23','2022-11-16 06:48:23','76d9c4b1-c39c-4086-9021-2dd394b112f8');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,1,'Uploads','contentAssets','contentAssets','','','site',NULL,0,'2022-11-16 06:42:21','2022-11-16 06:42:21',NULL,'a4f97962-52de-4b53-8422-5b833d1cd5fd'),(2,12,'Static Assets','staticAssets','staticAssets',NULL,'','site',NULL,0,'2022-11-16 06:42:29','2022-11-16 06:42:29',NULL,'3c05e593-d621-444e-8fb9-ddbb1b356a43');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,16,'craft\\widgets\\RecentEntries',1,NULL,'{\"siteId\":1,\"section\":\"*\",\"limit\":10}',1,'2022-11-16 06:45:15','2022-11-16 06:45:15','937253e3-18a9-446f-a3b7-2ed3eff65aad'),(2,16,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2022-11-16 06:45:15','2022-11-16 06:45:15','20353bb2-46b0-4545-9f0a-033bc8c160d3'),(3,16,'craft\\widgets\\Updates',3,NULL,'[]',1,'2022-11-16 06:45:15','2022-11-16 06:45:15','fedf2bd2-e001-4fdf-bf37-13a4f6e5e667'),(4,16,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2022-11-16 06:45:15','2022-11-16 06:45:15','459b7ec5-3614-41d9-a9d9-970384b93547');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-17 10:50:04