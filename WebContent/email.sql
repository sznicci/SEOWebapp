ALTER TABLE felh_adatai ADD COLUMN email VARCHAR(30) AFTER cegjegyzekszam;

ALTER TABLE gyakorisag DROP FOREIGN KEY `gyakorisag_ibfk_1`;
ALTER TABLE gyakorisag ADD FOREIGN KEY (`gyak_id`) REFERENCES `felh_adatai` (`id`) ON DELETE CASCADE;

ALTER TABLE history DROP FOREIGN KEY `history_ibfk_1`;
ALTER TABLE history ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`history_id`) REFERENCES `gyakorisag` (`id`) ON DELETE CASCADE;


ALTER TABLE history ADD COLUMN tart_oldal VARCHAR(300) AFTER meresiEredmeny;


ALTER TABLE history ADD COLUMN valtozas INT AFTER tart_oldal;