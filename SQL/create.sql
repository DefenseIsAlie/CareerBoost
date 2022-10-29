USE JobsData;

CREATE TABLE PortalUser (
    u_id      VARCHAR(10),
    user_name VARCHAR(30) NOT NULL,    
    password  VARCHAR(20) NOT NULL,
    email_id  VARCHAR(50) NOT NULL,

    PRIMARY KEY(u_id)    
);

CREATE TABLE Company (
    c_id      VARCHAR(10),
    company_name VARCHAR(30) NOT NULL,    
    password  VARCHAR(20) NOT NULL,
    email_id  VARCHAR(50) NOT NULL,

    PRIMARY KEY(c_id)
);
