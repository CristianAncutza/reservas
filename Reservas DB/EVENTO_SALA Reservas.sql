SELECT * FROM sala a INNER JOIN banda b ON (a.ID=b.salaid) 

DROP TABLE EVENTO_SALA

CREATE TABLE EVENTO_SALA (
ID INT IDENTITY(1,1) NOT NULL,
SALAID	INT,
EVENTOID INT,
) ON [PRIMARY]

ALTER TABLE EVENTO_SALA  
 ADD  FOREIGN KEY (SALAID) REFERENCES SALA(ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE

ALTER TABLE EVENTO_SALA  
  ADD  FOREIGN KEY (EVENTOID) REFERENCES EVENTO(ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE


SELECT * FROM EVENTO
SELECT * FROM SALA
SELECT * FROM EVENTO_SALA

SELECT SALAID FROM EVENTO_SALA

INSERT INTO EVENTO_SALA (SALAID, EVENTOID)VALUES
(4,1),
(5,1),
(4,4)