CREATE TABLE kullanici (  
  "KullaniciID" SERIAL,  
  "AdSoyad" VARCHAR(100),  
  "Sifre" VARCHAR(100),  
  "KayitTarihi" DATE,  
CONSTRAINT "kullaniciPK" PRIMARY KEY ("KullaniciID")  
);  
CREATE TABLE "BireyselKullanici" (  
  "KullaniciID" INT,  
  "TcNo" VARCHAR(11) UNIQUE NOT NULL,  
CONSTRAINT "BireyselKullanici_PK" PRIMARY KEY ("KullaniciID"),  
CONSTRAINT "FK_BireyselKullanici" FOREIGN KEY ("KullaniciID")  
  REFERENCES "kullanici" ("KullaniciID")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE  
);   
CREATE TABLE "KurumsalKullanici" (  
  "KullaniciID" INT,  
  "VergiNo" VARCHAR(15) UNIQUE,  
  "SirketAdi" VARCHAR(150),  
CONSTRAINT "KurumsalKullanici_PK" PRIMARY KEY ("KullaniciID"),  
CONSTRAINT "FK_KurumsalKullanici" FOREIGN KEY ("KullaniciID")  
  REFERENCES "kullanici" ("KullaniciID")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE  
);  
CREATE TABLE urun(  
  "UrunNo" SERIAL,  
  "UrunAdi" VARCHAR(255) NOT NULL,  
  "UrunTipi" VARCHAR(50),  
  "Miktar" INT,  
CONSTRAINT "UrunPK" PRIMARY KEY ("UrunNo")  
);  
CREATE TABLE "Tohum"(  
  "UrunNo" INT,  
  "TMahsulu" VARCHAR(255),  
CONSTRAINT "TohumPK" PRIMARY KEY ("UrunNo"),  
CONSTRAINT "FKTohum" FOREIGN KEY ("UrunNo")  
  REFERENCES "urun" ("UrunNo")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE  
);  
CREATE TABLE "Mahsul"(  
  "UrunNo" INT,  
  "Verim" Numeric,  
CONSTRAINT "MahsulPK" PRIMARY KEY ("UrunNo"),  
CONSTRAINT "FKMahsul" FOREIGN KEY ("UrunNo")  
  REFERENCES "urun" ("UrunNo")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE  
);  
CREATE TABLE ekipman(  
  "EkipmanID" SERIAL,  
  "KullaniciID" INT,  
  "EkipmanAdi" VARCHAR(50) NOT NULL,  
  "EkipmanTuru" VARCHAR(50) NOT NULL,  
  "Model" VARCHAR(50),  
  "AlimTarihi" DATE,  
CONSTRAINT "EkipmanPK" PRIMARY KEY ("EkipmanID"),  
CONSTRAINT "FKEkipman" FOREIGN KEY ("KullaniciID")  
  REFERENCES "kullanici" ("KullaniciID")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE  
);  
CREATE TABLE bolge(  
  "BolgeID" SERIAL,  
  "BolgeAdi" VARCHAR(50),  
  "IklimTipi" VARCHAR(50),  
CONSTRAINT "BolgePK" PRIMARY KEY ("BolgeID")  
);  
CREATE TABLE Tarla(  
  "TarlaNo" SERIAL,  
  "KullaniciID" INT,  
  "BolgeID" INT,  
  "Alan" NUMERIC(10,2) NOT NULL,  
CONSTRAINT "TarlaPK" PRIMARY KEY ("TarlaNo"),  
CONSTRAINT "FKTarla" FOREIGN KEY ("BolgeID")  
  REFERENCES "bolge" ("BolgeID")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE,  
CONSTRAINT "FKTarlaKul" FOREIGN KEY ("KullaniciID")  
  REFERENCES "kullanici" ("KullaniciID")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE  
);  
CREATE TABLE TarlaEkipman(  
  "TarlaNo" INT,  
  "EkipmanID" INT,  
CONSTRAINT "TarlaEkipmanPK" PRIMARY KEY ("TarlaNo", "EkipmanID"),  
CONSTRAINT "FKTarlaEkipman" FOREIGN KEY ("TarlaNo")  
  REFERENCES "tarla" ("TarlaNo")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE,  
CONSTRAINT "FKTarlaEkipman_Ekipman" FOREIGN KEY ("EkipmanID")  
  REFERENCES "ekipman" ("EkipmanID")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE  
);  
CREATE TABLE HavaDurumuRaporu(  
  "RaporNo" SERIAL,  
  "BolgeID" INT,  
  "Tarih" DATE,  
  "Sicaklik" NUMERIC(5,2),  
  "NemOrani" NUMERIC(5,2),  
  "YagisMiktari" NUMERIC(5,2),  
  "RuzgarHizi" NUMERIC(5,2),  
CONSTRAINT "HavaDurumuPK" PRIMARY KEY ("RaporNo"),  
CONSTRAINT "FKHavaDurumu" FOREIGN KEY ("BolgeID")  
  REFERENCES "bolge" ("BolgeID")  
  ON DELETE CASCADE  
  ON UPDATE CASCADE  
);  
CREATE TABLE Ekim(  
"EkimID" SERIAL,  
"TarlaNo" INT,  
"UrunNo" INT NOT NULL,  
"EkilenALan" NUMERIC(10,2),  
"EkimTarihi" DATE NOT NULL,  
CONSTRAINT "EkimPK" PRIMARY KEY ("EkimID"),  
CONSTRAINT "FKEkim" FOREIGN KEY ("TarlaNo")  
REFERENCES "tarla" ("TarlaNo")  
ON DELETE CASCADE  
ON UPDATE CASCADE,  
CONSTRAINT "EkimFK" FOREIGN KEY ("UrunNo")  
REFERENCES "urun" ("UrunNo")  
ON DELETE CASCADE  
ON UPDATE CASCADE  
);  
CREATE TABLE Hasat(  
"HasatID" SERIAL,  
"EkimID" INT,  
"HasatTarihi" DATE,  
"HasilatMiktarı" NUMERIC,  
CONSTRAINT "HasatPK" PRIMARY KEY ("HasatID"),  
CONSTRAINT "FKHasat" FOREIGN KEY ("EkimID")  
REFERENCES "ekim" ("EkimID")  
ON DELETE CASCADE  
ON UPDATE CASCADE     
);  
CREATE TABLE Maliyet(  
"MaliyetID" SERIAL,  
"EkimID" INT,  
"Tutar" Numeric(10,2) NOT NULL,  
CONSTRAINT "MaliyetPK" PRIMARY KEY ("MaliyetID"),  
CONSTRAINT "FKMAliyet" FOREIGN KEY ("EkimID")  
REFERENCES "ekim" ("EkimID")  
ON DELETE CASCADE  
ON UPDATE CASCADE     
);  
CREATE TABLE BakimTuru(  
"BakimTuruID" SERIAL,  
"BakimTAdi" VARCHAR(100) NOT NULL,  
CONSTRAINT "BakimTuruPK" PRIMARY KEY ("BakimTuruID")    
);  
CREATE TABLE BakimIslemi(  
"BakimIslemiID" SERIAL,  
"EkimID" INT,  
"BakimTuruID" INT,  
"Tarih" DATE,  
"Sure" NUMERIC(5,2),  
"EkipmanID" INT,  
CONSTRAINT "BakimIslemiPK" PRIMARY KEY ("BakimIslemiID"),  
CONSTRAINT "FKBakimIslemi" FOREIGN KEY ("EkimID")  
REFERENCES "ekim" ("EkimID")  
ON DELETE CASCADE  
ON UPDATE CASCADE,  
CONSTRAINT "BakimIslemi_FK" FOREIGN KEY ("BakimTuruID")  
REFERENCES "bakimturu" ("BakimTuruID")  
ON DELETE CASCADE  
ON UPDATE CASCADE,    
CONSTRAINT "BakimIslemiFK" FOREIGN KEY ("EkipmanID")  
REFERENCES "ekipman" ("EkipmanID")  
ON DELETE CASCADE  
ON UPDATE CASCADE  
);  
CREATE TABLE GubreTuru(  
"GubreKodu" SERIAL,  
"GubreAdi" VARCHAR(50),  
CONSTRAINT "GubreTuruPK" PRIMARY KEY ("GubreKodu")  
);  
CREATE TABLE IlacTuru(  
"IlacKodu" SERIAL,  
"IlacAdi" VARCHAR(50),  
CONSTRAINT "IlacTuruPK" PRIMARY KEY ("IlacKodu")  
);  
CREATE TABLE EkimGubre(  
"EkimID" INT,  
"GubreKodu" INT,  
CONSTRAINT "EkimGubrePK" PRIMARY KEY ("EkimID", "GubreKodu"),  
CONSTRAINT "FKEkimGubre_Ekim" FOREIGN KEY ("EkimID")  
REFERENCES "ekim" ("EkimID")  
ON DELETE CASCADE  
ON UPDATE CASCADE,  
CONSTRAINT "FKEkimGubre_Gubre" FOREIGN KEY ("GubreKodu")  
REFERENCES "gubreturu" ("GubreKodu")  
ON DELETE CASCADE  
ON UPDATE CASCADE  
);  
CREATE TABLE EkimIlac(  
"EkimID" INT,  
"IlacKodu" INT,  
CONSTRAINT "EkimIlacPK" PRIMARY KEY ("EkimID", "IlacKodu"),  
CONSTRAINT "FKEkimIlac_Ekim" FOREIGN KEY ("EkimID")  
REFERENCES "ekim" ("EkimID")  
ON DELETE CASCADE  
ON UPDATE CASCADE,  
CONSTRAINT "FKEkimIlac_Ilac" FOREIGN KEY ("IlacKodu")  
REFERENCES "ilacturu" ("IlacKodu")  
ON DELETE CASCADE  
ON UPDATE CASCADE  
);  --kullanıcı ekleme fonksiyonu  
CREATE OR REPLACE FUNCTION kullanici_ekle(     
p_adsoyad VARCHAR,     p_sifre VARCHAR,     p_tur 
VARCHAR, -- 'bireysel' veya 'kurumsal'     
VARCHAR DEFAULT NULL,     
VARCHAR DEFAULT NULL,     
VARCHAR DEFAULT NULL  
) RETURNS VOID AS $$ 
DECLARE  
p_tcno 
p_vergino 
p_sirketadi 
v_kullaniciid INT; -- Kullanıcı ID'sini tutmak için değişken tanımlanıyor  
BEGIN  -- Genel kullanıcı ekle  
INSERT INTO kullanici ("AdSoyad", "Sifre", "KayitTarihi")  
VALUES (p_adsoyad, p_sifre, CURRENT_DATE)  
RETURNING "KullaniciID" INTO v_kullaniciid;  -- Türüne göre bireysel veya kurumsal kullanıcı ekle  
IF p_tur = 'bireysel' THEN  
INSERT INTO "BireyselKullanici" ("KullaniciID", "TcNo")  
VALUES (v_kullaniciid, p_tcno);  
ELSIF p_tur = 'kurumsal' THEN  
INSERT INTO "KurumsalKullanici" ("KullaniciID", "VergiNo", "SirketAdi")  
VALUES (v_kullaniciid, p_vergino, p_sirketadi);  
END IF;  
END;  
$$ LANGUAGE plpgsql;  --ürün güncelleme fonksiyonu  
CREATE OR REPLACE FUNCTION urun_guncelle(  
p_urunno INT,     
p_urunadi VARCHAR,     
p_uruntipi VARCHAR,     
p_miktar INT  
) RETURNS VOID AS $$  
BEGIN  
UPDATE urun  
SET "UrunAdi" = p_urunadi,  
"UrunTipi" = p_uruntipi,  
"Miktar" = p_miktar  
WHERE "UrunNo" = p_urunno;  
END;  
$$ LANGUAGE plpgsql;  --ekipman silmek için fonksiyon  
CREATE OR REPLACE FUNCTION ekipman_sil(p_ekipmanid INT) RETURNS VOID AS $$  
BEGIN  
DELETE FROM ekipman -- Burada tablo ismi küçük harfle yazılmalı  
WHERE "EkipmanID" = p_ekipmanid;  
END;  
$$ LANGUAGE plpgsql;  --ekim alanı aramak için fonksiyon  
CREATE OR REPLACE FUNCTION ekim_alani_ara(     
p_min_alan NUMERIC(10,2),     p_max_alan 
NUMERIC(10,2)  
) RETURNS TABLE(  
"EkimID" INT,  
"TarlaNo" INT,  
"UrunNo" INT,  
"EkilenALan" NUMERIC(10,2),  
"EkimTarihi" DATE  
) AS $$  
BEGIN  
RETURN QUERY  
SELECT "EkimID", "TarlaNo", "UrunNo", "EkilenALan", "EkimTarihi"  
FROM "Ekim"  
WHERE "EkilenALan" BETWEEN p_min_alan AND p_max_alan;  
END;  
$$ LANGUAGE plpgsql;  
--yeni kayıta bugunun tarihini atmak icin trigger  
CREATE OR REPLACE FUNCTION set_kayittarihi()  
RETURNS TRIGGER AS $$  
BEGIN  
NEW."KayitTarihi" := CURRENT_DATE;  
RETURN NEW;  
END;  
$$ LANGUAGE plpgsql;  
CREATE TRIGGER trg_set_kayittarihi  
BEFORE INSERT ON kullanici  
FOR EACH ROW  
EXECUTE FUNCTION set_kayittarihi();  --urun silme trigger  
CREATE OR REPLACE FUNCTION urun_sil_ekim()  
RETURNS TRIGGER AS $$  
BEGIN  
DELETE FROM ekim WHERE "UrunNo" = OLD."UrunNo";  
RETURN OLD;  
END;  
$$ LANGUAGE plpgsql;  
CREATE TRIGGER trg_urun_sil_ekim  
AFTER DELETE ON urun  
FOR EACH ROW  
EXECUTE FUNCTION urun_sil_ekim();  --güncelleme trigger  
CREATE OR REPLACE FUNCTION set_guncelleme_tarihi()  
RETURNS TRIGGER AS $$  
BEGIN  
NEW."GuncellemeTarihi" := CURRENT_DATE;  
RETURN NEW; 
END;  
$$ LANGUAGE plpgsql;  
ALTER TABLE ekipman ADD COLUMN "GuncellemeTarihi" DATE;  
CREATE TRIGGER trg_set_guncelleme_tarihi  
BEFORE UPDATE ON ekipman  
FOR EACH ROW  
EXECUTE FUNCTION set_guncelleme_tarihi();  --alan trigger  
CREATE OR REPLACE FUNCTION ekim_alani_ara_trigger()  
RETURNS TRIGGER AS $$  
BEGIN  -- Ekim alanı güncellenince, fonksiyonu tetikleyerek arama yapılabilir  
PERFORM ekim_alani_ara(0, 10000); -- örneğin, 0 ile 10000 arasındaki alanları arıyoruz  
RETURN NEW; 
END;  
$$ LANGUAGE plpgsql;  -- Ekim tablosunda ekim alanı güncellendiğinde trigger tetiklenir  
CREATE TRIGGER trg_ekim_alani_ara  
AFTER UPDATE ON Ekim  
FOR EACH ROW  
WHEN (NEW."EkilenALan" <> OLD."EkilenALan") -- sadece alan değiştiğinde tetiklenecek EXECUTE 
FUNCTION ekim_alani_ara_trigger();  -- Bireysel kullanıcı eklemek  
SELECT kullanici_ekle(  
'Ahmet Yılmaz',   
'ahmet123',   
'bireysel',   
'12345678901',   
NULL,   
NULL  
);  -- Kurumsal kullanıcı eklemek  
SELECT kullanici_ekle(  
'XYZ A.Ş.',   
'xyz123',   
'kurumsal',   
NULL,   
'9876543210',   
'XYZ Agriculture'  
);  
INSERT INTO urun ("UrunNo","UrunAdi", "UrunTipi", "Miktar")  
VALUES   
(1, 'Domates', 'Sebze', 100),  
(2, 'Biber', 'Sebze', 150),  
(3, 'Patates', 'Kök', 200);  
INSERT INTO ekipman ("KullaniciID", "EkipmanAdi", "EkipmanTuru", "Model", "AlimTarihi")  
VALUES  
(6, 'Traktör', 'Tarım', 'John Deere', '2022-05-10'),  
(7, 'Büyük Çapa Makinesi', 'Tarım', 'Kubota', '2023-07-20');  
INSERT INTO tarla ("KullaniciID", "BolgeID", "Alan")  
VALUES  
(6, 1, 200.50),     
(7, 2, 300.00);  
INSERT INTO ekim ("TarlaNo", "UrunNo", "EkilenALan", "EkimTarihi")  
VALUES  
(1, 1, 150.00, '2024-03-10'),     
(2, 2, 100.00, '2024-04-15');  
SELECT urun_guncelle(1, 'Patates', 'Kök', 250);  
SELECT * from ekipman  -- Ekipman güncelleme fonksiyonu ile  
SELECT ekipman_guncelle(1, 'Yeni Traktör', 'Tarım', 'New John Deere', '2024-01-01');  
SELECT * FROM ekipman WHERE "EkipmanID" = 1;  --TABLOLARI BİRLEŞTİRME İŞLEMLERİ  
SELECT   
U."UrunNo",  
U."UrunAdi",  
U."UrunTipi",  
U."Miktar",  
T."TMahsulu" AS "TohumMahsulTuru",  
M."Verim"  
FROM   
"urun" U  
LEFT JOIN   
"Tohum" T ON U."UrunNo" = T."UrunNo"  
LEFT JOIN   
"Mahsul" M ON U."UrunNo" = M."UrunNo";  -----------------------------------------  
SELECT   
K."KullaniciID" AS "ID",  
K."AdSoyad" AS "Ad Soyad",  
K."Sifre",  
K."KayitTarihi" AS "Kayıt Tarihi",     
KK."SirketAdi" AS "Şirket Adı",  
KK."VergiNo" AS "Vergi No"  
FROM   
"kullanici" K  
LEFT JOIN   
"KurumsalKullanici" KK ON K."KullaniciID" = KK."KullaniciID";  --------------------------------------------  
SELECT   
e."EkimID",  
h."HasatID",  
h."HasatTarihi",  
h."HasilatMiktarı"  
FROM   
"ekim" e  
LEFT JOIN   
"hasat" h  
ON   
e."EkimID" = h."EkimID";  ------------------------------------------  
SELECT   
e."EkipmanID",  
e."KullaniciID",  
k."AdSoyad" AS "Kullanıcı Adı",  
e."EkipmanAdi" AS "Ekipman Adı",  
e."EkipmanTuru" AS "Tür",  
e."Model",  
e."AlimTarihi" AS "Alım Tarihi"  
FROM   
"ekipman" e  
LEFT JOIN   
"kullanici" k  
ON   
e."KullaniciID" = k."KullaniciID";  -----------------------------------------  
SELECT   
e."EkimID" AS "ID",  
e."TarlaNo" AS "Tarla No",  
e."UrunNo" AS "Ürün No",  
e."EkilenALan" AS "Ekili Alan",  
e."EkimTarihi" 
AS 
"Ekim 
Tarihi",     
eg."GubreKodu" AS "Gübre", ei."IlacKodu" AS 
"İlaç",  
m."Tutar" AS "Maliyet"  
FROM   
"ekim" e  
LEFT JOIN   
"ekimgubre" eg  
ON   
e."EkimID" = eg."EkimID"  
LEFT JOIN   
"ekimilac" ei  
ON   
e."EkimID" = ei."EkimID"  
LEFT JOIN   
"maliyet" m  
ON   
e."EkimID" = m."EkimID";  -----------------------------------  
CREATE TEMP TABLE "BireyselTablo" AS  
SELECT   
k."KullaniciID",   
k."AdSoyad",   
k."Sifre",   
k."KayitTarihi",   
b."TcNo"  
FROM   
"kullanici" k  
LEFT JOIN   
"BireyselKullanici" b  
ON   
k."KullaniciID" = b."KullaniciID";   
