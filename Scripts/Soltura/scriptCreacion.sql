USE [solturaDB]
GO
/****** Object:  Schema [solturaDB]    Script Date: 5/6/2025 5:15:49 PM ******/
CREATE SCHEMA [solturaDB]
GO
/****** Object:  Table [dbo].[sol_migratedUsers]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sol_migratedUsers](
	[migratedUserID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[changedPassword] [binary](1) NULL,
	[platform] [varchar](60) NULL,
 CONSTRAINT [PK_sol_migratedUsers] PRIMARY KEY CLUSTERED 
(
	[migratedUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_addresses]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_addresses](
	[addressid] [int] IDENTITY(1,1) NOT NULL,
	[line1] [nvarchar](200) NOT NULL,
	[line2] [nvarchar](200) NULL,
	[zipcode] [nvarchar](9) NOT NULL,
	[geoposition] [geometry] NOT NULL,
	[cityID] [int] NOT NULL,
 CONSTRAINT [PK_sol_addresses_addressid] PRIMARY KEY CLUSTERED 
(
	[addressid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_associateIdentificationTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_associateIdentificationTypes](
	[identificationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[datatype] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_associateIdentificationTypes_identificationTypeID] PRIMARY KEY CLUSTERED 
(
	[identificationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_associatePlans]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_associatePlans](
	[associatePlanID] [int] IDENTITY(1,1) NOT NULL,
	[associateID] [int] NOT NULL,
	[userPlanID] [int] NOT NULL,
 CONSTRAINT [PK_sol_associatePlans_associatePlanID] PRIMARY KEY CLUSTERED 
(
	[associatePlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_availablePayMethods]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_availablePayMethods](
	[available_method_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[userID] [int] NOT NULL,
	[token] [nvarchar](255) NOT NULL,
	[expToken] [date] NOT NULL,
	[maskAccount] [nvarchar](50) NOT NULL,
	[methodID] [int] NOT NULL,
 CONSTRAINT [PK_sol_availablePayMethods_available_method_id] PRIMARY KEY CLUSTERED 
(
	[available_method_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_balances]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_balances](
	[balanceID] [int] IDENTITY(1,1) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[expirationDate] [datetime2](0) NOT NULL,
	[lastUpdate] [datetime2](0) NOT NULL,
	[balanceTypeID] [int] NOT NULL,
	[planFeatureID] [int] NOT NULL,
	[userID] [int] NOT NULL,
 CONSTRAINT [PK_sol_balances_balanceID] PRIMARY KEY CLUSTERED 
(
	[balanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_city]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_city](
	[cityID] [int] IDENTITY(1,1) NOT NULL,
	[stateID] [int] NOT NULL,
	[name] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_sol_city_cityID] PRIMARY KEY CLUSTERED 
(
	[cityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_communicationChannels]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_communicationChannels](
	[communicationChannelID] [int] NOT NULL,
	[channel] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_sol_communicationChannels_communicationChannelID] PRIMARY KEY CLUSTERED 
(
	[communicationChannelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_contact_departments]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_contact_departments](
	[contactDepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_contact_departments_contactDepartmentId] PRIMARY KEY CLUSTERED 
(
	[contactDepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_contact_info]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_contact_info](
	[contactInfoID] [int] IDENTITY(1,1) NOT NULL,
	[value] [nvarchar](100) NOT NULL,
	[enable] [binary](1) NOT NULL,
	[lastUpdate] [datetime2](0) NOT NULL,
	[contactTypeID] [int] NOT NULL,
	[contactDepartmentId] [int] NOT NULL,
	[partnerId] [int] NOT NULL,
 CONSTRAINT [PK_sol_contact_info_contactInfoID] PRIMARY KEY CLUSTERED 
(
	[contactInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_contactType]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_contactType](
	[contactTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_contactType_contactTypeID] PRIMARY KEY CLUSTERED 
(
	[contactTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_countries]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_countries](
	[countryID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_sol_countries_countryID] PRIMARY KEY CLUSTERED 
(
	[countryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_currencies]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_currencies](
	[currency_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[acronym] [nvarchar](5) NOT NULL,
	[symbol] [nvarchar](5) NOT NULL,
	[countryID] [int] NOT NULL,
 CONSTRAINT [PK_sol_currencies_currency_id] PRIMARY KEY CLUSTERED 
(
	[currency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_deals]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_deals](
	[dealId] [int] IDENTITY(1,1) NOT NULL,
	[partnerId] [int] NOT NULL,
	[dealDescription] [nvarchar](250) NOT NULL,
	[sealDate] [datetime2](0) NOT NULL,
	[endDate] [datetime2](0) NOT NULL,
	[solturaComission] [decimal](5, 2) NOT NULL,
	[discount] [decimal](5, 2) NOT NULL,
	[isActive] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_deals_dealId] PRIMARY KEY CLUSTERED 
(
	[dealId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_enterprise_size]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_enterprise_size](
	[enterpriseSizeId] [int] IDENTITY(1,1) NOT NULL,
	[size] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_enterprise_size_enterpriseSizeId] PRIMARY KEY CLUSTERED 
(
	[enterpriseSizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_exchangeCurrencies]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_exchangeCurrencies](
	[exchangeCurrencyID] [int] IDENTITY(1,1) NOT NULL,
	[sourceID] [int] NOT NULL,
	[destinyID] [int] NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NULL,
	[exchange_rate] [decimal](12, 3) NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[currentExchange] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_exchangeCurrencies_exchangeCurrencyID] PRIMARY KEY CLUSTERED 
(
	[exchangeCurrencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_featureAvailableLocations]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_featureAvailableLocations](
	[locationID] [int] IDENTITY(1,1) NOT NULL,
	[featurePerPlanID] [int] NOT NULL,
	[partnerAddressId] [int] NOT NULL,
	[available] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_featureAvailableLocations_locationID] PRIMARY KEY CLUSTERED 
(
	[locationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_featurePrices]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_featurePrices](
	[featurePriceID] [int] IDENTITY(1,1) NOT NULL,
	[originalPrice] [decimal](10, 2) NULL,
	[discountedPrice] [decimal](10, 2) NULL,
	[finalPrice] [decimal](10, 2) NULL,
	[currency_id] [int] NOT NULL,
	[current] [binary](1) NOT NULL,
	[variable] [binary](1) NOT NULL,
	[planFeatureID] [int] NOT NULL,
 CONSTRAINT [PK_sol_featurePrices_featurePriceID] PRIMARY KEY CLUSTERED 
(
	[featurePriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_featuresPerPlans]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_featuresPerPlans](
	[featurePerPlansID] [int] IDENTITY(1,1) NOT NULL,
	[planFeatureID] [int] NOT NULL,
	[planID] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_featuresPerPlans_featurePerPlansID] PRIMARY KEY CLUSTERED 
(
	[featurePerPlansID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_featureTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_featureTypes](
	[featureTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](75) NOT NULL,
 CONSTRAINT [PK_sol_featureTypes_featureTypeID] PRIMARY KEY CLUSTERED 
(
	[featureTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_languages]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_languages](
	[languageID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
	[culture] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_sol_languages_languageID] PRIMARY KEY CLUSTERED 
(
	[languageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_logs]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_logs](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](200) NOT NULL,
	[postTime] [datetime2](0) NOT NULL,
	[computer] [nvarchar](75) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[trace] [nvarchar](100) NOT NULL,
	[referenceId1] [bigint] NULL,
	[referenceId2] [bigint] NULL,
	[value1] [nvarchar](180) NULL,
	[value2] [nvarchar](180) NULL,
	[checksum] [varbinary](250) NOT NULL,
	[logSeverityID] [int] NOT NULL,
	[logTypesID] [int] NOT NULL,
	[logSourcesID] [int] NOT NULL,
 CONSTRAINT [PK_sol_logs_log_id] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_logSources]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_logSources](
	[logSourcesID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_logSources_logSourcesID] PRIMARY KEY CLUSTERED 
(
	[logSourcesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_logsSererity]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_logsSererity](
	[logSererityID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_logsSererity_logSererityID] PRIMARY KEY CLUSTERED 
(
	[logSererityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_logTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_logTypes](
	[logTypesID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
	[reference1Description] [nvarchar](75) NULL,
	[reference2Description] [nvarchar](75) NULL,
	[value1Description] [nvarchar](75) NULL,
	[value2Description] [nvarchar](75) NULL,
 CONSTRAINT [PK_sol_logTypes_logTypesID] PRIMARY KEY CLUSTERED 
(
	[logTypesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_mediaFile]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_mediaFile](
	[mediaFileID] [int] IDENTITY(1,1) NOT NULL,
	[URL] [nvarchar](200) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[media_type_id] [smallint] NOT NULL,
	[userID] [int] NOT NULL,
 CONSTRAINT [PK_sol_mediaFile_mediaFileID] PRIMARY KEY CLUSTERED 
(
	[mediaFileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_mediaTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_mediaTypes](
	[mediaTypeID] [smallint] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_sol_mediaTypes_mediaTypeID] PRIMARY KEY CLUSTERED 
(
	[mediaTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_modules]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_modules](
	[moduleID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_sol_modules_moduleID] PRIMARY KEY CLUSTERED 
(
	[moduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_notificationConfigurations]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_notificationConfigurations](
	[configurationID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[notificationTypeID] [smallint] NOT NULL,
	[communicationChannelID] [int] NOT NULL,
	[settings] [nvarchar](max) NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_notificationConfigurations_configurationID] PRIMARY KEY CLUSTERED 
(
	[configurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_notifications]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_notifications](
	[notificationID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[notification_type_id] [smallint] NOT NULL,
	[message] [nvarchar](300) NOT NULL,
	[sentTime] [datetime2](0) NOT NULL,
	[status] [smallint] NOT NULL,
	[communicationChannelID] [int] NOT NULL,
 CONSTRAINT [PK_sol_notifications_notificationID] PRIMARY KEY CLUSTERED 
(
	[notificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_notificationTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_notificationTypes](
	[notificationTypeID] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](70) NOT NULL,
 CONSTRAINT [PK_sol_notificationTypes_notificationTypeID] PRIMARY KEY CLUSTERED 
(
	[notificationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_partner_addresses]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_partner_addresses](
	[partnerAddressId] [int] IDENTITY(1,1) NOT NULL,
	[partnerId] [int] NOT NULL,
	[addressid] [int] NOT NULL,
 CONSTRAINT [PK_sol_partner_addresses_partnerAddressId] PRIMARY KEY CLUSTERED 
(
	[partnerAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_partners]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_partners](
	[partnerId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](60) NOT NULL,
	[registerDate] [datetime2](0) NOT NULL,
	[state] [smallint] NOT NULL,
	[identificationtypeId] [int] NOT NULL,
	[enterpriseSizeId] [int] NOT NULL,
	[identification] [nvarchar](90) NOT NULL,
 CONSTRAINT [PK_sol_partners_partnerId] PRIMARY KEY CLUSTERED 
(
	[partnerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_partners_identifications_types]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_partners_identifications_types](
	[identificationtypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_partners_identifications_types_identificationtypeId] PRIMARY KEY CLUSTERED 
(
	[identificationtypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_payments]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_payments](
	[paymentID] [int] IDENTITY(1,1) NOT NULL,
	[availableMethodID] [int] NOT NULL,
	[currency_id] [int] NOT NULL,
	[amount] [decimal](9, 2) NOT NULL,
	[date_pay] [date] NOT NULL,
	[confirmed] [binary](1) NOT NULL,
	[result] [nvarchar](200) NOT NULL,
	[auth] [nvarchar](60) NOT NULL,
	[reference] [nvarchar](100) NOT NULL,
	[charge_token] [varbinary](255) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[error] [nvarchar](200) NULL,
	[checksum] [varbinary](250) NOT NULL,
	[methodID] [int] NOT NULL,
 CONSTRAINT [PK_sol_payments_paymentID] PRIMARY KEY CLUSTERED 
(
	[paymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_payMethod]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_payMethod](
	[payMethodID] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[apiURL] [nvarchar](200) NOT NULL,
	[secretKey] [varbinary](255) NOT NULL,
	[key] [nvarchar](255) NOT NULL,
	[logoIconURL] [nvarchar](200) NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_payMethod_payMethodID] PRIMARY KEY CLUSTERED 
(
	[payMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_permissions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_permissions](
	[permissionID] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](200) NOT NULL,
	[code] [nvarchar](10) NOT NULL,
	[moduleID] [int] NOT NULL,
 CONSTRAINT [PK_sol_permissions_permissionID] PRIMARY KEY CLUSTERED 
(
	[permissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [sol_permissions$code_UNIQUE] UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planFeatures]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planFeatures](
	[planFeatureID] [int] IDENTITY(1,1) NOT NULL,
	[dealId] [int] NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[unit] [nvarchar](50) NOT NULL,
	[consumableQuantity] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[isRecurrent] [binary](1) NOT NULL,
	[scheduleID] [int] NOT NULL,
	[featureTypeID] [int] NOT NULL,
 CONSTRAINT [PK_sol_planFeatures_planFeatureID] PRIMARY KEY CLUSTERED 
(
	[planFeatureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planPrices]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planPrices](
	[planPriceID] [int] IDENTITY(1,1) NOT NULL,
	[planID] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[currency_id] [int] NOT NULL,
	[postTime] [datetime2](0) NOT NULL,
	[endDate] [nvarchar](45) NOT NULL,
	[current] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_planPrices_planPriceID] PRIMARY KEY CLUSTERED 
(
	[planPriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_plans]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_plans](
	[planID] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[planTypeID] [int] NOT NULL,
 CONSTRAINT [PK_sol_plans_planID] PRIMARY KEY CLUSTERED 
(
	[planID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planTransactions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planTransactions](
	[planTransactionID] [int] IDENTITY(1,1) NOT NULL,
	[planTransactionTypeID] [int] NOT NULL,
	[date] [datetime2](0) NOT NULL,
	[postTime] [datetime2](0) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
	[userID] [int] NOT NULL,
	[associateID] [int] NOT NULL,
	[partnerAddressId] [int] NULL,
 CONSTRAINT [PK_sol_planTransactions_planTransactionID] PRIMARY KEY CLUSTERED 
(
	[planTransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planTransactionTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planTransactionTypes](
	[planTransactionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_sol_planTransactionTypes_planTransactionTypeID] PRIMARY KEY CLUSTERED 
(
	[planTransactionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planTypes](
	[planTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[userID] [int] NULL,
 CONSTRAINT [PK_sol_planTypes_planTypeID] PRIMARY KEY CLUSTERED 
(
	[planTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_rolePermissions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_rolePermissions](
	[rolePermissionID] [int] IDENTITY(1,1) NOT NULL,
	[roleID] [smallint] NOT NULL,
	[permissionID] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[lastPermUpdate] [datetime2](0) NOT NULL,
	[username] [nvarchar](45) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
 CONSTRAINT [PK_sol_rolePermissions_rolePermissionID] PRIMARY KEY CLUSTERED 
(
	[rolePermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_roles]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_roles](
	[roleID] [smallint] IDENTITY(1,1) NOT NULL,
	[roleName] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_roles_roleID] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_schedules]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_schedules](
	[scheduleID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](70) NOT NULL,
	[repit] [binary](1) NOT NULL,
	[repetitions] [smallint] NOT NULL,
	[recurrencyType] [smallint] NOT NULL,
	[endDate] [datetime2](0) NULL,
	[startDate] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_sol_schedules_scheduleID] PRIMARY KEY CLUSTERED 
(
	[scheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_schedulesDetails]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_schedulesDetails](
	[schedulesDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[schedule_id] [int] NOT NULL,
	[baseDate] [datetime2](0) NOT NULL,
	[datePart] [date] NOT NULL,
	[lastExecute] [datetime2](0) NULL,
	[nextExecute] [datetime2](0) NOT NULL,
	[description] [varchar](100) NOT NULL,
	[detail] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_sol_schedulesDetails_schedulesDetailsID] PRIMARY KEY CLUSTERED 
(
	[schedulesDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_states]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_states](
	[stateID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](40) NOT NULL,
	[countryID] [int] NOT NULL,
 CONSTRAINT [PK_sol_states_stateID] PRIMARY KEY CLUSTERED 
(
	[stateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_transactions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_transactions](
	[transactionsID] [int] IDENTITY(1,1) NOT NULL,
	[payment_id] [int] NULL,
	[date] [datetime2](0) NOT NULL,
	[postTime] [datetime2](0) NOT NULL,
	[refNumber] [nvarchar](50) NOT NULL,
	[user_id] [int] NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
	[exchangeRate] [decimal](12, 3) NOT NULL,
	[convertedAmount] [decimal](12, 2) NOT NULL,
	[transactionTypesID] [int] NOT NULL,
	[transactionSubtypesID] [int] NOT NULL,
	[amount] [decimal](12, 2) NULL,
	[exchangeCurrencyID] [int] NULL,
 CONSTRAINT [PK_sol_transactions_transactionsID] PRIMARY KEY CLUSTERED 
(
	[transactionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_transactionSubtypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_transactionSubtypes](
	[transactionSubtypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_transactionSubtypes_transactionSubtypeID] PRIMARY KEY CLUSTERED 
(
	[transactionSubtypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_transactionTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_transactionTypes](
	[transactionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_transactionTypes_transactionTypeID] PRIMARY KEY CLUSTERED 
(
	[transactionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_translations]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_translations](
	[translationsID] [int] IDENTITY(1,1) NOT NULL,
	[moduleID] [int] NOT NULL,
	[code] [nvarchar](100) NOT NULL,
	[caption] [nvarchar](100) NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[languageID] [int] NOT NULL,
 CONSTRAINT [PK_sol_translations_translationsID] PRIMARY KEY CLUSTERED 
(
	[translationsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_userAssociateIdentifications]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_userAssociateIdentifications](
	[associateID] [int] NOT NULL,
	[token] [varbinary](max) NOT NULL,
	[userID] [int] NOT NULL,
	[identificationTypeID] [int] NOT NULL,
 CONSTRAINT [PK_sol_userAssociateIdentifications_associateID] PRIMARY KEY CLUSTERED 
(
	[associateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_userPermissions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_userPermissions](
	[userPermissionID] [int] IDENTITY(1,1) NOT NULL,
	[permissionID] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[lastPermUpdate] [datetime2](0) NOT NULL,
	[username] [nvarchar](45) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
	[userID] [int] NOT NULL,
 CONSTRAINT [PK_sol_userPermissions_userPermissionID] PRIMARY KEY CLUSTERED 
(
	[userPermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_userPlans]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_userPlans](
	[userPlanID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[planPriceID] [int] NOT NULL,
	[scheduleID] [int] NOT NULL,
	[adquisition] [date] NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_userPlans_userPlanID] PRIMARY KEY CLUSTERED 
(
	[userPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_userRoles]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_userRoles](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [smallint] NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[lastUpdate] [datetime2](0) NOT NULL,
	[username] [nvarchar](45) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
 CONSTRAINT [PK_sol_userRoles_userID] PRIMARY KEY CLUSTERED 
(
	[userID] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_users]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_users](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](80) NOT NULL,
	[firstName] [nvarchar](50) NOT NULL,
	[lastName] [nvarchar](50) NOT NULL,
	[password] [varbinary](250) NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_users_userID] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [sol_users$email_UNIQUE] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_usersAdresses]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_usersAdresses](
	[userAddressID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[addressID] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_usersAdresses_userAddressID] PRIMARY KEY CLUSTERED 
(
	[userAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sol_migratedUsers] ADD  CONSTRAINT [DF_sol_migratedUsers_changedPassword]  DEFAULT (0x00) FOR [changedPassword]
GO
ALTER TABLE [solturaDB].[sol_addresses] ADD  DEFAULT (NULL) FOR [line2]
GO
ALTER TABLE [solturaDB].[sol_contact_info] ADD  DEFAULT (0x01) FOR [enable]
GO
ALTER TABLE [solturaDB].[sol_contact_info] ADD  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [solturaDB].[sol_deals] ADD  DEFAULT (0x01) FOR [isActive]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] ADD  DEFAULT (NULL) FOR [endDate]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] ADD  DEFAULT (0x01) FOR [currentExchange]
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations] ADD  DEFAULT (0x01) FOR [available]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (NULL) FOR [originalPrice]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (NULL) FOR [discountedPrice]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (NULL) FOR [finalPrice]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (0x01) FOR [current]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (0x00) FOR [variable]
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_logs] ADD  DEFAULT (NULL) FOR [referenceId1]
GO
ALTER TABLE [solturaDB].[sol_logs] ADD  DEFAULT (NULL) FOR [referenceId2]
GO
ALTER TABLE [solturaDB].[sol_logs] ADD  DEFAULT (NULL) FOR [value1]
GO
ALTER TABLE [solturaDB].[sol_logs] ADD  DEFAULT (NULL) FOR [value2]
GO
ALTER TABLE [solturaDB].[sol_logTypes] ADD  DEFAULT (NULL) FOR [reference1Description]
GO
ALTER TABLE [solturaDB].[sol_logTypes] ADD  DEFAULT (NULL) FOR [reference2Description]
GO
ALTER TABLE [solturaDB].[sol_logTypes] ADD  DEFAULT (NULL) FOR [value1Description]
GO
ALTER TABLE [solturaDB].[sol_logTypes] ADD  DEFAULT (NULL) FOR [value2Description]
GO
ALTER TABLE [solturaDB].[sol_mediaFile] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_partners] ADD  DEFAULT ((1)) FOR [state]
GO
ALTER TABLE [solturaDB].[sol_payments] ADD  DEFAULT (0x00) FOR [confirmed]
GO
ALTER TABLE [solturaDB].[sol_payments] ADD  DEFAULT (N'En proceso') FOR [result]
GO
ALTER TABLE [solturaDB].[sol_payments] ADD  DEFAULT (NULL) FOR [error]
GO
ALTER TABLE [solturaDB].[sol_payMethod] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_planFeatures] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_planPrices] ADD  DEFAULT (0x01) FOR [current]
GO
ALTER TABLE [solturaDB].[sol_planTransactions] ADD  DEFAULT (NULL) FOR [partnerAddressId]
GO
ALTER TABLE [solturaDB].[sol_planTypes] ADD  DEFAULT (NULL) FOR [userID]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] ADD  DEFAULT (getdate()) FOR [lastPermUpdate]
GO
ALTER TABLE [solturaDB].[sol_schedules] ADD  DEFAULT (NULL) FOR [endDate]
GO
ALTER TABLE [solturaDB].[sol_schedulesDetails] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_schedulesDetails] ADD  DEFAULT (NULL) FOR [lastExecute]
GO
ALTER TABLE [solturaDB].[sol_transactions] ADD  DEFAULT (NULL) FOR [payment_id]
GO
ALTER TABLE [solturaDB].[sol_transactions] ADD  DEFAULT (NULL) FOR [amount]
GO
ALTER TABLE [solturaDB].[sol_transactions] ADD  DEFAULT (NULL) FOR [exchangeCurrencyID]
GO
ALTER TABLE [solturaDB].[sol_userPermissions] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_userPermissions] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_userPermissions] ADD  DEFAULT (getdate()) FOR [lastPermUpdate]
GO
ALTER TABLE [solturaDB].[sol_userPlans] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_userRoles] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_userRoles] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_userRoles] ADD  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [solturaDB].[sol_users] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_usersAdresses] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [dbo].[sol_migratedUsers]  WITH NOCHECK ADD  CONSTRAINT [FK_sol_migratedUsers_sol_users] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [dbo].[sol_migratedUsers] NOCHECK CONSTRAINT [FK_sol_migratedUsers_sol_users]
GO
ALTER TABLE [solturaDB].[sol_addresses]  WITH NOCHECK ADD  CONSTRAINT [sol_addresses$fk_pay_Addresses_pay_city1] FOREIGN KEY([cityID])
REFERENCES [solturaDB].[sol_city] ([cityID])
GO
ALTER TABLE [solturaDB].[sol_addresses] NOCHECK CONSTRAINT [sol_addresses$fk_pay_Addresses_pay_city1]
GO
ALTER TABLE [solturaDB].[sol_associatePlans]  WITH NOCHECK ADD  CONSTRAINT [sol_associatePlans$fk_sol_associatePlans_sol_userAssociateIdentifications1] FOREIGN KEY([associateID])
REFERENCES [solturaDB].[sol_userAssociateIdentifications] ([associateID])
GO
ALTER TABLE [solturaDB].[sol_associatePlans] NOCHECK CONSTRAINT [sol_associatePlans$fk_sol_associatePlans_sol_userAssociateIdentifications1]
GO
ALTER TABLE [solturaDB].[sol_associatePlans]  WITH NOCHECK ADD  CONSTRAINT [sol_associatePlans$fk_sol_associatePlans_sol_userPlans1] FOREIGN KEY([userPlanID])
REFERENCES [solturaDB].[sol_userPlans] ([userPlanID])
GO
ALTER TABLE [solturaDB].[sol_associatePlans] NOCHECK CONSTRAINT [sol_associatePlans$fk_sol_associatePlans_sol_userPlans1]
GO
ALTER TABLE [solturaDB].[sol_availablePayMethods]  WITH NOCHECK ADD  CONSTRAINT [sol_availablePayMethods$fk_pay_available_media_pay_pay_method1] FOREIGN KEY([methodID])
REFERENCES [solturaDB].[sol_payMethod] ([payMethodID])
GO
ALTER TABLE [solturaDB].[sol_availablePayMethods] NOCHECK CONSTRAINT [sol_availablePayMethods$fk_pay_available_media_pay_pay_method1]
GO
ALTER TABLE [solturaDB].[sol_availablePayMethods]  WITH NOCHECK ADD  CONSTRAINT [sol_availablePayMethods$fk_pay_available_media_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_availablePayMethods] NOCHECK CONSTRAINT [sol_availablePayMethods$fk_pay_available_media_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_balances]  WITH NOCHECK ADD  CONSTRAINT [sol_balances$fk_sol_balances_sol_planFeatures1] FOREIGN KEY([planFeatureID])
REFERENCES [solturaDB].[sol_planFeatures] ([planFeatureID])
GO
ALTER TABLE [solturaDB].[sol_balances] NOCHECK CONSTRAINT [sol_balances$fk_sol_balances_sol_planFeatures1]
GO
ALTER TABLE [solturaDB].[sol_balances]  WITH NOCHECK ADD  CONSTRAINT [sol_balances$fk_sol_balances_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_balances] NOCHECK CONSTRAINT [sol_balances$fk_sol_balances_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_city]  WITH NOCHECK ADD  CONSTRAINT [sol_city$fk_pay_city_pay_states1] FOREIGN KEY([stateID])
REFERENCES [solturaDB].[sol_states] ([stateID])
GO
ALTER TABLE [solturaDB].[sol_city] NOCHECK CONSTRAINT [sol_city$fk_pay_city_pay_states1]
GO
ALTER TABLE [solturaDB].[sol_contact_info]  WITH NOCHECK ADD  CONSTRAINT [sol_contact_info$fk_pay_contact_info_pay_contact_type1] FOREIGN KEY([contactTypeID])
REFERENCES [solturaDB].[sol_contactType] ([contactTypeID])
GO
ALTER TABLE [solturaDB].[sol_contact_info] NOCHECK CONSTRAINT [sol_contact_info$fk_pay_contact_info_pay_contact_type1]
GO
ALTER TABLE [solturaDB].[sol_contact_info]  WITH NOCHECK ADD  CONSTRAINT [sol_contact_info$fk_sol_contact_info_sol_contact_departments1] FOREIGN KEY([contactDepartmentId])
REFERENCES [solturaDB].[sol_contact_departments] ([contactDepartmentId])
GO
ALTER TABLE [solturaDB].[sol_contact_info] NOCHECK CONSTRAINT [sol_contact_info$fk_sol_contact_info_sol_contact_departments1]
GO
ALTER TABLE [solturaDB].[sol_contact_info]  WITH NOCHECK ADD  CONSTRAINT [sol_contact_info$fk_sol_contact_info_sol_partners1] FOREIGN KEY([partnerId])
REFERENCES [solturaDB].[sol_partners] ([partnerId])
GO
ALTER TABLE [solturaDB].[sol_contact_info] NOCHECK CONSTRAINT [sol_contact_info$fk_sol_contact_info_sol_partners1]
GO
ALTER TABLE [solturaDB].[sol_currencies]  WITH NOCHECK ADD  CONSTRAINT [sol_currencies$fk_pay_currencies_pay_countries1] FOREIGN KEY([countryID])
REFERENCES [solturaDB].[sol_countries] ([countryID])
GO
ALTER TABLE [solturaDB].[sol_currencies] NOCHECK CONSTRAINT [sol_currencies$fk_pay_currencies_pay_countries1]
GO
ALTER TABLE [solturaDB].[sol_deals]  WITH NOCHECK ADD  CONSTRAINT [sol_deals$fk_sol_deals_sol_partners1] FOREIGN KEY([partnerId])
REFERENCES [solturaDB].[sol_partners] ([partnerId])
GO
ALTER TABLE [solturaDB].[sol_deals] NOCHECK CONSTRAINT [sol_deals$fk_sol_deals_sol_partners1]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies]  WITH NOCHECK ADD  CONSTRAINT [sol_exchangeCurrencies$fk_pay_exchange_currency_pay_currency1] FOREIGN KEY([sourceID])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] NOCHECK CONSTRAINT [sol_exchangeCurrencies$fk_pay_exchange_currency_pay_currency1]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies]  WITH NOCHECK ADD  CONSTRAINT [sol_exchangeCurrencies$fk_pay_exchange_currency_pay_currency2] FOREIGN KEY([destinyID])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] NOCHECK CONSTRAINT [sol_exchangeCurrencies$fk_pay_exchange_currency_pay_currency2]
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations]  WITH NOCHECK ADD  CONSTRAINT [sol_featureAvailableLocations$fk_sol_featureLocations_sol_featuresPerPlans1] FOREIGN KEY([featurePerPlanID])
REFERENCES [solturaDB].[sol_featuresPerPlans] ([featurePerPlansID])
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations] NOCHECK CONSTRAINT [sol_featureAvailableLocations$fk_sol_featureLocations_sol_featuresPerPlans1]
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations]  WITH NOCHECK ADD  CONSTRAINT [sol_featureAvailableLocations$fk_sol_featureLocations_sol_partner_addresses1] FOREIGN KEY([partnerAddressId])
REFERENCES [solturaDB].[sol_partner_addresses] ([partnerAddressId])
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations] NOCHECK CONSTRAINT [sol_featureAvailableLocations$fk_sol_featureLocations_sol_partner_addresses1]
GO
ALTER TABLE [solturaDB].[sol_featurePrices]  WITH NOCHECK ADD  CONSTRAINT [sol_featurePrices$fk_sol_featurePrices_sol_currencies1] FOREIGN KEY([currency_id])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_featurePrices] NOCHECK CONSTRAINT [sol_featurePrices$fk_sol_featurePrices_sol_currencies1]
GO
ALTER TABLE [solturaDB].[sol_featurePrices]  WITH NOCHECK ADD  CONSTRAINT [sol_featurePrices$fk_sol_featurePrices_sol_planFeatures1] FOREIGN KEY([planFeatureID])
REFERENCES [solturaDB].[sol_planFeatures] ([planFeatureID])
GO
ALTER TABLE [solturaDB].[sol_featurePrices] NOCHECK CONSTRAINT [sol_featurePrices$fk_sol_featurePrices_sol_planFeatures1]
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_featuresPerPlans$fk_sol_featuresPerPlans_sol_planFeatures1] FOREIGN KEY([planFeatureID])
REFERENCES [solturaDB].[sol_planFeatures] ([planFeatureID])
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans] NOCHECK CONSTRAINT [sol_featuresPerPlans$fk_sol_featuresPerPlans_sol_planFeatures1]
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_featuresPerPlans$fk_sol_featuresPerPlans_sol_plans1] FOREIGN KEY([planID])
REFERENCES [solturaDB].[sol_plans] ([planID])
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans] NOCHECK CONSTRAINT [sol_featuresPerPlans$fk_sol_featuresPerPlans_sol_plans1]
GO
ALTER TABLE [solturaDB].[sol_logs]  WITH NOCHECK ADD  CONSTRAINT [sol_logs$fk_pay_logs_pay_log_severity1] FOREIGN KEY([logSeverityID])
REFERENCES [solturaDB].[sol_logsSererity] ([logSererityID])
GO
ALTER TABLE [solturaDB].[sol_logs] NOCHECK CONSTRAINT [sol_logs$fk_pay_logs_pay_log_severity1]
GO
ALTER TABLE [solturaDB].[sol_logs]  WITH NOCHECK ADD  CONSTRAINT [sol_logs$fk_pay_logs_pay_log_sources1] FOREIGN KEY([logSourcesID])
REFERENCES [solturaDB].[sol_logSources] ([logSourcesID])
GO
ALTER TABLE [solturaDB].[sol_logs] NOCHECK CONSTRAINT [sol_logs$fk_pay_logs_pay_log_sources1]
GO
ALTER TABLE [solturaDB].[sol_logs]  WITH NOCHECK ADD  CONSTRAINT [sol_logs$fk_pay_logs_pay_log_types1] FOREIGN KEY([logTypesID])
REFERENCES [solturaDB].[sol_logTypes] ([logTypesID])
GO
ALTER TABLE [solturaDB].[sol_logs] NOCHECK CONSTRAINT [sol_logs$fk_pay_logs_pay_log_types1]
GO
ALTER TABLE [solturaDB].[sol_mediaFile]  WITH NOCHECK ADD  CONSTRAINT [sol_mediaFile$fk_pay_media_files_pay_media_types] FOREIGN KEY([media_type_id])
REFERENCES [solturaDB].[sol_mediaTypes] ([mediaTypeID])
GO
ALTER TABLE [solturaDB].[sol_mediaFile] NOCHECK CONSTRAINT [sol_mediaFile$fk_pay_media_files_pay_media_types]
GO
ALTER TABLE [solturaDB].[sol_mediaFile]  WITH NOCHECK ADD  CONSTRAINT [sol_mediaFile$fk_pay_media_files_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_mediaFile] NOCHECK CONSTRAINT [sol_mediaFile$fk_pay_media_files_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations]  WITH NOCHECK ADD  CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_communication_channels1] FOREIGN KEY([communicationChannelID])
REFERENCES [solturaDB].[sol_communicationChannels] ([communicationChannelID])
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations] NOCHECK CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_communication_channels1]
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations]  WITH NOCHECK ADD  CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_notification_types1] FOREIGN KEY([notificationTypeID])
REFERENCES [solturaDB].[sol_notificationTypes] ([notificationTypeID])
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations] NOCHECK CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_notification_types1]
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations]  WITH NOCHECK ADD  CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_users2] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations] NOCHECK CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_users2]
GO
ALTER TABLE [solturaDB].[sol_notifications]  WITH NOCHECK ADD  CONSTRAINT [sol_notifications$fk_pay_notifications_pay_channel_types1] FOREIGN KEY([communicationChannelID])
REFERENCES [solturaDB].[sol_communicationChannels] ([communicationChannelID])
GO
ALTER TABLE [solturaDB].[sol_notifications] NOCHECK CONSTRAINT [sol_notifications$fk_pay_notifications_pay_channel_types1]
GO
ALTER TABLE [solturaDB].[sol_notifications]  WITH NOCHECK ADD  CONSTRAINT [sol_notifications$fk_pay_notifications_pay_notification_types1] FOREIGN KEY([notification_type_id])
REFERENCES [solturaDB].[sol_notificationTypes] ([notificationTypeID])
GO
ALTER TABLE [solturaDB].[sol_notifications] NOCHECK CONSTRAINT [sol_notifications$fk_pay_notifications_pay_notification_types1]
GO
ALTER TABLE [solturaDB].[sol_notifications]  WITH NOCHECK ADD  CONSTRAINT [sol_notifications$fk_pay_notifications_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_notifications] NOCHECK CONSTRAINT [sol_notifications$fk_pay_notifications_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_partner_addresses]  WITH NOCHECK ADD  CONSTRAINT [sol_partner_addresses$fk_sol_partners_addresses_sol_addresses1] FOREIGN KEY([addressid])
REFERENCES [solturaDB].[sol_addresses] ([addressid])
GO
ALTER TABLE [solturaDB].[sol_partner_addresses] NOCHECK CONSTRAINT [sol_partner_addresses$fk_sol_partners_addresses_sol_addresses1]
GO
ALTER TABLE [solturaDB].[sol_partner_addresses]  WITH NOCHECK ADD  CONSTRAINT [sol_partner_addresses$fk_sol_partners_addresses_sol_partners1] FOREIGN KEY([partnerId])
REFERENCES [solturaDB].[sol_partners] ([partnerId])
GO
ALTER TABLE [solturaDB].[sol_partner_addresses] NOCHECK CONSTRAINT [sol_partner_addresses$fk_sol_partners_addresses_sol_partners1]
GO
ALTER TABLE [solturaDB].[sol_partners]  WITH NOCHECK ADD  CONSTRAINT [sol_partners$fk_sol_partners_sol_enterprise_size1] FOREIGN KEY([enterpriseSizeId])
REFERENCES [solturaDB].[sol_enterprise_size] ([enterpriseSizeId])
GO
ALTER TABLE [solturaDB].[sol_partners] NOCHECK CONSTRAINT [sol_partners$fk_sol_partners_sol_enterprise_size1]
GO
ALTER TABLE [solturaDB].[sol_partners]  WITH NOCHECK ADD  CONSTRAINT [sol_partners$fk_sol_partners_sol_partners_identifications_types1] FOREIGN KEY([identificationtypeId])
REFERENCES [solturaDB].[sol_partners_identifications_types] ([identificationtypeId])
GO
ALTER TABLE [solturaDB].[sol_partners] NOCHECK CONSTRAINT [sol_partners$fk_sol_partners_sol_partners_identifications_types1]
GO
ALTER TABLE [solturaDB].[sol_payments]  WITH NOCHECK ADD  CONSTRAINT [sol_payments$fk_pay_payments_pay_available_pay_methods1] FOREIGN KEY([availableMethodID])
REFERENCES [solturaDB].[sol_availablePayMethods] ([available_method_id])
GO
ALTER TABLE [solturaDB].[sol_payments] NOCHECK CONSTRAINT [sol_payments$fk_pay_payments_pay_available_pay_methods1]
GO
ALTER TABLE [solturaDB].[sol_payments]  WITH NOCHECK ADD  CONSTRAINT [sol_payments$fk_pay_payments_pay_currency1] FOREIGN KEY([currency_id])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_payments] NOCHECK CONSTRAINT [sol_payments$fk_pay_payments_pay_currency1]
GO
ALTER TABLE [solturaDB].[sol_payments]  WITH NOCHECK ADD  CONSTRAINT [sol_payments$fk_pay_pays_pay_pay_method1] FOREIGN KEY([methodID])
REFERENCES [solturaDB].[sol_payMethod] ([payMethodID])
GO
ALTER TABLE [solturaDB].[sol_payments] NOCHECK CONSTRAINT [sol_payments$fk_pay_pays_pay_pay_method1]
GO
ALTER TABLE [solturaDB].[sol_permissions]  WITH NOCHECK ADD  CONSTRAINT [sol_permissions$fk_pay_permissions_pay_modules1] FOREIGN KEY([moduleID])
REFERENCES [solturaDB].[sol_modules] ([moduleID])
GO
ALTER TABLE [solturaDB].[sol_permissions] NOCHECK CONSTRAINT [sol_permissions$fk_pay_permissions_pay_modules1]
GO
ALTER TABLE [solturaDB].[sol_planFeatures]  WITH NOCHECK ADD  CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_deals1] FOREIGN KEY([dealId])
REFERENCES [solturaDB].[sol_deals] ([dealId])
GO
ALTER TABLE [solturaDB].[sol_planFeatures] NOCHECK CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_deals1]
GO
ALTER TABLE [solturaDB].[sol_planFeatures]  WITH NOCHECK ADD  CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_featureTypes1] FOREIGN KEY([featureTypeID])
REFERENCES [solturaDB].[sol_featureTypes] ([featureTypeID])
GO
ALTER TABLE [solturaDB].[sol_planFeatures] NOCHECK CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_featureTypes1]
GO
ALTER TABLE [solturaDB].[sol_planFeatures]  WITH NOCHECK ADD  CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_schedules1] FOREIGN KEY([scheduleID])
REFERENCES [solturaDB].[sol_schedules] ([scheduleID])
GO
ALTER TABLE [solturaDB].[sol_planFeatures] NOCHECK CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_schedules1]
GO
ALTER TABLE [solturaDB].[sol_planPrices]  WITH NOCHECK ADD  CONSTRAINT [sol_planPrices$fk_sol_planPrices_sol_currencies1] FOREIGN KEY([currency_id])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_planPrices] NOCHECK CONSTRAINT [sol_planPrices$fk_sol_planPrices_sol_currencies1]
GO
ALTER TABLE [solturaDB].[sol_planPrices]  WITH NOCHECK ADD  CONSTRAINT [sol_planPrices$fk_sol_planPrices_sol_plans1] FOREIGN KEY([planID])
REFERENCES [solturaDB].[sol_plans] ([planID])
GO
ALTER TABLE [solturaDB].[sol_planPrices] NOCHECK CONSTRAINT [sol_planPrices$fk_sol_planPrices_sol_plans1]
GO
ALTER TABLE [solturaDB].[sol_plans]  WITH NOCHECK ADD  CONSTRAINT [sol_plans$fk_sol_plans_sol_planTypes1] FOREIGN KEY([planTypeID])
REFERENCES [solturaDB].[sol_planTypes] ([planTypeID])
GO
ALTER TABLE [solturaDB].[sol_plans] NOCHECK CONSTRAINT [sol_plans$fk_sol_plans_sol_planTypes1]
GO
ALTER TABLE [solturaDB].[sol_planTransactions]  WITH NOCHECK ADD  CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_partner_addresses1] FOREIGN KEY([partnerAddressId])
REFERENCES [solturaDB].[sol_partner_addresses] ([partnerAddressId])
GO
ALTER TABLE [solturaDB].[sol_planTransactions] NOCHECK CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_partner_addresses1]
GO
ALTER TABLE [solturaDB].[sol_planTransactions]  WITH NOCHECK ADD  CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_planTransactionTypes1] FOREIGN KEY([planTransactionTypeID])
REFERENCES [solturaDB].[sol_planTransactionTypes] ([planTransactionTypeID])
GO
ALTER TABLE [solturaDB].[sol_planTransactions] NOCHECK CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_planTransactionTypes1]
GO
ALTER TABLE [solturaDB].[sol_planTransactions]  WITH NOCHECK ADD  CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_userAssociateIdentifications1] FOREIGN KEY([associateID])
REFERENCES [solturaDB].[sol_userAssociateIdentifications] ([associateID])
GO
ALTER TABLE [solturaDB].[sol_planTransactions] NOCHECK CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_userAssociateIdentifications1]
GO
ALTER TABLE [solturaDB].[sol_planTransactions]  WITH NOCHECK ADD  CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_planTransactions] NOCHECK CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_planTypes]  WITH NOCHECK ADD  CONSTRAINT [sol_planTypes$fk_sol_planTypes_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_planTypes] NOCHECK CONSTRAINT [sol_planTypes$fk_sol_planTypes_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions]  WITH NOCHECK ADD  CONSTRAINT [sol_rolePermissions$fk_pay_role_permissions_pay_permissions1] FOREIGN KEY([permissionID])
REFERENCES [solturaDB].[sol_permissions] ([permissionID])
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] NOCHECK CONSTRAINT [sol_rolePermissions$fk_pay_role_permissions_pay_permissions1]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions]  WITH NOCHECK ADD  CONSTRAINT [sol_rolePermissions$fk_pay_role_permissions_pay_roles1] FOREIGN KEY([roleID])
REFERENCES [solturaDB].[sol_roles] ([roleID])
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] NOCHECK CONSTRAINT [sol_rolePermissions$fk_pay_role_permissions_pay_roles1]
GO
ALTER TABLE [solturaDB].[sol_schedulesDetails]  WITH NOCHECK ADD  CONSTRAINT [sol_schedulesDetails$fk_pay_schedules_details_pay_schedules1] FOREIGN KEY([schedule_id])
REFERENCES [solturaDB].[sol_schedules] ([scheduleID])
GO
ALTER TABLE [solturaDB].[sol_schedulesDetails] NOCHECK CONSTRAINT [sol_schedulesDetails$fk_pay_schedules_details_pay_schedules1]
GO
ALTER TABLE [solturaDB].[sol_states]  WITH NOCHECK ADD  CONSTRAINT [sol_states$fk_pay_states_pay_countries1] FOREIGN KEY([countryID])
REFERENCES [solturaDB].[sol_countries] ([countryID])
GO
ALTER TABLE [solturaDB].[sol_states] NOCHECK CONSTRAINT [sol_states$fk_pay_states_pay_countries1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_pay_transactions_pay_pays1] FOREIGN KEY([payment_id])
REFERENCES [solturaDB].[sol_payments] ([paymentID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_pay_transactions_pay_pays1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_pay_transactions_pay_transaction_subtypes1] FOREIGN KEY([transactionSubtypesID])
REFERENCES [solturaDB].[sol_transactionSubtypes] ([transactionSubtypeID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_pay_transactions_pay_transaction_subtypes1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_pay_transactions_pay_transaction_types1] FOREIGN KEY([transactionTypesID])
REFERENCES [solturaDB].[sol_transactionTypes] ([transactionTypeID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_pay_transactions_pay_transaction_types1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_pay_transactions_pay_users1] FOREIGN KEY([user_id])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_pay_transactions_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_sol_transactions_sol_exchangeCurrencies1] FOREIGN KEY([exchangeCurrencyID])
REFERENCES [solturaDB].[sol_exchangeCurrencies] ([exchangeCurrencyID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_sol_transactions_sol_exchangeCurrencies1]
GO
ALTER TABLE [solturaDB].[sol_translations]  WITH NOCHECK ADD  CONSTRAINT [sol_translations$fk_pay_translations_pay_languages1] FOREIGN KEY([languageID])
REFERENCES [solturaDB].[sol_languages] ([languageID])
GO
ALTER TABLE [solturaDB].[sol_translations] NOCHECK CONSTRAINT [sol_translations$fk_pay_translations_pay_languages1]
GO
ALTER TABLE [solturaDB].[sol_translations]  WITH NOCHECK ADD  CONSTRAINT [sol_translations$fk_pay_translations_pay_modules1] FOREIGN KEY([moduleID])
REFERENCES [solturaDB].[sol_modules] ([moduleID])
GO
ALTER TABLE [solturaDB].[sol_translations] NOCHECK CONSTRAINT [sol_translations$fk_pay_translations_pay_modules1]
GO
ALTER TABLE [solturaDB].[sol_userAssociateIdentifications]  WITH NOCHECK ADD  CONSTRAINT [sol_userAssociateIdentifications$fk_sol_userAssociateIdentifications_sol_associateIdentificati1] FOREIGN KEY([identificationTypeID])
REFERENCES [solturaDB].[sol_associateIdentificationTypes] ([identificationTypeID])
GO
ALTER TABLE [solturaDB].[sol_userAssociateIdentifications] NOCHECK CONSTRAINT [sol_userAssociateIdentifications$fk_sol_userAssociateIdentifications_sol_associateIdentificati1]
GO
ALTER TABLE [solturaDB].[sol_userAssociateIdentifications]  WITH NOCHECK ADD  CONSTRAINT [sol_userAssociateIdentifications$fk_sol_userAssociateIdentifications_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_userAssociateIdentifications] NOCHECK CONSTRAINT [sol_userAssociateIdentifications$fk_sol_userAssociateIdentifications_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_userPermissions]  WITH NOCHECK ADD  CONSTRAINT [sol_userPermissions$fk_pay_role_permissions_pay_permissions10] FOREIGN KEY([permissionID])
REFERENCES [solturaDB].[sol_permissions] ([permissionID])
GO
ALTER TABLE [solturaDB].[sol_userPermissions] NOCHECK CONSTRAINT [sol_userPermissions$fk_pay_role_permissions_pay_permissions10]
GO
ALTER TABLE [solturaDB].[sol_userPermissions]  WITH NOCHECK ADD  CONSTRAINT [sol_userPermissions$fk_pay_user_permissions_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_userPermissions] NOCHECK CONSTRAINT [sol_userPermissions$fk_pay_user_permissions_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_userPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_pay_schedules1] FOREIGN KEY([scheduleID])
REFERENCES [solturaDB].[sol_schedules] ([scheduleID])
GO
ALTER TABLE [solturaDB].[sol_userPlans] NOCHECK CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_pay_schedules1]
GO
ALTER TABLE [solturaDB].[sol_userPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_planPrices1] FOREIGN KEY([planPriceID])
REFERENCES [solturaDB].[sol_planPrices] ([planPriceID])
GO
ALTER TABLE [solturaDB].[sol_userPlans] NOCHECK CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_planPrices1]
GO
ALTER TABLE [solturaDB].[sol_userPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_userPlans] NOCHECK CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_userRoles]  WITH NOCHECK ADD  CONSTRAINT [sol_userRoles$fk_pay_users_has_pay_roles_pay_roles1] FOREIGN KEY([role_id])
REFERENCES [solturaDB].[sol_roles] ([roleID])
GO
ALTER TABLE [solturaDB].[sol_userRoles] NOCHECK CONSTRAINT [sol_userRoles$fk_pay_users_has_pay_roles_pay_roles1]
GO
ALTER TABLE [solturaDB].[sol_userRoles]  WITH NOCHECK ADD  CONSTRAINT [sol_userRoles$fk_pay_users_has_pay_roles_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_userRoles] NOCHECK CONSTRAINT [sol_userRoles$fk_pay_users_has_pay_roles_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_usersAdresses]  WITH NOCHECK ADD  CONSTRAINT [sol_usersAdresses$fk_pay_users_adresses_pay_addresses1] FOREIGN KEY([addressID])
REFERENCES [solturaDB].[sol_addresses] ([addressid])
GO
ALTER TABLE [solturaDB].[sol_usersAdresses] NOCHECK CONSTRAINT [sol_usersAdresses$fk_pay_users_adresses_pay_addresses1]
GO
ALTER TABLE [solturaDB].[sol_usersAdresses]  WITH NOCHECK ADD  CONSTRAINT [sol_usersAdresses$fk_pay_users_adresses_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_usersAdresses] NOCHECK CONSTRAINT [sol_usersAdresses$fk_pay_users_adresses_pay_users1]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_addresses' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_addresses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_associateIdentificationTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_associateIdentificationTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_associatePlans' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_associatePlans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_availablePayMethods' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_availablePayMethods'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_balances' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_balances'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_city' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_communicationChannels' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_communicationChannels'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_contact_departments' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_contact_departments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_contact_info' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_contact_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_contactType' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_contactType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_countries' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_countries'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_currencies' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_currencies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_deals' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_deals'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_enterprise_size' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_enterprise_size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_exchangeCurrencies' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_exchangeCurrencies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_featureAvailableLocations' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_featureAvailableLocations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_featurePrices' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_featurePrices'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_featuresPerPlans' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_featuresPerPlans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_featureTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_featureTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_languages' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_languages'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_logs' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_logs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_logSources' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_logSources'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_logsSererity' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_logsSererity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_logTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_logTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_mediaFile' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_mediaFile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_mediaTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_mediaTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_modules' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_modules'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_notificationConfigurations' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_notificationConfigurations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_notifications' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_notifications'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_notificationTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_notificationTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_partner_addresses' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_partner_addresses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_partners' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_partners'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_partners_identifications_types' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_partners_identifications_types'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_payments' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_payments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_payMethod' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_payMethod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_permissions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_permissions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planFeatures' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planFeatures'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planPrices' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planPrices'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_plans' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_plans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planTransactions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planTransactions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planTransactionTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planTransactionTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_rolePermissions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_rolePermissions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_roles' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_schedules' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_schedules'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_schedulesDetails' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_schedulesDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_states' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_states'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_transactions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_transactions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_transactionSubtypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_transactionSubtypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_transactionTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_transactionTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_translations' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_translations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_userAssociateIdentifications' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_userAssociateIdentifications'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_userPermissions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_userPermissions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_userPlans' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_userPlans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_userRoles' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_userRoles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_users' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_users'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_usersAdresses' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_usersAdresses'
GO
