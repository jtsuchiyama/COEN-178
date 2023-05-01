CREATE TABLE Club (
clubName varchar(25),
fee int,
PRIMARY KEY(clubName,fee)
);

CREATE TABLE Members (
id varchar(5),
name varchar(20),
clubName varchar(25),
PRIMARY KEY (id,name,clubName)
);
