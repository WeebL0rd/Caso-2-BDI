USE solturaDB;
GO

CREATE TABLE sol_payment_queue (
  queueID      INT IDENTITY(1,1) PRIMARY KEY,
  userID       INT             NOT NULL,
  amount       DECIMAL(9,2)    NOT NULL,
  payload      NVARCHAR(MAX)   NULL,
  date_created DATETIME        NOT NULL DEFAULT GETDATE()
);
GO
