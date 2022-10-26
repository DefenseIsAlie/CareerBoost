CREATE USER 'JobPortal'@'localhost' IDENTIFIED BY 'CareerBoost123**';

CREATE DATABASE JobsData;

GRANT ALL PRIVILEGES ON JobsData.* TO 'JobPortal'@'localhost';