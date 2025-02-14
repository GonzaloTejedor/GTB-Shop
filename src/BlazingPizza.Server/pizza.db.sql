BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Address" (
	"Id"	INTEGER NOT NULL,
	"Name"	TEXT NOT NULL,
	"Line1"	TEXT NOT NULL,
	"Line2"	TEXT NOT NULL,
	"City"	TEXT NOT NULL,
	"Region"	TEXT NOT NULL,
	"PostalCode"	TEXT NOT NULL,
	CONSTRAINT "PK_Address" PRIMARY KEY("Id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "AspNetRoleClaims" (
	"Id"	INTEGER NOT NULL,
	"RoleId"	TEXT NOT NULL,
	"ClaimType"	TEXT,
	"ClaimValue"	TEXT,
	CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY("Id" AUTOINCREMENT),
	CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY("RoleId") REFERENCES "AspNetRoles"("Id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "AspNetRoles" (
	"Id"	TEXT NOT NULL,
	"Name"	TEXT,
	"NormalizedName"	TEXT,
	"ConcurrencyStamp"	TEXT,
	CONSTRAINT "PK_AspNetRoles" PRIMARY KEY("Id")
);
CREATE TABLE IF NOT EXISTS "AspNetUserClaims" (
	"Id"	INTEGER NOT NULL,
	"UserId"	TEXT NOT NULL,
	"ClaimType"	TEXT,
	"ClaimValue"	TEXT,
	CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY("Id" AUTOINCREMENT),
	CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "AspNetUserLogins" (
	"LoginProvider"	TEXT NOT NULL,
	"ProviderKey"	TEXT NOT NULL,
	"ProviderDisplayName"	TEXT,
	"UserId"	TEXT NOT NULL,
	CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY("LoginProvider","ProviderKey"),
	CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "AspNetUserRoles" (
	"UserId"	TEXT NOT NULL,
	"RoleId"	TEXT NOT NULL,
	CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY("UserId","RoleId"),
	CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY("RoleId") REFERENCES "AspNetRoles"("Id") ON DELETE CASCADE,
	CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "AspNetUserTokens" (
	"UserId"	TEXT NOT NULL,
	"LoginProvider"	TEXT NOT NULL,
	"Name"	TEXT NOT NULL,
	"Value"	TEXT,
	CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY("UserId","LoginProvider","Name"),
	CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "AspNetUsers" (
	"Id"	TEXT NOT NULL,
	"UserName"	TEXT,
	"NormalizedUserName"	TEXT,
	"Email"	TEXT,
	"NormalizedEmail"	TEXT,
	"EmailConfirmed"	INTEGER NOT NULL,
	"PasswordHash"	TEXT,
	"SecurityStamp"	TEXT,
	"ConcurrencyStamp"	TEXT,
	"PhoneNumber"	TEXT,
	"PhoneNumberConfirmed"	INTEGER NOT NULL,
	"TwoFactorEnabled"	INTEGER NOT NULL,
	"LockoutEnd"	TEXT,
	"LockoutEnabled"	INTEGER NOT NULL,
	"AccessFailedCount"	INTEGER NOT NULL,
	CONSTRAINT "PK_AspNetUsers" PRIMARY KEY("Id")
);
CREATE TABLE IF NOT EXISTS "DeviceCodes" (
	"UserCode"	TEXT NOT NULL,
	"DeviceCode"	TEXT NOT NULL,
	"SubjectId"	TEXT,
	"SessionId"	TEXT,
	"ClientId"	TEXT NOT NULL,
	"Description"	TEXT,
	"CreationTime"	TEXT NOT NULL,
	"Expiration"	TEXT NOT NULL,
	"Data"	TEXT NOT NULL,
	CONSTRAINT "PK_DeviceCodes" PRIMARY KEY("UserCode")
);
CREATE TABLE IF NOT EXISTS "Keys" (
	"Id"	TEXT NOT NULL,
	"Version"	INTEGER NOT NULL,
	"Created"	TEXT NOT NULL,
	"Use"	TEXT,
	"Algorithm"	TEXT NOT NULL,
	"IsX509Certificate"	INTEGER NOT NULL,
	"DataProtected"	INTEGER NOT NULL,
	"Data"	TEXT NOT NULL,
	CONSTRAINT "PK_Keys" PRIMARY KEY("Id")
);
CREATE TABLE IF NOT EXISTS "NotificationSubscriptions" (
	"NotificationSubscriptionId"	INTEGER NOT NULL,
	"UserId"	TEXT,
	"Url"	TEXT,
	"P256dh"	TEXT,
	"Auth"	TEXT,
	CONSTRAINT "PK_NotificationSubscriptions" PRIMARY KEY("NotificationSubscriptionId" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Orders" (
	"OrderId"	INTEGER NOT NULL,
	"UserId"	TEXT,
	"CreatedTime"	TEXT NOT NULL,
	"DeliveryAddressId"	INTEGER NOT NULL,
	"DeliveryLocation_Latitude"	REAL,
	"DeliveryLocation_Longitude"	REAL,
	CONSTRAINT "PK_Orders" PRIMARY KEY("OrderId"),
	CONSTRAINT "FK_Orders_Address_DeliveryAddressId" FOREIGN KEY("DeliveryAddressId") REFERENCES "Address"("Id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "PersistedGrants" (
	"Key"	TEXT NOT NULL,
	"Type"	TEXT NOT NULL,
	"SubjectId"	TEXT,
	"SessionId"	TEXT,
	"ClientId"	TEXT NOT NULL,
	"Description"	TEXT,
	"CreationTime"	TEXT NOT NULL,
	"Expiration"	TEXT,
	"ConsumedTime"	TEXT,
	"Data"	TEXT NOT NULL,
	CONSTRAINT "PK_PersistedGrants" PRIMARY KEY("Key")
);
CREATE TABLE IF NOT EXISTS "PizzaTopping" (
	"ToppingId"	INTEGER NOT NULL,
	"PizzaId"	INTEGER NOT NULL,
	CONSTRAINT "PK_PizzaTopping" PRIMARY KEY("PizzaId","ToppingId"),
	CONSTRAINT "FK_PizzaTopping_Pizzas_PizzaId" FOREIGN KEY("PizzaId") REFERENCES "Pizzas"("Id") ON DELETE CASCADE,
	CONSTRAINT "FK_PizzaTopping_Toppings_ToppingId" FOREIGN KEY("ToppingId") REFERENCES "Toppings"("Id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "Pizzas" (
	"Id"	INTEGER NOT NULL,
	"OrderId"	INTEGER NOT NULL,
	"SpecialId"	INTEGER NOT NULL,
	"Size"	INTEGER NOT NULL,
	CONSTRAINT "PK_Pizzas" PRIMARY KEY("Id" AUTOINCREMENT),
	CONSTRAINT "FK_Pizzas_Orders_OrderId" FOREIGN KEY("OrderId") REFERENCES "Orders"("OrderId") ON DELETE CASCADE,
	CONSTRAINT "FK_Pizzas_Specials_SpecialId" FOREIGN KEY("SpecialId") REFERENCES "Specials"("Id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "Specials" (
	"Id"	INTEGER NOT NULL,
	"Name"	TEXT NOT NULL,
	"BasePrice"	TEXT NOT NULL,
	"Description"	TEXT NOT NULL,
	"ImageUrl"	TEXT NOT NULL,
	CONSTRAINT "PK_Specials" PRIMARY KEY("Id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Toppings" (
	"Id"	INTEGER NOT NULL,
	"Name"	TEXT NOT NULL,
	"Price"	TEXT NOT NULL,
	CONSTRAINT "PK_Toppings" PRIMARY KEY("Id" AUTOINCREMENT)
);
INSERT INTO "Keys" VALUES ('C82033092E1726FD9F5B537A2D7AF8D3',1,'2025-02-10 15:29:05.3424269','signing','RS256',0,1,'CfDJ8PGyqerP2CJGh6VcPBs0FQcjJmBYO6ppnjTZ8izyq_gGm5RJM6_q8-2IW582SpxxYgkS0Us-hltg7TQiCl4ghn5Xh5j3NjMJjhLV2jFKRCuG3pMahlvseQYrdiRhAVRCxpzq8vliYw_EufVl3rZGaM_qfWe_V6wGH_BjjU9ZoxuBv157Hs-tTiVQuSTAHRsc39X6ZOfKJZsOh8nfUhcOilm3ER_jS6UoTlwlyiM_tf6-uPVZl6V9VqcDdGJXCBurXEUhE_bPoQ2kJDQ9P4DxXUXXER3rpCT9rc-PPlclZchaip_mEvsMxdFrlAExOsOIK5aWLmghr5_4Eki5bnknYC7tOOgfzZDwDLWlqrladeFG3ahca6j70AHiVdyW5rDhBzTRHk6F9ufX9CiT15b35OjIxHRcvjZy8hrHGpjAX6l3HaUMaP7guo4601IyS6BakaamVVGX4KoEvG9QEPvOU5HAvr9bQvAQgMvCnSogIHvZ5oYb1J7xhbz7We6Cf_hTG19pccl2slcFcTqYZM81u24iNDvJ2LnW-oaxOFhu1Nd0gPp9ApiTc9KPri0E3rRUmoOikgRrJsrwHlUXKLexxXuK1LSzgHvLwxZHIq7UyqDNtWEuPe9B0Y5hBL_4PQAoujc6Z-aisR33ZoA4OT_munAHLTzshgzpiz6QIXmCUEGPL8SAOFJ_r2JiDsjiwd2OP-znkDOt6kga6vfY7PP9sRtOm62GL0lThSAqspPTdYMe4_E0mFJDj9jnmuZfOMmiMdWA7Jv_5gsadxy0yv7VeMVPPUDLufab6KSVgzXyDX-55d-T5f_8exxsa46-EeL8ozHVdfXF-0YTY_Rig_8hQ7eZHf67pPmqLbQ3xoIPxQ4AAAsNSdjoeVbM8fNrAK9jUHnZCmQZoui12oBU0aZdaBMYejnrZpgrom_t6qgECg15mqx_TUiAMViCwKxIAcDfJbBvzaOXWp2Np-Q-b6BEzYjlJD1tImJ4jxC8aCSrpbyHoucJybbfofm-71UR7xTeRDjLxcvbA-3bHhWCdTqtpmbljqhJGiJdFKP8qvcSbILoz41s1yW1zRjbu-gZ9yiLFZxZ8LcUrNHLoxED9QRKHQWvqtfsYBRqzO81Gr2SROZX1bF72RK-877zakG6DDGIhMujNfibqVJsiuXl4qJDI1I8trDUhXpHRgJvMShudvi2d6vIsZ60-9NlbZVyTuX5KfYWvXGBKtYg73HE75TACHTNdLFmPkBCrO2VoYWDCD-AIcSZVO_vLPLcUV9LRzk1pewgvDTSMykN3C_EpOeUE4rMQ3y6piSlAH6qOV_uJGZLeOcc61nVhkJkT4o8liEm7r4KS38MHUhe2EfmSvsbxIWubKMI1Ppzc-qKb75tfTop_mibUdpkgshhiPrXMYFa_60nY0rPoGmZgQvJ7Sjd3CdamoysKeFjqLLH8J7EO1t5U47py5QWTxhSyz4PedgRT3lvJGCt1VMpzFraG6VKURVVKEaXFCqDvchPM2yR4NYm3nAcAmn9n3m8T9schGiAYrGq1GfUdRD43iE0FKH4hfyengh_2QOPjbFnVBkKwbE4QZV5FMCordVYxnl28usnsIcEHBS9YhJDHui-RZIdG55yQdfTIQAY2sBIHYMMzNk7wYkqOYygvqQnNBbCPV_rC34op1qBgJJyGDNcTJQzVZt82EAe-fwy9tKuuoU2pwMamdBa1gRoJLd_PCULWHxaYEQt9LvST9YGqc2iGrU6TcjTInDFZDbuopK-qESYWoUvrcGWKV7yiWYsgA3OX1CjQxGtEiSBUZs44JuY-VKk9YTyfVgi1VsOKuB1E2Hi_oT8Ws7Eo6ybramNhEtRIHMbAiAdsxFcWDQrp41uvF5kAy2oJSG9iPOaMK8ssXT8G1cWjdhgNYlgbTAHLK7X1C0KIQ4cMPw4BrI8SUbAVZgBoO_YShgTpv-9l72MY-h7XdiV2ehMfqcoZDlsN9W7tCLzHc2vmxBzkAMpHJZQRVdwubQhso24NJQ-I8qYJV-wP7kAatdZVTlDrBEb9aLcEgjPPy945AbY603-HNiGSr58dPXD0mZ6IzvRVLNA2_o2DFHzMOoptmzsIzeNJudR1PknIrwPweF_Y0nEMfN8oNiP1B-JLLDgMNgoPj48vKcjoTpmpz0pXCV7PEy1uNqif9Hc1DdKrU4Rj8fQR8gwulLnqqO-Yu-0mwCFKw8Idln5RrH4ao8IJeuG0cKJeycjx23BuDtGAHmfw65S7cdjdHkzgeSYzzZQYepmm0gZhs9-T8rUOkT8eeEKXAcgFSOIitmTi1evKhwCLCh8XkRC3yylin1sSeGtYjZjselNnMK8h288xSH5CsFOPupJKafAK-zDCnih3P0yvJLPNytiRsXzKdNppnJ7Y_o3YJ-i7msvO4AJjzXjzl9oa68yYV_yB-aFVyNFN3vAizkYocKRqNhdcR9jyiYgwGQfZGOx1zwHtzYf');
INSERT INTO "Keys" VALUES ('63D6488F56A251A47BA89EC12F68182B',1,'2025-02-10 15:35:57.042664','signing','RS256',0,1,'CfDJ8PGyqerP2CJGh6VcPBs0FQeXfdAiVYYjBuelIRR4PF5woKdjNtMMOACWUOdq4NyBQXsUTFuKjzj518n90g2dSK-TuoLt9-0eOzRLPPyWXzukyWe7c4a8wVdqjCyNQKpYrPPvrM0XwCMlp7kntkrH-zUYLTroFWhoaJwcIXGqEfNORyHsQrwJuL1ZMFwnw33Gxp264bPu71CFbFKmY5RHjHnvLA1HWWk4fI0AjZES0bVJYmhRtkMxCNhYSVUOiyfdaAOu1zeQ_gzs8ed9X4LZAJUTmfvGG4zIsZy1TWibIFWcIHzP4ykhkzB-Tc-BrlolwAi8jT-XYzqywA5gDXYudn2yEFCHm4ntlVPtoytXNxoBUnNzBkwY7uUcUeEiox_aWyUke2Q-VxMmGAaoeUFv9Gbrr9besjjCjFkNbCk3a3xWL2gfmF0BnYfnLgTlB7ju7Wyt_jwzytumG-EfhnBW7GSokJEF4zBe3YMjZUJkeMl0ShtP_-foeHuBJauHDOwRdO2knAwJ1_Zdkbfco7gMwxJMvy_EhQLxk7Xo6-CUHf8Ker2il64kjemtBoH0E7kRzU3-ss6jZj1EPqhDg3q6Cez3XT6MMQIk7pK7pP78ldvUbX0eLzJu4Xp3wOOZlU1jPSfgsJmuDyUExeE5XzyQo7dCiWA2LtgQplV1ez3_XKchQZeynOX1T43-gbWRPQFyhrv6Sdt1he9G-WHX3Jprzq-EuRM1RP6uHUutJ6I_HfekwyccpgIy-YnoCraydcPat_ebONt06_NR-RRAd0u1K5DGo6YxT9JXnuOEsEnwlUdBfTLETHp1eKF9g6KHwTplYMwq3hxnYfRocmdPTetsUJ2rhaeLzdtKmmg9rgKQQHyYtshu40cmwC7-yogE9Vgz261A4m-ZFUcAm0xPT99mx796a82w7z1mb2W9md9B42gtfSO8HG7wki5W3D-bMN5IKecmiYTXxiH355c-0cJH167jYdW_Vh8ZT-ByHqlOj39kO6AAQU5S7hN5DWG-9T4zba5olm6W4TpgYQ5jTZnZV8e1ETzTRCNZhrBZlbUOsuvNKlQZx4Chd27Tmc2WjDGq9avKuVfz1Zq9IKL2bYknlLVEX8ybokHh3QkmD6gNKrh3Tslw0eAKX3ZmguVm4W_disij4pM9F2XmHBpisguisMoomwpWllw6GAOU3YA91O9r92rUSxY4XjNI19RWZGgo2Y1B-1wzrDwaUKNuD04vxWpdqf5ds3ybIwJuNnhQzuUIC5RRVu-8oSHvORZyOXlMTVU6Z6MWJKvGrSYfWjE--dSL6l8t0k4ER2Gobl4hW-bjaOBbzMaeLZhYEg65NxWdd_xEyEYtvlA7udpAyxbk3lZTRHaA3A9Oucxgq0OjB9CoC6A_e6S6I0j5M-rbnn8bq5PKxmlsZvopXLy2nTpAauELjTxLqarWcQoryO4zeYGTQVVvndFAQxmf_9b2FEi0dP1II5xLsBlmhjnr1SIOPQ2cpcbUXSUPzh3U0dBeVh1CHV2tf8maE2ypN_trmK3j2m0Z8dGyVqWsk3KddqtfOwMItQanlZsMFT1KoauExicmoB3TRb0oVKCO1WiSoKCrk0rPCiSABEQ697fmPgFVn_Icd0eblUIDK_LPWImNg-590waF_n8sjLjza1hGqhtFug0YvUE4Q-FsbEFXVLWVQEtgIQRJpXbLNZAueCpWlcmqqCTB30Qrqw0jf4Cdd9U3m2KYEJ5SCPBaJRBisUYqfvIKSRrq6ytd7UJ8q7zM8VHNHiGQ1LeNhCHbZNXSx8bPQ4wVkCGOBfr1YBzauSp6snnoLi3a2-z5NcyvcQr0-SqIJQQqfVszdjpfCYHum_YlvF1uvUKusdqlZAZIp5DnPx3RHEg2aLzI-r6UcD6XFAePTek6uY-bStwDptWGP0VghkP3tjhXdKMPSj_oneoRKHn_ShpdezQ_GBPRtEAM-XHroBr7i9ruNjDmWTdBPFcYXmkfiB3X8tuxXRFI1REAvBI2vy8coh3E2X12GK_P0_lnfjc2CY86ycehIm7eksKlDRR5BfyUKv3r5zONOHr0G1-39foPZzzYs46ZCtb8UGz1OR422vzS61csTlJqmfhBA0-s2VWJkFBvHCE3yPlVUfnZdUZc8V3G57lOJ2Wi4rji1i3YSYvQddtpWvDwN80kHBbABN_mbTJ2l6dLrywIx-MeEj_L4sYrl50dhhAw_yhEKwBF5CVlnOfSViXa_9fDHUI0btDP905w9hn0KC4zUfvVQJnHI6DiaAfeCL00GodQ_DFePjj7fUv2kx7tbivUy4UDTdXWLZKXEO5sEKo1biNsQucKjzqFBgoq7fo60th4zV52yelGajX0-sJC9V-0XXAViDaW58F8ol7iBeCPTOqlCKJ5c6CM-Q_dTz5N3s8-izhFgq7fp-AbUUgS2mp7SmPW0ESwOKj_z-1bWKiPXNpzGq1Es7MhNHHQKEXJ4adl');
INSERT INTO "Specials" VALUES (1,'Pizza de Queso','9.99','Pizza de queso deliciosa.','img/pizzas/cheese.jpg');
INSERT INTO "Specials" VALUES (2,'MegaBacon','9.99','Con cada tipo de bacon!','img/pizzas/bacon.jpg');
INSERT INTO "Specials" VALUES (3,'G Pepperoni','10.99','La pizza de pepperoni clasica, con mas pepperoni','img/pizzas/pepperoni.jpg');
INSERT INTO "Specials" VALUES (4,'Pollo Bufalo','10.99','De pollo picante, te encantará!','img/pizzas/meaty.jpg');
INSERT INTO "Specials" VALUES (5,'Champiñon','9.99','Champiñones y poco mas','img/pizzas/mushroom.jpg');
INSERT INTO "Specials" VALUES (6,'La Britanica','8.99','Solo le gusta a los ingleses','img/pizzas/brit.jpg');
INSERT INTO "Specials" VALUES (7,'La Vegetariana','8.99','De ensalada.','img/pizzas/salad.jpg');
INSERT INTO "Specials" VALUES (8,'Margarita de la Casa','9.99','Margarita de toda la vida.','img/pizzas/margherita.jpg');
INSERT INTO "Toppings" VALUES (1,'Extra de queso','2.5');
INSERT INTO "Toppings" VALUES (2,'Bacon Americano','2.99');
INSERT INTO "Toppings" VALUES (3,'Bacon Ingles','2.99');
INSERT INTO "Toppings" VALUES (4,'Bacon Canadiense','2.99');
INSERT INTO "Toppings" VALUES (5,'Te y Galletas','5.0');
INSERT INTO "Toppings" VALUES (6,'Galletas recien horneadas','4.5');
INSERT INTO "Toppings" VALUES (7,'Jalapeños','1.0');
INSERT INTO "Toppings" VALUES (8,'Cebolla','1.0');
INSERT INTO "Toppings" VALUES (9,'Setas','1.0');
INSERT INTO "Toppings" VALUES (10,'Pepperoni','1.0');
INSERT INTO "Toppings" VALUES (11,'Salchichas','3.2');
INSERT INTO "Toppings" VALUES (12,'Albondigas','2.5');
INSERT INTO "Toppings" VALUES (13,'Servido en bandeja de plata','250.99');
INSERT INTO "Toppings" VALUES (14,'Langosta','64.5');
INSERT INTO "Toppings" VALUES (15,'Cabiar','101.75');
INSERT INTO "Toppings" VALUES (16,'Coles de bruselas','3.4');
INSERT INTO "Toppings" VALUES (17,'Tomate','1.5');
INSERT INTO "Toppings" VALUES (18,'Oregano','1.5');
INSERT INTO "Toppings" VALUES (19,'Chuleton','8.5');
INSERT INTO "Toppings" VALUES (20,'Guindilla Fantasma','4.2');
INSERT INTO "Toppings" VALUES (21,'Pollo bufalo','5.0');
INSERT INTO "Toppings" VALUES (22,'Queso azul ','2.5');
CREATE INDEX IF NOT EXISTS "EmailIndex" ON "AspNetUsers" (
	"NormalizedEmail"
);
CREATE INDEX IF NOT EXISTS "IX_AspNetRoleClaims_RoleId" ON "AspNetRoleClaims" (
	"RoleId"
);
CREATE INDEX IF NOT EXISTS "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" (
	"UserId"
);
CREATE INDEX IF NOT EXISTS "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" (
	"UserId"
);
CREATE INDEX IF NOT EXISTS "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" (
	"RoleId"
);
CREATE UNIQUE INDEX IF NOT EXISTS "IX_DeviceCodes_DeviceCode" ON "DeviceCodes" (
	"DeviceCode"
);
CREATE INDEX IF NOT EXISTS "IX_DeviceCodes_Expiration" ON "DeviceCodes" (
	"Expiration"
);
CREATE INDEX IF NOT EXISTS "IX_Keys_Use" ON "Keys" (
	"Use"
);
CREATE INDEX IF NOT EXISTS "IX_Orders_DeliveryAddressId" ON "Orders" (
	"DeliveryAddressId"
);
CREATE INDEX IF NOT EXISTS "IX_PersistedGrants_ConsumedTime" ON "PersistedGrants" (
	"ConsumedTime"
);
CREATE INDEX IF NOT EXISTS "IX_PersistedGrants_Expiration" ON "PersistedGrants" (
	"Expiration"
);
CREATE INDEX IF NOT EXISTS "IX_PersistedGrants_SubjectId_ClientId_Type" ON "PersistedGrants" (
	"SubjectId",
	"ClientId",
	"Type"
);
CREATE INDEX IF NOT EXISTS "IX_PersistedGrants_SubjectId_SessionId_Type" ON "PersistedGrants" (
	"SubjectId",
	"SessionId",
	"Type"
);
CREATE INDEX IF NOT EXISTS "IX_PizzaTopping_ToppingId" ON "PizzaTopping" (
	"ToppingId"
);
CREATE INDEX IF NOT EXISTS "IX_Pizzas_OrderId" ON "Pizzas" (
	"OrderId"
);
CREATE INDEX IF NOT EXISTS "IX_Pizzas_SpecialId" ON "Pizzas" (
	"SpecialId"
);
CREATE UNIQUE INDEX IF NOT EXISTS "RoleNameIndex" ON "AspNetRoles" (
	"NormalizedName"
);
CREATE UNIQUE INDEX IF NOT EXISTS "UserNameIndex" ON "AspNetUsers" (
	"NormalizedUserName"
);
COMMIT;
